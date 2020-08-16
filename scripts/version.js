const util = require("util");
const exec = util.promisify(require("child_process").exec);

(async function () {
  const { stdout: LONGVERSION } = await exec(
    `$(git describe--tags--long--abbrev = 8 --always HEAD || : )$(echo - "$GITHUB_REF##*/" | tr / - | grep - v '\-master' || : )`
  );
  const VERSION = await exec(`$github.sha-${LONGVERSION}`);
  const REACT_APP_VERSION = VERSION;
  await exec(`export LONGVERSION=${LONGVERSION}`);
  await exec(`export VERSION=${VERSION}`);
  await exec(`export REACT_APP_VERSION=${REACT_APP_VERSION}`);
})();
