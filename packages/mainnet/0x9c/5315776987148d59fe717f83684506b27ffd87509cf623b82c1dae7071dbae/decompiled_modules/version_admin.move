module 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::version_admin {
    public fun migrate(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp) : u64 {
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::migrate(arg1)
    }

    // decompiled from Move bytecode v6
}

