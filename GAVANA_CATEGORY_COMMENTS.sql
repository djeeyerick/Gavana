-- GAVANA FILMS V4 FINAL: Category, Cast and Comment Manager
-- Run once in Supabase SQL Editor.

-- Movie metadata used by Admin Dashboard
ALTER TABLE public.movies ADD COLUMN IF NOT EXISTS category text;
ALTER TABLE public.movies ADD COLUMN IF NOT EXISTS cast_names text;
CREATE INDEX IF NOT EXISTS movies_category_status_idx
  ON public.movies (category, status);

-- Public comments are linked to movies/series by movie_id.
-- Keep the existing table and visitor insert/read policies intact.
ALTER TABLE public.movie_comments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Admins can update movie comments" ON public.movie_comments;
CREATE POLICY "Admins can update movie comments" ON public.movie_comments
FOR UPDATE TO authenticated
USING (EXISTS (SELECT 1 FROM public.admin_users au WHERE au.user_id = auth.uid()))
WITH CHECK (EXISTS (SELECT 1 FROM public.admin_users au WHERE au.user_id = auth.uid()));

DROP POLICY IF EXISTS "Admins can delete movie comments" ON public.movie_comments;
CREATE POLICY "Admins can delete movie comments" ON public.movie_comments
FOR DELETE TO authenticated
USING (EXISTS (SELECT 1 FROM public.admin_users au WHERE au.user_id = auth.uid()));

DROP POLICY IF EXISTS "Admins can read all movie comments" ON public.movie_comments;
CREATE POLICY "Admins can read all movie comments" ON public.movie_comments
FOR SELECT TO authenticated
USING (EXISTS (SELECT 1 FROM public.admin_users au WHERE au.user_id = auth.uid()));

GRANT SELECT, UPDATE, DELETE ON public.movie_comments TO authenticated;
