import { defineConfig } from "vite";
import symfonyPlugin from "vite-plugin-symfony";
import vuePlugin from "@vitejs/plugin-vue";
import {viteStaticCopy} from "vite-plugin-static-copy";

/* if you're using React */
// import react from '@vitejs/plugin-react';

export default defineConfig({
    plugins: [
        /* react(), // if you're using React */
        symfonyPlugin(),
        vuePlugin(),
        viteStaticCopy({
            targets: [
                {
                    src: 'assets/files/*',
                    dest: 'files'
                }
            ]
        })
    ],
    build: {
        rollupOptions: {
            input: {
                customStyle: "./assets/styles/index.scss",
                customScript: "./assets/scripts/index.ts",
            },
        }
    },
});
