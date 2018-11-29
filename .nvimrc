:autocmd BufWritePre,InsertLeave assets/*.js !assets/node_modules/prettier/bin-prettier.js --write <afile>
