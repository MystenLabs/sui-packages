module 0x8cdd3bd1a996d0d62a65383e6d76e4389a5c2b9c18ad15525e641c941917c9d2::admin_registry {
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

