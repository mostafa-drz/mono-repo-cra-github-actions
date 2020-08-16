const util = require("util");
const exec = util.promisify(require("child_process").exec);

(async function () {
  const VERSION = generateDateVersion();
  const newTag = await getNewTag(VERSION);
  pushNewTag(newTag);
})();

function generateDateVersion() {
  const date = new Date();
  return `v${date.getFullYear()}.${date.getMonth()}.${date.getDate()}`;
}

// Gets all the tags for today
async function getNewTag(todayVersion) {
  let newTag = "";
  try {
    const { stderr, stdout } = await exec("git tag -l --sort=v:refname");
    if (stderr) {
      console.error(stderr);
      return;
    } else {
      const allTags = stdout.split("\n");
      if (allTags.includes(`${todayVersion}-1`.trim())) {
        newTag = `${todayVersion}-${allTags.length + 1}`;
      } else {
        newTag = `${todayVersion}-1`;
      }
      return newTag;
    }
  } catch (error) {
    console.error(error);
  }
}

async function pushNewTag(newTag) {
  try {
    const { stderr: newTagError } = await exec(`git tag ${newTag}`);
    if (newTagError) {
      console.error(newTagError);
      return;
    }
    const { stderr: pushTagsError } = await exec(`git push --tags`);
    if (pushTagsError) {
      console.error(pushTagsError);
      return;
    }
  } catch (error) {
    console.error(error);
  }
}
