module 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::version_admin {
    public fun migrate(arg0: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::AdminCap, arg1: &mut 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp) : u64 {
        0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::migrate(arg1)
    }

    // decompiled from Move bytecode v6
}

