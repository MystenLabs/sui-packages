module 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::version_admin {
    public fun migrate(arg0: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::AdminCap, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp) : u64 {
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::migrate(arg1)
    }

    // decompiled from Move bytecode v6
}

