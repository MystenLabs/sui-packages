module 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction {
    struct Auction {
        dummy_field: bool,
    }

    struct AuctionState<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        migration_fee: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::Fee,
        auction_duration: u64,
        initial_reserve: u64,
        accrued_meme_balance: u64,
        allocation: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::Allocation<T0>,
        meme_reserve: 0x2::balance::Balance<T0>,
        liquidity_provision: 0x2::balance::Balance<T0>,
        fixed_rate: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::FixedRate<T0, T1>,
    }

    public fun new<T0, T1, T2, T3>(arg0: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::MemezConfig, arg1: &0x2::clock::Clock, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction_config::AuctionConfig, arg5: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_metadata::MemezMetadata, arg6: vector<address>, arg7: bool, arg8: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : (0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Auction, T0, T1>, 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::MetadataCap) {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg8);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::assert_quote_coin<T2, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::assert_migrator_witness<T2, T3>(arg0);
        let v0 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::fees<T2>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::assert_dynamic_stake_holders(v0, arg6);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::take<0x2::sui::SUI>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::creation(v0), &mut arg3, arg9);
        let v1 = arg9;
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(v1));
        };
        let v2 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction_config::total_supply(&arg4);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 1);
        assert!(v2 != 0, 19);
        let (v3, v4) = 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::new<T0>(arg2, arg9);
        let v5 = v4;
        let v6 = v3;
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::set_maximum_supply(&mut v5, v2);
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::allow_public_burn(&mut v5, &mut v6);
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::destroy_witness<T0>(&mut v6, v5);
        0x2::transfer::public_share_object<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard>(v6);
        let v7 = 0x2::coin::mint_balance<T0>(&mut arg2, v2);
        let v8 = 0x2::balance::split<T0>(&mut v7, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction_config::seed_liquidity(&arg4));
        let v9 = AuctionState<T0, T1>{
            id                   : 0x2::object::new(arg9),
            start_time           : 0x2::clock::timestamp_ms(arg1),
            migration_fee        : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::migration(v0, arg6),
            auction_duration     : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction_config::auction_duration(&arg4),
            initial_reserve      : 0x2::balance::value<T0>(&v7),
            accrued_meme_balance : 0,
            allocation           : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::allocation<T0>(v0, &mut v7, arg6),
            meme_reserve         : v7,
            liquidity_provision  : 0x2::balance::split<T0>(&mut v7, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction_config::liquidity_provision(&arg4)),
            fixed_rate           : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::new<T0, T1>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction_config::target_quote_liquidity(&arg4), v8, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::meme_swap(v0, arg6), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::quote_swap(v0, arg6), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::meme_referrer_fee<T2>(arg0), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::quote_referrer_fee<T2>(arg0)),
        };
        let v10 = 0x2::object::id_address<AuctionState<T0, T1>>(&v9);
        let v11 = if (arg7) {
            0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::public_key<T2>(arg0)
        } else {
            b""
        };
        let v12 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::new<Auction, T0, T1, T2, T3>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned::create<AuctionState<T0, T1>>(1, v9, arg9), v11, v10, arg5, 0x2::object::id_address<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard>(&v6), 0, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction_config::target_quote_liquidity(&arg4), 0x2::balance::value<T0>(&v8), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction_config::total_supply(&arg4), 0x2::tx_context::sender(arg9), arg9);
        let v13 = &mut v12;
        let v14 = state_mut<T0, T1>(v13);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::set_memez_fun<T0, T1>(&mut v14.fixed_rate, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::addr<Auction, T0, T1>(&v12));
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::set_inner_state<T0, T1>(&mut v14.fixed_rate, v10);
        (v12, 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::create_metadata_cap(&mut v5, arg9))
    }

    public fun distribute_stake_holders_allocation<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Auction, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg2);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_migrated<Auction, T0, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::allocation_take<T0>(&mut state_mut<T0, T1>(arg0).allocation, arg1, arg3);
    }

    fun drip<T0, T1>(arg0: &mut AuctionState<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = expected_drip_amount<T0, T1>(arg0, arg1);
        arg0.accrued_meme_balance = arg0.accrued_meme_balance + v0;
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::increase_meme_available<T0, T1>(&mut arg0.fixed_rate, 0x2::balance::split<T0>(&mut arg0.meme_reserve, v0));
    }

    public fun dump<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Auction, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::option::Option<address>, arg4: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg4);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_bonding<Auction, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        drip<T0, T1>(v0, arg1);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::dump<T0, T1>(&mut v0.fixed_rate, arg2, arg3, arg5)
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

    fun maybe_upgrade_state_to_latest(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned::Versioned) {
        assert!(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned::version(arg0) == 1, 4);
    }

    public fun meme_balance<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Auction, T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = state<T0, T1>(arg0);
        0x2::balance::value<T0>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::meme_balance<T0, T1>(&v0.fixed_rate)) + expected_drip_amount<T0, T1>(v0, arg1)
    }

    public fun migrate<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Auction, T0, T1>, arg1: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg2: &mut 0x2::tx_context::TxContext) : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, T1> {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg1);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_migrating<Auction, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut v0.meme_reserve);
        if (0x2::balance::value<T0>(&v1) == 0) {
            0x2::balance::destroy_zero<T0>(v1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), @0x0);
        };
        let v2 = 0x2::balance::withdraw_all<T0>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::meme_balance_mut<T0, T1>(&mut v0.fixed_rate));
        if (0x2::balance::value<T0>(&v2) == 0) {
            0x2::balance::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), @0x0);
        };
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::quote_balance_mut<T0, T1>(&mut v0.fixed_rate)), arg2);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::take<T1>(v0.migration_fee, &mut v3, arg2);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::migrate<Auction, T0, T1>(arg0, 0x2::balance::withdraw_all<T0>(&mut v0.liquidity_provision), 0x2::coin::into_balance<T1>(v3))
    }

    public fun pump<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Auction, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg5);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_bonding<Auction, T0, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_verifier::assert_can_buy(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::nonces_mut<Auction, T0, T1>(arg0), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::public_key<Auction, T0, T1>(arg0), arg4, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::addr<Auction, T0, T1>(arg0), 0x2::coin::value<T1>(&arg2), arg6);
        let v0 = state_mut<T0, T1>(arg0);
        drip<T0, T1>(v0, arg1);
        let (v1, v2, v3) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::pump<T0, T1>(&mut v0.fixed_rate, arg2, arg3, arg6);
        if (v1) {
            0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::set_progress_to_migrating<Auction, T0, T1>(arg0);
        };
        (v2, v3)
    }

    public fun quote_dump<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Auction, T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : vector<u64> {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_bonding<Auction, T0, T1>(arg0);
        let v0 = state<T0, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::dump_amount<T0, T1>(&v0.fixed_rate, arg1, expected_drip_amount<T0, T1>(v0, arg2))
    }

    public fun quote_pump<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Auction, T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : vector<u64> {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_bonding<Auction, T0, T1>(arg0);
        let v0 = state<T0, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fixed_rate::pump_amount<T0, T1>(&v0.fixed_rate, arg1, expected_drip_amount<T0, T1>(v0, arg2))
    }

    fun state<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Auction, T0, T1>) : &AuctionState<T0, T1> {
        let v0 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::versioned_mut<Auction, T0, T1>(arg0);
        maybe_upgrade_state_to_latest(v0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned::load_value<AuctionState<T0, T1>>(v0)
    }

    fun state_mut<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Auction, T0, T1>) : &mut AuctionState<T0, T1> {
        let v0 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::versioned_mut<Auction, T0, T1>(arg0);
        maybe_upgrade_state_to_latest(v0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned::load_value_mut<AuctionState<T0, T1>>(v0)
    }

    // decompiled from Move bytecode v6
}

