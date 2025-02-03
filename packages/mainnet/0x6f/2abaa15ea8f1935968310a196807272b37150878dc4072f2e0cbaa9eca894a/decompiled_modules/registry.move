module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct DeepbookAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct RegistryInner has store {
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        pools: 0x2::bag::Bag,
        treasury_address: address,
    }

    struct PoolKey has copy, drop, store {
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
    }

    public(friend) fun allowed_versions(arg0: &Registry) : 0x2::vec_set::VecSet<u64> {
        load_inner(arg0).allowed_versions
    }

    public fun disable_version(arg0: &mut Registry, arg1: u64, arg2: &DeepbookAdminCap) {
        let v0 = 0x2::versioned::load_value_mut<RegistryInner>(&mut arg0.inner);
        assert!(arg1 != 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::current_version(), 6);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 4);
        0x2::vec_set::remove<u64>(&mut v0.allowed_versions, &arg1);
    }

    public fun enable_version(arg0: &mut Registry, arg1: u64, arg2: &DeepbookAdminCap) {
        let v0 = 0x2::versioned::load_value_mut<RegistryInner>(&mut arg0.inner);
        assert!(!0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 5);
        0x2::vec_set::insert<u64>(&mut v0.allowed_versions, arg1);
    }

    public(friend) fun get_pool_id<T0, T1>(arg0: &Registry) : 0x2::object::ID {
        let v0 = load_inner(arg0);
        let v1 = PoolKey{
            base  : 0x1::type_name::get<T0>(),
            quote : 0x1::type_name::get<T1>(),
        };
        assert!(0x2::bag::contains<PoolKey>(&v0.pools, v1), 2);
        *0x2::bag::borrow<PoolKey, 0x2::object::ID>(&v0.pools, v1)
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistryInner{
            allowed_versions : 0x2::vec_set::singleton<u64>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::current_version()),
            pools            : 0x2::bag::new(arg1),
            treasury_address : 0x2::tx_context::sender(arg1),
        };
        let v1 = Registry{
            id    : 0x2::object::new(arg1),
            inner : 0x2::versioned::create<RegistryInner>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::current_version(), v0, arg1),
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = DeepbookAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<DeepbookAdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun load_inner(arg0: &Registry) : &RegistryInner {
        let v0 = 0x2::versioned::load_value<RegistryInner>(&arg0.inner);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 3);
        v0
    }

    public(friend) fun load_inner_mut(arg0: &mut Registry) : &mut RegistryInner {
        let v0 = 0x2::versioned::load_value_mut<RegistryInner>(&mut arg0.inner);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 3);
        v0
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Registry, arg1: 0x2::object::ID) {
        let v0 = load_inner_mut(arg0);
        let v1 = PoolKey{
            base  : 0x1::type_name::get<T1>(),
            quote : 0x1::type_name::get<T0>(),
        };
        assert!(!0x2::bag::contains<PoolKey>(&v0.pools, v1), 1);
        let v2 = PoolKey{
            base  : 0x1::type_name::get<T0>(),
            quote : 0x1::type_name::get<T1>(),
        };
        assert!(!0x2::bag::contains<PoolKey>(&v0.pools, v2), 1);
        0x2::bag::add<PoolKey, 0x2::object::ID>(&mut v0.pools, v2, arg1);
    }

    public fun set_treasury_address(arg0: &mut Registry, arg1: address, arg2: &DeepbookAdminCap) {
        load_inner_mut(arg0).treasury_address = arg1;
    }

    public(friend) fun treasury_address(arg0: &Registry) : address {
        load_inner(arg0).treasury_address
    }

    public(friend) fun unregister_pool<T0, T1>(arg0: &mut Registry) {
        let v0 = load_inner_mut(arg0);
        let v1 = PoolKey{
            base  : 0x1::type_name::get<T0>(),
            quote : 0x1::type_name::get<T1>(),
        };
        assert!(0x2::bag::contains<PoolKey>(&v0.pools, v1), 2);
        0x2::bag::remove<PoolKey, 0x2::object::ID>(&mut v0.pools, v1);
    }

    // decompiled from Move bytecode v6
}

