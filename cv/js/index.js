import Mustache from "./mustache.js";

console.data = fetch("/cv/data/experience.json")
.then(async (data) => {
    fetch("/cv/templates/experience.template.html")
    .then(async (template) => {
        const rendered = Mustache.render(await template.text(), await data.json());
        const el = document.createElement("div");
        el.innerHTML = rendered;

        const profile = document.querySelector("main");
        profile.insertBefore(el.childNodes[0], profile.lastElementChild);
    });
});
