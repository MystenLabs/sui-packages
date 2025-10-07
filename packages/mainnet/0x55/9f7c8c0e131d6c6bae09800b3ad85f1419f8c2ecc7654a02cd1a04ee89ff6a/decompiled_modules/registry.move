module 0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry {
    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        version: u64,
        created_at: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: address,
        admin: address,
        created_at: u64,
    }

    struct REGISTRY has drop {
        dummy_field: bool,
    }

    public fun get_admin(arg0: &AdminRegistry) : address {
        arg0.admin
    }

    public fun get_info(arg0: &AdminRegistry) : (address, u64, u64) {
        (arg0.admin, arg0.version, arg0.created_at)
    }

    public fun get_registry_id(arg0: &AdminRegistry) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminRegistry{
            id         : 0x2::object::new(arg1),
            admin      : @0x9a43df7e88fa9868bf9daed7253b400c7577124265bb3b7598510cb8a5a28f40,
            version    : 1,
            created_at : 0x2::tx_context::epoch(arg1),
        };
        let v1 = RegistryCreated{
            registry_id : 0x2::object::uid_to_address(&v0.id),
            admin       : @0x9a43df7e88fa9868bf9daed7253b400c7577124265bb3b7598510cb8a5a28f40,
            created_at  : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<RegistryCreated>(v1);
        0x2::transfer::share_object<AdminRegistry>(v0);
    }

    public fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        arg0.admin == arg1
    }

    // decompiled from Move bytecode v6
}

