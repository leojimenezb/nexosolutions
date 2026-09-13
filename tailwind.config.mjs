/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./src/**/*.{astro,html,js,jsx,ts,tsx,vue,svelte}"
  ],

  theme: {
    extend: {
      colors: {
        primary: "#55A630",
        secondary: "#0F172A",
        accent: "#2563EB",
        light: "#F8FAFC"
      }
    }
  },

  plugins: []
};