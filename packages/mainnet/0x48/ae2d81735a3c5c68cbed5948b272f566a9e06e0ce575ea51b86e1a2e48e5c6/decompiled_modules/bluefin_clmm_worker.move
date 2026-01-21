module 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_worker {
    struct WorkerInfo<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        reinvest_bounty_bps: u64,
        max_reinvest_bounty_bps: u64,
        ok_reinvestors: 0x2::table::Table<address, bool>,
        ok_rebalancers: 0x2::table::Table<address, bool>,
        ok_strategies: 0x2::table::Table<u8, bool>,
        treasury_account: address,
        reinvest_path: vector<0x1::type_name::TypeName>,
        reinvest_threshold: u64,
        shares: 0x2::table::Table<u64, u128>,
        total_share: u128,
        config: address,
        position_nft: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
        position_operator_cap: 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::VaultCap<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::PositionOperatorFeature<T0>>,
        coin_base_decimals: u8,
        coin_farming_decimals: u8,
        tiny_coin_base: 0x2::balance::Balance<T0>,
        tiny_coin_farming: 0x2::balance::Balance<T1>,
        pool_id: 0x2::object::ID,
        package_version: u64,
        tiny_coin_base_bounty: 0x2::balance::Balance<T0>,
        tiny_coin_farming_bounty: 0x2::balance::Balance<T1>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct InitializeEvent has copy, drop {
        worker_info: address,
    }

    struct RebalanceEvent has copy, drop {
        tick_lower_idx: u32,
        tick_upper_idx: u32,
        liquidity_before: u128,
        liquidity_after: u128,
    }

    struct ReinvestEvent has copy, drop {
        liquidity_before: u128,
        liquidity_after: u128,
    }

    struct VirtualClmmLP {
        dummy_field: bool,
    }

    public entry fun add_collateral_only_base_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: vector<0x2::coin::Coin<T0>>, arg8: u64, arg9: bool, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        add_collateral_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun add_collateral_only_base_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: vector<0x2::coin::Coin<T0>>, arg8: u64, arg9: bool, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        add_collateral_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun add_collateral_only_farming_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: vector<0x2::coin::Coin<T1>>, arg8: u64, arg9: bool, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        add_collateral_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun add_collateral_only_farming_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: vector<0x2::coin::Coin<T1>>, arg8: u64, arg9: bool, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        add_collateral_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun add_collateral_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: vector<0x2::coin::Coin<T0>>, arg8: u64, arg9: vector<0x2::coin::Coin<T1>>, arg10: u64, arg11: bool, arg12: u8, arg13: vector<u8>, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = join_split_keep<T0>(arg7, arg8, arg18);
        let v1 = join_split_keep<T1>(arg9, arg10, arg18);
        add_collateral_single_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v1, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    }

    public entry fun add_collateral_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: vector<0x2::coin::Coin<T0>>, arg8: u64, arg9: vector<0x2::coin::Coin<T1>>, arg10: u64, arg11: bool, arg12: u8, arg13: vector<u8>, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = join_split_keep<T0>(arg7, arg8, arg18);
        let v1 = join_split_keep<T1>(arg9, arg10, arg18);
        add_collateral_single_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v1, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    }

    public entry fun add_collateral_single_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: bool, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg16);
        let v1 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_add_collateral<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg6, arg7, arg9, health<T0, T1, T2>(arg1, arg5, arg6), is_stable<T0, T1, T2>(arg1, arg2, arg5, arg12, arg13, arg15), is_reserve_consistent<T0, T1, T2>(), arg15, arg16);
        let v2 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::extract_add_collateral_context_coin_send<T0>(&mut v1, arg16);
        assert!(0x2::table::contains<u64, u128>(&arg1.shares, arg6), 36);
        let v3 = share_to_balance<T0, T1, T2>(arg1, *0x2::table::borrow<u64, u128>(&arg1.shares, arg6));
        let v4 = work_inner_safe<T0, T1, T2>(arg2, arg0, arg1, arg4, arg5, arg6, v2, arg8, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_add_collateral_context_debt<T0>(&v1), arg10, arg11, arg14, arg15, arg16);
        if (0x2::coin::value<T0>(&v4) == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else {
            0x2::pay::keep<T0>(v4, arg16);
        };
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_add_collateral<T0>(&arg1.position_operator_cap, arg2, v1, arg9, health<T0, T1, T2>(arg1, arg5, arg6), is_stable<T0, T1, T2>(arg1, arg2, arg5, arg12, arg13, arg15), is_reserve_consistent<T0, T1, T2>());
        assert!(share_to_balance<T0, T1, T2>(arg1, *0x2::table::borrow<u64, u128>(&arg1.shares, arg6)) > v3, 37);
    }

    public entry fun add_collateral_single_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: bool, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg16);
        assert!(0x2::table::contains<u64, u128>(&arg1.shares, arg6), 36);
        let v1 = share_to_balance<T0, T1, T2>(arg1, *0x2::table::borrow<u64, u128>(&arg1.shares, arg6));
        let v2 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_add_collateral<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg6, arg7, arg9, health_reverse<T0, T1, T2>(arg1, arg5, arg6), is_stable_reverse<T0, T1, T2>(arg1, arg2, arg5, arg12, arg13, arg15), is_reserve_consistent<T0, T1, T2>(), arg15, arg16);
        let v3 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::extract_add_collateral_context_coin_send<T0>(&mut v2, arg16);
        let v4 = work_inner_safe_reverse<T0, T1, T2>(arg2, arg0, arg1, arg4, arg5, arg6, v3, arg8, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_add_collateral_context_debt<T0>(&v2), arg10, arg11, arg14, arg15, arg16);
        if (0x2::coin::value<T0>(&v4) == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else {
            0x2::pay::keep<T0>(v4, arg16);
        };
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_add_collateral<T0>(&arg1.position_operator_cap, arg2, v2, arg9, health_reverse<T0, T1, T2>(arg1, arg5, arg6), is_stable_reverse<T0, T1, T2>(arg1, arg2, arg5, arg12, arg13, arg15), is_reserve_consistent<T0, T1, T2>());
        assert!(share_to_balance<T0, T1, T2>(arg1, *0x2::table::borrow<u64, u128>(&arg1.shares, arg6)) > v1, 37);
    }

    fun add_share<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: u64, arg2: u128, arg3: u128) {
        if (arg2 > 0) {
            let v0 = balance_to_share_inner<T0, T1, T2>(arg0, arg2, arg3);
            assert!(v0 > 0, 4);
            let v1 = &mut arg0.shares;
            let v2 = if (0x2::table::contains<u64, u128>(v1, arg1)) {
                0x2::table::borrow_mut<u64, u128>(v1, arg1)
            } else {
                0x2::table::add<u64, u128>(v1, arg1, 0);
                0x2::table::borrow_mut<u64, u128>(v1, arg1)
            };
            *v2 = *v2 + v0;
            arg0.total_share = arg0.total_share + v0;
        };
    }

    public fun balance_to_share<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: u128) : u128 {
        checked_package_version<T0, T1, T2>(arg0);
        balance_to_share_inner<T0, T1, T2>(arg0, arg1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nft)))
    }

    fun balance_to_share_inner<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: u128, arg2: u128) : u128 {
        let v0 = arg0.total_share;
        if (v0 == 0) {
            return arg1
        };
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div_u128(arg1, v0, arg2)
    }

    public fun checked_package_version<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>) {
        assert!(arg0.package_version == 3, 33);
    }

    public fun collect_reward_all_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: bool, arg8: bool, arg9: bool, arg10: bool, arg11: u8, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T0>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v4), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v4) >= v6) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v4, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v5), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v5) >= v7) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v5, v7));
        };
        if (arg7) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T0>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v8);
        };
        if (arg8) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T1>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v10);
        };
        if (arg9) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T3>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v13 = 0x2::balance::value<T3>(&v12);
            if (v13 > 0) {
                if (arg10) {
                    let (v14, v15) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg11, arg3, arg5, 0x2::coin::zero<T0>(arg14), 0x2::coin::from_balance<T3>(v12, arg14), false, true, v13, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v15);
                    let v16 = 0x2::coin::into_balance<T0>(v14);
                    let v17 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v16), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v16) >= v17) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v16, v17));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v16);
                } else {
                    let (v18, v19) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg11, arg3, arg6, 0x2::coin::zero<T1>(arg14), 0x2::coin::from_balance<T3>(v12, arg14), false, true, v13, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v19);
                    let v20 = 0x2::coin::into_balance<T1>(v18);
                    let v21 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v20), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v20) >= v21) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v20, v21));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v20);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v12, arg14));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v4);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v5);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_all_reverse_one_other_no_farm_swap<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: u8, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T0>(arg12, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v4), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v4) >= v6) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v4, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v5), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v5) >= v7) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v5, v7));
        };
        if (arg6) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T0>(arg12, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v8);
        };
        if (arg7) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T1>(arg12, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v10);
        };
        if (arg8) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T3>(arg12, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v13 = 0x2::balance::value<T3>(&v12);
            if (v13 > 0) {
                assert!(arg9 == true, 38);
                let (v14, v15) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg10, arg3, arg5, 0x2::coin::zero<T0>(arg13), 0x2::coin::from_balance<T3>(v12, arg13), false, true, v13, arg11, arg12, arg13);
                0x2::coin::destroy_zero<T3>(v15);
                let v16 = 0x2::coin::into_balance<T0>(v14);
                let v17 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v16), arg2.reinvest_bounty_bps, 10000);
                if (0x2::balance::value<T0>(&v16) >= v17) {
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v16, v17));
                };
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v16);
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v12, arg13));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v4);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v5);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_all_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T0>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T1>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: bool, arg15: u8, arg16: u8, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T0>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v4), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v4) >= v6) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v4, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v5), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v5) >= v7) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v5, v7));
        };
        if (arg9) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T0>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v8);
        };
        if (arg10) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T1>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v10);
        };
        if (arg11) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T3>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v13 = 0x2::balance::value<T3>(&v12);
            if (v13 > 0) {
                if (arg13) {
                    let (v14, v15) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg15, arg3, arg5, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T3>(v12, arg19), false, true, v13, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v15);
                    let v16 = 0x2::coin::into_balance<T0>(v14);
                    let v17 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v16), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v16) >= v17) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v16, v17));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v16);
                } else {
                    let (v18, v19) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg15, arg3, arg6, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T3>(v12, arg19), false, true, v13, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v19);
                    let v20 = 0x2::coin::into_balance<T1>(v18);
                    let v21 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v20), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v20) >= v21) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v20, v21));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v20);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v12, arg19));
            };
        };
        if (arg12) {
            let v22 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T4>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v23 = 0x2::balance::value<T4>(&v22);
            if (v23 > 0) {
                if (arg14) {
                    let (v24, v25) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T4>(arg0, arg1, arg2.coin_base_decimals, arg16, arg3, arg7, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T4>(v22, arg19), false, true, v23, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v25);
                    let v26 = 0x2::coin::into_balance<T0>(v24);
                    let v27 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v26), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v26) >= v27) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v26, v27));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v26);
                } else {
                    let (v28, v29) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T1, T4>(arg0, arg1, arg2.coin_farming_decimals, arg16, arg3, arg8, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T4>(v22, arg19), false, true, v23, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v29);
                    let v30 = 0x2::coin::into_balance<T1>(v28);
                    let v31 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v30), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v30) >= v31) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v30, v31));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v30);
                };
            } else {
                0x2::coin::destroy_zero<T4>(0x2::coin::from_balance<T4>(v22, arg19));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v4);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v5);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_all_reverse_two_others_midone<T0, T1, T2, T3, T4, T5>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T5>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T5, T0>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T0>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: u8, arg15: u8, arg16: u8, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T0>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v4), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v4) >= v6) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v4, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v5), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v5) >= v7) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v5, v7));
        };
        if (arg8) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T0>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v8);
        };
        if (arg9) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T1>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v10);
        };
        if (arg10) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T3>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v13 = 0x2::balance::value<T3>(&v12);
            if (v13 > 0) {
                let (v14, v15) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T5, T3>(arg0, arg1, arg16, arg14, arg3, arg5, 0x2::coin::zero<T5>(arg19), 0x2::coin::from_balance<T3>(v12, arg19), false, true, v13, arg17, arg18, arg19);
                let v16 = v14;
                0x2::coin::destroy_zero<T3>(v15);
                let v17 = 0x2::coin::value<T5>(&v16);
                if (v17 > 0) {
                    assert!(arg12, 0);
                    let (v18, v19) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T5>(arg0, arg1, arg2.coin_base_decimals, arg16, arg3, arg6, 0x2::coin::zero<T0>(arg19), v16, false, true, v17, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T5>(v19);
                    let v20 = 0x2::coin::into_balance<T0>(v18);
                    let v21 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v20), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v20) >= v21) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v20, v21));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v20);
                } else {
                    0x2::coin::destroy_zero<T5>(v16);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v12, arg19));
            };
        };
        if (arg11) {
            let v22 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T4>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v23 = 0x2::balance::value<T4>(&v22);
            if (v23 > 0) {
                assert!(arg13, 0);
                let (v24, v25) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T4>(arg0, arg1, arg2.coin_base_decimals, arg15, arg3, arg7, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T4>(v22, arg19), false, true, v23, arg17, arg18, arg19);
                0x2::coin::destroy_zero<T4>(v25);
                let v26 = 0x2::coin::into_balance<T0>(v24);
                let v27 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v26), arg2.reinvest_bounty_bps, 10000);
                if (0x2::balance::value<T0>(&v26) >= v27) {
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v26, v27));
                };
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v26);
            } else {
                0x2::coin::destroy_zero<T4>(0x2::coin::from_balance<T4>(v22, arg19));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v4);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v5);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: bool, arg8: bool, arg9: bool, arg10: bool, arg11: u8, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v5), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v5) >= v6) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v5, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v4), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v4) >= v7) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v4, v7));
        };
        if (arg7) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v8);
        };
        if (arg8) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v10);
        };
        if (arg9) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T3>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v13 = 0x2::balance::value<T3>(&v12);
            if (v13 > 0) {
                if (arg10) {
                    let (v14, v15) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg11, arg3, arg5, 0x2::coin::zero<T0>(arg14), 0x2::coin::from_balance<T3>(v12, arg14), false, true, v13, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v15);
                    let v16 = 0x2::coin::into_balance<T0>(v14);
                    let v17 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v16), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v16) >= v17) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v16, v17));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v16);
                } else {
                    let (v18, v19) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg11, arg3, arg6, 0x2::coin::zero<T1>(arg14), 0x2::coin::from_balance<T3>(v12, arg14), false, true, v13, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v19);
                    let v20 = 0x2::coin::into_balance<T1>(v18);
                    let v21 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v20), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v20) >= v21) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v20, v21));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v20);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v12, arg14));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v5);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v4);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_pool_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: bool, arg8: bool, arg9: bool, arg10: bool, arg11: u8, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T0>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v4), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v4) >= v6) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v4, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v5), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v5) >= v7) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v5, v7));
        };
        if (arg7) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T0>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v8);
        };
        if (arg8) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T1>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v10);
        };
        if (arg9) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T3>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v13 = 0x2::balance::value<T3>(&v12);
            if (v13 > 0) {
                if (arg10) {
                    let (v14, v15) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg11, arg3, arg5, 0x2::coin::zero<T0>(arg14), 0x2::coin::from_balance<T3>(v12, arg14), false, true, v13, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v15);
                    let v16 = 0x2::coin::into_balance<T0>(v14);
                    let v17 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v16), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v16) >= v17) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v16, v17));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v16);
                } else {
                    let (v18, v19) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg11, arg3, arg6, 0x2::coin::zero<T1>(arg14), 0x2::coin::from_balance<T3>(v12, arg14), false, true, v13, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v19);
                    let v20 = 0x2::coin::into_balance<T1>(v18);
                    let v21 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v20), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v20) >= v21) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v20, v21));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v20);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v12, arg14));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v4);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v5);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_pool_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T4>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T4>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: bool, arg15: u8, arg16: u8, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T0>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v4), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v4) >= v6) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v4, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v5), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v5) >= v7) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v5, v7));
        };
        if (arg9) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T0>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v8);
        };
        if (arg10) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T1>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v10);
        };
        if (arg11) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T3>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v13 = 0x2::balance::value<T3>(&v12);
            if (v13 > 0) {
                if (arg13) {
                    let (v14, v15) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg15, arg3, arg5, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T3>(v12, arg19), false, true, v13, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v15);
                    let v16 = 0x2::coin::into_balance<T0>(v14);
                    let v17 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v16), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v16) >= v17) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v16, v17));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v16);
                } else {
                    let (v18, v19) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg15, arg3, arg6, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T3>(v12, arg19), false, true, v13, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v19);
                    let v20 = 0x2::coin::into_balance<T1>(v18);
                    let v21 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v20), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v20) >= v21) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v20, v21));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v20);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v12, arg19));
            };
        };
        if (arg12) {
            let v22 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T4>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v23 = 0x2::balance::value<T4>(&v22);
            if (v23 > 0) {
                if (arg14) {
                    let (v24, v25) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T0, T4>(arg0, arg1, arg2.coin_base_decimals, arg16, arg3, arg7, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T4>(v22, arg19), false, true, v23, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v25);
                    let v26 = 0x2::coin::into_balance<T0>(v24);
                    let v27 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v26), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v26) >= v27) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v26, v27));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v26);
                } else {
                    let (v28, v29) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T1, T4>(arg0, arg1, arg2.coin_farming_decimals, arg16, arg3, arg8, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T4>(v22, arg19), false, true, v23, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v29);
                    let v30 = 0x2::coin::into_balance<T1>(v28);
                    let v31 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v30), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v30) >= v31) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v30, v31));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v30);
                };
            } else {
                0x2::coin::destroy_zero<T4>(0x2::coin::from_balance<T4>(v22, arg19));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v4);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v5);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_swap_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: bool, arg8: bool, arg9: bool, arg10: bool, arg11: u8, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v5), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v5) >= v6) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v5, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v4), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v4) >= v7) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v4, v7));
        };
        if (arg7) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v8);
        };
        if (arg8) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v10);
        };
        if (arg9) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T3>(arg13, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v13 = 0x2::balance::value<T3>(&v12);
            if (v13 > 0) {
                if (arg10) {
                    let (v14, v15) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg11, arg3, arg5, 0x2::coin::zero<T0>(arg14), 0x2::coin::from_balance<T3>(v12, arg14), false, true, v13, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v15);
                    let v16 = 0x2::coin::into_balance<T0>(v14);
                    let v17 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v16), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v16) >= v17) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v16, v17));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v16);
                } else {
                    let (v18, v19) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg11, arg3, arg6, 0x2::coin::zero<T1>(arg14), 0x2::coin::from_balance<T3>(v12, arg14), false, true, v13, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v19);
                    let v20 = 0x2::coin::into_balance<T1>(v18);
                    let v21 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v20), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v20) >= v21) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v20, v21));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v20);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v12, arg14));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v5);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v4);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_swap_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T0>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T1>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: bool, arg15: u8, arg16: u8, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v5), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v5) >= v6) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v5, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v4), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v4) >= v7) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v4, v7));
        };
        if (arg9) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v8);
        };
        if (arg10) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v10);
        };
        if (arg11) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T3>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v13 = 0x2::balance::value<T3>(&v12);
            if (v13 > 0) {
                if (arg13) {
                    let (v14, v15) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg15, arg3, arg5, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T3>(v12, arg19), false, true, v13, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v15);
                    let v16 = 0x2::coin::into_balance<T0>(v14);
                    let v17 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v16), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v16) >= v17) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v16, v17));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v16);
                } else {
                    let (v18, v19) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg15, arg3, arg6, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T3>(v12, arg19), false, true, v13, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v19);
                    let v20 = 0x2::coin::into_balance<T1>(v18);
                    let v21 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v20), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v20) >= v21) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v20, v21));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v20);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v12, arg19));
            };
        };
        if (arg12) {
            let v22 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T4>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v23 = 0x2::balance::value<T4>(&v22);
            if (v23 > 0) {
                if (arg14) {
                    let (v24, v25) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T4>(arg0, arg1, arg2.coin_base_decimals, arg16, arg3, arg7, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T4>(v22, arg19), false, true, v23, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v25);
                    let v26 = 0x2::coin::into_balance<T0>(v24);
                    let v27 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v26), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v26) >= v27) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v26, v27));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v26);
                } else {
                    let (v28, v29) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T1, T4>(arg0, arg1, arg2.coin_farming_decimals, arg16, arg3, arg8, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T4>(v22, arg19), false, true, v23, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v29);
                    let v30 = 0x2::coin::into_balance<T1>(v28);
                    let v31 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v30), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v30) >= v31) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v30, v31));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v30);
                };
            } else {
                0x2::coin::destroy_zero<T4>(0x2::coin::from_balance<T4>(v22, arg19));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v5);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v4);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T4>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T4>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: bool, arg15: u8, arg16: u8, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v5), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v5) >= v6) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v5, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v4), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v4) >= v7) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v4, v7));
        };
        if (arg9) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v8);
        };
        if (arg10) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v10);
        };
        if (arg11) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T3>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v13 = 0x2::balance::value<T3>(&v12);
            if (v13 > 0) {
                if (arg13) {
                    let (v14, v15) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg15, arg3, arg5, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T3>(v12, arg19), false, true, v13, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v15);
                    let v16 = 0x2::coin::into_balance<T0>(v14);
                    let v17 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v16), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v16) >= v17) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v16, v17));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v16);
                } else {
                    let (v18, v19) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg15, arg3, arg6, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T3>(v12, arg19), false, true, v13, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v19);
                    let v20 = 0x2::coin::into_balance<T1>(v18);
                    let v21 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v20), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v20) >= v21) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v20, v21));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v20);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v12, arg19));
            };
        };
        if (arg12) {
            let v22 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T4>(arg18, arg3, arg4, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft));
            let v23 = 0x2::balance::value<T4>(&v22);
            if (v23 > 0) {
                if (arg14) {
                    let (v24, v25) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T0, T4>(arg0, arg1, arg2.coin_base_decimals, arg16, arg3, arg7, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T4>(v22, arg19), false, true, v23, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v25);
                    let v26 = 0x2::coin::into_balance<T0>(v24);
                    let v27 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v26), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v26) >= v27) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v26, v27));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v26);
                } else {
                    let (v28, v29) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T1, T4>(arg0, arg1, arg2.coin_farming_decimals, arg16, arg3, arg8, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T4>(v22, arg19), false, true, v23, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v29);
                    let v30 = 0x2::coin::into_balance<T1>(v28);
                    let v31 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v30), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v30) >= v31) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v30, v31));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v30);
                };
            } else {
                0x2::coin::destroy_zero<T4>(0x2::coin::from_balance<T4>(v22, arg19));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v5);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v4);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_without_swap<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg5, arg1, arg2, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v5), arg0.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v5) >= v6) {
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v5, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v4), arg0.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v4) >= v7) {
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v4, v7));
        };
        if (arg3) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg5, arg1, arg2, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg0.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg0.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v8);
        };
        if (arg4) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg5, arg1, arg2, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg0.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg0.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v10);
        };
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v5);
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v4);
        (0x2::balance::value<T0>(&arg0.tiny_coin_base), 0x2::balance::value<T1>(&arg0.tiny_coin_farming))
    }

    public fun collect_reward_without_swap_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T0>(arg5, arg1, arg2, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nft));
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v4), arg0.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v4) >= v6) {
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v4, v6));
        };
        let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v5), arg0.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v5) >= v7) {
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v5, v7));
        };
        if (arg3) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T0>(arg5, arg1, arg2, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nft));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v8), arg0.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v8) >= v9) {
                0x2::balance::join<T0>(&mut arg0.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v8, v9));
            };
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v8);
        };
        if (arg4) {
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T1>(arg5, arg1, arg2, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nft));
            let v11 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v10), arg0.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v10) >= v11) {
                0x2::balance::join<T1>(&mut arg0.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v10, v11));
            };
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v10);
        };
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v4);
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v5);
        (0x2::balance::value<T0>(&arg0.tiny_coin_base), 0x2::balance::value<T1>(&arg0.tiny_coin_farming))
    }

    public fun get_max_reinvestor_bounty_bps<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>) : u64 {
        checked_package_version<T0, T1, T2>(arg0);
        arg0.max_reinvest_bounty_bps
    }

    fun get_mkt_sell_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        assert!(arg1 > 0 && arg2 > 0, 6);
        let v0 = arg0 * 9980;
        (((v0 as u128) * (arg2 as u128) / ((arg1 as u128) * 10000 + (v0 as u128))) as u64)
    }

    public fun get_mole_cetus_worker_addr() : address {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::type_to_package_address<AdminCap>()
    }

    public fun get_reinvestor_bounty_bps<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>) : u64 {
        checked_package_version<T0, T1, T2>(arg0);
        arg0.reinvest_bounty_bps
    }

    public fun get_share<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: u64) : u128 {
        checked_package_version<T0, T1, T2>(arg0);
        *0x2::table::borrow<u64, u128>(&arg0.shares, arg1)
    }

    public fun health<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u64) : u64 {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = &arg0.shares;
        let v1 = 0;
        if (0x2::table::contains<u64, u128>(v0, arg2)) {
            v1 = *0x2::table::borrow<u64, u128>(v0, arg2);
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nft));
        let v3 = share_to_balance_inner<T2>(v2, arg0.total_share, v1);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nft)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nft)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), v2, false);
        let v6 = if (v2 == 0) {
            0
        } else {
            (0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div_u128(v3, (v4 as u128), v2) as u64)
        };
        let v7 = if (v2 == 0) {
            0
        } else {
            (0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div_u128(v3, (v5 as u128), v2) as u64)
        };
        let v8 = false;
        let v9 = if (v8) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1
        };
        let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, v8, true, v7, v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v10) + v6
    }

    public fun health_reverse<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: u64) : u64 {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = &arg0.shares;
        let v1 = 0;
        if (0x2::table::contains<u64, u128>(v0, arg2)) {
            v1 = *0x2::table::borrow<u64, u128>(v0, arg2);
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nft));
        let v3 = share_to_balance_inner<T2>(v2, arg0.total_share, v1);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nft)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nft)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T1, T0>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg1), v2, false);
        let v6 = if (v2 == 0) {
            0
        } else {
            (0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div_u128(v3, (v5 as u128), v2) as u64)
        };
        let v7 = if (v2 == 0) {
            0
        } else {
            (0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div_u128(v3, (v4 as u128), v2) as u64)
        };
        let v8 = true;
        let v9 = if (v8) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1
        };
        let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, T0>(arg1, v8, true, v7, v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v10) + v6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize<T0, T1, T2>(arg0: &AdminCap, arg1: &0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::AdminCap, arg2: &0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::AdminCap, arg3: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg4: &mut 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::WorkerInfoStore, arg5: u8, arg6: u8, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: address, arg10: u64, arg11: address, arg12: u64, arg13: u32, arg14: u32, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = get_mole_cetus_worker_addr();
        assert!(!0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::is_worker_info_registered(arg4, v0), 2);
        assert!(0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::is_vault_initialized<T0>(arg3), 13);
        let v1 = 900;
        assert!(arg10 <= v1, 15);
        let v2 = WorkerInfo<T0, T1, T2>{
            id                       : 0x2::object::new(arg15),
            reinvest_bounty_bps      : arg10,
            max_reinvest_bounty_bps  : v1,
            ok_reinvestors           : 0x2::table::new<address, bool>(arg15),
            ok_rebalancers           : 0x2::table::new<address, bool>(arg15),
            ok_strategies            : 0x2::table::new<u8, bool>(arg15),
            treasury_account         : arg11,
            reinvest_path            : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reinvest_threshold       : arg12,
            shares                   : 0x2::table::new<u64, u128>(arg15),
            total_share              : 0,
            config                   : arg9,
            position_nft             : 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg7, arg8, arg13, arg14, arg15)),
            position_operator_cap    : 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::acquire_position_operator_cap<T0>(arg1),
            coin_base_decimals       : arg5,
            coin_farming_decimals    : arg6,
            tiny_coin_base           : 0x2::balance::zero<T0>(),
            tiny_coin_farming        : 0x2::balance::zero<T1>(),
            pool_id                  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg8),
            package_version          : 3,
            tiny_coin_base_bounty    : 0x2::balance::zero<T0>(),
            tiny_coin_farming_bounty : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<WorkerInfo<T0, T1, T2>>(v2);
        0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::register_worker_info<T0, T1, T2>(arg2, arg4, v0);
        let v3 = InitializeEvent{worker_info: 0x2::object::uid_to_address(&v2.id)};
        0x2::event::emit<InitializeEvent>(v3);
    }

    public entry fun initialize_reverse<T0, T1, T2>(arg0: &AdminCap, arg1: &0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::AdminCap, arg2: &0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::AdminCap, arg3: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg4: &mut 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::WorkerInfoStore, arg5: u8, arg6: u8, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg9: address, arg10: u64, arg11: address, arg12: u64, arg13: u32, arg14: u32, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = get_mole_cetus_worker_addr();
        assert!(!0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::is_worker_info_registered(arg4, v0), 2);
        assert!(0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::is_vault_initialized<T0>(arg3), 13);
        let v1 = 900;
        assert!(arg10 <= v1, 15);
        let v2 = WorkerInfo<T0, T1, T2>{
            id                       : 0x2::object::new(arg15),
            reinvest_bounty_bps      : arg10,
            max_reinvest_bounty_bps  : v1,
            ok_reinvestors           : 0x2::table::new<address, bool>(arg15),
            ok_rebalancers           : 0x2::table::new<address, bool>(arg15),
            ok_strategies            : 0x2::table::new<u8, bool>(arg15),
            treasury_account         : arg11,
            reinvest_path            : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reinvest_threshold       : arg12,
            shares                   : 0x2::table::new<u64, u128>(arg15),
            total_share              : 0,
            config                   : arg9,
            position_nft             : 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T1, T0>(arg7, arg8, arg13, arg14, arg15)),
            position_operator_cap    : 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::acquire_position_operator_cap<T0>(arg1),
            coin_base_decimals       : arg5,
            coin_farming_decimals    : arg6,
            tiny_coin_base           : 0x2::balance::zero<T0>(),
            tiny_coin_farming        : 0x2::balance::zero<T1>(),
            pool_id                  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg8),
            package_version          : 3,
            tiny_coin_base_bounty    : 0x2::balance::zero<T0>(),
            tiny_coin_farming_bounty : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<WorkerInfo<T0, T1, T2>>(v2);
        0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::register_worker_info<T0, T1, T2>(arg2, arg4, v0);
        let v3 = InitializeEvent{worker_info: 0x2::object::uid_to_address(&v2.id)};
        0x2::event::emit<InitializeEvent>(v3);
    }

    public fun is_rebalancer<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: address) : bool {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = &arg0.ok_rebalancers;
        0x2::table::contains<address, bool>(v0, arg1) && *0x2::table::borrow<address, bool>(v0, arg1)
    }

    public fun is_reinvestor<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: address) : bool {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = &arg0.ok_reinvestors;
        0x2::table::contains<address, bool>(v0, arg1) && *0x2::table::borrow<address, bool>(v0, arg1)
    }

    public fun is_reserve_consistent<T0, T1, T2>() : bool {
        true
    }

    public fun is_stable<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x2::clock::Clock) : bool {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = arg0.config;
        let (v1, v2) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::get_pool_price_amount_ratio<T0, T1>(arg2);
        let (v3, v4) = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::oracle_medianizer::get_price_generic<T0, T1>(arg1, 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_oracle(arg1, v0), arg3, arg4, arg5);
        if (v4 + 86400 <= now_seconds(arg5)) {
            return false
        };
        let v5 = ((v2 * (0x2::math::pow(10, 8) as u128) * (0x2::math::pow(10, 9 - arg0.coin_farming_decimals) as u128) / v1 / (0x2::math::pow(10, 9 - arg0.coin_base_decimals) as u128)) as u64);
        let v6 = 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_max_price_diff(arg1, v0, get_mole_cetus_worker_addr());
        let v7 = 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_max_price_diff_scale();
        if (v5 * v7 > v3 * v6 || v5 * v6 < v3 * v7) {
            return false
        };
        true
    }

    public fun is_stable_reverse<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x2::clock::Clock) : bool {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = arg0.config;
        let (v1, v2) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::get_pool_price_amount_ratio<T1, T0>(arg2);
        let (v3, v4) = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::oracle_medianizer::get_price_generic<T0, T1>(arg1, 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_oracle(arg1, v0), arg3, arg4, arg5);
        if (v4 + 86400 <= now_seconds(arg5)) {
            return false
        };
        let v5 = ((v1 * (0x2::math::pow(10, 8) as u128) * (0x2::math::pow(10, 9 - arg0.coin_farming_decimals) as u128) / v2 / (0x2::math::pow(10, 9 - arg0.coin_base_decimals) as u128)) as u64);
        let v6 = 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_max_price_diff(arg1, v0, get_mole_cetus_worker_addr());
        let v7 = 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_max_price_diff_scale();
        if (v5 * v7 > v3 * v6 || v5 * v6 < v3 * v7) {
            return false
        };
        true
    }

    public fun is_strategy_ok<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: u8) : bool {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = &arg0.ok_strategies;
        0x2::table::contains<u8, bool>(v0, arg1) && *0x2::table::borrow<u8, bool>(v0, arg1)
    }

    fun join_split_keep<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        0x2::pay::keep<T0>(v0, arg2);
        0x2::coin::split<T0>(&mut v0, arg1, arg2)
    }

    public entry fun kill_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg11);
        let v1 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_kill<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg6, health<T0, T1, T2>(arg1, arg5, arg6), is_stable<T0, T1, T2>(arg1, arg2, arg5, arg7, arg8, arg10), arg10, arg11);
        let v2 = liquidate_safe<T0, T1, T2>(arg2, arg0, arg1, arg5, arg4, arg6, arg9, arg10, arg11);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::merge_kill_context_coin_back<T0>(&mut v1, v2);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_kill<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, v1, arg11);
    }

    public entry fun kill_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg11);
        let v1 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_kill<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg6, health_reverse<T0, T1, T2>(arg1, arg5, arg6), is_stable_reverse<T0, T1, T2>(arg1, arg2, arg5, arg7, arg8, arg10), arg10, arg11);
        let v2 = liquidate_safe_reverse<T0, T1, T2>(arg2, arg0, arg1, arg5, arg4, arg6, arg9, arg10, arg11);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::merge_kill_context_coin_back<T0>(&mut v1, v2);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_kill<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, v1, arg11);
    }

    fun liquidate_safe<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg2, arg5);
        let v1 = 0x2::coin::zero<T0>(arg8);
        let v2 = 0x2::coin::zero<T1>(arg8);
        let (v3, v4) = strategy_execute_safe<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, v1, v2, v0, 0, 3, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::encode_u64(0), arg6, arg7, arg8);
        let v5 = v4;
        assert!(0x2::coin::value<T1>(&v5) == 0, 24);
        0x2::coin::destroy_zero<T1>(v5);
        v3
    }

    fun liquidate_safe_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg2, arg5);
        let v1 = 0x2::coin::zero<T0>(arg8);
        let v2 = 0x2::coin::zero<T1>(arg8);
        let (v3, v4) = strategy_execute_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, v1, v2, v0, 0, 3, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::encode_u64(0), arg6, arg7, arg8);
        let v5 = v4;
        assert!(0x2::coin::value<T1>(&v5) == 0, 24);
        0x2::coin::destroy_zero<T1>(v5);
        v3
    }

    fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun position_info<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        (health<T0, T1, T2>(arg0, arg2, arg3), 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::position_debt_val<T0>(arg1, arg3))
    }

    public fun position_info_reverse<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: u64) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        (health_reverse<T0, T1, T2>(arg0, arg2, arg3), 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::position_debt_val<T0>(arg1, arg3))
    }

    public entry fun rebalance_all_safe_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: bool, arg8: bool, arg9: bool, arg10: u32, arg11: u32, arg12: u128, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: bool, arg17: u8, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg16, arg17, arg18, arg20, arg21);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg10, arg11, arg12, arg13, arg14, arg15, arg19, arg20, arg21);
    }

    public entry fun rebalance_all_safe_reverse_one_other_no_farm_swap<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: bool, arg7: bool, arg8: bool, arg9: u32, arg10: u32, arg11: u128, arg12: u64, arg13: u64, arg14: vector<u8>, arg15: bool, arg16: u8, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_one_other_no_farm_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg15, arg16, arg17, arg19, arg20);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg9, arg10, arg11, arg12, arg13, arg14, arg18, arg19, arg20);
    }

    public entry fun rebalance_all_safe_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T0>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T1>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: u32, arg14: u32, arg15: u128, arg16: u64, arg17: u64, arg18: vector<u8>, arg19: bool, arg20: bool, arg21: u8, arg22: u8, arg23: u64, arg24: u64, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg19, arg20, arg21, arg22, arg23, arg25, arg26);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg13, arg14, arg15, arg16, arg17, arg18, arg24, arg25, arg26);
    }

    public entry fun rebalance_all_safe_reverse_two_others_midone<T0, T1, T2, T3, T4, T5>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T5>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T5, T0>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T0>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u32, arg13: u32, arg14: u128, arg15: u64, arg16: u64, arg17: vector<u8>, arg18: bool, arg19: bool, arg20: u8, arg21: u8, arg22: u8, arg23: u64, arg24: u64, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_two_others_midone<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg18, arg19, arg20, arg21, arg22, arg23, arg25, arg26);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg12, arg13, arg14, arg15, arg16, arg17, arg24, arg25, arg26);
    }

    fun rebalance_inner_safe<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: u128, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(is_rebalancer<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg13)), 32);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft))) == arg5 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft))) == arg6) {
            abort 26
        };
        let v0 = 0x1::option::extract<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            let (v4, v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg4, &mut v0, v1, arg12);
            let _ = v5;
            let _ = v4;
            (v6, v7)
        } else {
            let _ = 0;
            let _ = 0;
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v10 = v3;
        let v11 = v2;
        0x2::balance::join<T0>(&mut v11, 0x2::balance::withdraw_all<T0>(&mut arg2.tiny_coin_base));
        0x2::balance::join<T1>(&mut v10, 0x2::balance::withdraw_all<T1>(&mut arg2.tiny_coin_farming));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg12, arg3, arg4, v0);
        0x1::option::fill<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg4, arg5, arg6, arg13));
        if (0x2::balance::value<T0>(&v11) > 0 || 0x2::balance::value<T1>(&v10) > 0) {
            let v12 = 0x2::coin::from_balance<T0>(v11, arg13);
            let v13 = 0x2::coin::from_balance<T1>(v10, arg13);
            let (v14, v15) = strategy_execute_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v12, v13, 0, 0, 2, arg10, arg11, arg12, arg13);
            let v16 = v15;
            let v17 = v14;
            assert!(0x2::coin::value<T0>(&v17) <= arg8 && 0x2::coin::value<T1>(&v16) <= arg9, 27);
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, 0x2::coin::into_balance<T0>(v17));
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, 0x2::coin::into_balance<T1>(v16));
        } else {
            0x2::balance::destroy_zero<T0>(v11);
            0x2::balance::destroy_zero<T1>(v10);
        };
        let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft));
        assert!(v18 >= arg7, 28);
        let v19 = RebalanceEvent{
            tick_lower_idx   : arg5,
            tick_upper_idx   : arg6,
            liquidity_before : v1,
            liquidity_after  : v18,
        };
        0x2::event::emit<RebalanceEvent>(v19);
    }

    fun rebalance_inner_safe_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: u32, arg6: u32, arg7: u128, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(is_rebalancer<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg13)), 32);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft))) == arg5 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft))) == arg6) {
            abort 26
        };
        let v0 = 0x1::option::extract<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            let (v4, v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T1, T0>(arg3, arg4, &mut v0, v1, arg12);
            let _ = v5;
            let _ = v4;
            (v6, v7)
        } else {
            let _ = 0;
            let _ = 0;
            (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        let v10 = v3;
        let v11 = v2;
        0x2::balance::join<T0>(&mut v10, 0x2::balance::withdraw_all<T0>(&mut arg2.tiny_coin_base));
        0x2::balance::join<T1>(&mut v11, 0x2::balance::withdraw_all<T1>(&mut arg2.tiny_coin_farming));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T1, T0>(arg12, arg3, arg4, v0);
        0x1::option::fill<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T1, T0>(arg3, arg4, arg5, arg6, arg13));
        if (0x2::balance::value<T0>(&v10) > 0 || 0x2::balance::value<T1>(&v11) > 0) {
            let v12 = 0x2::coin::from_balance<T0>(v10, arg13);
            let v13 = 0x2::coin::from_balance<T1>(v11, arg13);
            let (v14, v15) = strategy_execute_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v12, v13, 0, 0, 2, arg10, arg11, arg12, arg13);
            let v16 = v15;
            let v17 = v14;
            assert!(0x2::coin::value<T0>(&v17) <= arg8 && 0x2::coin::value<T1>(&v16) <= arg9, 27);
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, 0x2::coin::into_balance<T0>(v17));
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, 0x2::coin::into_balance<T1>(v16));
        } else {
            0x2::balance::destroy_zero<T0>(v10);
            0x2::balance::destroy_zero<T1>(v11);
        };
        let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft));
        assert!(v18 >= arg7, 28);
        let v19 = RebalanceEvent{
            tick_lower_idx   : arg5,
            tick_upper_idx   : arg6,
            liquidity_before : v1,
            liquidity_after  : v18,
        };
        0x2::event::emit<RebalanceEvent>(v19);
    }

    public entry fun rebalance_one_other_safe<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: bool, arg8: bool, arg9: bool, arg10: u32, arg11: u32, arg12: u128, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: bool, arg17: u8, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg16, arg17, arg18, arg20, arg21);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg10, arg11, arg12, arg13, arg14, arg15, arg19, arg20, arg21);
    }

    public entry fun rebalance_pool_safe_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: bool, arg8: bool, arg9: bool, arg10: u32, arg11: u32, arg12: u128, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: bool, arg17: u8, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_pool_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg16, arg17, arg18, arg20, arg21);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg10, arg11, arg12, arg13, arg14, arg15, arg19, arg20, arg21);
    }

    public entry fun rebalance_pool_safe_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T4>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T4>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: u32, arg14: u32, arg15: u128, arg16: u64, arg17: u64, arg18: vector<u8>, arg19: bool, arg20: bool, arg21: u8, arg22: u8, arg23: u64, arg24: u64, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_pool_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg19, arg20, arg21, arg22, arg23, arg25, arg26);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg13, arg14, arg15, arg16, arg17, arg18, arg24, arg25, arg26);
    }

    public entry fun rebalance_swap_safe_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: bool, arg8: bool, arg9: bool, arg10: u32, arg11: u32, arg12: u128, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: bool, arg17: u8, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_swap_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg16, arg17, arg18, arg20, arg21);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg10, arg11, arg12, arg13, arg14, arg15, arg19, arg20, arg21);
    }

    public entry fun rebalance_swap_safe_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T0>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T1>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: u32, arg14: u32, arg15: u128, arg16: u64, arg17: u64, arg18: vector<u8>, arg19: bool, arg20: bool, arg21: u8, arg22: u8, arg23: u64, arg24: u64, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_swap_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg19, arg20, arg21, arg22, arg23, arg25, arg26);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg13, arg14, arg15, arg16, arg17, arg18, arg24, arg25, arg26);
    }

    public entry fun rebalance_two_others_safe<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T4>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T4>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: u32, arg14: u32, arg15: u128, arg16: u64, arg17: u64, arg18: vector<u8>, arg19: bool, arg20: bool, arg21: u8, arg22: u8, arg23: u64, arg24: u64, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg19, arg20, arg21, arg22, arg23, arg25, arg26);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg13, arg14, arg15, arg16, arg17, arg18, arg24, arg25, arg26);
    }

    public entry fun rebalance_without_swap_reward_safe<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: bool, arg6: bool, arg7: u32, arg8: u32, arg9: u128, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_without_swap<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg15);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg14, arg15, arg16);
    }

    public entry fun rebalance_without_swap_reward_safe_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: bool, arg6: bool, arg7: u32, arg8: u32, arg9: u128, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_without_swap_reverse<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg15);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg14, arg15, arg16);
    }

    public entry fun reinvest_all_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: bool, arg8: bool, arg9: bool, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: bool, arg15: u8, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14, arg15, arg16, arg18, arg19);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg10, arg11, arg12, arg13, arg17, arg18, arg19);
    }

    public entry fun reinvest_all_reverse_one_other_no_farm_swap<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: bool, arg7: bool, arg8: bool, arg9: u128, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: bool, arg14: u8, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_one_other_no_farm_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg13, arg14, arg15, arg17, arg18);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg9, arg10, arg11, arg12, arg16, arg17, arg18);
    }

    public entry fun reinvest_all_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T0>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T1>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: u128, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: bool, arg18: bool, arg19: u8, arg20: u8, arg21: u64, arg22: u64, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg17, arg18, arg19, arg20, arg21, arg23, arg24);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg13, arg14, arg15, arg16, arg22, arg23, arg24);
    }

    public entry fun reinvest_all_reverse_two_others_midone<T0, T1, T2, T3, T4, T5>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T5>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T5, T0>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T0>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u128, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: bool, arg17: bool, arg18: u8, arg19: u8, arg20: u8, arg21: u64, arg22: u64, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_two_others_midone<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg16, arg17, arg18, arg19, arg20, arg21, arg23, arg24);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg12, arg13, arg14, arg15, arg22, arg23, arg24);
    }

    fun reinvest_inner<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: u128, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(is_reinvestor<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg11)), 20);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft));
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg2.tiny_coin_base);
        let v2 = 0x2::balance::withdraw_all<T1>(&mut arg2.tiny_coin_farming);
        if (0x2::balance::value<T0>(&v1) == 0 && 0x2::balance::value<T1>(&v2) == 0) {
            abort 29
        };
        let v3 = 0x2::coin::from_balance<T0>(v1, arg11);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg11);
        let (v5, v6) = strategy_execute_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v3, v4, 0, 0, 2, arg8, arg9, arg10, arg11);
        let v7 = v6;
        let v8 = v5;
        assert!(0x2::coin::value<T0>(&v8) <= arg6 && 0x2::coin::value<T1>(&v7) <= arg7, 27);
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, 0x2::coin::into_balance<T0>(v8));
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, 0x2::coin::into_balance<T1>(v7));
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft));
        assert!(v9 >= v0 + arg5, 28);
        let v10 = ReinvestEvent{
            liquidity_before : v0,
            liquidity_after  : v9,
        };
        0x2::event::emit<ReinvestEvent>(v10);
    }

    fun reinvest_inner_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: u128, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(is_reinvestor<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg11)), 20);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft));
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg2.tiny_coin_base);
        let v2 = 0x2::balance::withdraw_all<T1>(&mut arg2.tiny_coin_farming);
        if (0x2::balance::value<T0>(&v1) == 0 && 0x2::balance::value<T1>(&v2) == 0) {
            abort 29
        };
        let v3 = 0x2::coin::from_balance<T0>(v1, arg11);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg11);
        let (v5, v6) = strategy_execute_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v3, v4, 0, 0, 2, arg8, arg9, arg10, arg11);
        let v7 = v6;
        let v8 = v5;
        assert!(0x2::coin::value<T0>(&v8) <= arg6 && 0x2::coin::value<T1>(&v7) <= arg7, 27);
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, 0x2::coin::into_balance<T0>(v8));
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, 0x2::coin::into_balance<T1>(v7));
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft));
        assert!(v9 >= v0 + arg5, 28);
        let v10 = ReinvestEvent{
            liquidity_before : v0,
            liquidity_after  : v9,
        };
        0x2::event::emit<ReinvestEvent>(v10);
    }

    public entry fun reinvest_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: bool, arg8: bool, arg9: bool, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: bool, arg15: u8, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14, arg15, arg16, arg18, arg19);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg10, arg11, arg12, arg13, arg17, arg18, arg19);
    }

    public entry fun reinvest_pool_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: bool, arg8: bool, arg9: bool, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: bool, arg15: u8, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_pool_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14, arg15, arg16, arg18, arg19);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg10, arg11, arg12, arg13, arg17, arg18, arg19);
    }

    public entry fun reinvest_pool_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T4>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T4>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: u128, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: bool, arg18: bool, arg19: u8, arg20: u8, arg21: u64, arg22: u64, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_pool_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg17, arg18, arg19, arg20, arg21, arg23, arg24);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg13, arg14, arg15, arg16, arg22, arg23, arg24);
    }

    public entry fun reinvest_swap_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: bool, arg8: bool, arg9: bool, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: bool, arg15: u8, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_swap_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14, arg15, arg16, arg18, arg19);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg10, arg11, arg12, arg13, arg17, arg18, arg19);
    }

    public entry fun reinvest_swap_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T0>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T1>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: u128, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: bool, arg18: bool, arg19: u8, arg20: u8, arg21: u64, arg22: u64, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_swap_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg17, arg18, arg19, arg20, arg21, arg23, arg24);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg13, arg14, arg15, arg16, arg22, arg23, arg24);
    }

    public entry fun reinvest_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T4>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T4>, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: u128, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: bool, arg18: bool, arg19: u8, arg20: u8, arg21: u64, arg22: u64, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg17, arg18, arg19, arg20, arg21, arg23, arg24);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg13, arg14, arg15, arg16, arg22, arg23, arg24);
    }

    public entry fun reinvest_without_swap_reward<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: bool, arg6: bool, arg7: u128, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_without_swap<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg13);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg12, arg13, arg14);
    }

    public entry fun reinvest_without_swap_reward_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: bool, arg6: bool, arg7: u128, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_without_swap_reverse<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg13);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg12, arg13, arg14);
    }

    fun remove_share<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: u64) : u128 {
        if (0x2::table::contains<u64, u128>(&arg0.shares, arg1)) {
            let v0 = *0x2::table::borrow<u64, u128>(&arg0.shares, arg1);
            if (v0 > 0) {
                arg0.total_share = arg0.total_share - v0;
                *0x2::table::borrow_mut<u64, u128>(&mut arg0.shares, arg1) = 0;
                return share_to_balance_inner<T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nft)), arg0.total_share, v0)
            };
        };
        0
    }

    public entry fun set_max_reinvestor_bounty_bps<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: u64) {
        checked_package_version<T0, T1, T2>(arg1);
        assert!(arg2 >= arg1.reinvest_bounty_bps, 16);
        arg1.max_reinvest_bounty_bps = arg2;
    }

    public entry fun set_rebalancers_ok<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: vector<address>, arg3: bool) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = &mut arg1.ok_rebalancers;
        let v1 = &mut arg2;
        let v2 = 0x1::vector::length<address>(v1);
        while (v2 > 0) {
            v2 = v2 - 1;
            let v3 = 0x1::vector::pop_back<address>(v1);
            if (0x2::table::contains<address, bool>(v0, v3)) {
                *0x2::table::borrow_mut<address, bool>(v0, v3) = arg3;
                continue
            };
            0x2::table::add<address, bool>(v0, v3, arg3);
        };
    }

    public entry fun set_reinvest_threshold<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: u64) {
        checked_package_version<T0, T1, T2>(arg1);
        arg1.reinvest_threshold = arg2;
    }

    public entry fun set_reinvestor_bounty_bps<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: u64) {
        checked_package_version<T0, T1, T2>(arg1);
        assert!(arg2 <= arg1.max_reinvest_bounty_bps, 15);
        arg1.reinvest_bounty_bps = arg2;
    }

    public entry fun set_reinvestor_ok<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: address, arg3: bool) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = &mut arg1.ok_reinvestors;
        if (0x2::table::contains<address, bool>(v0, arg2)) {
            *0x2::table::borrow_mut<address, bool>(v0, arg2) = arg3;
        } else {
            0x2::table::add<address, bool>(v0, arg2, arg3);
        };
    }

    public entry fun set_reinvestors_ok<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: vector<address>, arg3: bool) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = &mut arg1.ok_reinvestors;
        let v1 = &mut arg2;
        let v2 = 0x1::vector::length<address>(v1);
        while (v2 > 0) {
            v2 = v2 - 1;
            let v3 = 0x1::vector::pop_back<address>(v1);
            if (0x2::table::contains<address, bool>(v0, v3)) {
                *0x2::table::borrow_mut<address, bool>(v0, v3) = arg3;
                continue
            };
            0x2::table::add<address, bool>(v0, v3, arg3);
        };
    }

    public entry fun set_strategies_ok<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: vector<u8>, arg3: bool) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = &mut arg1.ok_strategies;
        let v1 = &mut arg2;
        let v2 = 0x1::vector::length<u8>(v1);
        while (v2 > 0) {
            v2 = v2 - 1;
            let v3 = 0x1::vector::pop_back<u8>(v1);
            if (0x2::table::contains<u8, bool>(v0, v3)) {
                *0x2::table::borrow_mut<u8, bool>(v0, v3) = arg3;
                continue
            };
            0x2::table::add<u8, bool>(v0, v3, arg3);
        };
    }

    public entry fun set_strategy_ok<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: u8, arg3: bool) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = &mut arg1.ok_strategies;
        if (0x2::table::contains<u8, bool>(v0, arg2)) {
            *0x2::table::borrow_mut<u8, bool>(v0, arg2) = arg3;
        } else {
            0x2::table::add<u8, bool>(v0, arg2, arg3);
        };
    }

    public entry fun set_treasury_account<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: address) {
        checked_package_version<T0, T1, T2>(arg1);
        arg1.treasury_account = arg2;
    }

    public fun share_to_balance<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: u128) : u128 {
        checked_package_version<T0, T1, T2>(arg0);
        share_to_balance_inner<T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nft)), arg0.total_share, arg1)
    }

    fun share_to_balance_inner<T0>(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg1 == 0) {
            return arg2
        };
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div_u128(arg2, arg0, arg1)
    }

    fun strategy_execute_safe<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: u64, arg9: u8, arg10: vector<u8>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft);
        if (arg9 == 1) {
            return 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_add_base_coin_only::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
        };
        if (arg9 == 2) {
            return 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_add_two_sides_optimal::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
        };
        if (arg9 == 3) {
            return 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_liquidate::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
        };
        if (arg9 == 4) {
            return 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_withdraw_minimize_trading::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
        };
        if (arg9 == 5) {
            return 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_partial_close_liquidate::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
        };
        assert!(arg9 == 6, 5);
        0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_partial_close_minimize_trading::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
    }

    fun strategy_execute_safe_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: u64, arg9: u8, arg10: vector<u8>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2.position_nft);
        if (arg9 == 1) {
            return 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_add_base_coin_only::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
        };
        if (arg9 == 2) {
            return 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_add_two_sides_optimal::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
        };
        if (arg9 == 3) {
            return 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_liquidate::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
        };
        if (arg9 == 4) {
            return 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_withdraw_minimize_trading::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
        };
        if (arg9 == 5) {
            return 0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_partial_close_liquidate::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
        };
        assert!(arg9 == 6, 5);
        0x7d8184a8dd4491fee80c65bc788896843a40c852068d2d042a102dbb2298d7a8::bluefin_clmm_strategy_partial_close_minimize_trading::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg10, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg11, arg12, arg13)
    }

    entry fun upgrade_package_version<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: u64) {
        arg1.package_version = arg2;
    }

    public entry fun withdraw_rewards_bounty<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        if (arg2) {
            arg3 = 0x2::balance::value<T0>(&arg1.tiny_coin_base_bounty);
            arg4 = 0x2::balance::value<T1>(&arg1.tiny_coin_farming_bounty);
        } else {
            assert!(arg3 <= 0x2::balance::value<T0>(&arg1.tiny_coin_base_bounty), 34);
            assert!(arg4 <= 0x2::balance::value<T1>(&arg1.tiny_coin_farming_bounty), 35);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tiny_coin_base_bounty, arg3), arg5), arg1.treasury_account);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.tiny_coin_farming_bounty, arg4), arg5), arg1.treasury_account);
    }

    fun work_inner_safe<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u8, arg10: vector<u8>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg2, arg5);
        let v1 = &arg2.ok_strategies;
        assert!(0x2::table::contains<u8, bool>(v1, arg9) && *0x2::table::borrow<u8, bool>(v1, arg9), 22);
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4) == arg2.pool_id, 25);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft)) - v0;
        let (v3, v4) = strategy_execute_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg13);
        let v5 = v4;
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft)) - v2;
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::pay::keep<T1>(v5, arg13);
        };
        add_share<T0, T1, T2>(arg2, arg5, v6, v2);
        v3
    }

    fun work_inner_safe_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u8, arg10: vector<u8>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg2, arg5);
        let v1 = &arg2.ok_strategies;
        assert!(0x2::table::contains<u8, bool>(v1, arg9) && *0x2::table::borrow<u8, bool>(v1, arg9), 22);
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg4) == arg2.pool_id, 25);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft)) - v0;
        let (v3, v4) = strategy_execute_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg13);
        let v5 = v4;
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2.position_nft)) - v2;
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::pay::keep<T1>(v5, arg13);
        };
        add_share<T0, T1, T2>(arg2, arg5, v6, v2);
        v3
    }

    public entry fun work_none_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: vector<u8>, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun work_none_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: vector<u8>, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun work_only_base_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: vector<0x2::coin::Coin<T0>>, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: vector<u8>, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public entry fun work_only_base_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: vector<0x2::coin::Coin<T0>>, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: vector<u8>, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public entry fun work_only_farming_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: vector<0x2::coin::Coin<T1>>, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: vector<u8>, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public entry fun work_only_farming_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: vector<0x2::coin::Coin<T1>>, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: vector<u8>, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public entry fun work_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: vector<0x2::coin::Coin<T0>>, arg8: u64, arg9: vector<0x2::coin::Coin<T1>>, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: vector<u8>, arg15: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg16: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = join_split_keep<T0>(arg7, arg8, arg19);
        let v1 = join_split_keep<T1>(arg9, arg10, arg19);
        work_single_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v1, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
    }

    public entry fun work_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: vector<0x2::coin::Coin<T0>>, arg8: u64, arg9: vector<0x2::coin::Coin<T1>>, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: vector<u8>, arg15: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg16: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = join_split_keep<T0>(arg7, arg8, arg19);
        let v1 = join_split_keep<T1>(arg9, arg10, arg19);
        work_single_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v1, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
    }

    public entry fun work_single_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: u8, arg12: vector<u8>, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg17);
        let (v1, v2) = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_work<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg6, get_mole_cetus_worker_addr(), arg7, arg9, is_stable<T0, T1, T2>(arg1, arg2, arg5, arg13, arg14, arg16), arg16, arg17);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::extract_work_context_coin_send<T0>(v5, arg17);
        let v7 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_work_context_debt<T0>(v5);
        let v8 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_work_context_id<T0>(v5);
        let v9 = work_inner_safe<T0, T1, T2>(arg2, arg0, arg1, arg4, arg5, v8, v6, arg8, v7, arg11, arg12, arg15, arg16, arg17);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::merge_work_context_coin_back<T0>(v5, v9);
        if (v7 > 0) {
            0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::set_work_context_health<T0>(v5, health<T0, T1, T2>(arg1, arg5, v8));
        };
        0x2::coin::join<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&mut v3, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_work<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, v4, arg10, is_stable<T0, T1, T2>(arg1, arg2, arg5, arg13, arg14, arg16), arg16, arg17));
        if (0x2::coin::value<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&v3) == 0) {
            0x2::coin::destroy_zero<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(v3);
        } else {
            0x2::pay::keep<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(v3, arg17);
        };
    }

    public entry fun work_single_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: u8, arg12: vector<u8>, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg17);
        let (v1, v2) = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_work<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg6, get_mole_cetus_worker_addr(), arg7, arg9, is_stable_reverse<T0, T1, T2>(arg1, arg2, arg5, arg13, arg14, arg16), arg16, arg17);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::extract_work_context_coin_send<T0>(v5, arg17);
        let v7 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_work_context_debt<T0>(v5);
        let v8 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_work_context_id<T0>(v5);
        let v9 = work_inner_safe_reverse<T0, T1, T2>(arg2, arg0, arg1, arg4, arg5, v8, v6, arg8, v7, arg11, arg12, arg15, arg16, arg17);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::merge_work_context_coin_back<T0>(v5, v9);
        if (v7 > 0) {
            0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::set_work_context_health<T0>(v5, health_reverse<T0, T1, T2>(arg1, arg5, v8));
        };
        0x2::coin::join<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&mut v3, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_work<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, v4, arg10, is_stable_reverse<T0, T1, T2>(arg1, arg2, arg5, arg13, arg14, arg16), arg16, arg17));
        if (0x2::coin::value<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&v3) == 0) {
            0x2::coin::destroy_zero<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(v3);
        } else {
            0x2::pay::keep<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(v3, arg17);
        };
    }

    // decompiled from Move bytecode v6
}

