module 0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::version {
    public fun migrate(arg0: &mut 0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::ProjectManagerConfig, arg1: &mut 0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::milestone::VestingConfig, arg2: &0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::launchpad_manager_config::LaunchManagerAdmin) {
        0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::migrate(arg0);
        0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

