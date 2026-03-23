import { supabase, supabaseAdmin, withCors, checkAdmin } from './supabase-client.js';

export default withCors(async (req, res) => {
  if (!supabase) return res.status(503).json({ success: false, error: 'Database not configured' });

  if (req.method === 'GET') {
    const { data, error } = await supabase.from('skills').select('*').eq('is_active', true).order('sort_order');
    if (error) return res.status(500).json({ success: false, error: error.message });
    return res.json({ success: true, data });
  }

  if (!checkAdmin(req)) return res.status(401).json({ success: false, error: 'Unauthorized' });
  const db = supabaseAdmin || supabase;

  if (req.method === 'POST') {
    const { data, error } = await db.from('skills').insert(req.body).select().single();
    if (error) return res.status(500).json({ success: false, error: error.message });
    return res.status(201).json({ success: true, data });
  }

  if (req.method === 'PUT') {
    const { id, ...updates } = req.body;
    const { data, error } = await db.from('skills').update(updates).eq('id', id).select().single();
    if (error) return res.status(500).json({ success: false, error: error.message });
    return res.json({ success: true, data });
  }

  if (req.method === 'DELETE') {
    const { id } = req.body;
    const { error } = await db.from('skills').update({ is_active: false }).eq('id', id);
    if (error) return res.status(500).json({ success: false, error: error.message });
    return res.json({ success: true });
  }

  res.status(405).json({ success: false, error: 'Method not allowed' });
});
