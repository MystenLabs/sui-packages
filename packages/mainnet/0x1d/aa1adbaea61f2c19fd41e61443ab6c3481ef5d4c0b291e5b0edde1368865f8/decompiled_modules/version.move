module 0x1daa1adbaea61f2c19fd41e61443ab6c3481ef5d4c0b291e5b0edde1368865f8::version {
    public fun migrate(arg0: &mut 0x1daa1adbaea61f2c19fd41e61443ab6c3481ef5d4c0b291e5b0edde1368865f8::project_manager::ProjectManagerConfig, arg1: &mut 0x1daa1adbaea61f2c19fd41e61443ab6c3481ef5d4c0b291e5b0edde1368865f8::milestone::VestingConfig, arg2: &0x1daa1adbaea61f2c19fd41e61443ab6c3481ef5d4c0b291e5b0edde1368865f8::launchpad_manager_config::LaunchManagerAdmin) {
        0x1daa1adbaea61f2c19fd41e61443ab6c3481ef5d4c0b291e5b0edde1368865f8::project_manager::migrate(arg0);
        0x1daa1adbaea61f2c19fd41e61443ab6c3481ef5d4c0b291e5b0edde1368865f8::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

