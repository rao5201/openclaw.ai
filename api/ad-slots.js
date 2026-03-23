import { supabase, supabaseAdmin, withCors, checkAdmin } from './supabase-client.js';

export default withCors(async (req, res) => {
  if (!supabase) return res.status(503).json({ success: false, error: 'Database not configured' });

  if (req.method === 'GET') {
    const { data, error } = await supabase.from('ad_slots').select('*').order('slot_number');
    if (error) return res.status(500).json({ success: false, error: error.message });
    return res.json({ success: true, data });
  }

  if (!checkAdmin(req)) return res.status(401).json({ success: false, error: 'Unauthorized' });
  const db = supabaseAdmin || supabase;

  if (req.method === 'PUT') {
    const { slot_number, status, advertiser_name, contact_email } = req.body;
    const { data, error } = await db.from('ad_slots').update({ status, advertiser_name, contact_email }).eq('slot_number', slot_number).select().single();
    if (error) return res.status(500).json({ success: false, error: error.message });
    return res.json({ success: true, data });
  }

  res.status(405).json({ success: false, error: 'Method not allowed' });
});
