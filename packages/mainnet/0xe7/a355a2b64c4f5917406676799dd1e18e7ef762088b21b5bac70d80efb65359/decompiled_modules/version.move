module 0xe7a355a2b64c4f5917406676799dd1e18e7ef762088b21b5bac70d80efb65359::version {
    public fun migrate(arg0: &mut 0xe7a355a2b64c4f5917406676799dd1e18e7ef762088b21b5bac70d80efb65359::project_manager::ProjectManagerConfig, arg1: &mut 0xe7a355a2b64c4f5917406676799dd1e18e7ef762088b21b5bac70d80efb65359::milestone::VestingConfig, arg2: &0xe7a355a2b64c4f5917406676799dd1e18e7ef762088b21b5bac70d80efb65359::launchpad_manager_config::LaunchManagerAdmin) {
        0xe7a355a2b64c4f5917406676799dd1e18e7ef762088b21b5bac70d80efb65359::project_manager::migrate(arg0);
        0xe7a355a2b64c4f5917406676799dd1e18e7ef762088b21b5bac70d80efb65359::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

