module 0xfabcc8a26ec82a35ab88bef5521dc7ee100206c1b74f0b54c943e59930e5e117::version {
    public fun migrate(arg0: &mut 0xfabcc8a26ec82a35ab88bef5521dc7ee100206c1b74f0b54c943e59930e5e117::project_manager::ProjectManagerConfig, arg1: &mut 0xfabcc8a26ec82a35ab88bef5521dc7ee100206c1b74f0b54c943e59930e5e117::milestone::VestingConfig, arg2: &0xfabcc8a26ec82a35ab88bef5521dc7ee100206c1b74f0b54c943e59930e5e117::launchpad_manager_config::LaunchManagerAdmin) {
        0xfabcc8a26ec82a35ab88bef5521dc7ee100206c1b74f0b54c943e59930e5e117::project_manager::migrate(arg0);
        0xfabcc8a26ec82a35ab88bef5521dc7ee100206c1b74f0b54c943e59930e5e117::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

