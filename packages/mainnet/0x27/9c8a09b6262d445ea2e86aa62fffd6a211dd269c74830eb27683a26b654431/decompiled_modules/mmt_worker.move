module 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_worker {
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
        position_nft: 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>,
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

    public entry fun add_collateral_only_base_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        add_collateral_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun add_collateral_only_base_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        add_collateral_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun add_collateral_only_farming_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        add_collateral_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun add_collateral_only_farming_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        add_collateral_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun add_collateral_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: vector<0x2::coin::Coin<T1>>, arg9: u64, arg10: bool, arg11: u8, arg12: vector<u8>, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: u64, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = join_split_keep<T0>(arg6, arg7, arg18);
        let v1 = join_split_keep<T1>(arg8, arg9, arg18);
        add_collateral_single_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, v1, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    }

    public entry fun add_collateral_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: vector<0x2::coin::Coin<T1>>, arg9: u64, arg10: bool, arg11: u8, arg12: vector<u8>, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: u64, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = join_split_keep<T0>(arg6, arg7, arg18);
        let v1 = join_split_keep<T1>(arg8, arg9, arg18);
        add_collateral_single_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, v1, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    }

    public entry fun add_collateral_single_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg16);
        let v1 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_add_collateral<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg5, arg6, arg8, health<T0, T1, T2>(arg1, arg4, arg5), is_stable<T0, T1, T2>(arg1, arg2, arg4, arg11, arg12, arg15), is_reserve_consistent<T0, T1, T2>(), arg15, arg16);
        let v2 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::extract_add_collateral_context_coin_send<T0>(&mut v1, arg16);
        assert!(0x2::table::contains<u64, u128>(&arg1.shares, arg5), 36);
        let v3 = share_to_balance<T0, T1, T2>(arg1, *0x2::table::borrow<u64, u128>(&arg1.shares, arg5));
        let v4 = work_inner_safe<T0, T1, T2>(arg2, arg0, arg1, arg4, arg5, v2, arg7, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_add_collateral_context_debt<T0>(&v1), arg9, arg10, arg13, arg14, arg15, arg16);
        if (0x2::coin::value<T0>(&v4) == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else {
            0x2::pay::keep<T0>(v4, arg16);
        };
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_add_collateral<T0>(&arg1.position_operator_cap, arg2, v1, arg8, health<T0, T1, T2>(arg1, arg4, arg5), is_stable<T0, T1, T2>(arg1, arg2, arg4, arg11, arg12, arg15), is_reserve_consistent<T0, T1, T2>());
        assert!(share_to_balance<T0, T1, T2>(arg1, *0x2::table::borrow<u64, u128>(&arg1.shares, arg5)) > v3, 37);
    }

    public entry fun add_collateral_single_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg16);
        assert!(0x2::table::contains<u64, u128>(&arg1.shares, arg5), 36);
        let v1 = share_to_balance<T0, T1, T2>(arg1, *0x2::table::borrow<u64, u128>(&arg1.shares, arg5));
        let v2 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_add_collateral<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg5, arg6, arg8, health_reverse<T0, T1, T2>(arg1, arg4, arg5), is_stable_reverse<T0, T1, T2>(arg1, arg2, arg4, arg11, arg12, arg15), is_reserve_consistent<T0, T1, T2>(), arg15, arg16);
        let v3 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::extract_add_collateral_context_coin_send<T0>(&mut v2, arg16);
        let v4 = work_inner_safe_reverse<T0, T1, T2>(arg2, arg0, arg1, arg4, arg5, v3, arg7, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_add_collateral_context_debt<T0>(&v2), arg9, arg10, arg13, arg14, arg15, arg16);
        if (0x2::coin::value<T0>(&v4) == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else {
            0x2::pay::keep<T0>(v4, arg16);
        };
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_add_collateral<T0>(&arg1.position_operator_cap, arg2, v2, arg8, health_reverse<T0, T1, T2>(arg1, arg4, arg5), is_stable_reverse<T0, T1, T2>(arg1, arg2, arg4, arg11, arg12, arg15), is_reserve_consistent<T0, T1, T2>());
        assert!(share_to_balance<T0, T1, T2>(arg1, *0x2::table::borrow<u64, u128>(&arg1.shares, arg5)) > v1, 37);
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
        balance_to_share_inner<T0, T1, T2>(arg0, arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nft)))
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

    public fun collect_reward<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: u8, arg9: u64, arg10: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg5) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg6) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg7) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg8, arg4, 0x2::coin::zero<T0>(arg12), 0x2::coin::from_balance<T3>(v10, arg12), false, true, v11, arg9, arg10, arg11, arg12);
                0x2::coin::destroy_zero<T3>(v13);
                let v14 = 0x2::coin::into_balance<T0>(v12);
                let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                if (0x2::balance::value<T0>(&v14) >= v15) {
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                };
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg12));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_all_reverse<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: u8, arg9: u64, arg10: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12);
        let v2 = 0x2::coin::into_balance<T0>(v1);
        let v3 = 0x2::coin::into_balance<T1>(v0);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg5) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg6) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg7) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg8, arg4, 0x2::coin::zero<T0>(arg12), 0x2::coin::from_balance<T3>(v10, arg12), false, true, v11, arg9, arg10, arg11, arg12);
                0x2::coin::destroy_zero<T3>(v13);
                let v14 = 0x2::coin::into_balance<T0>(v12);
                let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                if (0x2::balance::value<T0>(&v14) >= v15) {
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                };
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg12));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_all_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: u8, arg11: u64, arg12: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14);
        let v2 = 0x2::coin::into_balance<T0>(v1);
        let v3 = 0x2::coin::into_balance<T1>(v0);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg6) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg7) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg8) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                if (arg9) {
                    let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg10, arg4, 0x2::coin::zero<T0>(arg14), 0x2::coin::from_balance<T3>(v10, arg14), false, true, v11, arg11, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v13);
                    let v14 = 0x2::coin::into_balance<T0>(v12);
                    let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v14) >= v15) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
                } else {
                    let (v16, v17) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg10, arg5, 0x2::coin::zero<T1>(arg14), 0x2::coin::from_balance<T3>(v10, arg14), false, true, v11, arg11, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v17);
                    let v18 = 0x2::coin::into_balance<T1>(v16);
                    let v19 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v18), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v18) >= v19) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v18, v19));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v18);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg14));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_all_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T0>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T1>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: u8, arg15: u8, arg16: u64, arg17: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19);
        let v2 = 0x2::coin::into_balance<T0>(v1);
        let v3 = 0x2::coin::into_balance<T1>(v0);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg8) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg9) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg10) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                if (arg12) {
                    let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg14, arg4, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T3>(v10, arg19), false, true, v11, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v13);
                    let v14 = 0x2::coin::into_balance<T0>(v12);
                    let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v14) >= v15) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
                } else {
                    let (v16, v17) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg14, arg5, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T3>(v10, arg19), false, true, v11, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v17);
                    let v18 = 0x2::coin::into_balance<T1>(v16);
                    let v19 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v18), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v18) >= v19) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v18, v19));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v18);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg19));
            };
        };
        if (arg11) {
            let v20 = 0x2::coin::into_balance<T4>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T4>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v21 = 0x2::balance::value<T4>(&v20);
            if (v21 > 0) {
                if (arg13) {
                    let (v22, v23) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T0, T4>(arg0, arg1, arg2.coin_base_decimals, arg15, arg6, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T4>(v20, arg19), false, true, v21, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v23);
                    let v24 = 0x2::coin::into_balance<T0>(v22);
                    let v25 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v24), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v24) >= v25) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v24, v25));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v24);
                } else {
                    let (v26, v27) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T1, T4>(arg0, arg1, arg2.coin_farming_decimals, arg15, arg7, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T4>(v20, arg19), false, true, v21, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v27);
                    let v28 = 0x2::coin::into_balance<T1>(v26);
                    let v29 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v28), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v28) >= v29) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v28, v29));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v28);
                };
            } else {
                0x2::coin::destroy_zero<T4>(0x2::coin::from_balance<T4>(v20, arg19));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: u8, arg11: u64, arg12: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg6) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg7) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg8) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                if (arg9) {
                    let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg10, arg4, 0x2::coin::zero<T0>(arg14), 0x2::coin::from_balance<T3>(v10, arg14), false, true, v11, arg11, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v13);
                    let v14 = 0x2::coin::into_balance<T0>(v12);
                    let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v14) >= v15) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
                } else {
                    let (v16, v17) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg10, arg5, 0x2::coin::zero<T1>(arg14), 0x2::coin::from_balance<T3>(v10, arg14), false, true, v11, arg11, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v17);
                    let v18 = 0x2::coin::into_balance<T1>(v16);
                    let v19 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v18), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v18) >= v19) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v18, v19));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v18);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg14));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_pool_reverse<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: u8, arg9: u64, arg10: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12);
        let v2 = 0x2::coin::into_balance<T0>(v1);
        let v3 = 0x2::coin::into_balance<T1>(v0);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg5) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg6) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg7) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg8, arg4, 0x2::coin::zero<T0>(arg12), 0x2::coin::from_balance<T3>(v10, arg12), false, true, v11, arg9, arg10, arg11, arg12);
                0x2::coin::destroy_zero<T3>(v13);
                let v14 = 0x2::coin::into_balance<T0>(v12);
                let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                if (0x2::balance::value<T0>(&v14) >= v15) {
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                };
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg12));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_pool_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: u8, arg11: u64, arg12: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14);
        let v2 = 0x2::coin::into_balance<T0>(v1);
        let v3 = 0x2::coin::into_balance<T1>(v0);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg6) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg7) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg8) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                if (arg9) {
                    let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg10, arg4, 0x2::coin::zero<T0>(arg14), 0x2::coin::from_balance<T3>(v10, arg14), false, true, v11, arg11, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v13);
                    let v14 = 0x2::coin::into_balance<T0>(v12);
                    let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v14) >= v15) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
                } else {
                    let (v16, v17) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg10, arg5, 0x2::coin::zero<T1>(arg14), 0x2::coin::from_balance<T3>(v10, arg14), false, true, v11, arg11, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v17);
                    let v18 = 0x2::coin::into_balance<T1>(v16);
                    let v19 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v18), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v18) >= v19) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v18, v19));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v18);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg14));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_pool_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T4>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T4>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: u8, arg15: u8, arg16: u64, arg17: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19);
        let v2 = 0x2::coin::into_balance<T0>(v1);
        let v3 = 0x2::coin::into_balance<T1>(v0);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg8) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg9) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg10) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                if (arg12) {
                    let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg14, arg4, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T3>(v10, arg19), false, true, v11, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v13);
                    let v14 = 0x2::coin::into_balance<T0>(v12);
                    let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v14) >= v15) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
                } else {
                    let (v16, v17) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg14, arg5, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T3>(v10, arg19), false, true, v11, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v17);
                    let v18 = 0x2::coin::into_balance<T1>(v16);
                    let v19 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v18), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v18) >= v19) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v18, v19));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v18);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg19));
            };
        };
        if (arg11) {
            let v20 = 0x2::coin::into_balance<T4>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T4>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v21 = 0x2::balance::value<T4>(&v20);
            if (v21 > 0) {
                if (arg13) {
                    let (v22, v23) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T0, T4>(arg0, arg1, arg2.coin_base_decimals, arg15, arg6, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T4>(v20, arg19), false, true, v21, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v23);
                    let v24 = 0x2::coin::into_balance<T0>(v22);
                    let v25 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v24), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v24) >= v25) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v24, v25));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v24);
                } else {
                    let (v26, v27) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T1, T4>(arg0, arg1, arg2.coin_farming_decimals, arg15, arg7, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T4>(v20, arg19), false, true, v21, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v27);
                    let v28 = 0x2::coin::into_balance<T1>(v26);
                    let v29 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v28), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v28) >= v29) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v28, v29));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v28);
                };
            } else {
                0x2::coin::destroy_zero<T4>(0x2::coin::from_balance<T4>(v20, arg19));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_swap_reverse<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: u8, arg9: u64, arg10: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg5) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg6) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg7) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg11, arg10, arg12));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg8, arg4, 0x2::coin::zero<T0>(arg12), 0x2::coin::from_balance<T3>(v10, arg12), false, true, v11, arg9, arg10, arg11, arg12);
                0x2::coin::destroy_zero<T3>(v13);
                let v14 = 0x2::coin::into_balance<T0>(v12);
                let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                if (0x2::balance::value<T0>(&v14) >= v15) {
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                };
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg12));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_swap_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: u8, arg11: u64, arg12: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg6) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg7) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg8) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg13, arg12, arg14));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                if (arg9) {
                    let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg10, arg4, 0x2::coin::zero<T0>(arg14), 0x2::coin::from_balance<T3>(v10, arg14), false, true, v11, arg11, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v13);
                    let v14 = 0x2::coin::into_balance<T0>(v12);
                    let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v14) >= v15) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
                } else {
                    let (v16, v17) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg10, arg5, 0x2::coin::zero<T1>(arg14), 0x2::coin::from_balance<T3>(v10, arg14), false, true, v11, arg11, arg12, arg13, arg14);
                    0x2::coin::destroy_zero<T3>(v17);
                    let v18 = 0x2::coin::into_balance<T1>(v16);
                    let v19 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v18), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v18) >= v19) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v18, v19));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v18);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg14));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_swap_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T0>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T1>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: u8, arg15: u8, arg16: u64, arg17: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg8) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg9) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg10) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                if (arg12) {
                    let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg14, arg4, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T3>(v10, arg19), false, true, v11, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v13);
                    let v14 = 0x2::coin::into_balance<T0>(v12);
                    let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v14) >= v15) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
                } else {
                    let (v16, v17) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg14, arg5, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T3>(v10, arg19), false, true, v11, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v17);
                    let v18 = 0x2::coin::into_balance<T1>(v16);
                    let v19 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v18), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v18) >= v19) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v18, v19));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v18);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg19));
            };
        };
        if (arg11) {
            let v20 = 0x2::coin::into_balance<T4>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T4>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v21 = 0x2::balance::value<T4>(&v20);
            if (v21 > 0) {
                if (arg13) {
                    let (v22, v23) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T0, T4>(arg0, arg1, arg2.coin_base_decimals, arg15, arg6, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T4>(v20, arg19), false, true, v21, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v23);
                    let v24 = 0x2::coin::into_balance<T0>(v22);
                    let v25 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v24), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v24) >= v25) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v24, v25));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v24);
                } else {
                    let (v26, v27) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T1, T4>(arg0, arg1, arg2.coin_farming_decimals, arg15, arg7, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T4>(v20, arg19), false, true, v21, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v27);
                    let v28 = 0x2::coin::into_balance<T1>(v26);
                    let v29 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v28), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v28) >= v29) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v28, v29));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v28);
                };
            } else {
                0x2::coin::destroy_zero<T4>(0x2::coin::from_balance<T4>(v20, arg19));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T4>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T4>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: u8, arg15: u8, arg16: u64, arg17: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg2);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg2.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg8) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v6);
        };
        if (arg9) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T1>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg2.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v8);
        };
        if (arg10) {
            let v10 = 0x2::coin::into_balance<T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T3>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v11 = 0x2::balance::value<T3>(&v10);
            if (v11 > 0) {
                if (arg12) {
                    let (v12, v13) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T0, T3>(arg0, arg1, arg2.coin_base_decimals, arg14, arg4, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T3>(v10, arg19), false, true, v11, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v13);
                    let v14 = 0x2::coin::into_balance<T0>(v12);
                    let v15 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v14), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v14) >= v15) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v14, v15));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v14);
                } else {
                    let (v16, v17) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T1, T3>(arg0, arg1, arg2.coin_farming_decimals, arg14, arg5, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T3>(v10, arg19), false, true, v11, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T3>(v17);
                    let v18 = 0x2::coin::into_balance<T1>(v16);
                    let v19 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v18), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v18) >= v19) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v18, v19));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v18);
                };
            } else {
                0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v10, arg19));
            };
        };
        if (arg11) {
            let v20 = 0x2::coin::into_balance<T4>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T4>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft), arg18, arg17, arg19));
            let v21 = 0x2::balance::value<T4>(&v20);
            if (v21 > 0) {
                if (arg13) {
                    let (v22, v23) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T0, T4>(arg0, arg1, arg2.coin_base_decimals, arg15, arg6, 0x2::coin::zero<T0>(arg19), 0x2::coin::from_balance<T4>(v20, arg19), false, true, v21, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v23);
                    let v24 = 0x2::coin::into_balance<T0>(v22);
                    let v25 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v24), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T0>(&v24) >= v25) {
                        0x2::balance::join<T0>(&mut arg2.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v24, v25));
                    };
                    0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v24);
                } else {
                    let (v26, v27) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T1, T4>(arg0, arg1, arg2.coin_farming_decimals, arg15, arg7, 0x2::coin::zero<T1>(arg19), 0x2::coin::from_balance<T4>(v20, arg19), false, true, v21, arg16, arg17, arg18, arg19);
                    0x2::coin::destroy_zero<T4>(v27);
                    let v28 = 0x2::coin::into_balance<T1>(v26);
                    let v29 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v28), arg2.reinvest_bounty_bps, 10000);
                    if (0x2::balance::value<T1>(&v28) >= v29) {
                        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v28, v29));
                    };
                    0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v28);
                };
            } else {
                0x2::coin::destroy_zero<T4>(0x2::coin::from_balance<T4>(v20, arg19));
            };
        };
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg2.tiny_coin_base), 0x2::balance::value<T1>(&arg2.tiny_coin_farming))
    }

    public fun collect_reward_without_swap<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg1, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nft), arg5, arg4, arg6);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg0.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg0.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg2) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T0>(arg1, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nft), arg5, arg4, arg6));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg0.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg0.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v6);
        };
        if (arg3) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T1>(arg1, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nft), arg5, arg4, arg6));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg0.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg0.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v8);
        };
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v3);
        (0x2::balance::value<T0>(&arg0.tiny_coin_base), 0x2::balance::value<T1>(&arg0.tiny_coin_farming))
    }

    public fun collect_reward_without_swap_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg2: bool, arg3: bool, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T1, T0>(arg1, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nft), arg5, arg4, arg6);
        let v2 = 0x2::coin::into_balance<T0>(v1);
        let v3 = 0x2::coin::into_balance<T1>(v0);
        let v4 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v2), arg0.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T0>(&v2) >= v4) {
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v2, v4));
        };
        let v5 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v3), arg0.reinvest_bounty_bps, 10000);
        if (0x2::balance::value<T1>(&v3) >= v5) {
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v3, v5));
        };
        if (arg2) {
            let v6 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T0>(arg1, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nft), arg5, arg4, arg6));
            let v7 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T0>(&v6), arg0.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T0>(&v6) >= v7) {
                0x2::balance::join<T0>(&mut arg0.tiny_coin_base_bounty, 0x2::balance::split<T0>(&mut v6, v7));
            };
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v6);
        };
        if (arg3) {
            let v8 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T1, T0, T1>(arg1, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nft), arg5, arg4, arg6));
            let v9 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div(0x2::balance::value<T1>(&v8), arg0.reinvest_bounty_bps, 10000);
            if (0x2::balance::value<T1>(&v8) >= v9) {
                0x2::balance::join<T1>(&mut arg0.tiny_coin_farming_bounty, 0x2::balance::split<T1>(&mut v8, v9));
            };
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v8);
        };
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v2);
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v3);
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

    public fun get_mole_mmt_worker_addr() : address {
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

    public fun health<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64) : u64 {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = &arg0.shares;
        let v1 = 0;
        if (0x2::table::contains<u64, u128>(v0, arg2)) {
            v1 = *0x2::table::borrow<u64, u128>(v0, arg2);
        };
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nft));
        let v3 = share_to_balance_inner<T2>(v2, arg0.total_share, v1);
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nft))), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nft))), v2, false);
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
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price() + 1
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price() - 1
        };
        let v10 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, v8, true, v9, v7);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v10) + v6
    }

    public fun health_reverse<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg2: u64) : u64 {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = &arg0.shares;
        let v1 = 0;
        if (0x2::table::contains<u64, u128>(v0, arg2)) {
            v1 = *0x2::table::borrow<u64, u128>(v0, arg2);
        };
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nft));
        let v3 = share_to_balance_inner<T2>(v2, arg0.total_share, v1);
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T1, T0>(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nft))), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nft))), v2, false);
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
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price() + 1
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price() - 1
        };
        let v10 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T1, T0>(arg1, v8, true, v9, v7);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v10) + v6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize<T0, T1, T2>(arg0: &AdminCap, arg1: &0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::AdminCap, arg2: &0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::AdminCap, arg3: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg4: &mut 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::WorkerInfoStore, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg8: address, arg9: u64, arg10: address, arg11: u64, arg12: u32, arg13: u32, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = get_mole_mmt_worker_addr();
        assert!(!0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::is_worker_info_registered(arg4, v0), 2);
        assert!(0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::is_vault_initialized<T0>(arg3), 13);
        let v1 = 900;
        assert!(arg9 <= v1, 15);
        let v2 = WorkerInfo<T0, T1, T2>{
            id                       : 0x2::object::new(arg15),
            reinvest_bounty_bps      : arg9,
            max_reinvest_bounty_bps  : v1,
            ok_reinvestors           : 0x2::table::new<address, bool>(arg15),
            ok_rebalancers           : 0x2::table::new<address, bool>(arg15),
            ok_strategies            : 0x2::table::new<u8, bool>(arg15),
            treasury_account         : arg10,
            reinvest_path            : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reinvest_threshold       : arg11,
            shares                   : 0x2::table::new<u64, u128>(arg15),
            total_share              : 0,
            config                   : arg8,
            position_nft             : 0x1::option::some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg7, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg12), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg13), arg14, arg15)),
            position_operator_cap    : 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::acquire_position_operator_cap<T0>(arg1),
            coin_base_decimals       : 0x2::coin::get_decimals<T0>(arg5),
            coin_farming_decimals    : 0x2::coin::get_decimals<T1>(arg6),
            tiny_coin_base           : 0x2::balance::zero<T0>(),
            tiny_coin_farming        : 0x2::balance::zero<T1>(),
            pool_id                  : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg7),
            package_version          : 3,
            tiny_coin_base_bounty    : 0x2::balance::zero<T0>(),
            tiny_coin_farming_bounty : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<WorkerInfo<T0, T1, T2>>(v2);
        0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::register_worker_info<T0, T1, T2>(arg2, arg4, v0);
        let v3 = InitializeEvent{worker_info: 0x2::object::uid_to_address(&v2.id)};
        0x2::event::emit<InitializeEvent>(v3);
    }

    public entry fun initialize_reverse<T0, T1, T2>(arg0: &AdminCap, arg1: &0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::AdminCap, arg2: &0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::AdminCap, arg3: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg4: &mut 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::WorkerInfoStore, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg8: address, arg9: u64, arg10: address, arg11: u64, arg12: u32, arg13: u32, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = get_mole_mmt_worker_addr();
        assert!(!0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::is_worker_info_registered(arg4, v0), 2);
        assert!(0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::is_vault_initialized<T0>(arg3), 13);
        let v1 = 900;
        assert!(arg9 <= v1, 15);
        let v2 = WorkerInfo<T0, T1, T2>{
            id                       : 0x2::object::new(arg15),
            reinvest_bounty_bps      : arg9,
            max_reinvest_bounty_bps  : v1,
            ok_reinvestors           : 0x2::table::new<address, bool>(arg15),
            ok_rebalancers           : 0x2::table::new<address, bool>(arg15),
            ok_strategies            : 0x2::table::new<u8, bool>(arg15),
            treasury_account         : arg10,
            reinvest_path            : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reinvest_threshold       : arg11,
            shares                   : 0x2::table::new<u64, u128>(arg15),
            total_share              : 0,
            config                   : arg8,
            position_nft             : 0x1::option::some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T1, T0>(arg7, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg12), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg13), arg14, arg15)),
            position_operator_cap    : 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::acquire_position_operator_cap<T0>(arg1),
            coin_base_decimals       : 0x2::coin::get_decimals<T0>(arg5),
            coin_farming_decimals    : 0x2::coin::get_decimals<T1>(arg6),
            tiny_coin_base           : 0x2::balance::zero<T0>(),
            tiny_coin_farming        : 0x2::balance::zero<T1>(),
            pool_id                  : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg7),
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

    public fun is_stable<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x2::clock::Clock) : bool {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = arg0.config;
        let (v1, v2) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::get_pool_price_amount_ratio<T0, T1>(arg2);
        let (v3, v4) = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::oracle_medianizer::get_price_generic<T0, T1>(arg1, 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_oracle(arg1, v0), arg3, arg4, arg5);
        if (v4 + 86400 <= now_seconds(arg5)) {
            return false
        };
        let v5 = ((v2 * (0x2::math::pow(10, 8) as u128) * (0x2::math::pow(10, 9 - arg0.coin_farming_decimals) as u128) / v1 / (0x2::math::pow(10, 9 - arg0.coin_base_decimals) as u128)) as u64);
        let v6 = 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_max_price_diff(arg1, v0, get_mole_mmt_worker_addr());
        let v7 = 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_max_price_diff_scale();
        if (v5 * v7 > v3 * v6 || v5 * v6 < v3 * v7) {
            return false
        };
        true
    }

    public fun is_stable_reverse<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x2::clock::Clock) : bool {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = arg0.config;
        let (v1, v2) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::get_pool_price_amount_ratio<T1, T0>(arg2);
        let (v3, v4) = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::oracle_medianizer::get_price_generic<T0, T1>(arg1, 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_oracle(arg1, v0), arg3, arg4, arg5);
        if (v4 + 86400 <= now_seconds(arg5)) {
            return false
        };
        let v5 = ((v1 * (0x2::math::pow(10, 8) as u128) * (0x2::math::pow(10, 9 - arg0.coin_farming_decimals) as u128) / v2 / (0x2::math::pow(10, 9 - arg0.coin_base_decimals) as u128)) as u64);
        let v6 = 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_max_price_diff(arg1, v0, get_mole_mmt_worker_addr());
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

    public entry fun kill_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: u64, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: u64, arg9: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg11);
        let v1 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_kill<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg5, health<T0, T1, T2>(arg1, arg4, arg5), is_stable<T0, T1, T2>(arg1, arg2, arg4, arg6, arg7, arg10), arg10, arg11);
        let v2 = liquidate_safe<T0, T1, T2>(arg2, arg0, arg1, arg4, arg5, arg8, arg9, arg10, arg11);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::merge_kill_context_coin_back<T0>(&mut v1, v2);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_kill<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, v1, arg11);
    }

    public entry fun kill_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: u64, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: u64, arg9: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg11);
        let v1 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_kill<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg5, health_reverse<T0, T1, T2>(arg1, arg4, arg5), is_stable_reverse<T0, T1, T2>(arg1, arg2, arg4, arg6, arg7, arg10), arg10, arg11);
        let v2 = liquidate_safe_reverse<T0, T1, T2>(arg2, arg0, arg1, arg4, arg5, arg8, arg9, arg10, arg11);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::merge_kill_context_coin_back<T0>(&mut v1, v2);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_kill<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, v1, arg11);
    }

    fun liquidate_safe<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg2, arg4);
        let v1 = 0x2::coin::zero<T0>(arg8);
        let v2 = 0x2::coin::zero<T1>(arg8);
        let (v3, v4) = strategy_execute_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, v1, v2, v0, 0, 3, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::encode_u64(0), arg5, arg6, arg7, arg8);
        let v5 = v4;
        assert!(0x2::coin::value<T1>(&v5) == 0, 24);
        0x2::coin::destroy_zero<T1>(v5);
        v3
    }

    fun liquidate_safe_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: u64, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg2, arg4);
        let v1 = 0x2::coin::zero<T0>(arg8);
        let v2 = 0x2::coin::zero<T1>(arg8);
        let (v3, v4) = strategy_execute_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, v1, v2, v0, 0, 3, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::encode_u64(0), arg5, arg6, arg7, arg8);
        let v5 = v4;
        assert!(0x2::coin::value<T1>(&v5) == 0, 24);
        0x2::coin::destroy_zero<T1>(v5);
        v3
    }

    fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun position_info<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: u64) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        (health<T0, T1, T2>(arg0, arg2, arg3), 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::position_debt_val<T0>(arg1, arg3))
    }

    public fun position_info_reverse<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: u64) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        (health_reverse<T0, T1, T2>(arg0, arg2, arg3), 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::position_debt_val<T0>(arg1, arg3))
    }

    public entry fun rebalance_all_safe_reverse<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: u8, arg15: u64, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg14, arg15, arg16, arg17, arg18);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg16, arg17, arg18);
    }

    public entry fun rebalance_all_safe_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: bool, arg7: bool, arg8: bool, arg9: u32, arg10: u32, arg11: u128, arg12: u64, arg13: u64, arg14: vector<u8>, arg15: bool, arg16: u8, arg17: u64, arg18: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg15, arg16, arg17, arg18, arg19, arg20);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg9, arg10, arg11, arg12, arg13, arg14, arg17, arg18, arg19, arg20);
    }

    public entry fun rebalance_all_safe_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T0>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T1>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u32, arg13: u32, arg14: u128, arg15: u64, arg16: u64, arg17: vector<u8>, arg18: bool, arg19: bool, arg20: u8, arg21: u8, arg22: u64, arg23: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg12, arg13, arg14, arg15, arg16, arg17, arg22, arg23, arg24, arg25);
    }

    fun rebalance_inner_safe<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u128, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: u64, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(is_rebalancer<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg13)), 32);
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft))) == arg4 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft))) == arg5) {
            abort 26
        };
        let v0 = 0x1::option::extract<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg3, &mut v0, v1, 0, 0, arg12, arg11, arg13);
            (0x2::coin::into_balance<T0>(v4), 0x2::coin::into_balance<T1>(v5))
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v6 = v3;
        let v7 = v2;
        0x2::balance::join<T0>(&mut v7, 0x2::balance::withdraw_all<T0>(&mut arg2.tiny_coin_base));
        0x2::balance::join<T1>(&mut v6, 0x2::balance::withdraw_all<T1>(&mut arg2.tiny_coin_farming));
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(v0, arg11, arg13);
        0x1::option::fill<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg4), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg5), arg11, arg13));
        if (0x2::balance::value<T0>(&v7) > 0 || 0x2::balance::value<T1>(&v6) > 0) {
            let v8 = 0x2::coin::from_balance<T0>(v7, arg13);
            let v9 = 0x2::coin::from_balance<T1>(v6, arg13);
            let (v10, v11) = strategy_execute_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, v8, v9, 0, 0, 2, arg9, arg10, arg11, arg12, arg13);
            let v12 = v11;
            let v13 = v10;
            assert!(0x2::coin::value<T0>(&v13) <= arg7 && 0x2::coin::value<T1>(&v12) <= arg8, 27);
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, 0x2::coin::into_balance<T0>(v13));
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, 0x2::coin::into_balance<T1>(v12));
        } else {
            0x2::balance::destroy_zero<T0>(v7);
            0x2::balance::destroy_zero<T1>(v6);
        };
        let v14 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft));
        assert!(v14 >= arg6, 28);
        let v15 = RebalanceEvent{
            tick_lower_idx   : arg4,
            tick_upper_idx   : arg5,
            liquidity_before : v1,
            liquidity_after  : v14,
        };
        0x2::event::emit<RebalanceEvent>(v15);
    }

    fun rebalance_inner_safe_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: u32, arg5: u32, arg6: u128, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: u64, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(is_rebalancer<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg13)), 32);
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft))) == arg4 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft))) == arg5) {
            abort 26
        };
        let v0 = 0x1::option::extract<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T1, T0>(arg3, &mut v0, v1, 0, 0, arg12, arg11, arg13);
            (0x2::coin::into_balance<T1>(v4), 0x2::coin::into_balance<T0>(v5))
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        let v6 = v3;
        let v7 = v2;
        0x2::balance::join<T0>(&mut v6, 0x2::balance::withdraw_all<T0>(&mut arg2.tiny_coin_base));
        0x2::balance::join<T1>(&mut v7, 0x2::balance::withdraw_all<T1>(&mut arg2.tiny_coin_farming));
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(v0, arg11, arg13);
        0x1::option::fill<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T1, T0>(arg3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg4), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg5), arg11, arg13));
        if (0x2::balance::value<T0>(&v6) > 0 || 0x2::balance::value<T1>(&v7) > 0) {
            let v8 = 0x2::coin::from_balance<T0>(v6, arg13);
            let v9 = 0x2::coin::from_balance<T1>(v7, arg13);
            let (v10, v11) = strategy_execute_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, v8, v9, 0, 0, 2, arg9, arg10, arg11, arg12, arg13);
            let v12 = v11;
            let v13 = v10;
            assert!(0x2::coin::value<T0>(&v13) <= arg7 && 0x2::coin::value<T1>(&v12) <= arg8, 27);
            0x2::balance::join<T0>(&mut arg2.tiny_coin_base, 0x2::coin::into_balance<T0>(v13));
            0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, 0x2::coin::into_balance<T1>(v12));
        } else {
            0x2::balance::destroy_zero<T0>(v6);
            0x2::balance::destroy_zero<T1>(v7);
        };
        let v14 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft));
        assert!(v14 >= arg6, 28);
        let v15 = RebalanceEvent{
            tick_lower_idx   : arg4,
            tick_upper_idx   : arg5,
            liquidity_before : v1,
            liquidity_after  : v14,
        };
        0x2::event::emit<RebalanceEvent>(v15);
    }

    public entry fun rebalance_one_other_safe<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: bool, arg7: bool, arg8: bool, arg9: u32, arg10: u32, arg11: u128, arg12: u64, arg13: u64, arg14: vector<u8>, arg15: bool, arg16: u8, arg17: u64, arg18: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg15, arg16, arg17, arg18, arg19, arg20);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg9, arg10, arg11, arg12, arg13, arg14, arg17, arg18, arg19, arg20);
    }

    public entry fun rebalance_pool_safe_reverse<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: u8, arg15: u64, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_pool_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg14, arg15, arg16, arg17, arg18);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg16, arg17, arg18);
    }

    public entry fun rebalance_pool_safe_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: bool, arg7: bool, arg8: bool, arg9: u32, arg10: u32, arg11: u128, arg12: u64, arg13: u64, arg14: vector<u8>, arg15: bool, arg16: u8, arg17: u64, arg18: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_pool_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg15, arg16, arg17, arg18, arg19, arg20);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg9, arg10, arg11, arg12, arg13, arg14, arg17, arg18, arg19, arg20);
    }

    public entry fun rebalance_pool_safe_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T4>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T4>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u32, arg13: u32, arg14: u128, arg15: u64, arg16: u64, arg17: vector<u8>, arg18: bool, arg19: bool, arg20: u8, arg21: u8, arg22: u64, arg23: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_pool_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg12, arg13, arg14, arg15, arg16, arg17, arg22, arg23, arg24, arg25);
    }

    public entry fun rebalance_safe<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: u8, arg15: u64, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg14, arg15, arg16, arg17, arg18);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg16, arg17, arg18);
    }

    public entry fun rebalance_swap_safe_reverse<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: u8, arg15: u64, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_swap_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg14, arg15, arg16, arg17, arg18);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg16, arg17, arg18);
    }

    public entry fun rebalance_swap_safe_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: bool, arg7: bool, arg8: bool, arg9: u32, arg10: u32, arg11: u128, arg12: u64, arg13: u64, arg14: vector<u8>, arg15: bool, arg16: u8, arg17: u64, arg18: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_swap_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg15, arg16, arg17, arg18, arg19, arg20);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg9, arg10, arg11, arg12, arg13, arg14, arg17, arg18, arg19, arg20);
    }

    public entry fun rebalance_swap_safe_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T0>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T1>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u32, arg13: u32, arg14: u128, arg15: u64, arg16: u64, arg17: vector<u8>, arg18: bool, arg19: bool, arg20: u8, arg21: u8, arg22: u64, arg23: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_swap_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg12, arg13, arg14, arg15, arg16, arg17, arg22, arg23, arg24, arg25);
    }

    public entry fun rebalance_two_others_safe<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T4>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T4>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u32, arg13: u32, arg14: u128, arg15: u64, arg16: u64, arg17: vector<u8>, arg18: bool, arg19: bool, arg20: u8, arg21: u8, arg22: u64, arg23: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg12, arg13, arg14, arg15, arg16, arg17, arg22, arg23, arg24, arg25);
    }

    public entry fun rebalance_without_swap_reward_safe<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: bool, arg5: bool, arg6: u32, arg7: u32, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u64, arg13: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_without_swap<T0, T1, T2>(arg2, arg3, arg4, arg5, arg13, arg14, arg15);
        rebalance_inner_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun rebalance_without_swap_reward_safe_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: bool, arg5: bool, arg6: u32, arg7: u32, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u64, arg13: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_without_swap_reverse<T0, T1, T2>(arg2, arg3, arg4, arg5, arg13, arg14, arg15);
        rebalance_inner_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun reinvest<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u8, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13, arg14, arg15, arg16);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg13, arg14, arg15, arg16);
    }

    public entry fun reinvest_all_reverse<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u8, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13, arg14, arg15, arg16);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg13, arg14, arg15, arg16);
    }

    public entry fun reinvest_all_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: bool, arg7: bool, arg8: bool, arg9: u128, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: bool, arg14: u8, arg15: u64, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg13, arg14, arg15, arg16, arg17, arg18);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg9, arg10, arg11, arg12, arg15, arg16, arg17, arg18);
    }

    public entry fun reinvest_all_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T0>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T1>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u128, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: bool, arg17: bool, arg18: u8, arg19: u8, arg20: u64, arg21: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_all_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg12, arg13, arg14, arg15, arg20, arg21, arg22, arg23);
    }

    fun reinvest_inner<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u128, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(is_reinvestor<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg11)), 20);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft));
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg2.tiny_coin_base);
        let v2 = 0x2::balance::withdraw_all<T1>(&mut arg2.tiny_coin_farming);
        if (0x2::balance::value<T0>(&v1) == 0 && 0x2::balance::value<T1>(&v2) == 0) {
            abort 29
        };
        let v3 = 0x2::coin::from_balance<T0>(v1, arg11);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg11);
        let (v5, v6) = strategy_execute_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, v3, v4, 0, 0, 2, arg7, arg8, arg9, arg10, arg11);
        let v7 = v6;
        let v8 = v5;
        assert!(0x2::coin::value<T0>(&v8) <= arg5 && 0x2::coin::value<T1>(&v7) <= arg6, 27);
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, 0x2::coin::into_balance<T0>(v8));
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, 0x2::coin::into_balance<T1>(v7));
        let v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft));
        assert!(v9 >= v0 + arg4, 28);
        let v10 = ReinvestEvent{
            liquidity_before : v0,
            liquidity_after  : v9,
        };
        0x2::event::emit<ReinvestEvent>(v10);
    }

    fun reinvest_inner_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: u128, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(is_reinvestor<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg11)), 20);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft));
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg2.tiny_coin_base);
        let v2 = 0x2::balance::withdraw_all<T1>(&mut arg2.tiny_coin_farming);
        if (0x2::balance::value<T0>(&v1) == 0 && 0x2::balance::value<T1>(&v2) == 0) {
            abort 29
        };
        let v3 = 0x2::coin::from_balance<T0>(v1, arg11);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg11);
        let (v5, v6) = strategy_execute_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, v3, v4, 0, 0, 2, arg7, arg8, arg9, arg10, arg11);
        let v7 = v6;
        let v8 = v5;
        assert!(0x2::coin::value<T0>(&v8) <= arg5 && 0x2::coin::value<T1>(&v7) <= arg6, 27);
        0x2::balance::join<T0>(&mut arg2.tiny_coin_base, 0x2::coin::into_balance<T0>(v8));
        0x2::balance::join<T1>(&mut arg2.tiny_coin_farming, 0x2::coin::into_balance<T1>(v7));
        let v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft));
        assert!(v9 >= v0 + arg4, 28);
        let v10 = ReinvestEvent{
            liquidity_before : v0,
            liquidity_after  : v9,
        };
        0x2::event::emit<ReinvestEvent>(v10);
    }

    public entry fun reinvest_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: bool, arg7: bool, arg8: bool, arg9: u128, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: bool, arg14: u8, arg15: u64, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg13, arg14, arg15, arg16, arg17, arg18);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg9, arg10, arg11, arg12, arg15, arg16, arg17, arg18);
    }

    public entry fun reinvest_pool_reverse<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u8, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_pool_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13, arg14, arg15, arg16);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg13, arg14, arg15, arg16);
    }

    public entry fun reinvest_pool_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: bool, arg7: bool, arg8: bool, arg9: u128, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: bool, arg14: u8, arg15: u64, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_pool_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg13, arg14, arg15, arg16, arg17, arg18);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg9, arg10, arg11, arg12, arg15, arg16, arg17, arg18);
    }

    public entry fun reinvest_pool_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T4>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T4>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u128, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: bool, arg17: bool, arg18: u8, arg19: u8, arg20: u64, arg21: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_pool_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg12, arg13, arg14, arg15, arg20, arg21, arg22, arg23);
    }

    public entry fun reinvest_swap_reverse<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u8, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_swap_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13, arg14, arg15, arg16);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg13, arg14, arg15, arg16);
    }

    public entry fun reinvest_swap_reverse_one_other<T0, T1, T2, T3>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: bool, arg7: bool, arg8: bool, arg9: u128, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: bool, arg14: u8, arg15: u64, arg16: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_swap_reverse_one_other<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg13, arg14, arg15, arg16, arg17, arg18);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg9, arg10, arg11, arg12, arg15, arg16, arg17, arg18);
    }

    public entry fun reinvest_swap_reverse_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T1>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T0>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T4, T1>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u128, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: bool, arg17: bool, arg18: u8, arg19: u8, arg20: u64, arg21: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_swap_reverse_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg12, arg13, arg14, arg15, arg20, arg21, arg22, arg23);
    }

    public entry fun reinvest_two_others<T0, T1, T2, T3, T4>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T3>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T4>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T4>, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u128, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: bool, arg17: bool, arg18: u8, arg19: u8, arg20: u64, arg21: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_two_others<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg12, arg13, arg14, arg15, arg20, arg21, arg22, arg23);
    }

    public entry fun reinvest_without_swap_reward<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: bool, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: u64, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_without_swap<T0, T1, T2>(arg2, arg3, arg4, arg5, arg11, arg12, arg13);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun reinvest_without_swap_reward_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: bool, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: u64, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg2);
        let (_, _) = collect_reward_without_swap_reverse<T0, T1, T2>(arg2, arg3, arg4, arg5, arg11, arg12, arg13);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun remove_share<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: u64) : u128 {
        if (0x2::table::contains<u64, u128>(&arg0.shares, arg1)) {
            let v0 = *0x2::table::borrow<u64, u128>(&arg0.shares, arg1);
            if (v0 > 0) {
                arg0.total_share = arg0.total_share - v0;
                *0x2::table::borrow_mut<u64, u128>(&mut arg0.shares, arg1) = 0;
                return share_to_balance_inner<T2>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nft)), arg0.total_share, v0)
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
        share_to_balance_inner<T2>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nft)), arg0.total_share, arg1)
    }

    fun share_to_balance_inner<T0>(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg1 == 0) {
            return arg2
        };
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div_u128(arg2, arg0, arg1)
    }

    fun strategy_execute_safe<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u128, arg7: u64, arg8: u8, arg9: vector<u8>, arg10: u64, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft);
        if (arg8 == 1) {
            return 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_add_base_coin_only::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
        };
        if (arg8 == 2) {
            return 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_add_two_sides_optimal::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
        };
        if (arg8 == 3) {
            return 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_liquidate::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
        };
        if (arg8 == 4) {
            return 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_withdraw_minimize_trading::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
        };
        if (arg8 == 5) {
            return 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_partial_close_liquidate::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
        };
        assert!(arg8 == 6, 5);
        0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_partial_close_minimize_trading::execute_safe<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
    }

    fun strategy_execute_safe_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u128, arg7: u64, arg8: u8, arg9: vector<u8>, arg10: u64, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position_nft);
        if (arg8 == 1) {
            return 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_add_base_coin_only::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
        };
        if (arg8 == 2) {
            return 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_add_two_sides_optimal::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
        };
        if (arg8 == 3) {
            return 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_liquidate::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
        };
        if (arg8 == 4) {
            return 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_withdraw_minimize_trading::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
        };
        if (arg8 == 5) {
            return 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_partial_close_liquidate::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
        };
        assert!(arg8 == 6, 5);
        0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_partial_close_minimize_trading::execute_safe_reverse<T0, T1>(arg0, arg1, arg2.coin_base_decimals, arg2.coin_farming_decimals, arg3, arg4, arg5, arg6, v0, arg7, arg9, &mut arg2.tiny_coin_base, &mut arg2.tiny_coin_farming, arg10, arg11, arg12, arg13)
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

    fun work_inner_safe<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u8, arg9: vector<u8>, arg10: u64, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg2, arg4);
        let v1 = &arg2.ok_strategies;
        assert!(0x2::table::contains<u8, bool>(v1, arg8) && *0x2::table::borrow<u8, bool>(v1, arg8), 22);
        assert!(0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg3) == arg2.pool_id, 25);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft)) - v0;
        let (v3, v4) = strategy_execute_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v5 = v4;
        let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft)) - v2;
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::pay::keep<T1>(v5, arg13);
        };
        add_share<T0, T1, T2>(arg2, arg4, v6, v2);
        v3
    }

    fun work_inner_safe_reverse<T0, T1, T2>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &mut WorkerInfo<T0, T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u8, arg9: vector<u8>, arg10: u64, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg2, arg4);
        let v1 = &arg2.ok_strategies;
        assert!(0x2::table::contains<u8, bool>(v1, arg8) && *0x2::table::borrow<u8, bool>(v1, arg8), 22);
        assert!(0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg3) == arg2.pool_id, 25);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft)) - v0;
        let (v3, v4) = strategy_execute_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v5 = v4;
        let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position_nft)) - v2;
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::pay::keep<T1>(v5, arg13);
        };
        add_share<T0, T1, T2>(arg2, arg4, v6, v2);
        v3
    }

    public entry fun work_none_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: vector<u8>, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: u64, arg13: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun work_none_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: vector<u8>, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: u64, arg13: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun work_only_base_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public entry fun work_only_base_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public entry fun work_only_farming_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public entry fun work_only_farming_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        work_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public entry fun work_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: vector<0x2::coin::Coin<T1>>, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: vector<u8>, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg16: u64, arg17: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = join_split_keep<T0>(arg6, arg7, arg19);
        let v1 = join_split_keep<T1>(arg8, arg9, arg19);
        work_single_safe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, v1, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
    }

    public entry fun work_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: vector<0x2::coin::Coin<T1>>, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: vector<u8>, arg14: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg15: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg16: u64, arg17: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        let v0 = join_split_keep<T0>(arg6, arg7, arg19);
        let v1 = join_split_keep<T1>(arg8, arg9, arg19);
        work_single_safe_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, v1, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
    }

    public entry fun work_single_safe<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg17);
        let (v1, v2) = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_work<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg5, get_mole_mmt_worker_addr(), arg6, arg8, is_stable<T0, T1, T2>(arg1, arg2, arg4, arg12, arg13, arg16), arg16, arg17);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::extract_work_context_coin_send<T0>(v5, arg17);
        let v7 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_work_context_debt<T0>(v5);
        let v8 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_work_context_id<T0>(v5);
        let v9 = work_inner_safe<T0, T1, T2>(arg2, arg0, arg1, arg4, v8, v6, arg7, v7, arg10, arg11, arg14, arg15, arg16, arg17);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::merge_work_context_coin_back<T0>(v5, v9);
        if (v7 > 0) {
            0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::set_work_context_health<T0>(v5, health<T0, T1, T2>(arg1, arg4, v8));
        };
        0x2::coin::join<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&mut v3, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_work<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, v4, arg9, is_stable<T0, T1, T2>(arg1, arg2, arg4, arg12, arg13, arg16), arg16, arg17));
        if (0x2::coin::value<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&v3) == 0) {
            0x2::coin::destroy_zero<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(v3);
        } else {
            0x2::pay::keep<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(v3, arg17);
        };
    }

    public entry fun work_single_safe_reverse<T0, T1, T2>(arg0: address, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg13: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg14: u64, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg1);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::assert_no_emergency(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_emergency_status(arg2));
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_position_signer<T0>(arg17);
        let (v1, v2) = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::before_work<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, arg5, get_mole_mmt_worker_addr(), arg6, arg8, is_stable_reverse<T0, T1, T2>(arg1, arg2, arg4, arg12, arg13, arg16), arg16, arg17);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::extract_work_context_coin_send<T0>(v5, arg17);
        let v7 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_work_context_debt<T0>(v5);
        let v8 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_work_context_id<T0>(v5);
        let v9 = work_inner_safe_reverse<T0, T1, T2>(arg2, arg0, arg1, arg4, v8, v6, arg7, v7, arg10, arg11, arg14, arg15, arg16, arg17);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::merge_work_context_coin_back<T0>(v5, v9);
        if (v7 > 0) {
            0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::set_work_context_health<T0>(v5, health_reverse<T0, T1, T2>(arg1, arg4, v8));
        };
        0x2::coin::join<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&mut v3, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::after_work<T0>(&arg1.position_operator_cap, arg2, arg3, &v0, v4, arg9, is_stable_reverse<T0, T1, T2>(arg1, arg2, arg4, arg12, arg13, arg16), arg16, arg17));
        if (0x2::coin::value<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&v3) == 0) {
            0x2::coin::destroy_zero<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(v3);
        } else {
            0x2::pay::keep<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(v3, arg17);
        };
    }

    // decompiled from Move bytecode v6
}

