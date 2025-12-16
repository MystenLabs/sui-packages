module 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::dex_migration {
    struct MigrationRegistry has key {
        id: 0x2::object::UID,
        migrations: vector<MigrationRecord>,
        total_migrated: u64,
        total_sui_migrated: u128,
        total_lp_burned: u128,
    }

    struct MigrationRecord has copy, drop, store {
        bonding_pool_id: address,
        dex_pool_id: address,
        sui_migrated: u64,
        tokens_migrated: u64,
        lp_total: u64,
        lp_to_protocol: u64,
        lp_burned: u64,
        migrated_at: u64,
    }

    struct PendingMigration<phantom T0> has store, key {
        id: 0x2::object::UID,
        bonding_pool_id: 0x2::object::ID,
        sui_for_liquidity: 0x2::coin::Coin<0x2::sui::SUI>,
        sui_for_fee: 0x2::coin::Coin<0x2::sui::SUI>,
        tokens_to_mint: u64,
        creator: address,
        created_at: u64,
    }

    struct MigrationPrepared has copy, drop {
        bonding_pool_id: address,
        sui_for_liquidity: u64,
        sui_for_fee: u64,
        tokens_to_mint: u64,
        timestamp: u64,
    }

    struct MigrationExecuted has copy, drop {
        bonding_pool_id: address,
        dex_pool_id: address,
        sui_migrated: u64,
        tokens_migrated: u64,
        lp_total: u64,
        lp_to_protocol: u64,
        lp_burned: u64,
        timestamp: u64,
    }

    struct MigrationCancelled has copy, drop {
        bonding_pool_id: address,
        sui_returned: u64,
        timestamp: u64,
    }

    public entry fun cancel_migration<T0>(arg0: &0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::AdminCap, arg1: &mut 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::BondingPool<T0>, arg2: PendingMigration<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let PendingMigration {
            id                : v0,
            bonding_pool_id   : v1,
            sui_for_liquidity : v2,
            sui_for_fee       : v3,
            tokens_to_mint    : _,
            creator           : _,
            created_at        : _,
        } = arg2;
        assert!(0x2::object::id<0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::BondingPool<T0>>(arg1) == v1, 105);
        let v7 = v2;
        0x2::coin::join<0x2::sui::SUI>(&mut v7, v3);
        0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::return_sui_to_pool<T0>(arg1, v7);
        let v8 = MigrationCancelled{
            bonding_pool_id : 0x2::object::id_address<0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::BondingPool<T0>>(arg1),
            sui_returned    : 0x2::coin::value<0x2::sui::SUI>(&v7),
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MigrationCancelled>(v8);
        0x2::object::delete(v0);
    }

    fun distribute_lp_tokens<T0>(arg0: 0x2::coin::Coin<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, 0x2::sui::SUI>>, arg1: &0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::LaunchpadConfig, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::coin::value<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, 0x2::sui::SUI>>(&arg0) * 2 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, 0x2::sui::SUI>>>(0x2::coin::split<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, 0x2::sui::SUI>>(&mut arg0, v0, arg2), 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::get_project_wallet(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, 0x2::sui::SUI>>>(arg0, @0x0);
        (v0, 0x2::coin::value<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, 0x2::sui::SUI>>(&arg0))
    }

    public entry fun execute_migration<T0>(arg0: &0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::AdminCap, arg1: &0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::LaunchpadConfig, arg2: &mut 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::BondingPool<T0>, arg3: PendingMigration<T0>, arg4: &mut 0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::factory::Factory, arg5: &mut MigrationRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let PendingMigration {
            id                : v0,
            bonding_pool_id   : v1,
            sui_for_liquidity : v2,
            sui_for_fee       : v3,
            tokens_to_mint    : v4,
            creator           : _,
            created_at        : _,
        } = arg3;
        let v7 = v2;
        assert!(0x2::object::id<0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::BondingPool<T0>>(arg2) == v1, 105);
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&v7);
        let (v9, v10) = 0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::factory::create_pool_from_contract<T0, 0x2::sui::SUI>(arg4, v3, 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::mint_tokens_for_migration<T0>(arg2, v4, arg7), v7, arg6, arg7);
        let v11 = v10;
        let v12 = 0x2::coin::value<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, 0x2::sui::SUI>>(&v11);
        let (v13, v14) = distribute_lp_tokens<T0>(v11, arg1, arg7);
        0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::mark_pool_as_migrated<T0>(arg2, v9, arg6);
        let v15 = 0x2::clock::timestamp_ms(arg6);
        let v16 = MigrationRecord{
            bonding_pool_id : 0x2::object::id_address<0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::BondingPool<T0>>(arg2),
            dex_pool_id     : v9,
            sui_migrated    : v8,
            tokens_migrated : v4,
            lp_total        : v12,
            lp_to_protocol  : v13,
            lp_burned       : v14,
            migrated_at     : v15,
        };
        0x1::vector::push_back<MigrationRecord>(&mut arg5.migrations, v16);
        arg5.total_migrated = arg5.total_migrated + 1;
        arg5.total_sui_migrated = arg5.total_sui_migrated + (v8 as u128);
        arg5.total_lp_burned = arg5.total_lp_burned + (v14 as u128);
        let v17 = MigrationExecuted{
            bonding_pool_id : 0x2::object::id_address<0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::BondingPool<T0>>(arg2),
            dex_pool_id     : v9,
            sui_migrated    : v8,
            tokens_migrated : v4,
            lp_total        : v12,
            lp_to_protocol  : v13,
            lp_burned       : v14,
            timestamp       : v15,
        };
        0x2::event::emit<MigrationExecuted>(v17);
        0x2::object::delete(v0);
    }

    public fun get_migration_count(arg0: &MigrationRegistry) : u64 {
        arg0.total_migrated
    }

    public fun get_migration_record_info(arg0: &MigrationRecord) : (address, address, u64, u64, u64, u64, u64, u64) {
        (arg0.bonding_pool_id, arg0.dex_pool_id, arg0.sui_migrated, arg0.tokens_migrated, arg0.lp_total, arg0.lp_to_protocol, arg0.lp_burned, arg0.migrated_at)
    }

    public fun get_migration_records(arg0: &MigrationRegistry) : &vector<MigrationRecord> {
        &arg0.migrations
    }

    public fun get_pending_info<T0>(arg0: &PendingMigration<T0>) : (u64, u64, u64) {
        (0x2::coin::value<0x2::sui::SUI>(&arg0.sui_for_liquidity), 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_for_fee), arg0.tokens_to_mint)
    }

    public fun get_total_lp_burned(arg0: &MigrationRegistry) : u128 {
        arg0.total_lp_burned
    }

    public fun get_total_sui_migrated(arg0: &MigrationRegistry) : u128 {
        arg0.total_sui_migrated
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MigrationRegistry{
            id                 : 0x2::object::new(arg0),
            migrations         : 0x1::vector::empty<MigrationRecord>(),
            total_migrated     : 0,
            total_sui_migrated : 0,
            total_lp_burned    : 0,
        };
        0x2::transfer::share_object<MigrationRegistry>(v0);
    }

    public entry fun prepare_migration<T0>(arg0: &0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::AdminCap, arg1: &mut 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::BondingPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::get_pool_status<T0>(arg1) == 1, 100);
        assert!(!0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::is_migrated<T0>(arg1), 101);
        let v0 = 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::get_sui_reserve<T0>(arg1);
        assert!(v0 > 3000000000, 102);
        let v1 = 3000000000;
        let v2 = v0 - v1;
        let v3 = 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::calculate_current_price<T0>(arg1);
        let v4 = if (v3 > 0) {
            (((v2 as u128) * 1000000000000 / v3) as u64)
        } else {
            v2
        };
        let v5 = 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::extract_sui_for_migration<T0>(arg1, v0, arg3);
        let v6 = 0x2::clock::timestamp_ms(arg2);
        let v7 = PendingMigration<T0>{
            id                : 0x2::object::new(arg3),
            bonding_pool_id   : 0x2::object::id<0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::BondingPool<T0>>(arg1),
            sui_for_liquidity : v5,
            sui_for_fee       : 0x2::coin::split<0x2::sui::SUI>(&mut v5, v1, arg3),
            tokens_to_mint    : v4,
            creator           : 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::get_pool_creator<T0>(arg1),
            created_at        : v6,
        };
        let v8 = MigrationPrepared{
            bonding_pool_id   : 0x2::object::id_address<0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve::BondingPool<T0>>(arg1),
            sui_for_liquidity : v2,
            sui_for_fee       : v1,
            tokens_to_mint    : v4,
            timestamp         : v6,
        };
        0x2::event::emit<MigrationPrepared>(v8);
        0x2::transfer::share_object<PendingMigration<T0>>(v7);
    }

    // decompiled from Move bytecode v6
}

