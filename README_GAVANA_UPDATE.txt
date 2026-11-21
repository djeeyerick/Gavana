GAVANA FILMS — UPDATE PACKAGE

Included:
- index.html: Supabase-only homepage, latest slider with TMDB movie information, Trending/Best shelves, broad search, Download-only cards.
- interpreters.html: separate Premium-style Ibyamamare page; visitors open it from the Home navigation, choose ROCKY, GAVANA, SAVIMBI, GAHEZA, SIKOV, SANKALA or Others, then see matching published titles.
- movie-download.html / series-download.html: responsive desktop/mobile layout, link-aware buttons, random related recommendations, season + episode title display.
- admin.html: latest-five Edit/Remove list with MORE and optional Watch/Download links for Parts and Episodes.
- netlify/functions/movie-metadata.js + netlify.toml: optional automatic Cast/Director/Rating/Runtime lookup through TMDB.
- GAVANA_OPTIONAL_LINKS.sql: allows Part/Episode Watch and Download links to be saved separately.
- watchpage.html, download.html, _redirects: retained from the previous project.

IMPORTANT SETUP
1. Upload/replace the contents of this ZIP in the GAVANA FILMS GitHub repository. Keep the folder structure exactly as shown; do not move netlify/functions/movie-metadata.js.
2. In Supabase SQL Editor, run GAVANA_OPTIONAL_LINKS.sql once. It enables separate optional Watch/Download links and creates the anonymous movie_views counter used by Trending. It stores only the content ID and timestamp, not visitor identity.
3. For automatic TMDB Overview/Genres/Cast/Director/Rating/Runtime details in the Home hero, create a TMDB API Read Access Token and add it in Netlify:
   Site configuration > Environment variables > Add variable
   Name: TMDB_API_KEY
   Value: your TMDB API Read Access Token
   Then trigger a new deploy when Netlify deploy usage is available. The key stays server-side and is not exposed in public HTML.
4. The homepage uses the latest updated_at timestamp. When an Episode or Part is saved in Admin Dashboard, the parent Series/Movie updated_at is refreshed so it moves toward the front.

NOTES
- No demo movie records are used on the public homepage.
- Trending is ordered by public page views recorded in the last 30 days after the SQL setup. Best Movies uses a weighted-random order (movies with more views have a higher chance of appearing near the top) and rotates the visible list every 18 seconds.
- Ibyamamare is a separate designed page opened from the Home navigation beside Ubwoko; names are not printed on movie cards or shown as labels on posters. Selecting a name filters published Supabase titles using cast/actor and other uploaded details. Others shows titles that do not mention the six named interpreters in their available details.
- Movie Download and Watch buttons remain hidden until their respective valid links exist. If a movie has more than one part, the top-level buttons stay hidden and only the available links on each part are shown.
- Live Supabase access and Netlify deployment were not performed from this package build. Test Publish, Parts, Episodes and public pages after deployment.


GAVANA FILMS V4 FINAL — ADDITIONAL SETUP
1. Run GAVANA_V4_COMMENTS.sql once in Supabase SQL Editor. This creates the public comments table for Movie and Series download pages.
2. Email alerts are sent through Resend. In Netlify > Site configuration > Environment variables, add:
   - RESEND_API_KEY = your Resend API key
   - RESEND_FROM_EMAIL = a sender address on a domain verified in your Resend account (example: GAVANA FILMS <notifications@your-verified-domain.com>)
   The notification recipient is set to djeeyerick@gmail.com.
3. Redeploy the site after adding environment variables. Comments are saved and shown on the page even if email notification is not yet configured; the page will indicate when notification setup is pending.
4. Desktop Movie/Series download pages now use the full available width. Existing mobile layout and other page behavior are retained.
5. YouTube Channel button is in the homepage About Us footer area and opens https://youtube.com/@erick-gavana?si=b0_8vHx6XyMk9ZB7.

NEW UPDATE — ADMIN COMMENTS / CATEGORY / CAST / RED DOWNLOAD BUTTONS
1. Run GAVANA_CATEGORY_COMMENTS.sql once in Supabase SQL Editor.
2. Admin Dashboard now includes Category / Shelf and Cast / Abakinnyi selection fields.
3. Comment Manager shows name, email, comment, related movie/series title and date; admins can delete comments.
4. Download buttons are red with white text.
5. Movie Download Page hides the top Official Download and Watch Movie buttons whenever at least one Movie Part exists. Part-specific Watch/Download links are shown instead. For a solo movie with no Parts, the top buttons appear when their respective URLs exist.


TMDB INTEGRATION — HOMEPAGE + MOVIE/SERIES DETAILS
- The Home hero requests TMDB details for the currently featured Movie or Series and uses the TMDB backdrop/poster when a matching image is available.
- Movie and Series download pages show TMDB overview, tagline, genres, release date, cast, director/creator, rating, vote count, runtime, language and production details where available.
- If TMDB cannot find a match or the API is unavailable, the page keeps using the information entered in Admin Dashboard. Existing Watch/Download URLs are never replaced by TMDB.
- Keep TMDB_API_KEY only in Netlify Environment Variables; do not paste the token into HTML, Supabase, GitHub, or public chat. After setting it, redeploy the site.
- TMDB attribution is displayed on the public pages.
