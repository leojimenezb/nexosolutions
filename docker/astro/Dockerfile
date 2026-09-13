FROM node:22-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files
COPY . .

# Create .env file from environment variables if not exists
RUN if [ ! -f .env ]; then \
    echo "PUBLIC_SITE_URL=${PUBLIC_SITE_URL:-http://localhost:4321}" >> .env && \
    echo "PUBLIC_SITE_NAME=${PUBLIC_SITE_NAME:-NEXO Soluciones}" >> .env && \
    echo "PUBLIC_SITE_TAGLINE=${PUBLIC_SITE_TAGLINE:-Tecnología que impulsa tu negocio}" >> .env && \
    echo "PUBLIC_SITE_DESCRIPTION=${PUBLIC_SITE_DESCRIPTION:-Ayudamos a emprendedores y pequeñas empresas mediante soluciones tecnológicas, desarrollo web, automatización de procesos, soporte tecnológico y consultoría TI.}" >> .env && \
    echo "PUBLIC_COMPANY_NAME=${PUBLIC_COMPANY_NAME:-NEXO Soluciones}" >> .env && \
    echo "PUBLIC_COMPANY_ADDRESS=${PUBLIC_COMPANY_ADDRESS:-Ciudad de México, México}" >> .env && \
    echo "PUBLIC_CONTACT_PHONE=${PUBLIC_CONTACT_PHONE:-5523532259}" >> .env && \
    echo "PUBLIC_CONTACT_EMAIL=${PUBLIC_CONTACT_EMAIL:-contacto@nexosoluciones.com}" >> .env && \
    echo "PUBLIC_WHATSAPP_NUMBER=${PUBLIC_WHATSAPP_NUMBER:-525523532259}" >> .env && \
    echo "PUBLIC_FACEBOOK_URL=${PUBLIC_FACEBOOK_URL:-https://facebook.com/nexosoluciones}" >> .env && \
    echo "PUBLIC_INSTAGRAM_URL=${PUBLIC_INSTAGRAM_URL:-https://instagram.com/nexosoluciones}" >> .env && \
    echo "PUBLIC_LINKEDIN_URL=${PUBLIC_LINKEDIN_URL:-https://linkedin.com/company/nexosoluciones}" >> .env && \
    echo "PUBLIC_TWITTER_URL=${PUBLIC_TWITTER_URL:-https://twitter.com/nexosoluciones}" >> .env && \
    echo "PUBLIC_SITE_KEYWORDS=${PUBLIC_SITE_KEYWORDS:-desarrollo web, automatización, soporte tecnológico, consultoría TI, emprendedores, pequeñas empresas}" >> .env && \
    echo "PUBLIC_SITE_AUTHOR=${PUBLIC_SITE_AUTHOR:-NEXO Soluciones}" >> .env; \
    fi

EXPOSE 4321

# Default to development, can be overridden
CMD ["npm", "run", "dev"]