import { defineConfig } from "astro/config";
import tailwind from "@astrojs/tailwind";
import sitemap from "@astrojs/sitemap";

export default defineConfig({
  site: import.meta.env.PUBLIC_SITE_URL || "https://nexosoluciones.com",

  integrations: [
    tailwind(),
    sitemap()
  ],
  
  // Make env variables available with correct Astro 5 schema format
  env: {
    schema: {
      PUBLIC_SITE_URL: {
        type: "string",
        access: "public",
        context: "client",
        default: "https://nexosoluciones.com"
      },
      PUBLIC_SITE_NAME: {
        type: "string", 
        access: "public",
        context: "client",
        default: "NEXO Soluciones"
      },
      PUBLIC_SITE_TAGLINE: {
        type: "string",
        access: "public", 
        context: "client",
        default: "Tecnología que impulsa tu negocio"
      },
      PUBLIC_SITE_DESCRIPTION: {
        type: "string",
        access: "public",
        context: "client",
        default: "Ayudamos a emprendedores y pequeñas empresas mediante soluciones tecnológicas"
      },
      PUBLIC_COMPANY_NAME: {
        type: "string",
        access: "public",
        context: "client", 
        default: "NEXO Soluciones"
      },
      PUBLIC_COMPANY_ADDRESS: {
        type: "string",
        access: "public",
        context: "client",
        default: "Ciudad de México, México"
      },
      PUBLIC_CONTACT_PHONE: {
        type: "string",
        access: "public",
        context: "client",
        default: "5523532259"
      },
      PUBLIC_CONTACT_EMAIL: {
        type: "string",
        access: "public",
        context: "client",
        default: "contacto@nexosoluciones.com"
      },
      PUBLIC_WHATSAPP_NUMBER: {
        type: "string",
        access: "public",
        context: "client",
        default: "525523532259"
      },
      PUBLIC_FACEBOOK_URL: {
        type: "string",
        access: "public",
        context: "client",
        default: "https://facebook.com/nexosoluciones"
      },
      PUBLIC_INSTAGRAM_URL: {
        type: "string",
        access: "public",
        context: "client",
        default: "https://instagram.com/nexosoluciones"
      },
      PUBLIC_LINKEDIN_URL: {
        type: "string",
        access: "public",
        context: "client",
        default: "https://linkedin.com/company/nexosoluciones"
      },
      PUBLIC_TWITTER_URL: {
        type: "string",
        access: "public",
        context: "client",
        default: "https://twitter.com/nexosoluciones"
      },
      PUBLIC_SITE_KEYWORDS: {
        type: "string",
        access: "public",
        context: "client",
        default: "desarrollo web, automatización, soporte tecnológico"
      },
      PUBLIC_SITE_AUTHOR: {
        type: "string",
        access: "public",
        context: "client",
        default: "NEXO Soluciones"
      }
    }
  }
});