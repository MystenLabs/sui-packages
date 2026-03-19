module 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::version_admin {
    public fun migrate(arg0: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::AdminCap, arg1: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp) : u64 {
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::migrate(arg1)
    }

    // decompiled from Move bytecode v6
}

