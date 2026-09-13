import { defineConfig } from "astro/config";
import tailwind from "@astrojs/tailwind";
import sitemap from "@astrojs/sitemap";

const siteUrl = import.meta.env.PUBLIC_SITE_URL || "https://nexosolutions.online";

export default defineConfig({
  site: siteUrl,
  base: import.meta.env.PUBLIC_BASE_PATH || "/",

  integrations: [
    tailwind(),
    sitemap()
  ]
});