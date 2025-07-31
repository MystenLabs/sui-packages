module 0xe30b9f0c58cac12a341632af294af29cb33389fdfd241a5b631371fd5cfaeb60::version {
    public fun migrate(arg0: &mut 0xe30b9f0c58cac12a341632af294af29cb33389fdfd241a5b631371fd5cfaeb60::project_manager::ProjectManagerConfig, arg1: &mut 0xe30b9f0c58cac12a341632af294af29cb33389fdfd241a5b631371fd5cfaeb60::milestone::VestingConfig, arg2: &0xe30b9f0c58cac12a341632af294af29cb33389fdfd241a5b631371fd5cfaeb60::launchpad_manager_config::LaunchManagerAdmin) {
        0xe30b9f0c58cac12a341632af294af29cb33389fdfd241a5b631371fd5cfaeb60::project_manager::migrate(arg0);
        0xe30b9f0c58cac12a341632af294af29cb33389fdfd241a5b631371fd5cfaeb60::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

