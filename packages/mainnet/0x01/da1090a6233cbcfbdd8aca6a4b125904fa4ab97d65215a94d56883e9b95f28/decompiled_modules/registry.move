module 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolKey has copy, drop, store {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        pools: 0x2::vec_map::VecMap<PoolKey, 0x2::object::ID>,
    }

    public(friend) fun allowed_versions(arg0: &Registry) : 0x2::vec_set::VecSet<u64> {
        arg0.allowed_versions
    }

    public fun disable_version(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 != 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::constants::current_version(), 3);
        assert!(0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg1), 1);
        0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg1);
    }

    public fun enable_version(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        assert!(!0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg1), 2);
        0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u64>(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::constants::current_version()),
            pools            : 0x2::vec_map::empty<PoolKey, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Registry, arg1: 0x2::object::ID) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = PoolKey{
            type_x : v1,
            type_y : v0,
        };
        assert!(!0x2::vec_map::contains<PoolKey, 0x2::object::ID>(&arg0.pools, &v2), 0);
        let v3 = PoolKey{
            type_x : v0,
            type_y : v1,
        };
        assert!(!0x2::vec_map::contains<PoolKey, 0x2::object::ID>(&arg0.pools, &v3), 0);
        0x2::vec_map::insert<PoolKey, 0x2::object::ID>(&mut arg0.pools, v3, arg1);
    }

    // decompiled from Move bytecode v6
}

