module 0x59340db01e8120120a5680094f769b5866fd3eac3d50cd3f21e9da395cf0a6e0::dex_migration {
    struct MigrationRegistry has key {
        id: 0x2::object::UID,
        total_migrations: u64,
        total_liquidity_migrated: u128,
    }

    struct MigrationInfo has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        dex_type: u8,
        dex_pool_id: 0x1::option::Option<0x2::object::ID>,
        liquidity_migrated: u64,
        tokens_added: u64,
        initial_price: u128,
        migrated_at: u64,
        migrated_by: address,
    }

    struct MigrationStarted has copy, drop {
        pool_id: 0x2::object::ID,
        dex_type: u8,
        liquidity_amount: u64,
        token_amount: u64,
        timestamp: u64,
    }

    struct MigrationCompleted has copy, drop {
        pool_id: 0x2::object::ID,
        dex_type: u8,
        dex_pool_id: 0x2::object::ID,
        liquidity_migrated: u64,
        tokens_added: u64,
        initial_price: u128,
        timestamp: u64,
    }

    public fun get_migration_info(arg0: &MigrationInfo) : (0x2::object::ID, u8, 0x1::option::Option<0x2::object::ID>, u64, u64, u128) {
        (arg0.pool_id, arg0.dex_type, arg0.dex_pool_id, arg0.liquidity_migrated, arg0.tokens_added, arg0.initial_price)
    }

    public fun get_registry_stats(arg0: &MigrationRegistry) : (u64, u128) {
        (arg0.total_migrations, arg0.total_liquidity_migrated)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MigrationRegistry{
            id                       : 0x2::object::new(arg0),
            total_migrations         : 0,
            total_liquidity_migrated : 0,
        };
        0x2::transfer::share_object<MigrationRegistry>(v0);
    }

    entry fun prepare_migration<T0>(arg0: &0x59340db01e8120120a5680094f769b5866fd3eac3d50cd3f21e9da395cf0a6e0::bonding_curve::AdminCap, arg1: &mut MigrationRegistry, arg2: &mut 0x59340db01e8120120a5680094f769b5866fd3eac3d50cd3f21e9da395cf0a6e0::bonding_curve::BondingPool<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _, v4, v5, _, _) = 0x59340db01e8120120a5680094f769b5866fd3eac3d50cd3f21e9da395cf0a6e0::bonding_curve::get_pool_info<T0>(arg2);
        assert!(v5 == 1, 100);
        assert!(arg3 <= 2, 102);
        let v8 = 0x2::object::id<0x59340db01e8120120a5680094f769b5866fd3eac3d50cd3f21e9da395cf0a6e0::bonding_curve::BondingPool<T0>>(arg2);
        let v9 = 0x2::clock::timestamp_ms(arg4);
        let v10 = MigrationStarted{
            pool_id          : v8,
            dex_type         : arg3,
            liquidity_amount : v4,
            token_amount     : 0,
            timestamp        : v9,
        };
        0x2::event::emit<MigrationStarted>(v10);
        arg1.total_migrations = arg1.total_migrations + 1;
        arg1.total_liquidity_migrated = arg1.total_liquidity_migrated + (v4 as u128);
        let v11 = MigrationInfo{
            id                 : 0x2::object::new(arg5),
            pool_id            : v8,
            dex_type           : arg3,
            dex_pool_id        : 0x1::option::none<0x2::object::ID>(),
            liquidity_migrated : v4,
            tokens_added       : 0,
            initial_price      : 0,
            migrated_at        : v9,
            migrated_by        : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::share_object<MigrationInfo>(v11);
    }

    entry fun register_migration_complete(arg0: &0x59340db01e8120120a5680094f769b5866fd3eac3d50cd3f21e9da395cf0a6e0::bonding_curve::AdminCap, arg1: &mut MigrationInfo, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock) {
        arg1.dex_pool_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg1.tokens_added = arg3;
        arg1.initial_price = arg4;
        let v0 = MigrationCompleted{
            pool_id            : arg1.pool_id,
            dex_type           : arg1.dex_type,
            dex_pool_id        : arg2,
            liquidity_migrated : arg1.liquidity_migrated,
            tokens_added       : arg3,
            initial_price      : arg4,
            timestamp          : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<MigrationCompleted>(v0);
    }

    // decompiled from Move bytecode v6
}

