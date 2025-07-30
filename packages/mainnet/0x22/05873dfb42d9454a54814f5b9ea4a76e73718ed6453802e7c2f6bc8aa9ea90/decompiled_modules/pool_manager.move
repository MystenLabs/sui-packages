module 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool_manager {
    struct PoolDfKey has copy, drop, store {
        coin_type_x: 0x1::type_name::TypeName,
        coin_type_y: 0x1::type_name::TypeName,
        fee_rate: u64,
    }

    struct PoolManagerDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        fee_amount_tick_spacing: 0x2::table::Table<u64, u32>,
        num_pools: u64,
    }

    struct PoolCreated has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        coin_type_x: 0x1::type_name::TypeName,
        coin_type_y: 0x1::type_name::TypeName,
        fee_rate: u64,
        tick_spacing: u32,
    }

    struct FeeRateEnabled has copy, drop, store {
        sender: address,
        fee_rate: u64,
        tick_spacing: u32,
    }

    struct PoolManagerGranted has copy, drop, store {
        sender: address,
        pool_manager: address,
    }

    struct PoolManagerRevoked has copy, drop, store {
        sender: address,
        pool_manager: address,
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::admin_cap::AdminCap, arg1: &mut PoolRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::collect_protocol_fee<T0, T1>(arg0, borrow_mut_pool<T0, T1>(arg1, arg2), arg3, arg4, arg5, arg6);
        (0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::from_balance<T1>(v1, arg6))
    }

    public fun extend_pool_reward_timestamp<T0, T1, T2>(arg0: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::admin_cap::AdminCap, arg1: &mut PoolRegistry, arg2: u64, arg3: u64, arg4: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::extend_pool_reward_timestamp<T0, T1, T2>(arg0, borrow_mut_pool<T0, T1>(arg1, arg2), arg3, arg4, arg5, arg6);
    }

    public fun increase_pool_reward<T0, T1, T2>(arg0: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::admin_cap::AdminCap, arg1: &mut PoolRegistry, arg2: u64, arg3: 0x2::coin::Coin<T2>, arg4: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::increase_pool_reward<T0, T1, T2>(arg0, borrow_mut_pool<T0, T1>(arg1, arg2), 0x2::coin::into_balance<T2>(arg3), arg4, arg5, arg6);
    }

    public fun initialize_pool_reward<T0, T1, T2>(arg0: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::admin_cap::AdminCap, arg1: &mut PoolRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T2>, arg6: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::initialize_pool_reward<T0, T1, T2>(arg0, borrow_mut_pool<T0, T1>(arg1, arg2), arg3, arg4, 0x2::coin::into_balance<T2>(arg5), arg6, arg7, arg8);
    }

    public fun set_protocol_fee_rate<T0, T1>(arg0: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::admin_cap::AdminCap, arg1: &mut PoolRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::set_protocol_fee_rate<T0, T1>(arg0, borrow_mut_pool<T0, T1>(arg1, arg2), arg3, arg4, arg5, arg6);
    }

    public fun borrow_mut_pool<T0, T1>(arg0: &mut PoolRegistry, arg1: u64) : &mut 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::Pool<T0, T1> {
        check_exists<T0, T1>(arg0, arg1);
        0x2::dynamic_object_field::borrow_mut<PoolDfKey, 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::Pool<T0, T1>>(&mut arg0.id, pool_key<T0, T1>(arg1))
    }

    public fun borrow_pool<T0, T1>(arg0: &PoolRegistry, arg1: u64) : &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::Pool<T0, T1> {
        check_exists<T0, T1>(arg0, arg1);
        0x2::dynamic_object_field::borrow<PoolDfKey, 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::Pool<T0, T1>>(&arg0.id, pool_key<T0, T1>(arg1))
    }

    public fun check_exists<T0, T1>(arg0: &PoolRegistry, arg1: u64) {
        if (!0x2::dynamic_object_field::exists_<PoolDfKey>(&arg0.id, pool_key<T0, T1>(arg1))) {
            abort 5
        };
    }

    public fun check_pool_manager(arg0: &PoolRegistry, arg1: &0x2::tx_context::TxContext) {
        let v0 = PoolManagerDfKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists_with_type<PoolManagerDfKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0)) {
            let v2 = PoolManagerDfKey{dummy_field: false};
            let v3 = 0x2::tx_context::sender(arg1);
            !0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<PoolManagerDfKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v2), &v3)
        } else {
            false
        };
        if (v1) {
            abort 7
        };
    }

    public fun create_and_initialize_pool<T0, T1>(arg0: &mut PoolRegistry, arg1: u64, arg2: u128, arg3: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        create_pool<T0, T1>(arg0, arg1, arg3, arg5);
        if (0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::is_ordered<T0, T1>()) {
            0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::initialize<T0, T1>(borrow_mut_pool<T0, T1>(arg0, arg1), arg2, arg3, arg4, arg5);
        } else {
            0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::initialize<T1, T0>(borrow_mut_pool<T1, T0>(arg0, arg1), arg2, arg3, arg4, arg5);
        };
    }

    public fun create_and_initialize_pool_v2<T0, T1>(arg0: &mut PoolRegistry, arg1: u64, arg2: u128, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        create_pool_v2<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7);
        if (0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::is_ordered<T0, T1>()) {
            0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::initialize<T0, T1>(borrow_mut_pool<T0, T1>(arg0, arg1), arg2, arg5, arg6, arg7);
        } else {
            0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::initialize<T1, T0>(borrow_mut_pool<T1, T0>(arg0, arg1), arg2, arg5, arg6, arg7);
        };
    }

    public fun create_pool<T0, T1>(arg0: &mut PoolRegistry, arg1: u64, arg2: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::check_version(arg2);
        check_pool_manager(arg0, arg3);
        create_pool_permission_less<T0, T1>(arg0, arg1, arg3);
    }

    fun create_pool_<T0, T1>(arg0: &mut PoolRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<u64, u32>(&arg0.fee_amount_tick_spacing, arg1);
        let v1 = pool_key<T0, T1>(arg1);
        if (0x2::dynamic_object_field::exists_<PoolDfKey>(&arg0.id, v1)) {
            abort 1
        };
        let v2 = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::create<T0, T1>(arg1, v0, arg2);
        let v3 = PoolCreated{
            sender       : 0x2::tx_context::sender(arg2),
            pool_id      : 0x2::object::id<0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::Pool<T0, T1>>(&v2),
            coin_type_x  : 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::coin_type_x<T0, T1>(&v2),
            coin_type_y  : 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::coin_type_y<T0, T1>(&v2),
            fee_rate     : arg1,
            tick_spacing : v0,
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::dynamic_object_field::add<PoolDfKey, 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::Pool<T0, T1>>(&mut arg0.id, v1, v2);
        arg0.num_pools = arg0.num_pools + 1;
    }

    fun create_pool_permission_less<T0, T1>(arg0: &mut PoolRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u64, u32>(&arg0.fee_amount_tick_spacing, arg1)) {
            abort 6
        };
        if (0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::is_ordered<T0, T1>()) {
            create_pool_<T0, T1>(arg0, arg1, arg2);
        } else {
            create_pool_<T1, T0>(arg0, arg1, arg2);
        };
    }

    public fun create_pool_v2<T0, T1>(arg0: &mut PoolRegistry, arg1: u64, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::check_version(arg4);
        create_pool_permission_less<T0, T1>(arg0, arg1, arg5);
    }

    public fun enable_fee_rate(arg0: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::admin_cap::AdminCap, arg1: &mut PoolRegistry, arg2: u64, arg3: u32, arg4: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::check_version(arg4);
        if (arg2 >= 1000000) {
            abort 2
        };
        if (arg3 == 0 || arg3 >= 4194304) {
            abort 3
        };
        if (0x2::table::contains<u64, u32>(&arg1.fee_amount_tick_spacing, arg2)) {
            abort 4
        };
        enable_fee_rate_internal(arg1, arg2, arg3, arg5);
    }

    fun enable_fee_rate_internal(arg0: &mut PoolRegistry, arg1: u64, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        0x2::table::add<u64, u32>(&mut arg0.fee_amount_tick_spacing, arg1, arg2);
        let v0 = FeeRateEnabled{
            sender       : 0x2::tx_context::sender(arg3),
            fee_rate     : arg1,
            tick_spacing : arg2,
        };
        0x2::event::emit<FeeRateEnabled>(v0);
    }

    public fun grant_pool_manager(arg0: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::admin_cap::AdminCap, arg1: &mut PoolRegistry, arg2: address, arg3: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::check_version(arg3);
        let v0 = PoolManagerDfKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<PoolManagerDfKey, 0x2::vec_set::VecSet<address>>(&arg1.id, v0)) {
            let v1 = PoolManagerDfKey{dummy_field: false};
            0x2::dynamic_field::add<PoolManagerDfKey, 0x2::vec_set::VecSet<address>>(&mut arg1.id, v1, 0x2::vec_set::empty<address>());
        };
        let v2 = PoolManagerDfKey{dummy_field: false};
        0x2::vec_set::insert<address>(0x2::dynamic_field::borrow_mut<PoolManagerDfKey, 0x2::vec_set::VecSet<address>>(&mut arg1.id, v2), arg2);
        let v3 = PoolManagerGranted{
            sender       : 0x2::tx_context::sender(arg4),
            pool_manager : arg2,
        };
        0x2::event::emit<PoolManagerGranted>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id                      : 0x2::object::new(arg0),
            fee_amount_tick_spacing : 0x2::table::new<u64, u32>(arg0),
            num_pools               : 0,
        };
        let v1 = &mut v0;
        enable_fee_rate_internal(v1, 100, 2, arg0);
        let v2 = &mut v0;
        enable_fee_rate_internal(v2, 500, 10, arg0);
        let v3 = &mut v0;
        enable_fee_rate_internal(v3, 3000, 60, arg0);
        let v4 = &mut v0;
        enable_fee_rate_internal(v4, 10000, 200, arg0);
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    fun pool_key<T0, T1>(arg0: u64) : PoolDfKey {
        PoolDfKey{
            coin_type_x : 0x1::type_name::get<T0>(),
            coin_type_y : 0x1::type_name::get<T1>(),
            fee_rate    : arg0,
        }
    }

    public fun revoke_pool_manager(arg0: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::admin_cap::AdminCap, arg1: &mut PoolRegistry, arg2: address, arg3: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::check_version(arg3);
        let v0 = PoolManagerDfKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<PoolManagerDfKey, 0x2::vec_set::VecSet<address>>(&arg1.id, v0)) {
            let v1 = PoolManagerDfKey{dummy_field: false};
            0x2::dynamic_field::add<PoolManagerDfKey, 0x2::vec_set::VecSet<address>>(&mut arg1.id, v1, 0x2::vec_set::empty<address>());
        };
        let v2 = PoolManagerDfKey{dummy_field: false};
        0x2::vec_set::remove<address>(0x2::dynamic_field::borrow_mut<PoolManagerDfKey, 0x2::vec_set::VecSet<address>>(&mut arg1.id, v2), &arg2);
        let v3 = PoolManagerRevoked{
            sender       : 0x2::tx_context::sender(arg4),
            pool_manager : arg2,
        };
        0x2::event::emit<PoolManagerRevoked>(v3);
    }

    // decompiled from Move bytecode v6
}

