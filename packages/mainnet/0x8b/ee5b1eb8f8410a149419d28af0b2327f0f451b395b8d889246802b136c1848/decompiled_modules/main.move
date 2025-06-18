module 0x8bee5b1eb8f8410a149419d28af0b2327f0f451b395b8d889246802b136c1848::main {
    struct DexConfig has store, key {
        id: 0x2::object::UID,
        cetus_package: address,
        cetus_config: address,
        bluefin_package: address,
        deepbook_package: address,
        kriya_package: address,
    }

    public fun get_bluefin_package(arg0: &DexConfig) : address {
        arg0.bluefin_package
    }

    public fun get_cetus_package(arg0: &DexConfig) : address {
        arg0.cetus_package
    }

    public fun get_deepbook_package(arg0: &DexConfig) : address {
        arg0.deepbook_package
    }

    public fun get_kriya_package(arg0: &DexConfig) : address {
        arg0.kriya_package
    }

    public entry fun init_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DexConfig{
            id               : 0x2::object::new(arg0),
            cetus_package    : @0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be,
            cetus_config     : @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f,
            bluefin_package  : @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267,
            deepbook_package : @0xcaf6ba059d539a97646d47f0b9ddf843e138d215e2a12ca1f4585d386f7aec3a,
            kriya_package    : @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66,
        };
        0x2::transfer::share_object<DexConfig>(v0);
    }

    public fun verify_config(arg0: &DexConfig) : bool {
        if (arg0.cetus_package != @0x0) {
            if (arg0.bluefin_package != @0x0) {
                if (arg0.deepbook_package != @0x0) {
                    arg0.kriya_package != @0x0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

