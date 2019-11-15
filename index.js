require('babel-register');

const Koa = require('koa');
const router = require('koa-router')();

const app = module.exports = new Koa();

app.proxy = true;

// logger

app.use(async (ctx, next) => {
  await next();
  const rt = ctx.response.get('X-Response-Time');
  console.log(`${ctx.method} ${ctx.url} - ${rt}`);
});

// x-response-time

app.use(async (ctx, next) => {
  const start = Date.now();
  await next();
  const ms = Date.now() - start;
  ctx.set('X-Response-Time', `${ms}ms`);
});

// response

async function def (ctx) {
  console.log(ctx.ips);
  ctx.body = `Koa running on ${ctx.request.ip}\n`;
};

router.get('/', def)
  .get('/koa', def);

app.use(router.routes());


if (!module.parent) app.listen(8083, () => {
  console.log("Application Started!");
});

module.exports = app;