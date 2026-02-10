module 0x59deaa0810efec346642691164d9a480e8cef70836fcad517fb3da5dd917c975::platform {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct PlatformConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    public entry fun init_platform(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
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

