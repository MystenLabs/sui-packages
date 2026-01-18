module 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        base_tokens: vector<0x1::type_name::TypeName>,
        dex_enabled: vector<DexConfig>,
        pools: vector<PoolInfo>,
    }

    struct DexConfig has copy, drop, store {
        dex: u8,
        enabled: bool,
    }

    struct PoolInfo has copy, drop, store {
        dex: u8,
        coin_x: 0x1::type_name::TypeName,
        coin_y: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
        fee_rate: u64,
    }

    public fun add_base_token<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        assert_admin(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!contains_type(&arg0.base_tokens, &v0), 3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.base_tokens, v0);
    }

    public fun add_pool<T0, T1>(arg0: &mut Registry, arg1: &AdminCap, arg2: u8, arg3: 0x2::object::ID, arg4: u64) {
        assert_admin(arg0, arg1);
        assert_valid_dex(arg2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(!has_pool_by_type(&arg0.pools, arg2, &v0, &v1), 1);
        let v2 = PoolInfo{
            dex      : arg2,
            coin_x   : v0,
            coin_y   : v1,
            pool_id  : arg3,
            fee_rate : arg4,
        };
        0x1::vector::push_back<PoolInfo>(&mut arg0.pools, v2);
    }

    fun assert_admin(arg0: &Registry, arg1: &AdminCap) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 0);
    }

    public fun assert_base_token<T0>(arg0: &Registry) {
        assert!(is_base_token<T0>(arg0), 4);
    }

    public fun assert_dex_enabled(arg0: &Registry, arg1: u8) {
        assert!(is_dex_enabled(arg0, arg1), 6);
    }

    public fun assert_pool<T0, T1>(arg0: &Registry, arg1: u8) {
        assert_dex_enabled(arg0, arg1);
        assert!(has_pool<T0, T1>(arg0, arg1), 2);
    }

    fun assert_valid_dex(arg0: u8) {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v0, 5);
    }

    fun contains_type(arg0: &vector<0x1::type_name::TypeName>, arg1: &0x1::type_name::TypeName) : bool {
        let (v0, _) = find_type_index(arg0, arg1);
        v0
    }

    public fun dex_bluefin() : u8 {
        3
    }

    public fun dex_cetus() : u8 {
        1
    }

    public fun dex_flowx() : u8 {
        2
    }

    fun find_dex_index(arg0: &vector<DexConfig>, arg1: u8) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<DexConfig>(arg0)) {
            if (0x1::vector::borrow<DexConfig>(arg0, v0).dex == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun find_pool_index(arg0: &vector<PoolInfo>, arg1: u8, arg2: &0x1::type_name::TypeName, arg3: &0x1::type_name::TypeName) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PoolInfo>(arg0)) {
            let v1 = 0x1::vector::borrow<PoolInfo>(arg0, v0);
            let v2 = if (v1.dex == arg1) {
                if (v1.coin_x == *arg2) {
                    v1.coin_y == *arg3
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun find_type_index(arg0: &vector<0x1::type_name::TypeName>, arg1: &0x1::type_name::TypeName) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(arg0)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v0) == *arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun get_fee_rate<T0, T1>(arg0: &Registry, arg1: u8) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let (v2, v3) = find_pool_index(&arg0.pools, arg1, &v0, &v1);
        assert!(v2, 2);
        0x1::vector::borrow<PoolInfo>(&arg0.pools, v3).fee_rate
    }

    public fun get_pool_id<T0, T1>(arg0: &Registry, arg1: u8) : 0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let (v2, v3) = find_pool_index(&arg0.pools, arg1, &v0, &v1);
        assert!(v2, 2);
        0x1::vector::borrow<PoolInfo>(&arg0.pools, v3).pool_id
    }

    public fun has_pool<T0, T1>(arg0: &Registry, arg1: u8) : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        has_pool_by_type(&arg0.pools, arg1, &v0, &v1)
    }

    fun has_pool_by_type(arg0: &vector<PoolInfo>, arg1: u8, arg2: &0x1::type_name::TypeName, arg3: &0x1::type_name::TypeName) : bool {
        let (v0, _) = find_pool_index(arg0, arg1, arg2, arg3);
        v0
    }

    public entry fun init_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id          : 0x2::object::new(arg0),
            base_tokens : 0x1::vector::empty<0x1::type_name::TypeName>(),
            dex_enabled : 0x1::vector::empty<DexConfig>(),
            pools       : 0x1::vector::empty<PoolInfo>(),
        };
        let v1 = AdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<Registry>(&v0),
        };
        0x2::transfer::share_object<Registry>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_base_token<T0>(arg0: &Registry) : bool {
        let v0 = 0x1::type_name::get<T0>();
        contains_type(&arg0.base_tokens, &v0)
    }

    public fun is_dex_enabled(arg0: &Registry, arg1: u8) : bool {
        let (v0, v1) = find_dex_index(&arg0.dex_enabled, arg1);
        !v0 && false || 0x1::vector::borrow<DexConfig>(&arg0.dex_enabled, v1).enabled
    }

    public fun remove_base_token<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        assert_admin(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = find_type_index(&arg0.base_tokens, &v0);
        assert!(v1, 4);
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.base_tokens, v2);
    }

    public fun remove_pool<T0, T1>(arg0: &mut Registry, arg1: &AdminCap, arg2: u8) {
        assert_admin(arg0, arg1);
        assert_valid_dex(arg2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let (v2, v3) = find_pool_index(&arg0.pools, arg2, &v0, &v1);
        assert!(v2, 2);
        0x1::vector::swap_remove<PoolInfo>(&mut arg0.pools, v3);
    }

    public fun set_base_tokens(arg0: &mut Registry, arg1: &AdminCap, arg2: vector<0x1::type_name::TypeName>) {
        assert_admin(arg0, arg1);
        arg0.base_tokens = arg2;
    }

    public fun set_dex_enabled(arg0: &mut Registry, arg1: &AdminCap, arg2: u8, arg3: bool) {
        assert_admin(arg0, arg1);
        assert_valid_dex(arg2);
        let (v0, v1) = find_dex_index(&arg0.dex_enabled, arg2);
        if (v0) {
            0x1::vector::borrow_mut<DexConfig>(&mut arg0.dex_enabled, v1).enabled = arg3;
        } else {
            let v2 = DexConfig{
                dex     : arg2,
                enabled : arg3,
            };
            0x1::vector::push_back<DexConfig>(&mut arg0.dex_enabled, v2);
        };
    }

    // decompiled from Move bytecode v6
}

