module 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::version_admin {
    public fun migrate(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::AdminCap, arg1: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp) : u64 {
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::migrate(arg1)
    }

    // decompiled from Move bytecode v6
}

