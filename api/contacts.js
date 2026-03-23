import { supabase, supabaseAdmin, withCors, checkAdmin } from './supabase-client.js';

export default withCors(async (req, res) => {
  if (!supabase) return res.status(503).json({ success: false, error: 'Database not configured' });

  if (req.method === 'POST') {
    const { company, contact_name, phone, email, ad_position, duration, message, type } = req.body;
    const { data, error } = await supabase.from('contacts').insert({
      company, contact_name, phone, email, ad_position, duration, message, type: type || 'ad_inquiry'
    }).select().single();
    if (error) return res.status(500).json({ success: false, error: error.message });
    return res.status(201).json({ success: true, data });
  }

  if (!checkAdmin(req)) return res.status(401).json({ success: false, error: 'Unauthorized' });
  const db = supabaseAdmin || supabase;

  if (req.method === 'GET') {
    const { data, error } = await db.from('contacts').select('*').order('created_at', { ascending: false });
    if (error) return res.status(500).json({ success: false, error: error.message });
    return res.json({ success: true, data });
  }

  if (req.method === 'PUT') {
    const { id, is_read } = req.body;
    const { error } = await db.from('contacts').update({ is_read }).eq('id', id);
    if (error) return res.status(500).json({ success: false, error: error.message });
    return res.json({ success: true });
  }

  res.status(405).json({ success: false, error: 'Method not allowed' });
});
