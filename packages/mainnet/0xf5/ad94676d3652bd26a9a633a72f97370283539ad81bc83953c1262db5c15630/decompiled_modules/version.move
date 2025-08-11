module 0xf5ad94676d3652bd26a9a633a72f97370283539ad81bc83953c1262db5c15630::version {
    public fun migrate(arg0: &mut 0xf5ad94676d3652bd26a9a633a72f97370283539ad81bc83953c1262db5c15630::project_manager::ProjectManagerConfig, arg1: &mut 0xf5ad94676d3652bd26a9a633a72f97370283539ad81bc83953c1262db5c15630::milestone::VestingConfig, arg2: &0xf5ad94676d3652bd26a9a633a72f97370283539ad81bc83953c1262db5c15630::launchpad_manager_config::LaunchManagerAdmin) {
        0xf5ad94676d3652bd26a9a633a72f97370283539ad81bc83953c1262db5c15630::project_manager::migrate(arg0);
        0xf5ad94676d3652bd26a9a633a72f97370283539ad81bc83953c1262db5c15630::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

