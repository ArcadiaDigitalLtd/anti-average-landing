/// <reference path="./.sst/platform/config.d.ts" />

export default $config({
  app(input) {
    return {
      name: "anti-average",
      removal: input?.stage === "production" ? "retain" : "remove",
      home: "aws",
    };
  },
  async run() {
    new sst.aws.StaticSite("AntiAverageSite", {
      path: "site",
      domain: {
        name: "antiaverage.studio",
        aliases: ["www.antiaverage.studio"],
        dns: sst.aws.dns(),
      },
    });
  },
});
