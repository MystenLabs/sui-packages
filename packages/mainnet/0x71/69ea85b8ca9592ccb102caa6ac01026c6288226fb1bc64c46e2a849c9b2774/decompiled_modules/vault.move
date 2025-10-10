module 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault {
    struct VaultRegistry has store, key {
        id: 0x2::object::UID,
        index: u64,
        vaults: 0x2::table::Table<0x2::object::ID, 0x1::type_name::TypeName>,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        lp_token_treasury: 0x2::coin::TreasuryCap<T0>,
        quote_type: 0x1::option::Option<0x1::type_name::TypeName>,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        buffer_assets: 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::BalanceBag,
        protocol_fees: 0x2::bag::Bag,
        hard_cap: u128,
        markets: 0x2::object_bag::ObjectBag,
        action_status: u16,
        last_aum: u128,
        last_txs: 0x2::vec_map::VecMap<u8, vector<u8>>,
        protocol_fee_rate: u64,
    }

    struct InitEvent has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct CreateVaultEvent has copy, drop {
        id: 0x2::object::ID,
        lp_token_treasury_id: 0x2::object::ID,
        quote_type: 0x1::option::Option<0x1::type_name::TypeName>,
        hard_cap: u128,
    }

    struct AddDlmmMarketEvent has copy, drop {
        vault_id: 0x2::object::ID,
        dlmm_market_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        before_aum: u128,
        user_tvl: u128,
        before_supply: u64,
        lp_amount: u64,
        amount_a: u64,
        amount_b: u64,
    }

    public fun add_liquidity_bid_ask<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u32, arg6: u32, arg7: u32, arg8: u32, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg11: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg11);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        let v0 = 0x2::coin::from_balance<T1>(0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T1>(&mut arg0.buffer_assets, arg4), arg13);
        let v1 = 0x2::coin::from_balance<T0>(0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T0>(&mut arg0.buffer_assets, arg3), arg13);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::add_liquidity_bid_ask<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, &mut v1, &mut v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T0>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T0>(v1));
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T1>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T1>(v0));
    }

    public fun destory_close_cert(arg0: 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMPositionCloseCert, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg2: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg2);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::destory_close_cert(arg0, arg1);
    }

    public fun add_dlmm_liquidity<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: vector<u32>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg10: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg10);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        let v0 = 0x2::coin::from_balance<T1>(0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T1>(&mut arg0.buffer_assets, arg4), arg12);
        let v1 = 0x2::coin::from_balance<T0>(0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T0>(&mut arg0.buffer_assets, arg3), arg12);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::add_liquidity<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, &mut v1, &mut v0, arg5, arg6, arg7, arg8, arg9, arg11, arg12);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T0>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T0>(v1));
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T1>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T1>(v0));
    }

    public fun add_dlmm_liquidity_curve<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u32, arg6: u32, arg7: u32, arg8: u32, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg11: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg11);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        let v0 = 0x2::coin::from_balance<T1>(0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T1>(&mut arg0.buffer_assets, arg4), arg13);
        let v1 = 0x2::coin::from_balance<T0>(0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T0>(&mut arg0.buffer_assets, arg3), arg13);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::add_liquidity_curve<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, &mut v1, &mut v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T0>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T0>(v1));
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T1>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T1>(v0));
    }

    public fun add_dlmm_liquidity_on_bin<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: 0x2::object::ID, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinGroupRef, arg4: u8, arg5: u64, arg6: u64, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg8: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg8);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::add_liquidity_on_bin<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun add_dlmm_liquidity_spot<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg12: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg13: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg13);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        let v0 = 0x2::coin::from_balance<T1>(0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T1>(&mut arg0.buffer_assets, arg4), arg15);
        let v1 = 0x2::coin::from_balance<T0>(0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T0>(&mut arg0.buffer_assets, arg3), arg15);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::add_liquidity_spot<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, &mut v1, &mut v0, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14, arg15);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T0>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T0>(v1));
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T1>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T1>(v0));
    }

    public fun add_dlmm_market<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg2: &mut 0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg1);
        assert!(!0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::duplicate_market());
        assert!(arg0.coin_type_a == 0x1::type_name::with_defining_ids<T0>() && arg0.coin_type_b == 0x1::type_name::with_defining_ids<T1>() || arg0.coin_type_a == 0x1::type_name::with_defining_ids<T1>() && arg0.coin_type_b == 0x1::type_name::with_defining_ids<T0>(), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::vault_type_not_match());
        let v0 = 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::new_dlmm_market<T0, T1>(arg2);
        let v1 = AddDlmmMarketEvent{
            vault_id       : 0x2::object::id<Vault<T2>>(arg0),
            dlmm_market_id : 0x2::object::id<0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&v0),
        };
        0x2::event::emit<AddDlmmMarketEvent>(v1);
        0x2::object_bag::add<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET", v0);
    }

    public fun calculate_aum<T0>(arg0: &mut Vault<T0>, arg1: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::PythOracle, arg2: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg2);
        assert!(is_allow_calculate_aum<T0>(arg0), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::vault_not_allow_deposit());
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        if (0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET")) {
            let v1 = 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::last_amounts(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg4);
            let v2 = 0;
            while (v2 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(&v1)) {
                let (v3, v4) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v1, v2);
                if (*v4 > 0 && 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::contain_oracle_info(arg1, *v3)) {
                    0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, *v3, *v4);
                };
                v2 = v2 + 1;
            };
        };
        let v5 = *0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::balances(&arg0.buffer_assets);
        let v6 = 0;
        while (v6 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(&v5)) {
            let (v7, v8) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v5, v6);
            if (*v8 > 0 && 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::contain_oracle_info(arg1, *v7)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, *v7, *v8);
            };
            v6 = v6 + 1;
        };
        arg0.last_aum = calculate_tvl_base_on_quote(arg1, &v0, arg0.quote_type, arg3);
        update_calculate_aum_last_tx<T0>(arg0, arg4);
    }

    public fun calculate_dlmm_position_amounts<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg4);
        assert!(is_allow_calculate_aum<T2>(arg0), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::vault_not_allow_deposit());
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::calcualate_position_amounts<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, arg3, arg5, arg6);
    }

    fun calculate_tvl_base_on_quote(arg0: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::PythOracle, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg2: 0x1::option::Option<0x1::type_name::TypeName>, arg3: &0x2::clock::Clock) : u128 {
        let v0 = if (0x1::option::is_none<0x1::type_name::TypeName>(&arg2)) {
            0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::new_price(1 * 0x1::u64::pow(10, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::price_multiplier_decimal()), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::price_multiplier_decimal())
        } else {
            0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::get_price_by_type(arg0, *0x1::option::borrow<0x1::type_name::TypeName>(&arg2), arg3)
        };
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(arg1)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(arg1, v3);
            let v6 = 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::get_price_by_type(arg0, *v4, arg3);
            let (v7, _) = 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::calculate_prices(&v6, &v1);
            v2 = v2 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((v7 as u128), (*v5 as u128), (0x1::u64::pow(10, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::price_multiplier_decimal()) as u128));
            v3 = v3 + 1;
        };
        v2
    }

    public fun close_dlmm_position<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMPositionCloseCert {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg5);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        let (v0, v1, v2) = 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::close_position<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, arg3, arg4, arg6, arg7);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T0>(&mut arg0.buffer_assets, v1);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T1>(&mut arg0.buffer_assets, v2);
        v0
    }

    public fun collect_dlmm_fee<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg5);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        let (v0, v1) = 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::collect_position_fee<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, arg3, arg4, arg6);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T0>(&mut arg0.buffer_assets, v0);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T1>(&mut arg0.buffer_assets, v1);
    }

    public fun collect_dlmm_reward<T0, T1, T2, T3>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg5);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T3>(&mut arg0.buffer_assets, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::collect_position_reward<T0, T1, T3>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, arg3, arg4, arg6));
    }

    public fun collect_dlmm_reward_from_close_cert<T0, T1, T2, T3>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMPositionCloseCert, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg4);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T3>(&mut arg0.buffer_assets, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::collect_reward_from_close_cert<T0, T1, T3>(arg2, arg1, arg3));
    }

    public fun create_vault<T0, T1, T2>(arg0: &mut VaultRegistry, arg1: 0x2::coin::TreasuryCap<T2>, arg2: u8, arg3: u128, arg4: u64, arg5: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_config::GlobalConfig, arg6: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg7: &mut 0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg6);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_config::check_vault_manager_role(arg5, 0x2::tx_context::sender(arg7));
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::treasury_cap_illegal());
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::quote_type_error());
        let v1 = if (arg2 == 0) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>())
        } else if (arg2 == 1) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>())
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        };
        let v2 = Vault<T2>{
            id                : 0x2::object::new(arg7),
            lp_token_treasury : arg1,
            quote_type        : v1,
            coin_type_a       : 0x1::type_name::with_defining_ids<T0>(),
            coin_type_b       : 0x1::type_name::with_defining_ids<T1>(),
            buffer_assets     : 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::new_balance_bag(arg7),
            protocol_fees     : 0x2::bag::new(arg7),
            hard_cap          : arg3,
            markets           : 0x2::object_bag::new(arg7),
            action_status     : 0,
            last_aum          : 0,
            last_txs          : 0x2::vec_map::empty<u8, vector<u8>>(),
            protocol_fee_rate : arg4,
        };
        let v3 = 0x2::object::id<Vault<T2>>(&v2);
        0x2::table::add<0x2::object::ID, 0x1::type_name::TypeName>(&mut arg0.vaults, v3, 0x1::type_name::with_defining_ids<T2>());
        arg0.index = arg0.index + 1;
        let v4 = CreateVaultEvent{
            id                   : v3,
            lp_token_treasury_id : 0x2::object::id<0x2::coin::TreasuryCap<T2>>(&arg1),
            quote_type           : v1,
            hard_cap             : arg3,
        };
        0x2::event::emit<CreateVaultEvent>(v4);
        0x2::transfer::public_share_object<Vault<T2>>(v2);
    }

    public fun deposit<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::pyth_oracle::PythOracle, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg5);
        assert!(is_allow_deposit<T2>(arg0), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::vault_not_allow_deposit());
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0 || v1 > 0, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::deposit_amount_zero());
        assert!(last_calculate_aum_tx<T2>(arg0) == *0x2::tx_context::digest(arg6), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::aum_done_err());
        assert!(last_deposit_tx<T2>(arg0) == *0x2::tx_context::digest(arg6), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::operation_not_allowed());
        assert!(last_withdraw_tx<T2>(arg0) == *0x2::tx_context::digest(arg6), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::operation_not_allowed());
        update_deposit_last_tx<T2>(arg0, arg6);
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::with_defining_ids<T0>(), v0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::with_defining_ids<T1>(), v1);
        let v3 = calculate_tvl_base_on_quote(arg1, &v2, arg0.quote_type, arg4);
        let v4 = 0x2::coin::total_supply<T2>(&arg0.lp_token_treasury);
        if (arg0.hard_cap != 0) {
            assert!(arg0.last_aum + v3 <= arg0.hard_cap, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::hard_cap_reached());
        };
        let v5 = get_lp_amount_by_tvl(v4, v3, arg0.last_aum);
        assert!(v5 > 0, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::token_amount_is_zero());
        assert!(v5 < 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_utils::uint64_max() - 1 - (v4 as u128), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::token_amount_overflow());
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T0>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T0>(arg2));
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T1>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T1>(arg3));
        let v6 = DepositEvent{
            vault_id      : 0x2::object::id<Vault<T2>>(arg0),
            before_aum    : arg0.last_aum,
            user_tvl      : v3,
            before_supply : v4,
            lp_amount     : (v5 as u64),
            amount_a      : v0,
            amount_b      : v1,
        };
        0x2::event::emit<DepositEvent>(v6);
        0x2::coin::mint<T2>(&mut arg0.lp_token_treasury, (v5 as u64), arg6)
    }

    fun get_lp_amount_by_tvl(arg0: u64, arg1: u128, arg2: u128) : u128 {
        if (arg0 == 0) {
            return arg1
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round((arg0 as u128), arg1, arg2)
    }

    fun get_user_share_by_lp_amount(arg0: u64, arg1: u64, arg2: u128) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round((arg1 as u128), arg2, (arg0 as u128))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id     : 0x2::object::new(arg0),
            index  : 0,
            vaults : 0x2::table::new<0x2::object::ID, 0x1::type_name::TypeName>(arg0),
        };
        let v1 = InitEvent{registry_id: 0x2::object::id<VaultRegistry>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::public_share_object<VaultRegistry>(v0);
    }

    public fun is_allow_calculate_aum<T0>(arg0: &Vault<T0>) : bool {
        arg0.action_status & 1 << 2 != 0
    }

    public fun is_allow_deposit<T0>(arg0: &Vault<T0>) : bool {
        arg0.action_status & 1 << 0 != 0
    }

    public fun is_allow_withdraw<T0>(arg0: &Vault<T0>) : bool {
        arg0.action_status & 1 << 1 != 0
    }

    public fun last_calculate_aum_tx<T0>(arg0: &Vault<T0>) : vector<u8> {
        let v0 = 2;
        if (!0x2::vec_map::contains<u8, vector<u8>>(&arg0.last_txs, &v0)) {
            return 0x1::vector::empty<u8>()
        };
        *0x2::vec_map::get<u8, vector<u8>>(&arg0.last_txs, &v0)
    }

    public fun last_deposit_tx<T0>(arg0: &Vault<T0>) : vector<u8> {
        let v0 = 0;
        *0x2::vec_map::get<u8, vector<u8>>(&arg0.last_txs, &v0)
    }

    public fun last_withdraw_tx<T0>(arg0: &Vault<T0>) : vector<u8> {
        let v0 = 1;
        *0x2::vec_map::get<u8, vector<u8>>(&arg0.last_txs, &v0)
    }

    public fun new_dlmm_add_liquidity_cert<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: bool, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1> {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg6);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::new_add_liquidity_cert<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, arg3, arg4, arg5, arg7, arg8)
    }

    public fun open_dlmm_position<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg3: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::OpenPositionCert<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg5);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&arg3);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg1, &mut arg2, arg3, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T0>(&mut arg0.buffer_assets, v0), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T1>(&mut arg0.buffer_assets, v1), arg4);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::new_position(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg2, arg6);
    }

    public fun remove_dlmm_liquidity_by_percent<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: u16, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg8: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg8);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        let (v0, v1) = 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::remove_liquidity_by_percent<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T0>(&mut arg0.buffer_assets, v0);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::join<T1>(&mut arg0.buffer_assets, v1);
    }

    public fun repay_dlmm_add_liquidity<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::AddLiquidityCert<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::Versioned) {
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::vault_versioned::check_version(arg5);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.markets, b"DLMM_MARKET"), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::error::dlmm_market_not_initialized());
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::amounts<T0, T1>(&arg3);
        0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::repay_add_liquidity<T0, T1>(0x2::object_bag::borrow_mut<vector<u8>, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::market_dlmm::DLMMMarket>(&mut arg0.markets, b"DLMM_MARKET"), arg1, arg2, arg3, 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T0>(&mut arg0.buffer_assets, v0), 0x35adb403859f51bfd9d5f250e7128a0c2059f57fbeb51dec68948e56212e02ad::balance_bag::split<T1>(&mut arg0.buffer_assets, v1), arg4);
    }

    public fun set_action_status<T0>(arg0: &mut Vault<T0>, arg1: u16) {
        arg0.action_status = arg1;
    }

    fun update_calculate_aum_last_tx<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 2;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.last_txs, &v0)) {
            *0x2::vec_map::get_mut<u8, vector<u8>>(&mut arg0.last_txs, &v0) = *0x2::tx_context::digest(arg1);
        } else {
            0x2::vec_map::insert<u8, vector<u8>>(&mut arg0.last_txs, v0, *0x2::tx_context::digest(arg1));
        };
    }

    fun update_deposit_last_tx<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.last_txs, &v0)) {
            *0x2::vec_map::get_mut<u8, vector<u8>>(&mut arg0.last_txs, &v0) = *0x2::tx_context::digest(arg1);
        } else {
            0x2::vec_map::insert<u8, vector<u8>>(&mut arg0.last_txs, v0, *0x2::tx_context::digest(arg1));
        };
    }

    fun update_withdraw_last_tx<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 1;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.last_txs, &v0)) {
            *0x2::vec_map::get_mut<u8, vector<u8>>(&mut arg0.last_txs, &v0) = *0x2::tx_context::digest(arg1);
        } else {
            0x2::vec_map::insert<u8, vector<u8>>(&mut arg0.last_txs, v0, *0x2::tx_context::digest(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

