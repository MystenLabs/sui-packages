module 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::pool_registry {
    struct FluxAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        pools: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct POOL_2 {
        dummy_field: bool,
    }

    public fun create_new_pool<T0>(arg0: &FluxAdminCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::pool::PoolOwnerCap<T0>, 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::pool::Pool<T0>) {
        let (v0, v1) = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::pool::create_pool_internal<T0>(arg2, arg3);
        let v2 = v1;
        register_pool<T0>(arg1, 0x2::object::id<0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::pool::Pool<T0>>(&v2));
        (v0, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            version : 1,
            pools   : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        let v1 = FluxAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FluxAdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun register_pool<T0>(arg0: &mut Registry, arg1: 0x2::object::ID) {
        assert!(arg0.version == 1, 1);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, 0x1::type_name::get<T0>()), 2);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pools, 0x1::type_name::get<T0>(), arg1);
    }

    public(friend) fun unregister_pool<T0>(arg0: &mut Registry) {
        assert!(arg0.version == 1, 1);
        0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pools, 0x1::type_name::get<T0>());
    }

    // decompiled from Move bytecode v6
}

