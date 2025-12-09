module 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry {
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

    struct StableCoinKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BalanceManagerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AppKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun add_balance_manager(arg0: &mut Registry, arg1: address, arg2: 0x2::object::ID) {
        load_inner_mut(arg0);
        let v0 = BalanceManagerKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<BalanceManagerKey, 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>>(&mut arg0.id, v0);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(v1, arg1)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(v1, arg1, 0x2::vec_set::empty<0x2::object::ID>());
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(v1, arg1);
        if (!0x2::vec_set::contains<0x2::object::ID>(v2, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(v2, arg2);
        };
        assert!(0x2::vec_set::length<0x2::object::ID>(v2) <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_balance_managers(), 9);
    }

    public fun add_stablecoin<T0>(arg0: &mut Registry, arg1: &DeepbookAdminCap) {
        load_inner_mut(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = StableCoinKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<StableCoinKey>(&arg0.id, v1)) {
            let v2 = StableCoinKey{dummy_field: false};
            0x2::dynamic_field::add<StableCoinKey, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, v2, 0x2::vec_set::singleton<0x1::type_name::TypeName>(v0));
        } else {
            let v3 = StableCoinKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow_mut<StableCoinKey, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, v3);
            assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(v4, &v0), 7);
            0x2::vec_set::insert<0x1::type_name::TypeName>(v4, v0);
        };
    }

    public(friend) fun allowed_versions(arg0: &Registry) : 0x2::vec_set::VecSet<u64> {
        load_inner(arg0).allowed_versions
    }

    public fun assert_app_is_authorized<T0: drop>(arg0: &Registry) {
        let v0 = AppKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<AppKey<T0>>(&arg0.id, v0), 10);
    }

    public fun authorize_app<T0: drop>(arg0: &mut Registry, arg1: &DeepbookAdminCap) {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AppKey<T0>, bool>(&mut arg0.id, v0, true);
    }

    public fun deauthorize_app<T0: drop>(arg0: &mut Registry, arg1: &DeepbookAdminCap) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<AppKey<T0>, bool>(&mut arg0.id, v0)
    }

    public fun disable_version(arg0: &mut Registry, arg1: u64, arg2: &DeepbookAdminCap) {
        let v0 = 0x2::versioned::load_value_mut<RegistryInner>(&mut arg0.inner);
        assert!(arg1 != 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::current_version(), 6);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 4);
        0x2::vec_set::remove<u64>(&mut v0.allowed_versions, &arg1);
    }

    public fun enable_version(arg0: &mut Registry, arg1: u64, arg2: &DeepbookAdminCap) {
        let v0 = 0x2::versioned::load_value_mut<RegistryInner>(&mut arg0.inner);
        assert!(!0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 5);
        0x2::vec_set::insert<u64>(&mut v0.allowed_versions, arg1);
    }

    public fun get_balance_manager_ids(arg0: &Registry, arg1: address) : 0x2::vec_set::VecSet<0x2::object::ID> {
        let v0 = BalanceManagerKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<BalanceManagerKey, 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>>(&arg0.id, v0);
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(v1, arg1)) {
            *0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(v1, arg1)
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    public(friend) fun get_pool_id<T0, T1>(arg0: &Registry) : 0x2::object::ID {
        let v0 = load_inner(arg0);
        let v1 = PoolKey{
            base  : 0x1::type_name::with_defining_ids<T0>(),
            quote : 0x1::type_name::with_defining_ids<T1>(),
        };
        assert!(0x2::bag::contains<PoolKey>(&v0.pools, v1), 2);
        *0x2::bag::borrow<PoolKey, 0x2::object::ID>(&v0.pools, v1)
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistryInner{
            allowed_versions : 0x2::vec_set::singleton<u64>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::current_version()),
            pools            : 0x2::bag::new(arg1),
            treasury_address : 0x2::tx_context::sender(arg1),
        };
        let v1 = Registry{
            id    : 0x2::object::new(arg1),
            inner : 0x2::versioned::create<RegistryInner>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::current_version(), v0, arg1),
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = DeepbookAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<DeepbookAdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun init_balance_manager_map(arg0: &mut Registry, arg1: &DeepbookAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        load_inner_mut(arg0);
        let v0 = BalanceManagerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceManagerKey>(&arg0.id, v0)) {
            let v1 = BalanceManagerKey{dummy_field: false};
            0x2::dynamic_field::add<BalanceManagerKey, 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>>(&mut arg0.id, v1, 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg2));
        };
    }

    public fun is_stablecoin(arg0: &Registry, arg1: 0x1::type_name::TypeName) : bool {
        load_inner(arg0);
        let v0 = StableCoinKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<StableCoinKey>(&arg0.id, v0)) {
            false
        } else {
            let v2 = StableCoinKey{dummy_field: false};
            0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::dynamic_field::borrow<StableCoinKey, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.id, v2), &arg1)
        }
    }

    public(friend) fun load_inner(arg0: &Registry) : &RegistryInner {
        let v0 = 0x2::versioned::load_value<RegistryInner>(&arg0.inner);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 3);
        v0
    }

    public(friend) fun load_inner_mut(arg0: &mut Registry) : &mut RegistryInner {
        let v0 = 0x2::versioned::load_value_mut<RegistryInner>(&mut arg0.inner);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 3);
        v0
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Registry, arg1: 0x2::object::ID) {
        let v0 = load_inner_mut(arg0);
        let v1 = PoolKey{
            base  : 0x1::type_name::with_defining_ids<T1>(),
            quote : 0x1::type_name::with_defining_ids<T0>(),
        };
        assert!(!0x2::bag::contains<PoolKey>(&v0.pools, v1), 1);
        let v2 = PoolKey{
            base  : 0x1::type_name::with_defining_ids<T0>(),
            quote : 0x1::type_name::with_defining_ids<T1>(),
        };
        assert!(!0x2::bag::contains<PoolKey>(&v0.pools, v2), 1);
        0x2::bag::add<PoolKey, 0x2::object::ID>(&mut v0.pools, v2, arg1);
    }

    public fun remove_stablecoin<T0>(arg0: &mut Registry, arg1: &DeepbookAdminCap) {
        load_inner_mut(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = StableCoinKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<StableCoinKey>(&arg0.id, v1), 8);
        let v2 = StableCoinKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<StableCoinKey, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, v2);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(v3, &v0), 8);
        0x2::vec_set::remove<0x1::type_name::TypeName>(v3, &v0);
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
            base  : 0x1::type_name::with_defining_ids<T0>(),
            quote : 0x1::type_name::with_defining_ids<T1>(),
        };
        assert!(0x2::bag::contains<PoolKey>(&v0.pools, v1), 2);
        0x2::bag::remove<PoolKey, 0x2::object::ID>(&mut v0.pools, v1);
    }

    // decompiled from Move bytecode v6
}

