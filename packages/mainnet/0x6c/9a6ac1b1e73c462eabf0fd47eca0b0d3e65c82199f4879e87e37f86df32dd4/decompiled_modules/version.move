module 0x6c9a6ac1b1e73c462eabf0fd47eca0b0d3e65c82199f4879e87e37f86df32dd4::version {
    public fun migrate(arg0: &mut 0x6c9a6ac1b1e73c462eabf0fd47eca0b0d3e65c82199f4879e87e37f86df32dd4::project_manager::ProjectManagerConfig, arg1: &mut 0x6c9a6ac1b1e73c462eabf0fd47eca0b0d3e65c82199f4879e87e37f86df32dd4::milestone::VestingConfig, arg2: &0x6c9a6ac1b1e73c462eabf0fd47eca0b0d3e65c82199f4879e87e37f86df32dd4::launchpad_manager_config::LaunchManagerAdmin) {
        0x6c9a6ac1b1e73c462eabf0fd47eca0b0d3e65c82199f4879e87e37f86df32dd4::project_manager::migrate(arg0);
        0x6c9a6ac1b1e73c462eabf0fd47eca0b0d3e65c82199f4879e87e37f86df32dd4::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

