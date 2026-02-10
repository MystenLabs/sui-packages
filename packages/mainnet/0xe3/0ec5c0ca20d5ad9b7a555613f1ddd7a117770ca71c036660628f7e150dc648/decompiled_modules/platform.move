module 0xe30ec5c0ca20d5ad9b7a555613f1ddd7a117770ca71c036660628f7e150dc648::platform {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct PlatformConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    public fun init_platform(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id    : 0x2::object::new(arg1),
            admin : arg0,
        };
        0x2::transfer::transfer<AdminCap>(v0, arg0);
        let v1 = PlatformConfig{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : arg0,
        };
        0x2::transfer::share_object<PlatformConfig>(v1);
    }

    // decompiled from Move bytecode v6
}

