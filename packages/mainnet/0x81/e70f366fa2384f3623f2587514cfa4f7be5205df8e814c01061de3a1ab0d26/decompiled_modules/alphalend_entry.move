module 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_entry {
    struct AlphaLendLegAuth has drop {
        dummy_field: bool,
    }

    struct AlphaLendWithdrawSelectionEvent has copy, drop {
        market_id: u64,
        phase: u8,
        requested_assets: u128,
        user_underlying: u128,
        available_liquidity: u64,
        selected_withdraw_amount: u128,
    }

    public fun admin_recall_alphalend_to_idle<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::AdminRecallReceipt<T0>, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg3), arg4);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::get_underlying_balance(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::borrow_cap_for_recall<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg6);
        assert_not_suspicious_zero_liquidity((arg2 as u128), v1, arg5);
        let v2 = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::select_withdraw_amount((arg2 as u128), v1, arg5);
        emit_withdraw_selection(arg4, 4, (arg2 as u128), v1, arg5, (v2 as u128));
        if (v2 == 0) {
            return
        };
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::add_recall_withdraw_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), withdraw_underlying<T0>(v2, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::borrow_cap_for_recall<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg6, arg7), &v0);
    }

    public fun admin_recall_alphalend_to_idle_sui<T0>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::AdminRecallReceipt<0x2::sui::SUI>, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<0x2::sui::SUI, T0>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg3), arg4);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::get_underlying_balance(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::borrow_cap_for_recall<0x2::sui::SUI, T0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg7);
        assert_not_suspicious_zero_liquidity((arg2 as u128), v1, arg5);
        let v2 = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::select_withdraw_amount((arg2 as u128), v1, arg5);
        emit_withdraw_selection(arg4, 5, (arg2 as u128), v1, arg5, (v2 as u128));
        if (v2 == 0) {
            return
        };
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::add_recall_withdraw_leg<0x2::sui::SUI, T0, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), withdraw_underlying_sui(v2, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_recall::borrow_cap_for_recall_mut<0x2::sui::SUI, T0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg6, arg7, arg8), &v0);
    }

    fun assert_not_suspicious_zero_liquidity(arg0: u128, arg1: u128, arg2: u64) {
        if (arg0 > 0 && arg1 > 0) {
            assert!(arg2 > 0, 900);
        };
    }

    fun cap_excess_and_complete_withdraw<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::RebalanceReceipt<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND();
        let v2 = 0x2::balance::value<T0>(&arg3);
        let v3 = (arg4 as u64);
        if (v2 > v3) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::deposit_to_idle<T0, T1, AlphaLendLegAuth>(arg0, v1, 0x2::balance::split<T0>(&mut arg3, v2 - v3), &v0);
        };
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::add_rebalance_withdraw_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, v1, arg3, &v0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::sync_protocol_balance_for_rebalance<T0, T1, AlphaLendLegAuth>(arg0, arg1, v1, 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::get_underlying_balance(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, v1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg5, arg6), arg6, &v0);
    }

    public fun claim_alphalend_rewards<T0, T1, T2>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T1, T2>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_keeper<T1, T2>(arg1, 0x2::tx_context::sender(arg5));
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<T1, T2>(arg1, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_fee_recipient_set<T1, T2>(arg1);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let (v1, v2) = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::collect_reward<T0>(arg2, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_by_auth<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg5);
        let v3 = v1;
        0x2::coin::join<T0>(&mut v3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v2, arg4, arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_fee_recipient<T1, T2>(arg1));
    }

    public fun claim_alphalend_rewards_sui<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_keeper<T0, T1>(arg1, 0x2::tx_context::sender(arg6));
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<T0, T1>(arg1, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::assert_fee_recipient_set<T0, T1>(arg1);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let (v1, v2) = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::collect_reward<0x2::sui::SUI>(arg2, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_by_auth<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg5, arg6);
        let v3 = v1;
        0x2::coin::join<0x2::sui::SUI>(&mut v3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, v2, arg4, arg5, arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_fee_recipient<T0, T1>(arg1));
    }

    public fun deposit_to_alphalend<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::DepositReceipt<T0>, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg3), arg4);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_for_deposit<T0, T1, AlphaLendLegAuth>(arg0, arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::get_underlying_balance(arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_for_deposit<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg5), arg5, &v0);
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::resolve_requested_deposit_amount<T0>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), arg2);
        if (v1 == 0) {
            return
        };
        let (v2, v3) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::begin_deposit_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), v1, &v0);
        deposit_underlying<T0>(v2, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_for_deposit<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg5, arg6);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::finish_deposit_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, v3, 0x2::balance::zero<T0>(), &v0);
    }

    public(friend) fun deposit_underlying<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::deposit<T0>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(arg0, arg5), arg4, arg5);
    }

    fun emit_withdraw_selection(arg0: u64, arg1: u8, arg2: u128, arg3: u128, arg4: u64, arg5: u128) {
        let v0 = AlphaLendWithdrawSelectionEvent{
            market_id                : arg0,
            phase                    : arg1,
            requested_assets         : arg2,
            user_underlying          : arg3,
            available_liquidity      : arg4,
            selected_withdraw_amount : arg5,
        };
        0x2::event::emit<AlphaLendWithdrawSelectionEvent>(v0);
    }

    public fun get_pool_claimable_rewards<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &0x2::clock::Clock) : vector<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward> {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<T0, T1>(arg1, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_claimable_rewards(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_by_auth<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg4)
    }

    fun prepare_user_withdraw<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::WithdrawReceipt<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: &0x2::clock::Clock) : u64 {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg4);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND();
        let v2 = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::get_underlying_balance(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_for_withdraw<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, v1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg7);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_for_withdraw<T0, T1, AlphaLendLegAuth>(arg0, arg1, v1, v2, arg7, &v0);
        assert_not_suspicious_zero_liquidity(arg3, v2, arg5);
        let v3 = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::select_withdraw_amount(arg3, v2, arg5);
        emit_withdraw_selection(arg4, arg6, arg3, v2, arg5, (v3 as u128));
        v3
    }

    public fun rebalance_deposit_to_alphalend<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::RebalanceReceipt<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND();
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::get_amount(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::expected_deposit_plan<T0>(arg1), v1);
        let v3 = (0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::rebalance_balance_value<T0>(arg1) as u128);
        if (v2 > 0 && v3 > 0) {
            let v4 = if (v2 < v3) {
                (v2 as u64)
            } else {
                (v3 as u64)
            };
            if (v4 == 0) {
                return
            };
            let (v5, v6) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::begin_rebalance_deposit_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, v1, v4, &v0);
            deposit_underlying<T0>(v5, arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg3, arg4, arg5);
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::finish_rebalance_deposit_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, v6, 0x2::balance::zero<T0>(), &v0);
            return
        };
    }

    public fun rebalance_withdraw_from_alphalend<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::RebalanceReceipt<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::get_underlying_balance(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg3, arg5);
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::get_amount(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::expected_withdraw_plan<T0>(arg1), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND());
        assert_not_suspicious_zero_liquidity(v2, v1, arg4);
        let v3 = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::select_withdraw_amount(v2, v1, arg4);
        emit_withdraw_selection(arg3, 2, v2, v1, arg4, (v3 as u128));
        if (v3 == 0) {
            return
        };
        let v4 = withdraw_underlying<T0>(v3, arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg3, arg5, arg6);
        cap_excess_and_complete_withdraw<T0, T1>(arg0, arg1, arg2, v4, v2, arg3, arg5);
    }

    public fun rebalance_withdraw_from_alphalend_sui<T0>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::RebalanceReceipt<0x2::sui::SUI>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<0x2::sui::SUI, T0>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::get_underlying_balance(arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<0x2::sui::SUI, T0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg3, arg6);
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::get_amount(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::expected_withdraw_plan<0x2::sui::SUI>(arg1), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND());
        assert_not_suspicious_zero_liquidity(v2, v1, arg4);
        let v3 = 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::select_withdraw_amount(v2, v1, arg4);
        emit_withdraw_selection(arg3, 3, v2, v1, arg4, (v3 as u128));
        if (v3 == 0) {
            return
        };
        let v4 = withdraw_underlying_sui(v3, arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_rebalance::borrow_cap_for_rebalance<0x2::sui::SUI, T0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg3, arg5, arg6, arg7);
        cap_excess_and_complete_withdraw<0x2::sui::SUI, T0>(arg0, arg1, arg2, v4, v2, arg3, arg6);
    }

    public fun refresh_alphalend<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg1), arg2);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_protocol_balance_by_auth<T0, T1, AlphaLendLegAuth>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::get_underlying_balance(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_by_auth<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg2, arg3), arg3, &v0);
    }

    public fun refresh_alphalend_price<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::update_price_from_pyth(arg1, arg2, arg3);
        let v0 = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_price_info(arg1, 0x1::type_name::with_defining_ids<T0>());
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::update_price(arg0, &v0);
    }

    public fun register_alphalend_leg_auth<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::register_protocol_leg_auth<T0, T1, AlphaLendLegAuth>(arg1, arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND());
    }

    public fun sync_alphalend<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg1), arg2);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::sync_protocol_balance_by_auth<T0, T1, AlphaLendLegAuth>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::get_underlying_balance(arg1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_by_auth<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v0), arg2, arg3), arg3, &v0);
    }

    public fun withdraw_from_alphalend<T0, T1>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::WithdrawReceipt<T0, T1>, arg2: u128, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = prepare_user_withdraw<T0, T1>(arg0, arg1, arg3, arg2, arg4, arg5, 0, arg6);
        if (v0 == 0) {
            return
        };
        let v1 = AlphaLendLegAuth{dummy_field: false};
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND();
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::add_withdraw_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, v2, withdraw_underlying<T0>(v0, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_for_withdraw<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, v2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v1), arg4, arg6, arg7), &v1);
    }

    public fun withdraw_from_alphalend_sui<T0>(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::WithdrawReceipt<0x2::sui::SUI, T0>, arg2: u128, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = prepare_user_withdraw<0x2::sui::SUI, T0>(arg0, arg1, arg3, arg2, arg4, arg5, 1, arg7);
        if (v0 == 0) {
            return
        };
        let v1 = AlphaLendLegAuth{dummy_field: false};
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND();
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::add_withdraw_leg<0x2::sui::SUI, T0, AlphaLendLegAuth>(arg1, arg0, v2, withdraw_underlying_sui(v0, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_user_entry::borrow_cap_for_withdraw<0x2::sui::SUI, T0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, v2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), &v1), arg4, arg6, arg7, arg8), &v1);
    }

    public(friend) fun withdraw_underlying<T0>(arg0: u64, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::withdraw<T0>(arg1, arg2, arg3, arg0, arg4, arg5))
    }

    public(friend) fun withdraw_underlying_sui(arg0: u64, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::coin::into_balance<0x2::sui::SUI>(0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_adapter::withdraw_sui(arg1, arg2, arg3, arg0, arg4, arg5, arg6))
    }

    // decompiled from Move bytecode v7
}

