module 0x45c39da9189c8b9ab7b18c4876ba65c91665ed9842fe76d57b4719a69e3ddf98::admin_registry {
    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct ADMIN_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun get_admin(arg0: &AdminRegistry) : address {
        arg0.admin
    }

    fun init(arg0: ADMIN_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminRegistry{
            id    : 0x2::object::new(arg1),
            admin : @0x9a43df7e88fa9868bf9daed7253b400c7577124265bb3b7598510cb8a5a28f40,
        };
        0x2::transfer::share_object<AdminRegistry>(v0);
    }

    public fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        arg0.admin == arg1
    }

    // decompiled from Move bytecode v6
}

