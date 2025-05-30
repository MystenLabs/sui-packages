module 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_worker {
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
        position_nft: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        position_operator_cap: 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::VaultCap<0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::PositionOperatorFeature<T0>>,
        coin_base_decimals: u8,
        coin_farming_decimals: u8,
        tiny_coin_base: 0x2::balance::Balance<T0>,
        tiny_coin_farming: 0x2::balance::Balance<T1>,
        pool_id: 0x2::object::ID,
        package_version: u64,
    }

    struct AdminCap has key {
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

    public fun collect_reward<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), true);
        if (arg5) {
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8));
        };
        if (arg6) {
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8));
        };
        if (arg7) {
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8);
            let (v3, v4) = 0x392e916a31062fc503bd7144ad2e0c003d9b016b28ca1a3d23c1e3aa6ba3d361::cetus_clmm_utils::swap_exact<T0, T3>(arg1, arg4, 0x2::coin::zero<T0>(arg9), 0x2::coin::from_balance<T3>(v2, arg9), false, true, 0x2::balance::value<T3>(&v2), arg8, arg9);
            0x2::coin::destroy_zero<T3>(v4);
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x2::coin::into_balance<T0>(v3));
        };
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v0);
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v1);
        (0x2::balance::value<T0>(&arg0.tiny_coin_base), 0x2::balance::value<T1>(&arg0.tiny_coin_farming))
    }

    public entry fun add_collateral<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: vector<0x2::coin::Coin<T1>>, arg9: u64, arg10: bool, arg11: u8, arg12: vector<u8>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = join_split_keep<T0>(arg6, arg7, arg14);
        let v1 = join_split_keep<T1>(arg8, arg9, arg14);
        add_collateral_single<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, v1, arg10, arg11, arg12, arg13, arg14);
    }

    public entry fun add_collateral_only_base<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        add_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun add_collateral_only_base_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        add_collateral_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun add_collateral_only_farming<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        add_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun add_collateral_only_farming_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        add_collateral_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun add_collateral_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: vector<0x2::coin::Coin<T1>>, arg9: u64, arg10: bool, arg11: u8, arg12: vector<u8>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = join_split_keep<T0>(arg6, arg7, arg14);
        let v1 = join_split_keep<T1>(arg8, arg9, arg14);
        add_collateral_single_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, v1, arg10, arg11, arg12, arg13, arg14);
    }

    public entry fun add_collateral_single<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let v0 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_position_signer<T0>(arg12);
        let v1 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::before_add_collateral<T0>(&arg0.position_operator_cap, arg1, arg2, &v0, arg5, arg6, arg8, health<T0, T1, T2>(arg0, arg4, arg5), is_stable<T0, T1, T2>(arg0, arg1, arg4, arg11), is_reserve_consistent<T0, T1, T2>(), arg11, arg12);
        let v2 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::extract_add_collateral_context_coin_send<T0>(&mut v1, arg12);
        let v3 = work_inner<T0, T1, T2>(arg0, arg3, arg4, arg5, v2, arg7, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_add_collateral_context_debt<T0>(&v1), arg9, arg10, arg11, arg12);
        if (0x2::coin::value<T0>(&v3) == 0) {
            0x2::coin::destroy_zero<T0>(v3);
        } else {
            0x2::pay::keep<T0>(v3, arg12);
        };
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::after_add_collateral<T0>(&arg0.position_operator_cap, arg1, v1, arg8, health<T0, T1, T2>(arg0, arg4, arg5), is_stable<T0, T1, T2>(arg0, arg1, arg4, arg11), is_reserve_consistent<T0, T1, T2>());
    }

    public entry fun add_collateral_single_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: bool, arg9: u8, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let v0 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_position_signer<T0>(arg12);
        let v1 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::before_add_collateral<T0>(&arg0.position_operator_cap, arg1, arg2, &v0, arg5, arg6, arg8, health_reverse<T0, T1, T2>(arg0, arg4, arg5), is_stable_reverse<T0, T1, T2>(arg0, arg1, arg4, arg11), is_reserve_consistent<T0, T1, T2>(), arg11, arg12);
        let v2 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::extract_add_collateral_context_coin_send<T0>(&mut v1, arg12);
        let v3 = work_inner_reverse<T0, T1, T2>(arg0, arg3, arg4, arg5, v2, arg7, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_add_collateral_context_debt<T0>(&v1), arg9, arg10, arg11, arg12);
        if (0x2::coin::value<T0>(&v3) == 0) {
            0x2::coin::destroy_zero<T0>(v3);
        } else {
            0x2::pay::keep<T0>(v3, arg12);
        };
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::after_add_collateral<T0>(&arg0.position_operator_cap, arg1, v1, arg8, health_reverse<T0, T1, T2>(arg0, arg4, arg5), is_stable_reverse<T0, T1, T2>(arg0, arg1, arg4, arg11), is_reserve_consistent<T0, T1, T2>());
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
        balance_to_share_inner<T0, T1, T2>(arg0, arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft)))
    }

    fun balance_to_share_inner<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: u128, arg2: u128) : u128 {
        let v0 = arg0.total_share;
        if (v0 == 0) {
            return arg1
        };
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div_u128(arg1, v0, arg2)
    }

    public fun checked_package_version<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>) {
        assert!(arg0.package_version == 1, 33);
    }

    public fun collect_reward_all_reverse<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), true);
        if (arg5) {
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, T0>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8));
        };
        if (arg6) {
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, T1>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8));
        };
        if (arg7) {
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, T3>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8);
            let (v3, v4) = 0x392e916a31062fc503bd7144ad2e0c003d9b016b28ca1a3d23c1e3aa6ba3d361::cetus_clmm_utils::swap_exact_reverse<T0, T3>(arg1, arg4, 0x2::coin::zero<T0>(arg9), 0x2::coin::from_balance<T3>(v2, arg9), false, true, 0x2::balance::value<T3>(&v2), arg8, arg9);
            0x2::coin::destroy_zero<T3>(v4);
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x2::coin::into_balance<T0>(v3));
        };
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v1);
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v0);
        (0x2::balance::value<T0>(&arg0.tiny_coin_base), 0x2::balance::value<T1>(&arg0.tiny_coin_farming))
    }

    public fun collect_reward_pool_reverse<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), true);
        if (arg5) {
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, T0>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8));
        };
        if (arg6) {
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, T1>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8));
        };
        if (arg7) {
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, T3>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8);
            let (v3, v4) = 0x392e916a31062fc503bd7144ad2e0c003d9b016b28ca1a3d23c1e3aa6ba3d361::cetus_clmm_utils::swap_exact<T0, T3>(arg1, arg4, 0x2::coin::zero<T0>(arg9), 0x2::coin::from_balance<T3>(v2, arg9), false, true, 0x2::balance::value<T3>(&v2), arg8, arg9);
            0x2::coin::destroy_zero<T3>(v4);
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x2::coin::into_balance<T0>(v3));
        };
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v1);
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v0);
        (0x2::balance::value<T0>(&arg0.tiny_coin_base), 0x2::balance::value<T1>(&arg0.tiny_coin_farming))
    }

    public fun collect_reward_swap_reverse<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), true);
        if (arg5) {
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8));
        };
        if (arg6) {
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8));
        };
        if (arg7) {
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg8);
            let (v3, v4) = 0x392e916a31062fc503bd7144ad2e0c003d9b016b28ca1a3d23c1e3aa6ba3d361::cetus_clmm_utils::swap_exact_reverse<T0, T3>(arg1, arg4, 0x2::coin::zero<T0>(arg9), 0x2::coin::from_balance<T3>(v2, arg9), false, true, 0x2::balance::value<T3>(&v2), arg8, arg9);
            0x2::coin::destroy_zero<T3>(v4);
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x2::coin::into_balance<T0>(v3));
        };
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v0);
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v1);
        (0x2::balance::value<T0>(&arg0.tiny_coin_base), 0x2::balance::value<T1>(&arg0.tiny_coin_farming))
    }

    public fun collect_reward_without_swap<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: bool, arg6: &0x2::clock::Clock) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), true);
        if (arg4) {
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg6));
        };
        if (arg5) {
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg6));
        };
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v0);
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v1);
        (0x2::balance::value<T0>(&arg0.tiny_coin_base), 0x2::balance::value<T1>(&arg0.tiny_coin_farming))
    }

    public fun collect_reward_without_swap_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: bool, arg5: bool, arg6: &0x2::clock::Clock) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), true);
        if (arg4) {
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, T0>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg6));
        };
        if (arg5) {
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, T1>(arg1, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft), arg2, true, arg6));
        };
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, v1);
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, v0);
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
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::coder::type_to_package_address<AdminCap>()
    }

    public fun get_reinvestor_bounty_bps<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>) : u64 {
        checked_package_version<T0, T1, T2>(arg0);
        arg0.reinvest_bounty_bps
    }

    public fun get_share<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: u64) : u128 {
        checked_package_version<T0, T1, T2>(arg0);
        *0x2::table::borrow<u64, u128>(&arg0.shares, arg1)
    }

    public fun health<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64) : u64 {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = &arg0.shares;
        let v1 = 0;
        if (0x2::table::contains<u64, u128>(v0, arg2)) {
            v1 = *0x2::table::borrow<u64, u128>(v0, arg2);
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        let v3 = share_to_balance_inner<T2>(v2, arg0.total_share, v1);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v4, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), v2, false);
        let v8 = if (v2 == 0) {
            0
        } else {
            (0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div_u128(v3, (v6 as u128), v2) as u64)
        };
        let v9 = if (v2 == 0) {
            0
        } else {
            (0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div_u128(v3, (v7 as u128), v2) as u64)
        };
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, false, true, v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v10) + v8
    }

    public fun health_reverse<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64) : u64 {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = &arg0.shares;
        let v1 = 0;
        if (0x2::table::contains<u64, u128>(v0, arg2)) {
            v1 = *0x2::table::borrow<u64, u128>(v0, arg2);
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        let v3 = share_to_balance_inner<T2>(v2, arg0.total_share, v1);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v4, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T1, T0>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), v2, false);
        let v8 = if (v2 == 0) {
            0
        } else {
            (0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div_u128(v3, (v7 as u128), v2) as u64)
        };
        let v9 = if (v2 == 0) {
            0
        } else {
            (0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div_u128(v3, (v6 as u128), v2) as u64)
        };
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, true, true, v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v10) + v8
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize<T0, T1, T2>(arg0: &AdminCap, arg1: &0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::AdminCap, arg2: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg3: &mut 0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::WorkerInfoStore, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: address, arg9: u64, arg10: address, arg11: u64, arg12: u32, arg13: u32, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = get_mole_cetus_worker_addr();
        assert!(!0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::is_worker_info_registered(arg3, v0), 2);
        assert!(0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::is_vault_initialized<T0>(arg2), 13);
        let v1 = 900;
        assert!(arg9 <= v1, 15);
        let v2 = WorkerInfo<T0, T1, T2>{
            id                      : 0x2::object::new(arg14),
            reinvest_bounty_bps     : arg9,
            max_reinvest_bounty_bps : v1,
            ok_reinvestors          : 0x2::table::new<address, bool>(arg14),
            ok_rebalancers          : 0x2::table::new<address, bool>(arg14),
            ok_strategies           : 0x2::table::new<u8, bool>(arg14),
            treasury_account        : arg10,
            reinvest_path           : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reinvest_threshold      : arg11,
            shares                  : 0x2::table::new<u64, u128>(arg14),
            total_share             : 0,
            config                  : arg8,
            position_nft            : 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg6, arg7, arg12, arg13, arg14)),
            position_operator_cap   : 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::acquire_position_operator_cap<T0>(arg1),
            coin_base_decimals      : 0x2::coin::get_decimals<T0>(arg4),
            coin_farming_decimals   : 0x2::coin::get_decimals<T1>(arg5),
            tiny_coin_base          : 0x2::balance::zero<T0>(),
            tiny_coin_farming       : 0x2::balance::zero<T1>(),
            pool_id                 : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg7),
            package_version         : 1,
        };
        0x2::transfer::share_object<WorkerInfo<T0, T1, T2>>(v2);
        0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::register_worker_info<T0, T1, T2>(arg3, v0);
        let v3 = InitializeEvent{worker_info: 0x2::object::uid_to_address(&v2.id)};
        0x2::event::emit<InitializeEvent>(v3);
    }

    public entry fun initialize_reverse<T0, T1, T2>(arg0: &AdminCap, arg1: &0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::AdminCap, arg2: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg3: &mut 0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::WorkerInfoStore, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: address, arg9: u64, arg10: address, arg11: u64, arg12: u32, arg13: u32, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = get_mole_cetus_worker_addr();
        assert!(!0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::is_worker_info_registered(arg3, v0), 2);
        assert!(0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::is_vault_initialized<T0>(arg2), 13);
        let v1 = 900;
        assert!(arg9 <= v1, 15);
        let v2 = WorkerInfo<T0, T1, T2>{
            id                      : 0x2::object::new(arg14),
            reinvest_bounty_bps     : arg9,
            max_reinvest_bounty_bps : v1,
            ok_reinvestors          : 0x2::table::new<address, bool>(arg14),
            ok_rebalancers          : 0x2::table::new<address, bool>(arg14),
            ok_strategies           : 0x2::table::new<u8, bool>(arg14),
            treasury_account        : arg10,
            reinvest_path           : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reinvest_threshold      : arg11,
            shares                  : 0x2::table::new<u64, u128>(arg14),
            total_share             : 0,
            config                  : arg8,
            position_nft            : 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T1, T0>(arg6, arg7, arg12, arg13, arg14)),
            position_operator_cap   : 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::acquire_position_operator_cap<T0>(arg1),
            coin_base_decimals      : 0x2::coin::get_decimals<T0>(arg4),
            coin_farming_decimals   : 0x2::coin::get_decimals<T1>(arg5),
            tiny_coin_base          : 0x2::balance::zero<T0>(),
            tiny_coin_farming       : 0x2::balance::zero<T1>(),
            pool_id                 : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg7),
            package_version         : 1,
        };
        0x2::transfer::share_object<WorkerInfo<T0, T1, T2>>(v2);
        0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::register_worker_info<T0, T1, T2>(arg3, v0);
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

    public fun is_stable<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : bool {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = arg0.config;
        let (v1, v2) = 0x392e916a31062fc503bd7144ad2e0c003d9b016b28ca1a3d23c1e3aa6ba3d361::cetus_clmm_utils::get_pool_price_amount_ratio<T0, T1>(arg2);
        let (v3, v4) = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::oracle_medianizer::get_price_generic<T0, T1>(arg1, 0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::get_oracle(arg1, v0), arg3);
        if (v4 + 86400 <= now_seconds(arg3)) {
            return false
        };
        let v5 = ((v2 * (0x2::math::pow(10, 8) as u128) * (0x2::math::pow(10, 9 - arg0.coin_farming_decimals) as u128) / v1 / (0x2::math::pow(10, 9 - arg0.coin_base_decimals) as u128)) as u64);
        let v6 = 0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::get_max_price_diff(arg1, v0, get_mole_cetus_worker_addr());
        let v7 = 0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::get_max_price_diff_scale();
        if (v5 * v7 > v3 * v6 || v5 * v6 < v3 * v7) {
            return false
        };
        true
    }

    public fun is_stable_reverse<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock) : bool {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = arg0.config;
        let (v1, v2) = 0x392e916a31062fc503bd7144ad2e0c003d9b016b28ca1a3d23c1e3aa6ba3d361::cetus_clmm_utils::get_pool_price_amount_ratio<T1, T0>(arg2);
        let (v3, v4) = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::oracle_medianizer::get_price_generic<T0, T1>(arg1, 0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::get_oracle(arg1, v0), arg3);
        if (v4 + 86400 <= now_seconds(arg3)) {
            return false
        };
        let v5 = ((v1 * (0x2::math::pow(10, 8) as u128) * (0x2::math::pow(10, 9 - arg0.coin_farming_decimals) as u128) / v2 / (0x2::math::pow(10, 9 - arg0.coin_base_decimals) as u128)) as u64);
        let v6 = 0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::get_max_price_diff(arg1, v0, get_mole_cetus_worker_addr());
        let v7 = 0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config::get_max_price_diff_scale();
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

    public entry fun kill<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let v0 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_position_signer<T0>(arg7);
        let v1 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::before_kill<T0>(&arg0.position_operator_cap, arg1, arg2, &v0, arg5, health<T0, T1, T2>(arg0, arg4, arg5), is_stable<T0, T1, T2>(arg0, arg1, arg4, arg6), arg6, arg7);
        let v2 = liquidate<T0, T1, T2>(arg0, arg4, arg3, arg5, arg6, arg7);
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::merge_kill_context_coin_back<T0>(&mut v1, v2);
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::after_kill<T0>(&arg0.position_operator_cap, arg1, arg2, &v0, v1, arg7);
    }

    public entry fun kill_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let v0 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_position_signer<T0>(arg7);
        let v1 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::before_kill<T0>(&arg0.position_operator_cap, arg1, arg2, &v0, arg5, health_reverse<T0, T1, T2>(arg0, arg4, arg5), is_stable_reverse<T0, T1, T2>(arg0, arg1, arg4, arg6), arg6, arg7);
        let v2 = liquidate_reverse<T0, T1, T2>(arg0, arg4, arg3, arg5, arg6, arg7);
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::merge_kill_context_coin_back<T0>(&mut v1, v2);
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::after_kill<T0>(&arg0.position_operator_cap, arg1, arg2, &v0, v1, arg7);
    }

    fun liquidate<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg0, arg3);
        let v1 = 0x2::coin::zero<T0>(arg5);
        let v2 = 0x2::coin::zero<T1>(arg5);
        let (v3, v4) = strategy_execute<T0, T1, T2>(arg0, arg2, arg1, v1, v2, v0, 0, 3, 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::coder::encode_u64(0), arg4, arg5);
        let v5 = v4;
        assert!(0x2::coin::value<T1>(&v5) == 0, 24);
        0x2::coin::destroy_zero<T1>(v5);
        v3
    }

    fun liquidate_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg0, arg3);
        let v1 = 0x2::coin::zero<T0>(arg5);
        let v2 = 0x2::coin::zero<T1>(arg5);
        let (v3, v4) = strategy_execute_reverse<T0, T1, T2>(arg0, arg2, arg1, v1, v2, v0, 0, 3, 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::coder::encode_u64(0), arg4, arg5);
        let v5 = v4;
        assert!(0x2::coin::value<T1>(&v5) == 0, 24);
        0x2::coin::destroy_zero<T1>(v5);
        v3
    }

    fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun position_info<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        (health<T0, T1, T2>(arg0, arg2, arg3), 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::position_debt_val<T0>(arg1, arg3))
    }

    public fun position_info_reverse<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: u64) : (u64, u64) {
        checked_package_version<T0, T1, T2>(arg0);
        (health_reverse<T0, T1, T2>(arg0, arg2, arg3), 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::position_debt_val<T0>(arg1, arg3))
    }

    public entry fun rebalance<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg14, arg15);
        rebalance_inner<T0, T1, T2>(arg0, arg1, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun rebalance_all_reverse<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward_all_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg14, arg15);
        rebalance_inner_reverse<T0, T1, T2>(arg0, arg1, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    fun rebalance_inner<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: u128, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_rebalancer<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg10)), 32);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0) == arg3 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1) == arg4) {
            abort 26
        };
        let v2 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nft);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v2);
        let (v4, v5) = if (v3 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v2, v3, arg9)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v6 = v5;
        let v7 = v4;
        0x2::balance::join<T0>(&mut v7, 0x2::balance::withdraw_all<T0>(&mut arg0.tiny_coin_base));
        0x2::balance::join<T1>(&mut v6, 0x2::balance::withdraw_all<T1>(&mut arg0.tiny_coin_farming));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v2);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nft, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg10));
        if (0x2::balance::value<T0>(&v7) > 0 || 0x2::balance::value<T1>(&v6) > 0) {
            let v8 = 0x2::coin::from_balance<T0>(v7, arg10);
            let v9 = 0x2::coin::from_balance<T1>(v6, arg10);
            let (v10, v11) = strategy_execute<T0, T1, T2>(arg0, arg1, arg2, v8, v9, 0, 0, 2, arg8, arg9, arg10);
            let v12 = v11;
            let v13 = v10;
            assert!(0x2::coin::value<T0>(&v13) <= arg6 && 0x2::coin::value<T1>(&v12) <= arg7, 27);
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x2::coin::into_balance<T0>(v13));
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, 0x2::coin::into_balance<T1>(v12));
        } else {
            0x2::balance::destroy_zero<T0>(v7);
            0x2::balance::destroy_zero<T1>(v6);
        };
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        assert!(v14 >= arg5, 28);
        let v15 = RebalanceEvent{
            tick_lower_idx   : arg3,
            tick_upper_idx   : arg4,
            liquidity_before : v3,
            liquidity_after  : v14,
        };
        0x2::event::emit<RebalanceEvent>(v15);
    }

    fun rebalance_inner_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: u32, arg4: u32, arg5: u128, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_rebalancer<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg10)), 32);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0) == arg3 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1) == arg4) {
            abort 26
        };
        let v2 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nft);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v2);
        let (v4, v5) = if (v3 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T0>(arg1, arg2, &mut v2, v3, arg9)
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        let v6 = v5;
        let v7 = v4;
        0x2::balance::join<T0>(&mut v6, 0x2::balance::withdraw_all<T0>(&mut arg0.tiny_coin_base));
        0x2::balance::join<T1>(&mut v7, 0x2::balance::withdraw_all<T1>(&mut arg0.tiny_coin_farming));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T1, T0>(arg1, arg2, v2);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nft, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T1, T0>(arg1, arg2, arg3, arg4, arg10));
        if (0x2::balance::value<T0>(&v6) > 0 || 0x2::balance::value<T1>(&v7) > 0) {
            let v8 = 0x2::coin::from_balance<T0>(v6, arg10);
            let v9 = 0x2::coin::from_balance<T1>(v7, arg10);
            let (v10, v11) = strategy_execute_reverse<T0, T1, T2>(arg0, arg1, arg2, v8, v9, 0, 0, 2, arg8, arg9, arg10);
            let v12 = v11;
            let v13 = v10;
            assert!(0x2::coin::value<T0>(&v13) <= arg6 && 0x2::coin::value<T1>(&v12) <= arg7, 27);
            0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x2::coin::into_balance<T0>(v13));
            0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, 0x2::coin::into_balance<T1>(v12));
        } else {
            0x2::balance::destroy_zero<T0>(v6);
            0x2::balance::destroy_zero<T1>(v7);
        };
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        assert!(v14 >= arg5, 28);
        let v15 = RebalanceEvent{
            tick_lower_idx   : arg3,
            tick_upper_idx   : arg4,
            liquidity_before : v3,
            liquidity_after  : v14,
        };
        0x2::event::emit<RebalanceEvent>(v15);
    }

    public entry fun rebalance_pool_reverse<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward_pool_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg14, arg15);
        rebalance_inner_reverse<T0, T1, T2>(arg0, arg1, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun rebalance_swap_reverse<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward_swap_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg14, arg15);
        rebalance_inner<T0, T1, T2>(arg0, arg1, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun rebalance_without_swap_reward<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: bool, arg6: u32, arg7: u32, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward_without_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        rebalance_inner<T0, T1, T2>(arg0, arg1, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun rebalance_without_swap_reward_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: bool, arg5: bool, arg6: u32, arg7: u32, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward_without_swap_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        rebalance_inner_reverse<T0, T1, T2>(arg0, arg1, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun reinvest<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg3, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun reinvest_all_reverse<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward_all_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg3, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun reinvest_inner<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_reinvestor<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg8)), 20);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.tiny_coin_base);
        let v2 = 0x2::balance::withdraw_all<T1>(&mut arg0.tiny_coin_farming);
        if (0x2::balance::value<T0>(&v1) == 0 && 0x2::balance::value<T1>(&v2) == 0) {
            abort 29
        };
        let v3 = 0x2::coin::from_balance<T0>(v1, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg8);
        let (v5, v6) = strategy_execute<T0, T1, T2>(arg0, arg1, arg2, v3, v4, 0, 0, 2, arg6, arg7, arg8);
        let v7 = v6;
        let v8 = v5;
        assert!(0x2::coin::value<T0>(&v8) <= arg4 && 0x2::coin::value<T1>(&v7) <= arg5, 27);
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x2::coin::into_balance<T0>(v8));
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, 0x2::coin::into_balance<T1>(v7));
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        assert!(v9 >= v0 + arg3, 28);
        let v10 = ReinvestEvent{
            liquidity_before : v0,
            liquidity_after  : v9,
        };
        0x2::event::emit<ReinvestEvent>(v10);
    }

    fun reinvest_inner_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: u128, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_reinvestor<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg8)), 20);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.tiny_coin_base);
        let v2 = 0x2::balance::withdraw_all<T1>(&mut arg0.tiny_coin_farming);
        if (0x2::balance::value<T0>(&v1) == 0 && 0x2::balance::value<T1>(&v2) == 0) {
            abort 29
        };
        let v3 = 0x2::coin::from_balance<T0>(v1, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v2, arg8);
        let (v5, v6) = strategy_execute_reverse<T0, T1, T2>(arg0, arg1, arg2, v3, v4, 0, 0, 2, arg6, arg7, arg8);
        let v7 = v6;
        let v8 = v5;
        assert!(0x2::coin::value<T0>(&v8) <= arg4 && 0x2::coin::value<T1>(&v7) <= arg5, 27);
        0x2::balance::join<T0>(&mut arg0.tiny_coin_base, 0x2::coin::into_balance<T0>(v8));
        0x2::balance::join<T1>(&mut arg0.tiny_coin_farming, 0x2::coin::into_balance<T1>(v7));
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        assert!(v9 >= v0 + arg3, 28);
        let v10 = ReinvestEvent{
            liquidity_before : v0,
            liquidity_after  : v9,
        };
        0x2::event::emit<ReinvestEvent>(v10);
    }

    public entry fun reinvest_pool_reverse<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg5: bool, arg6: bool, arg7: bool, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward_pool_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg3, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun reinvest_swap_reverse<T0, T1, T2, T3>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg5: bool, arg6: bool, arg7: bool, arg8: u128, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward_swap_reverse<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg3, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun reinvest_without_swap_reward<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward_without_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg10);
        reinvest_inner<T0, T1, T2>(arg0, arg1, arg3, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun reinvest_without_swap_reward_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: bool, arg5: bool, arg6: u128, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let (_, _) = collect_reward_without_swap_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg10);
        reinvest_inner_reverse<T0, T1, T2>(arg0, arg1, arg3, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    fun remove_share<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: u64) : u128 {
        if (0x2::table::contains<u64, u128>(&arg0.shares, arg1)) {
            let v0 = *0x2::table::borrow<u64, u128>(&arg0.shares, arg1);
            if (v0 > 0) {
                arg0.total_share = arg0.total_share - v0;
                *0x2::table::borrow_mut<u64, u128>(&mut arg0.shares, arg1) = 0;
                return share_to_balance_inner<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft)), arg0.total_share, v0)
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

    public fun share_to_balance<T0, T1, T2>(arg0: &WorkerInfo<T0, T1, T2>, arg1: u128) : u128 {
        checked_package_version<T0, T1, T2>(arg0);
        share_to_balance_inner<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft)), arg0.total_share, arg1)
    }

    fun share_to_balance_inner<T0>(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg1 == 0) {
            return arg2
        };
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div_u128(arg2, arg0, arg1)
    }

    fun strategy_execute<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u128, arg6: u64, arg7: u8, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nft);
        if (arg7 == 1) {
            return 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_add_base_coin_only::execute<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
        };
        if (arg7 == 2) {
            return 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_add_two_sides_optimal::execute<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
        };
        if (arg7 == 3) {
            return 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_liquidate::execute<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
        };
        if (arg7 == 4) {
            return 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_withdraw_minimize_trading::execute<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
        };
        if (arg7 == 5) {
            return 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_partial_close_liquidate::execute<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
        };
        assert!(arg7 == 6, 5);
        0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_partial_close_minimize_trading::execute<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
    }

    fun strategy_execute_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u128, arg6: u64, arg7: u8, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nft);
        if (arg7 == 1) {
            return 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_add_base_coin_only::execute_reverse<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
        };
        if (arg7 == 2) {
            return 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_add_two_sides_optimal::execute_reverse<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
        };
        if (arg7 == 3) {
            return 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_liquidate::execute_reverse<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
        };
        if (arg7 == 4) {
            return 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_withdraw_minimize_trading::execute_reverse<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
        };
        if (arg7 == 5) {
            return 0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_partial_close_liquidate::execute_reverse<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
        };
        assert!(arg7 == 6, 5);
        0xc426da5c157a4595aba5bd9640cb5ccc1c41e847ab4898944dd2e449ef634266::cetus_clmm_strategy_partial_close_minimize_trading::execute_reverse<T0, T1>(arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8, &mut arg0.tiny_coin_base, &mut arg0.tiny_coin_farming, arg9, arg10)
    }

    public fun upgrade_package_version<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfo<T0, T1, T2>, arg2: u64) {
        arg1.package_version = arg2;
    }

    public entry fun work<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: vector<0x2::coin::Coin<T1>>, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = join_split_keep<T0>(arg6, arg7, arg15);
        let v1 = join_split_keep<T1>(arg8, arg9, arg15);
        work_single<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, v1, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    fun work_inner<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u8, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg0, arg3);
        let v1 = &arg0.ok_strategies;
        assert!(0x2::table::contains<u8, bool>(v1, arg7) && *0x2::table::borrow<u8, bool>(v1, arg7), 22);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == arg0.pool_id, 25);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        let (v3, v4) = strategy_execute<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, v0, arg6, arg7, arg8, arg9, arg10);
        let v5 = v4;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft)) - v2 - v0;
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::pay::keep<T1>(v5, arg10);
        };
        add_share<T0, T1, T2>(arg0, arg3, v6, v2);
        v3
    }

    fun work_inner_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u8, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = remove_share<T0, T1, T2>(arg0, arg3);
        let v1 = &arg0.ok_strategies;
        assert!(0x2::table::contains<u8, bool>(v1, arg7) && *0x2::table::borrow<u8, bool>(v1, arg7), 22);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2) == arg0.pool_id, 25);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft));
        let (v3, v4) = strategy_execute_reverse<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, v0, arg6, arg7, arg8, arg9, arg10);
        let v5 = v4;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nft)) - v2 - v0;
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::pay::keep<T1>(v5, arg10);
        };
        add_share<T0, T1, T2>(arg0, arg3, v6, v2);
        v3
    }

    public entry fun work_none<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        work<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun work_none_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        work_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun work_only_base<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        work<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun work_only_base_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        work_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun work_only_farming<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        work<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun work_only_farming_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        work_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun work_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: u64, arg8: vector<0x2::coin::Coin<T1>>, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        let v0 = join_split_keep<T0>(arg6, arg7, arg15);
        let v1 = join_split_keep<T1>(arg8, arg9, arg15);
        work_single_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, v1, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun work_single<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let v0 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_position_signer<T0>(arg13);
        let (v1, v2) = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::before_work<T0>(&arg0.position_operator_cap, arg1, arg2, &v0, arg5, get_mole_cetus_worker_addr(), arg6, arg8, is_stable<T0, T1, T2>(arg0, arg1, arg4, arg12), arg12, arg13);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::extract_work_context_coin_send<T0>(v5, arg13);
        let v7 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_work_context_debt<T0>(v5);
        let v8 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_work_context_id<T0>(v5);
        let v9 = work_inner<T0, T1, T2>(arg0, arg3, arg4, v8, v6, arg7, v7, arg10, arg11, arg12, arg13);
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::merge_work_context_coin_back<T0>(v5, v9);
        if (v7 > 0) {
            0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::set_work_context_health<T0>(v5, health<T0, T1, T2>(arg0, arg4, v8));
        };
        0x2::coin::join<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(&mut v3, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::after_work<T0>(&arg0.position_operator_cap, arg1, arg2, &v0, v4, arg9, is_stable<T0, T1, T2>(arg0, arg1, arg4, arg12), arg12, arg13));
        if (0x2::coin::value<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(&v3) == 0) {
            0x2::coin::destroy_zero<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(v3);
        } else {
            0x2::pay::keep<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(v3, arg13);
        };
    }

    public entry fun work_single_reverse<T0, T1, T2>(arg0: &mut WorkerInfo<T0, T1, T2>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u8, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version<T0, T1, T2>(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let v0 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_position_signer<T0>(arg13);
        let (v1, v2) = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::before_work<T0>(&arg0.position_operator_cap, arg1, arg2, &v0, arg5, get_mole_cetus_worker_addr(), arg6, arg8, is_stable_reverse<T0, T1, T2>(arg0, arg1, arg4, arg12), arg12, arg13);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::extract_work_context_coin_send<T0>(v5, arg13);
        let v7 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_work_context_debt<T0>(v5);
        let v8 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::get_work_context_id<T0>(v5);
        let v9 = work_inner_reverse<T0, T1, T2>(arg0, arg3, arg4, v8, v6, arg7, v7, arg10, arg11, arg12, arg13);
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::merge_work_context_coin_back<T0>(v5, v9);
        if (v7 > 0) {
            0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::set_work_context_health<T0>(v5, health_reverse<T0, T1, T2>(arg0, arg4, v8));
        };
        0x2::coin::join<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(&mut v3, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault::after_work<T0>(&arg0.position_operator_cap, arg1, arg2, &v0, v4, arg9, is_stable_reverse<T0, T1, T2>(arg0, arg1, arg4, arg12), arg12, arg13));
        if (0x2::coin::value<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(&v3) == 0) {
            0x2::coin::destroy_zero<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(v3);
        } else {
            0x2::pay::keep<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(v3, arg13);
        };
    }

    // decompiled from Move bytecode v6
}

