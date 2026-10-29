module 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::router {
    struct RouterSwapEvent has copy, drop {
        user: address,
        direction: u8,
        amount_in: u64,
        amount_out: u64,
    }

    struct RouterSwapYtEvent has copy, drop {
        user: address,
        sy_amount_in: u64,
        yt_amount_out: u64,
        sy_amount_out: u64,
    }

    struct RouterSwapYtForSyEvent has copy, drop {
        user: address,
        yt_amount_in: u64,
        sy_amount_out: u64,
        sy_amount_repaid: u64,
    }

    struct LpSyDustSweptEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        user: address,
        treasury: address,
        input_sy: u64,
        amount: u64,
        keep_yt: bool,
    }

    public fun transfer_position<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg6: address, arg7: &0x2::tx_context::TxContext) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg5, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4), 3007);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(&arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4));
        if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_required<T0, T1, T2>(arg4)) {
            assert_distributor_matches_state<T0, T1, T2>(arg2, arg4);
            let v0 = &mut arg0;
            let v1 = take_one_settlement(v0);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v1);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::consume_yt_transfer(&mut arg3, v1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg2), 0x2::tx_context::sender(arg7), arg6);
            let v2 = &mut arg1;
            let v3 = take_one_settlement(v2);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v3);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::consume_lp_transfer(&mut arg3, v3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg2), 0x2::tx_context::sender(arg7), arg6);
            0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
            0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg1);
        } else {
            assert_no_settlements(arg0);
            assert_no_settlements(arg1);
        };
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::transfer_position(arg3, arg6);
    }

    public fun redeem_yt_after_expiry<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg2: u64, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg5, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4), 3007);
        assert_position_matches_state<T0, T1, T2>(arg3, arg4);
        if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_required<T0, T1, T2>(arg4)) {
            assert_distributor_matches_state<T0, T1, T2>(arg1, arg4);
            let v2 = &mut arg0;
            let v3 = take_one_settlement(v2);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg1, &v3);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_yt_reward_mutation<T0, T1, T2>(arg4, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_yt_reward_mutation<T0, T1, T2>(arg4, v3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg3), 0x2::tx_context::sender(arg7), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg3), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg3)));
            0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
            let v4 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v4, begin_post_yt_operation<T0, T1, T2>(arg1, arg5, arg4, arg3, 0x2::tx_context::sender(arg7)));
            (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::redeem_yt_after_expiry<T0, T1, T2>(arg2, arg3, arg4, arg6, arg7), v4)
        } else {
            assert_no_settlements(arg0);
            (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::redeem_yt_after_expiry<T0, T1, T2>(arg2, arg3, arg4, arg6, arg7), 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>())
        }
    }

    public fun add_lp<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg7: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg8: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg9: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg2, arg6);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        let v2 = &mut arg1;
        let v3 = take_one_settlement(v2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v3);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg6, v1);
        let v5 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::begin_reward_mutation(arg7, v3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg2), 0x2::tx_context::sender(arg12));
        let (v6, v7, v8) = add_lp_core<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::end_reward_mutation(arg7, v5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg6, v4);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg1);
        let v9 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v9, begin_post_lp_operation<T0, T1, T2>(arg2, arg8, arg6, arg7, 0x2::tx_context::sender(arg12)));
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v9, begin_post_pool_operation<T0, T1, T2>(arg2, arg8, arg6));
        (v6, v7, v8, v9)
    }

    fun add_lp_core<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg6: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg5, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3), 3007);
        assert_before(arg5, arg7, arg8);
        assert_position_matches_state<T0, T1, T2>(arg4, arg3);
        let v0 = observe_index<T0, T1, T2>(arg3, arg5, arg6, arg8);
        let (v1, _, v3, v4) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::add_liquidity<T0, T1, T2>(arg0, arg1, arg3, arg4, v0, arg8, arg9);
        assert!(v1 >= arg2, 3001);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_pt(arg4, v3);
        (v1, v3, v4)
    }

    public fun add_lp_from_sy<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg9: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg10: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg11: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        add_lp_from_sy_settled<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    }

    fun add_lp_from_sy_core<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg6: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg7: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        assert!(arg3 == 0, 3001);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg6, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4), 3007);
        assert_before(arg6, arg8, arg9);
        assert_position_matches_state<T0, T1, T2>(arg5, arg4);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_accounted_sy<T0, T1, T2>(arg4);
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg5);
        let v3 = observe_index<T0, T1, T2>(arg4, arg6, arg7, arg9);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_balanced_lp<T0, T1, T2>(0x2::coin::value<T0>(&arg0), arg4, v3, arg9);
        let v5 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::status(&v4);
        assert!(v5 != 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::curve_limit(), 3010);
        assert!(v5 != 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::precision_unresolved(), 3011);
        assert!(v5 == 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::success(), 3012);
        let (v6, v7, v8, v9, v10) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::amounts(&v4);
        let (v11, v12) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::swap_sy_for_exact_pt<T0, T1, T2>(arg0, v6, v7, arg4, v3, arg9, arg10);
        assert!(v11 == v7, 3001);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_pt(arg5, v6);
        let (v13, _, v15, v16) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::add_liquidity<T0, T1, T2>(v12, v6, arg4, arg5, v3, arg9, arg10);
        let v17 = v16;
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_pt(arg5, v15);
        let v18 = if (v13 == v8) {
            if (0x2::coin::value<T0>(&v17) == v9) {
                v6 - v15 == v10
            } else {
                false
            }
        } else {
            false
        };
        assert!(v18, 3009);
        assert!(v13 >= arg2 && 0x2::coin::value<T0>(&v17) >= arg3, 3001);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::is_full(v0, 0x2::coin::value<T0>(&v17)), 3008);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::sy_is_conserved(v1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_accounted_sy<T0, T1, T2>(arg4), v0, 0x2::coin::value<T0>(&v17)), 3009);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::position_delta_valid(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::pt_balance(arg5), v2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg5), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::pt_balance(arg5), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg5), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg5), v13, 0, arg2), 3009);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg5) == v2, 3003);
        (v13, sweep_lp_sy_dust<T0, T1, T2>(v17, v0, arg4, arg5, false, arg10))
    }

    fun add_lp_from_sy_settled<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg9: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg10: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg11: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg3, arg8);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        let v2 = &mut arg1;
        let v3 = take_one_settlement(v2);
        let v4 = &mut arg2;
        let v5 = take_one_settlement(v4);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg3, &v1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg3, &v3);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg3, &v5);
        let v6 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg8, v1);
        let v7 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_yt_reward_mutation<T0, T1, T2>(arg8, v3, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg9), 0x2::tx_context::sender(arg14), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg9), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg9));
        let v8 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::begin_reward_mutation(arg9, v5, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg3), 0x2::tx_context::sender(arg14));
        let (v9, v10) = add_lp_from_sy_core<T0, T1, T2>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::end_reward_mutation(arg9, v8);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_yt_reward_mutation<T0, T1, T2>(arg8, v7);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg8, v6);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg1);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg2);
        let v11 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v11, begin_post_yt_operation<T0, T1, T2>(arg3, arg10, arg8, arg9, 0x2::tx_context::sender(arg14)));
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v11, begin_post_lp_operation<T0, T1, T2>(arg3, arg10, arg8, arg9, 0x2::tx_context::sender(arg14)));
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v11, begin_post_pool_operation<T0, T1, T2>(arg3, arg10, arg8));
        (v9, v10, v11)
    }

    public fun add_lp_keep_yt<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg9: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg10: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg3, arg7);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        let v2 = &mut arg1;
        let v3 = take_one_settlement(v2);
        let v4 = &mut arg2;
        let v5 = take_one_settlement(v4);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg3, &v1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg3, &v3);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg3, &v5);
        let v6 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg7, v1);
        let v7 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_yt_reward_mutation<T0, T1, T2>(arg7, v3, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), 0x2::tx_context::sender(arg13), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg8), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg8));
        let v8 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::begin_reward_mutation(arg8, v5, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg3), 0x2::tx_context::sender(arg13));
        let (v9, v10, v11) = add_lp_keep_yt_core<T0, T1, T2>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::end_reward_mutation(arg8, v8);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_yt_reward_mutation<T0, T1, T2>(arg7, v7);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg7, v6);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg1);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg2);
        let v12 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v12, begin_post_yt_operation<T0, T1, T2>(arg3, arg9, arg7, arg8, 0x2::tx_context::sender(arg13)));
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v12, begin_post_lp_operation<T0, T1, T2>(arg3, arg9, arg7, arg8, 0x2::tx_context::sender(arg13)));
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v12, begin_post_pool_operation<T0, T1, T2>(arg3, arg9, arg7));
        (v9, v10, v11, v12)
    }

    fun add_lp_keep_yt_core<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg6: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg5, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3), 3007);
        assert_before(arg5, arg7, arg8);
        assert_position_matches_state<T0, T1, T2>(arg4, arg3);
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 1, 3000);
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_accounted_sy<T0, T1, T2>(arg3);
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::pt_balance(arg4);
        let v3 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg4);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg4);
        let v5 = observe_index<T0, T1, T2>(arg3, arg5, arg6, arg8);
        let (v6, v7, v8) = add_lp_keep_yt_with_index<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v5, arg8, arg9);
        let v9 = v8;
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::is_keep_full(v0, 0x2::coin::value<T0>(&v9)), 3008);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::sy_is_conserved(v1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_accounted_sy<T0, T1, T2>(arg3), v0, 0x2::coin::value<T0>(&v9)), 3009);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::position_delta_valid(v2, v3, v4, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::pt_balance(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg4), v6, v7, arg2), 3009);
        (v6, v7, sweep_lp_sy_dust<T0, T1, T2>(v9, v0, arg3, arg4, true, arg9))
    }

    fun add_lp_keep_yt_with_index<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 1, 3000);
        let v1 = solve_keep_yt_split<T0, T1, T2>(v0, arg1, arg3, arg5);
        execute_lp_split<T0, T1, T2>(arg0, v1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun assert_before(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 == 0 || v0 <= arg1, 3004);
        v0
    }

    public fun assert_coin_max_value<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x2::coin::Coin<T0>, arg2: u64) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg0);
        let v0 = 0x2::coin::value<T0>(arg1);
        assert!(v0 <= arg2, 3001);
        v0
    }

    public fun assert_coin_min_value<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x2::coin::Coin<T0>, arg2: u64) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg0);
        let v0 = 0x2::coin::value<T0>(arg1);
        assert!(v0 >= arg2, 3001);
        v0
    }

    fun assert_distributor_matches_state<T0: drop, T1: drop, T2: drop>(arg0: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) {
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg0) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_id<T0, T1, T2>(arg1), 3002);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::market_state_id(arg0) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1), 3002);
    }

    public fun assert_lp_delta_at_least(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: u64, arg3: u64) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg0);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg1);
        assert!(v0 >= arg2, 3001);
        let v1 = v0 - arg2;
        assert!(v1 >= arg3, 3001);
        v1
    }

    fun assert_no_settlements(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>) {
        assert!(0x1::vector::length<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(&arg0) == 0, 3005);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
    }

    fun assert_position_matches_state<T0: drop, T1: drop, T2: drop>(arg0: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1));
    }

    public fun assert_pt_delta_at_least(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: u64, arg3: u64) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg0);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::pt_balance(arg1);
        assert!(v0 >= arg2, 3001);
        let v1 = v0 - arg2;
        assert!(v1 >= arg3, 3001);
        v1
    }

    public fun assert_yt_delta_at_least(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: u64, arg3: u64) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg0);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg1);
        assert!(v0 >= arg2, 3001);
        let v1 = v0 - arg2;
        assert!(v1 >= arg3, 3001);
        v1
    }

    fun begin_post_lp_operation<T0: drop, T1: drop, T2: drop>(arg0: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: address) : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::begin_scoped_operation_with_guard(arg0, arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope(), arg4, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg3), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg3), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_reward_guard(arg3))
    }

    fun begin_post_pool_operation<T0: drop, T1: drop, T2: drop>(arg0: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::begin_scoped_operation_with_guard(arg0, arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope(), @0x0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_sy<T0, T1, T2>(arg2), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::pool_reward_guard<T0, T1, T2>(arg2))
    }

    fun begin_post_yt_operation<T0: drop, T1: drop, T2: drop>(arg0: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: address) : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::begin_scoped_operation_with_guard(arg0, arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope(), arg4, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg3), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg3), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg3))
    }

    public fun buy_exact_pt<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg7: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg8: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg1, arg5);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg1, &v1);
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg5, v1);
        let (v3, v4) = buy_exact_pt_core<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg5, v2);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        let v5 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v5, begin_post_pool_operation<T0, T1, T2>(arg1, arg7, arg5));
        (v3, v4, v5)
    }

    fun buy_exact_pt_core<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg6: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg5, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3), 3007);
        assert_before(arg5, arg7, arg8);
        assert_position_matches_state<T0, T1, T2>(arg4, arg3);
        let v0 = observe_index<T0, T1, T2>(arg3, arg5, arg6, arg8);
        let (v1, v2) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::swap_sy_for_exact_pt<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg8, arg9);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_pt(arg4, arg1);
        let v3 = RouterSwapEvent{
            user       : 0x2::tx_context::sender(arg9),
            direction  : 0,
            amount_in  : v1,
            amount_out : arg1,
        };
        0x2::event::emit<RouterSwapEvent>(v3);
        (v1, v2)
    }

    public fun buy_exact_yt<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg7: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg8: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg9: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg2, arg6);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        let v2 = &mut arg1;
        let v3 = take_one_settlement(v2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v3);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg6, v1);
        let v5 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_yt_reward_mutation<T0, T1, T2>(arg6, v3, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg7), 0x2::tx_context::sender(arg12), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg7), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg7));
        let (v6, v7) = buy_exact_yt_core<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_yt_reward_mutation<T0, T1, T2>(arg6, v5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg6, v4);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg1);
        let v8 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v8, begin_post_yt_operation<T0, T1, T2>(arg2, arg8, arg6, arg7, 0x2::tx_context::sender(arg12)));
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v8, begin_post_pool_operation<T0, T1, T2>(arg2, arg8, arg6));
        (v6, v7, v8)
    }

    fun buy_exact_yt_core<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg6: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg5, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3), 3007);
        assert_before(arg5, arg7, arg8);
        assert_position_matches_state<T0, T1, T2>(arg4, arg3);
        assert!(arg1 > 0, 3000);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = observe_index<T0, T1, T2>(arg3, arg5, arg6, arg8);
        let (v2, v3) = mint_exact_yt_with_budget<T0, T1, T2>(arg0, arg1, arg2, 0, arg3, arg4, v1, arg8, arg9);
        let v4 = v3;
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = if (v0 > v5) {
            v0 - v5
        } else {
            0
        };
        assert!(v6 <= arg2, 3001);
        let v7 = RouterSwapYtEvent{
            user          : 0x2::tx_context::sender(arg9),
            sy_amount_in  : v6,
            yt_amount_out : v2,
            sy_amount_out : v5,
        };
        0x2::event::emit<RouterSwapYtEvent>(v7);
        (v2, v4)
    }

    public fun buy_pt<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg6: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg7: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg1, arg4);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg1, &v1);
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg4, v1);
        let (v3, v4) = buy_pt_core<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg4, v2);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        let v5 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v5, begin_post_pool_operation<T0, T1, T2>(arg1, arg6, arg4));
        (v3, v4, v5)
    }

    fun buy_pt_core<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg5: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg4, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), 3007);
        assert_before(arg4, arg6, arg7);
        assert_position_matches_state<T0, T1, T2>(arg3, arg2);
        let v0 = observe_index<T0, T1, T2>(arg2, arg4, arg5, arg7);
        let (v1, v2, v3) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::swap_sy_for_pt<T0, T1, T2>(arg0, arg1, arg2, v0, arg7, arg8);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_pt(arg3, v1);
        let v4 = RouterSwapEvent{
            user       : 0x2::tx_context::sender(arg8),
            direction  : 0,
            amount_in  : v2,
            amount_out : v1,
        };
        0x2::event::emit<RouterSwapEvent>(v4);
        (v1, v3)
    }

    public fun buy_yt<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg7: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg8: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg9: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg2, arg6);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        let v2 = &mut arg1;
        let v3 = take_one_settlement(v2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v3);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg6, v1);
        let v5 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_yt_reward_mutation<T0, T1, T2>(arg6, v3, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg7), 0x2::tx_context::sender(arg12), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg7), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg7));
        let (v6, v7) = buy_yt_core<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_yt_reward_mutation<T0, T1, T2>(arg6, v5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg6, v4);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg1);
        let v8 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v8, begin_post_yt_operation<T0, T1, T2>(arg2, arg8, arg6, arg7, 0x2::tx_context::sender(arg12)));
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v8, begin_post_pool_operation<T0, T1, T2>(arg2, arg8, arg6));
        (v6, v7, v8)
    }

    fun buy_yt_core<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg6: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg5, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3), 3007);
        assert_before(arg5, arg7, arg8);
        assert_position_matches_state<T0, T1, T2>(arg4, arg3);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = observe_index<T0, T1, T2>(arg3, arg5, arg6, arg8);
        let (v2, _) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_exact_sy_for_yt<T0, T1, T2>(v0, arg3, v1, arg8);
        assert!(v2 >= arg1, 3001);
        let (v4, v5) = mint_exact_yt_with_budget<T0, T1, T2>(arg0, v2, v0, arg2, arg3, arg4, v1, arg8, arg9);
        let v6 = v5;
        let v7 = RouterSwapYtEvent{
            user          : 0x2::tx_context::sender(arg9),
            sy_amount_in  : v0,
            yt_amount_out : v4,
            sy_amount_out : 0x2::coin::value<T0>(&v6),
        };
        0x2::event::emit<RouterSwapYtEvent>(v7);
        (v4, v6)
    }

    fun choose_keep_yt_split<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: u64, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: u128) : u64 {
        let v0 = clamp_keep_yt_split(arg0, arg2);
        if (quote_keep_yt_lp<T0, T1, T2>(arg0, v0, arg3, arg4) > quote_keep_yt_lp<T0, T1, T2>(arg0, arg1, arg3, arg4)) {
            v0
        } else {
            arg1
        }
    }

    public fun claim_yt_interest<T0: drop, T1: drop, T2: drop>(arg0: 0x1::option::Option<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg3, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), 3007);
        assert_position_matches_state<T0, T1, T2>(arg1, arg2);
        let v0 = if (0x2::clock::timestamp_ms(arg4) >= 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg2)) {
            assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::is_settled<T0, T1, T2>(arg2), 3002);
            if (0x1::option::is_some<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>(&arg0)) {
                0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::destroy<T0>(0x1::option::destroy_some<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>(arg0));
            } else {
                0x1::option::destroy_none<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>(arg0);
            };
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::settled_py_index<T0, T1, T2>(arg2)
        } else {
            observe_index<T0, T1, T2>(arg2, arg3, 0x1::option::destroy_some<0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>>(arg0), arg4)
        };
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::claim_interest<T0, T1, T2>(v0, arg1, arg2, arg4, arg5)
    }

    fun clamp_keep_yt_split(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1
        };
        if (arg1 >= arg0) {
            return arg0 - 1
        };
        arg1
    }

    public fun create_position<T0: drop, T1: drop, T2: drop>(arg0: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg1, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg0), 3007);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::mint_market_state(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg0), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg0), arg2, arg3)
    }

    fun execute_lp_split<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>) {
        assert!(arg1 > 0 && 0x2::coin::value<T0>(&arg0) > arg1, 3000);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::mint_py_with_sy_index<T0, T1, T2>(0x2::coin::split<T0>(&mut arg0, arg1, arg7), arg5, arg4, arg3, arg6);
        let (v1, _, v3, v4) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::add_liquidity<T0, T1, T2>(arg0, v0, arg3, arg4, arg5, arg6, arg7);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_pt(arg4, v3);
        assert!(v1 >= arg2, 3001);
        (v1, v0, v4)
    }

    public fun initialize_pool_by_admin<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg7: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg8: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg9: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg10: u64, arg11: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg8, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg6), 3007);
        assert_before(arg8, arg10, arg12);
        assert_position_matches_state<T0, T1, T2>(arg7, arg6);
        assert_distributor_matches_state<T0, T1, T2>(arg2, arg6);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::rewarder_count(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope()) > 0;
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::rewarder_count(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope()) > 0;
        let v2 = if (v0) {
            let v3 = &mut arg0;
            let v4 = take_one_settlement(v3);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v4);
            0x1::option::some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::RewardPoolOperation>(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg6, v4))
        } else {
            0x1::option::none<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::RewardPoolOperation>()
        };
        let v5 = v2;
        let v6 = if (v1) {
            let v7 = &mut arg1;
            let v8 = take_one_settlement(v7);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v8);
            0x1::option::some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::LpRewardMutation>(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::begin_reward_mutation(arg7, v8, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg2), 0x2::tx_context::sender(arg13)))
        } else {
            0x1::option::none<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::LpRewardMutation>()
        };
        let v9 = v6;
        assert_no_settlements(arg0);
        assert_no_settlements(arg1);
        let v10 = observe_index<T0, T1, T2>(arg6, arg8, arg9, arg12);
        let (v11, _, v13, v14) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::initialize_liquidity_by_admin<T0, T1, T2>(arg3, arg4, arg6, arg7, arg2, v10, arg11, arg12, arg13);
        assert!(v11 >= arg5, 3001);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_pt(arg7, v13);
        if (0x1::option::is_some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::LpRewardMutation>(&v9)) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::end_reward_mutation(arg7, 0x1::option::destroy_some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::LpRewardMutation>(v9));
        } else {
            0x1::option::destroy_none<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::LpRewardMutation>(v9);
        };
        if (0x1::option::is_some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::RewardPoolOperation>(&v5)) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg6, 0x1::option::destroy_some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::RewardPoolOperation>(v5));
        } else {
            0x1::option::destroy_none<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::RewardPoolOperation>(v5);
        };
        let v15 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        if (v1) {
            0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v15, begin_post_lp_operation<T0, T1, T2>(arg2, arg8, arg6, arg7, 0x2::tx_context::sender(arg13)));
        };
        if (v0) {
            0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v15, begin_post_pool_operation<T0, T1, T2>(arg2, arg8, arg6));
        };
        (v11, v13, v14, v15)
    }

    fun mint_exact_yt_with_budget<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg5, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4));
        assert!(arg1 > 0 && arg2 > 0, 3000);
        let (v0, v1, v2, v3) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_sy_for_exact_yt<T0, T1, T2>(arg1, arg4, arg6, arg7);
        assert!(v0 > 0, 3001);
        assert!(v3 <= arg2, 3001);
        assert!(v3 > 0 && 0x2::coin::value<T0>(&arg0) >= v3, 3001);
        let (v4, v5) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_buy_yt<T0, T1, T2>(arg4, v0, v2, arg6, arg7, arg8);
        let v6 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, v3, arg8));
        0x2::balance::join<T0>(&mut v6, 0x2::coin::into_balance<T0>(v4));
        assert!(0x2::balance::value<T0>(&v6) == v1, 3003);
        let v7 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::mint_py_with_sy_index<T0, T1, T2>(0x2::coin::from_balance<T0>(v6, arg8), arg6, arg5, arg4, arg7);
        assert!(v7 == v0, 3003);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_pt(arg5, v7);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::finish_buy_yt<T0, T1, T2>(arg4, v5, v7, arg8);
        assert!(0x2::coin::value<T0>(&arg0) >= arg3, 3001);
        (v7, arg0)
    }

    public fun mint_py<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg2: 0x2::coin::Coin<T0>, arg3: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_required<T0, T1, T2>(arg5)) {
            assert_distributor_matches_state<T0, T1, T2>(arg1, arg5);
            let v2 = &mut arg0;
            let v3 = take_one_settlement(v2);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg1, &v3);
            let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_yt_reward_mutation<T0, T1, T2>(arg5, v3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg4), 0x2::tx_context::sender(arg8), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg4));
            let v5 = mint_py_core<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_yt_reward_mutation<T0, T1, T2>(arg5, v4);
            0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
            let v6 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v6, begin_post_yt_operation<T0, T1, T2>(arg1, arg6, arg5, arg4, 0x2::tx_context::sender(arg8)));
            (v5, v6)
        } else {
            assert_no_settlements(arg0);
            (mint_py_core<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7), 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>())
        }
    }

    fun mint_py_core<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg5: &0x2::clock::Clock) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg4, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3), 3007);
        assert_position_matches_state<T0, T1, T2>(arg2, arg3);
        let v0 = observe_index<T0, T1, T2>(arg3, arg4, arg1, arg5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::mint_py_with_sy_index<T0, T1, T2>(arg0, v0, arg2, arg3, arg5)
    }

    fun observe_index<T0: drop, T1: drop, T2: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg3: &0x2::clock::Clock) : u128 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::update_py_index<T0, T1, T2>(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::consume_price_info<T0, T1, T2>(arg0, arg1, arg2, arg3), arg3)
    }

    public fun quote_add_lp_keep_yt<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, u64) {
        assert!(arg0 > 1, 3000);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::is_pool_active<T0, T1, T2>(arg1) && 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg1) > 0x2::clock::timestamp_ms(arg3), 3008);
        let v0 = solve_keep_yt_split<T0, T1, T2>(arg0, 0, arg1, arg2);
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::calc_py_amount_for_sy<T0, T1, T2>(v0, arg2, arg1);
        let v2 = arg0 - v0;
        let (v3, v4, v5) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::project_add(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::lp_supply<T0, T1, T2>(arg1), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_pt<T0, T1, T2>(arg1), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_sy<T0, T1, T2>(arg1), v1, v2);
        assert!(v3 > 0, 3008);
        let v6 = v2 - v5 - 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_sy<T0, T1, T2>(arg1);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::is_keep_full(arg0, v6), 3008);
        (v3, v1, v0, v2, v6, v1 - v4 - 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_pt<T0, T1, T2>(arg1))
    }

    fun quote_keep_yt_lp<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: u128) : u64 {
        let v0 = clamp_keep_yt_split(arg0, arg1);
        let v1 = arg0 - v0;
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::calc_py_amount_for_sy<T0, T1, T2>(v0, arg3, arg2);
        if (v1 == 0 || v2 == 0) {
            return 0
        };
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math::calc_lp_amount(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::lp_supply<T0, T1, T2>(arg2), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_sy<T0, T1, T2>(arg2), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_pt<T0, T1, T2>(arg2), v1, v2)
    }

    public fun redeem_pt_after_expiry<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg3, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), 3007);
        assert_position_matches_state<T0, T1, T2>(arg1, arg2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::redeem_py_after_expiry<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5)
    }

    public fun redeem_py<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg2: u64, arg3: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg6, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5), 3007);
        assert_position_matches_state<T0, T1, T2>(arg4, arg5);
        if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_required<T0, T1, T2>(arg5)) {
            assert_distributor_matches_state<T0, T1, T2>(arg1, arg5);
            let v2 = &mut arg0;
            let v3 = take_one_settlement(v2);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg1, &v3);
            let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_yt_reward_mutation<T0, T1, T2>(arg5, v3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg4), 0x2::tx_context::sender(arg8), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg4), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg4));
            let v5 = observe_index<T0, T1, T2>(arg5, arg6, arg3, arg7);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_yt_reward_mutation<T0, T1, T2>(arg5, v4);
            0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
            let v6 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
            0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v6, begin_post_yt_operation<T0, T1, T2>(arg1, arg6, arg5, arg4, 0x2::tx_context::sender(arg8)));
            (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::redeem_py_before_expiry_with_sy_index<T0, T1, T2>(arg2, v5, arg4, arg5, arg7, arg8), v6)
        } else {
            assert_no_settlements(arg0);
            let v7 = observe_index<T0, T1, T2>(arg5, arg6, arg3, arg7);
            (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::redeem_py_before_expiry_with_sy_index<T0, T1, T2>(arg2, v7, arg4, arg5, arg7, arg8), 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>())
        }
    }

    public fun remove_lp<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg7: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg8: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg2, arg6);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        let v2 = &mut arg1;
        let v3 = take_one_settlement(v2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v3);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg6, v1);
        let v5 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::begin_reward_mutation(arg7, v3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg2), 0x2::tx_context::sender(arg11));
        let (v6, v7) = remove_lp_core<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::end_reward_mutation(arg7, v5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg6, v4);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg1);
        let v8 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v8, begin_post_lp_operation<T0, T1, T2>(arg2, arg8, arg6, arg7, 0x2::tx_context::sender(arg11)));
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v8, begin_post_pool_operation<T0, T1, T2>(arg2, arg8, arg6));
        (v6, v7, v8)
    }

    fun remove_lp_core<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg5, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3), 3007);
        assert_before(arg5, arg6, arg7);
        assert_position_matches_state<T0, T1, T2>(arg4, arg3);
        let (v0, v1) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::remove_liquidity<T0, T1, T2>(arg0, arg3, arg4, arg8);
        let v2 = v0;
        assert!(0x2::coin::value<T0>(&v2) >= arg1, 3001);
        assert!(v1 >= arg2, 3001);
        if (v1 > 0) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_pt(arg4, v1);
        };
        (v2, v1)
    }

    public fun sell_pt<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg2: u64, arg3: u64, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg6: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg7: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg1, arg4);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg1, &v1);
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg4, v1);
        let v3 = sell_pt_core<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg4, v2);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        let v4 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v4, begin_post_pool_operation<T0, T1, T2>(arg1, arg6, arg4));
        (v3, v4)
    }

    fun sell_pt_core<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg5: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg4, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), 3007);
        assert_before(arg4, arg6, arg7);
        assert_position_matches_state<T0, T1, T2>(arg3, arg2);
        let v0 = observe_index<T0, T1, T2>(arg2, arg4, arg5, arg7);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_pt(arg3, arg0);
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::swap_pt_for_sy<T0, T1, T2>(arg0, arg1, arg2, v0, arg7, arg8);
        let v2 = RouterSwapEvent{
            user       : 0x2::tx_context::sender(arg8),
            direction  : 1,
            amount_in  : arg0,
            amount_out : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<RouterSwapEvent>(v2);
        v1
    }

    public fun sell_pt_for_exact_sy<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg2: u64, arg3: u64, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg6: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg7: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg1, arg4);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg1, &v1);
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg4, v1);
        let (v3, v4) = sell_pt_for_exact_sy_core<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg4, v2);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        let v5 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v5, begin_post_pool_operation<T0, T1, T2>(arg1, arg6, arg4));
        (v3, v4, v5)
    }

    fun sell_pt_for_exact_sy_core<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg5: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg4, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), 3007);
        assert_before(arg4, arg6, arg7);
        assert_position_matches_state<T0, T1, T2>(arg3, arg2);
        let v0 = observe_index<T0, T1, T2>(arg2, arg4, arg5, arg7);
        let (v1, v2) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::swap_pt_for_exact_sy<T0, T1, T2>(arg0, arg1, arg2, v0, arg7, arg8);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::sub_pt(arg3, v1);
        let v3 = RouterSwapEvent{
            user       : 0x2::tx_context::sender(arg8),
            direction  : 1,
            amount_in  : v1,
            amount_out : arg0,
        };
        0x2::event::emit<RouterSwapEvent>(v3);
        (v1, v2)
    }

    public fun sell_yt<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: u64, arg4: u64, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg7: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg8: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg2, arg5);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        let v2 = &mut arg1;
        let v3 = take_one_settlement(v2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v3);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg5, v1);
        let v5 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_yt_reward_mutation<T0, T1, T2>(arg5, v3, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6), 0x2::tx_context::sender(arg11), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg6), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg6));
        let v6 = sell_yt_core<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_yt_reward_mutation<T0, T1, T2>(arg5, v5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg5, v4);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg1);
        let v7 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v7, begin_post_yt_operation<T0, T1, T2>(arg2, arg7, arg5, arg6, 0x2::tx_context::sender(arg11)));
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v7, begin_post_pool_operation<T0, T1, T2>(arg2, arg7, arg5));
        (v6, v7)
    }

    fun sell_yt_core<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg5: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg4, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), 3007);
        assert_before(arg4, arg6, arg7);
        assert_position_matches_state<T0, T1, T2>(arg3, arg2);
        let v0 = observe_index<T0, T1, T2>(arg2, arg4, arg5, arg7);
        let (v1, v2) = sell_yt_with_pt_repayment<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg7, arg8);
        let v3 = v1;
        let v4 = RouterSwapYtForSyEvent{
            user             : 0x2::tx_context::sender(arg8),
            yt_amount_in     : arg0,
            sy_amount_out    : 0x2::coin::value<T0>(&v3),
            sy_amount_repaid : v2,
        };
        0x2::event::emit<RouterSwapYtForSyEvent>(v4);
        v3
    }

    public fun sell_yt_for_exact_sy<T0: drop, T1: drop, T2: drop>(arg0: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg1: vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: u64, arg4: u64, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg7: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg8: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>) {
        assert_distributor_matches_state<T0, T1, T2>(arg2, arg5);
        let v0 = &mut arg0;
        let v1 = take_one_settlement(v0);
        let v2 = &mut arg1;
        let v3 = take_one_settlement(v2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_config_current(arg2, &v3);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_pool_reward_operation<T0, T1, T2>(arg5, v1);
        let v5 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::begin_yt_reward_mutation<T0, T1, T2>(arg5, v3, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6), 0x2::tx_context::sender(arg11), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg6), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg6));
        let (v6, v7, v8) = sell_yt_for_exact_sy_core<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_yt_reward_mutation<T0, T1, T2>(arg5, v5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::end_pool_reward_operation<T0, T1, T2>(arg5, v4);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0);
        0x1::vector::destroy_empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg1);
        let v9 = 0x1::vector::empty<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>();
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v9, begin_post_yt_operation<T0, T1, T2>(arg2, arg7, arg5, arg6, 0x2::tx_context::sender(arg11)));
        0x1::vector::push_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation>(&mut v9, begin_post_pool_operation<T0, T1, T2>(arg2, arg7, arg5));
        (v6, v7, v8, v9)
    }

    fun sell_yt_for_exact_sy_core<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg5: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg4, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), 3007);
        assert_before(arg4, arg6, arg7);
        assert_position_matches_state<T0, T1, T2>(arg3, arg2);
        assert!(arg0 > 0 && arg1 > 0, 3000);
        let v0 = observe_index<T0, T1, T2>(arg2, arg4, arg5, arg7);
        let (v1, _, _, v4) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_yt_for_exact_sy<T0, T1, T2>(arg0, arg1, arg2, v0, arg7);
        let v5 = if (v1 > 0) {
            if (v1 <= arg1) {
                v4 >= arg0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 3001);
        let (v6, v7) = sell_yt_with_pt_repayment<T0, T1, T2>(v1, arg0, arg2, arg3, v0, arg7, arg8);
        let v8 = v6;
        let v9 = RouterSwapYtForSyEvent{
            user             : 0x2::tx_context::sender(arg8),
            yt_amount_in     : v1,
            sy_amount_out    : 0x2::coin::value<T0>(&v8),
            sy_amount_repaid : v7,
        };
        0x2::event::emit<RouterSwapYtForSyEvent>(v9);
        (v1, 0x2::coin::split<T0>(&mut v8, arg0, arg8), v8)
    }

    fun sell_yt_with_pt_repayment<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2));
        assert!(arg0 > 0, 3000);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_pt<T0, T1, T2>(arg2) > arg0, 3001);
        let (v0, v1) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::redeem_yt_with_external_pt_before_expiry_with_sy_index<T0, T1, T2>(arg0, arg4, arg3, arg2, arg5, arg6);
        let v2 = v0;
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 >= arg1, 3001);
        let (v4, v5) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::swap_sy_for_exact_pt<T0, T1, T2>(v2, arg0, v3 - arg1, arg2, arg4, arg5, arg6);
        let v6 = v5;
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::repay_borrowed_pt_for_yt_redeem<T0, T1, T2>(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::borrow_pt_for_yt_redeem<T0, T1, T2>(arg2, arg0), arg0);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::settle_external_pt_redeem<T0, T1, T2>(arg2, v1, arg0);
        assert!(0x2::coin::value<T0>(&v6) >= arg1, 3001);
        (v6, v4)
    }

    public fun settle_market_state_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg4: &0x2::clock::Clock) : u128 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg1, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg0), 3007);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::settle<T0, T1, T2>(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::consume_price_info<T0, T1, T2>(arg0, arg1, arg2, arg4), arg4)
    }

    fun solve_keep_yt_split<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u64, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: u128) : u64 {
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_sy<T0, T1, T2>(arg2);
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_pt<T0, T1, T2>(arg2);
        let v2 = clamp_keep_yt_split(arg0, arg0 / 2);
        if (v0 > 0 && v1 > 0) {
            let v3 = 1;
            let v4 = arg0 - 1;
            let v5 = 0;
            while (v5 < 64 && v3 < v4) {
                let v6 = v4 - v3;
                let v7 = v3 + v6 / 2 + v6 % 2;
                if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::calc_py_amount_for_sy<T0, T1, T2>(v7, arg3, arg2) <= (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor(((arg0 - v7) as u128), (v1 as u128), (v0 as u128)) as u64)) {
                    v3 = v7;
                } else {
                    v4 = v7 - 1;
                };
                v5 = v5 + 1;
            };
            let v8 = choose_keep_yt_split<T0, T1, T2>(arg0, clamp_keep_yt_split(arg0, v3), v3 + 1, arg2, arg3);
            v2 = v8;
            if (v3 > 1) {
                v2 = choose_keep_yt_split<T0, T1, T2>(arg0, v8, v3 - 1, arg2, arg3);
            };
        };
        if (arg1 > 0) {
            v2 = choose_keep_yt_split<T0, T1, T2>(arg0, v2, arg1, arg2, arg3);
        };
        let v9 = quote_keep_yt_lp<T0, T1, T2>(arg0, v2, arg2, arg3);
        if (v9 > 0 && 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::lp_supply<T0, T1, T2>(arg2) > 0) {
            let v10 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::ceil_div((v9 as u256) * (v0 as u256), (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::lp_supply<T0, T1, T2>(arg2) as u256));
            if (v10 > 0 && v10 < (arg0 as u256)) {
                let v11 = arg0 - (v10 as u64);
                let v12 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot<T0, T1, T2>(arg2);
                let v13 = (v11 as u256) * (0x1::u128::max(arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_py_index_stored(&v12)) as u256) / 18446744073709551616;
                let v14 = 18446744073709551615;
                let v15 = if (v11 >= v2) {
                    if (v13 > (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::calc_py_amount_for_sy<T0, T1, T2>(v2, arg3, arg2) as u256)) {
                        if (v13 <= v14 - (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_pt_supply(&v12) as u256)) {
                            v13 <= v14 - (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_yt_supply(&v12) as u256)
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v15) {
                    let (v16, _, _) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::project_add(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::lp_supply<T0, T1, T2>(arg2), v1, v0, (v13 as u64), (v10 as u64));
                    if (v16 >= v9) {
                        v2 = v11;
                    };
                };
            };
        };
        v2
    }

    fun sweep_lp_sy_dust<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(arg4 && 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::is_keep_full(arg1, v0) || 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::lp_balance::is_full(arg1, v0), 3008);
        if (v0 == 0) {
            return arg0
        };
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::treasury<T0, T1, T2>(arg2);
        let v2 = LpSyDustSweptEvent{
            market_state_id : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2),
            position_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg3),
            user            : 0x2::tx_context::sender(arg5),
            treasury        : v1,
            input_sy        : arg1,
            amount          : v0,
            keep_yt         : arg4,
        };
        0x2::event::emit<LpSyDustSweptEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v1);
        0x2::coin::zero<T0>(arg5)
    }

    fun take_one_settlement(arg0: &mut vector<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>) : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement {
        assert!(0x1::vector::length<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0) == 1, 3005);
        0x1::vector::pop_back<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement>(arg0)
    }

    public fun transfer_empty_position(arg0: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: address) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::is_py_empty(&arg0) && 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::is_lp_empty(&arg0), 3006);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::transfer_position(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

