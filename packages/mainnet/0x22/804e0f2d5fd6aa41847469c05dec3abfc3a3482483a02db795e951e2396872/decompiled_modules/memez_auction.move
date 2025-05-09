module 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_auction {
    struct Auction {
        dummy_field: bool,
    }

    struct AuctionState<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        migration_fee: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Fee,
        auction_duration: u64,
        initial_reserve: u64,
        accrued_meme_balance: u64,
        allocation: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Allocation<T0>,
        meme_reserve: 0x2::balance::Balance<T0>,
        liquidity_provision: 0x2::balance::Balance<T0>,
        fixed_rate: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::FixedRate<T0, T1>,
        meme_token_cap: 0x1::option::Option<0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::MemezTokenCap<T0>>,
    }

    public fun new<T0, T1, T2, T3>(arg0: &0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_config::MemezConfig, arg1: &0x2::clock::Clock, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_auction_config::AuctionConfig, arg5: bool, arg6: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_metadata::MemezMetadata, arg7: vector<address>, arg8: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : (0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::MetadataCap) {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg8);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_config::assert_quote_coin<T2, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_config::assert_migrator_witness<T2, T3>(arg0);
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_config::fees<T2>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::assert_dynamic_stake_holders(v0, arg7);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<0x2::sui::SUI>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::creation(v0), &mut arg3, arg9);
        let v1 = arg9;
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(v1));
        };
        let v2 = if (arg5) {
            0x1::option::some<0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::MemezTokenCap<T0>>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::new<T0>(&arg2, arg9))
        } else {
            0x1::option::none<0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::MemezTokenCap<T0>>()
        };
        let v3 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_auction_config::total_supply(&arg4);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 1);
        assert!(v3 != 0, 19);
        let (v4, v5) = 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::new<T0>(arg2, arg9);
        let v6 = v5;
        let v7 = v4;
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::set_maximum_supply(&mut v6, v3);
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::allow_public_burn(&mut v6, &mut v7);
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::destroy_witness<T0>(&mut v7, v6);
        0x2::transfer::public_share_object<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard>(v7);
        let v8 = 0x2::coin::mint_balance<T0>(&mut arg2, v3);
        let v9 = 0x2::balance::split<T0>(&mut v8, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_auction_config::seed_liquidity(&arg4));
        let v10 = AuctionState<T0, T1>{
            id                   : 0x2::object::new(arg9),
            start_time           : 0x2::clock::timestamp_ms(arg1),
            migration_fee        : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::migration(v0, arg7),
            auction_duration     : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_auction_config::auction_duration(&arg4),
            initial_reserve      : 0x2::balance::value<T0>(&v8),
            accrued_meme_balance : 0,
            allocation           : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::allocation<T0>(v0, &mut v8, arg7),
            meme_reserve         : v8,
            liquidity_provision  : 0x2::balance::split<T0>(&mut v8, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_auction_config::liquidity_provision(&arg4)),
            fixed_rate           : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::new<T0, T1>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_auction_config::target_quote_liquidity(&arg4), v9, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::meme_swap(v0, arg7), 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::quote_swap(v0, arg7)),
            meme_token_cap       : v2,
        };
        let v11 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::new<Auction, T0, T1, T2, T3>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_versioned::create<AuctionState<T0, T1>>(1, v10, arg9), arg5, 0x2::object::id_address<AuctionState<T0, T1>>(&v10), arg6, 0x2::object::id_address<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard>(&v7), 0, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_auction_config::target_quote_liquidity(&arg4), 0x2::balance::value<T0>(&v9), 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_auction_config::total_supply(&arg4), 0x2::tx_context::sender(arg9), arg9);
        let v12 = &mut v11;
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::set_memez_fun<T0, T1>(&mut state_mut<T0, T1>(v12).fixed_rate, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::addr<Auction, T0, T1>(&v11));
        (v11, 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::create_metadata_cap(&mut v6, arg9))
    }

    public fun distribute_stake_holders_allocation<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_migrated<Auction, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::allocation_take<T0>(&mut state_mut<T0, T1>(arg0).allocation, arg1, arg3);
    }

    fun drip<T0, T1>(arg0: &mut AuctionState<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = expected_drip_amount<T0, T1>(arg0, arg1);
        arg0.accrued_meme_balance = arg0.accrued_meme_balance + v0;
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::increase_meme_available<T0, T1>(&mut arg0.fixed_rate, 0x2::balance::split<T0>(&mut arg0.meme_reserve, v0));
    }

    public fun dump<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg3);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_uses_coin<Auction, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Auction, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        drip<T0, T1>(v0, arg1);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::dump<T0, T1>(&mut v0.fixed_rate, arg2, arg4)
    }

    public fun dump_token<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::token::Token<T0>, arg3: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg3);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_uses_token<Auction, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Auction, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        drip<T0, T1>(v0, arg1);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::dump<T0, T1>(&mut v0.fixed_rate, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::to_coin<T0>(token_cap<T0, T1>(v0), arg2, arg4), arg4)
    }

    fun expected_drip_amount<T0, T1>(arg0: &AuctionState<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 10000;
        let v1 = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc(0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(0x1::u64::min(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_up(0x2::clock::timestamp_ms(arg1) - arg0.start_time, v0, arg0.auction_duration), v0)), arg0.initial_reserve);
        if (v1 <= arg0.accrued_meme_balance) {
            return 0
        };
        let v2 = v1 - arg0.accrued_meme_balance;
        if (v2 == 0) {
            return 0
        };
        0x1::u64::min(v2, 0x2::balance::value<T0>(&arg0.meme_reserve))
    }

    fun maybe_upgrade_state_to_latest(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_versioned::Versioned) {
        assert!(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_versioned::version(arg0) == 1, 4);
    }

    public fun meme_balance<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = state<T0, T1>(arg0);
        0x2::balance::value<T0>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::meme_balance<T0, T1>(&v0.fixed_rate)) + expected_drip_amount<T0, T1>(v0, arg1)
    }

    public fun migrate<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, arg1: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg2: &mut 0x2::tx_context::TxContext) : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezMigrator<T0, T1> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg1);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_migrating<Auction, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut v0.meme_reserve);
        if (0x2::balance::value<T0>(&v1) == 0) {
            0x2::balance::destroy_zero<T0>(v1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), @0x0);
        };
        let v2 = 0x2::balance::withdraw_all<T0>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::meme_balance_mut<T0, T1>(&mut v0.fixed_rate));
        if (0x2::balance::value<T0>(&v2) == 0) {
            0x2::balance::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), @0x0);
        };
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::quote_balance_mut<T0, T1>(&mut v0.fixed_rate)), arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<T1>(v0.migration_fee, &mut v3, arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::migrate<Auction, T0, T1>(arg0, 0x2::balance::withdraw_all<T0>(&mut v0.liquidity_provision), 0x2::coin::into_balance<T1>(v3))
    }

    public fun pump<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg3);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_uses_coin<Auction, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Auction, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        drip<T0, T1>(v0, arg1);
        let (v1, v2, v3) = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::pump<T0, T1>(&mut v0.fixed_rate, arg2, arg4);
        if (v1) {
            0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::set_progress_to_migrating<Auction, T0, T1>(arg0);
        };
        (v2, v3)
    }

    public fun pump_token<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::token::Token<T0>) {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg3);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_uses_token<Auction, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Auction, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        drip<T0, T1>(v0, arg1);
        let (v1, v2, v3) = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::pump<T0, T1>(&mut v0.fixed_rate, arg2, arg4);
        if (v1) {
            0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::set_progress_to_migrating<Auction, T0, T1>(arg0);
        };
        (v2, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::from_coin<T0>(token_cap<T0, T1>(v0), v3, arg4))
    }

    public fun quote_dump<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : vector<u64> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Auction, T0, T1>(arg0);
        let v0 = state<T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::dump_amount<T0, T1>(&v0.fixed_rate, arg1, expected_drip_amount<T0, T1>(v0, arg2))
    }

    public fun quote_pump<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : vector<u64> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Auction, T0, T1>(arg0);
        let v0 = state<T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::pump_amount<T0, T1>(&v0.fixed_rate, arg1, expected_drip_amount<T0, T1>(v0, arg2))
    }

    fun state<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>) : &AuctionState<T0, T1> {
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::versioned_mut<Auction, T0, T1>(arg0);
        maybe_upgrade_state_to_latest(v0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_versioned::load_value<AuctionState<T0, T1>>(v0)
    }

    fun state_mut<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>) : &mut AuctionState<T0, T1> {
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::versioned_mut<Auction, T0, T1>(arg0);
        maybe_upgrade_state_to_latest(v0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_versioned::load_value_mut<AuctionState<T0, T1>>(v0)
    }

    public fun to_coin<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Auction, T0, T1>, arg1: 0x2::token::Token<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_migrated<Auction, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::to_coin<T0>(token_cap<T0, T1>(state_mut<T0, T1>(arg0)), arg1, arg2)
    }

    fun token_cap<T0, T1>(arg0: &AuctionState<T0, T1>) : &0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::MemezTokenCap<T0> {
        0x1::option::borrow<0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::MemezTokenCap<T0>>(&arg0.meme_token_cap)
    }

    // decompiled from Move bytecode v6
}

