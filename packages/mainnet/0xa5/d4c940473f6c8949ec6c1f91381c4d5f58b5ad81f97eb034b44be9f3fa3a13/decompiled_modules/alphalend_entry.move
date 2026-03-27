module 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_entry {
    struct AlphaLendLegAuth has drop {
        dummy_field: bool,
    }

    public fun admin_recall_alphalend_to_idle<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin_recall::AdminRecallReceipt<T0>, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg3), arg4);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::select_withdraw_amount((arg2 as u128), 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::get_underlying_balance(arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin_recall::borrow_cap_for_recall<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg6), arg5);
        if (v1 == 0) {
            return
        };
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin_recall::add_recall_withdraw_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), withdraw_underlying<T0>(v1, arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin_recall::borrow_cap_for_recall<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg6, arg7), &v0);
    }

    public fun admin_recall_alphalend_to_idle_sui<T0>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin_recall::AdminRecallReceipt<0x2::sui::SUI>, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<0x2::sui::SUI, T0>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg3), arg4);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::select_withdraw_amount((arg2 as u128), 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::get_underlying_balance(arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin_recall::borrow_cap_for_recall<0x2::sui::SUI, T0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg7), arg5);
        if (v1 == 0) {
            return
        };
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin_recall::add_recall_withdraw_leg<0x2::sui::SUI, T0, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), withdraw_underlying_sui(v1, arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin_recall::borrow_cap_for_recall_mut<0x2::sui::SUI, T0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg6, arg7, arg8), &v0);
    }

    public fun claim_alphalend_rewards<T0, T1, T2>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::LLVGlobal, arg1: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T1, T2>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::assert_version(arg0);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_keeper<T1, T2>(arg1, 0x2::tx_context::sender(arg5));
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<T1, T2>(arg1, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_fee_recipient_set<T1, T2>(arg1);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let (v1, v2) = 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::collect_reward<T0>(arg2, arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::borrow_cap_by_auth<T1, T2, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg5);
        let v3 = v1;
        0x2::coin::join<T0>(&mut v3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v2, arg4, arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_fee_recipient<T1, T2>(arg1));
    }

    public fun claim_alphalend_rewards_sui<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::LLVGlobal, arg1: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::assert_version(arg0);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_keeper<T0, T1>(arg1, 0x2::tx_context::sender(arg6));
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<T0, T1>(arg1, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_fee_recipient_set<T0, T1>(arg1);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let (v1, v2) = 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::collect_reward<0x2::sui::SUI>(arg2, arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::borrow_cap_by_auth<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg5, arg6);
        let v3 = v1;
        0x2::coin::join<0x2::sui::SUI>(&mut v3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, v2, arg4, arg5, arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_fee_recipient<T0, T1>(arg1));
    }

    public fun deposit_to_alphalend<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::DepositReceipt<T0>, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg3), arg4);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::sync_for_deposit<T0, T1, AlphaLendLegAuth>(arg0, arg1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::get_underlying_balance(arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::borrow_cap_for_deposit<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg5), arg5, &v0);
        let (v1, v2) = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::begin_deposit_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), arg2, &v0);
        deposit_underlying<T0>(v1, arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::borrow_cap_for_deposit<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg5, arg6);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::finish_deposit_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, v2, 0x2::balance::zero<T0>(), &v0);
    }

    public(friend) fun deposit_underlying<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::deposit<T0>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(arg0, arg5), arg4, arg5);
    }

    public fun rebalance_deposit_to_alphalend<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::RebalanceReceipt<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND();
        let v2 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::get_amount(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::expected_deposit_plan<T0>(arg1), v1);
        let v3 = (0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::rebalance_balance_value<T0>(arg1) as u128);
        if (v2 > 0 && v3 > 0) {
            let v4 = if (v2 < v3) {
                (v2 as u64)
            } else {
                (v3 as u64)
            };
            if (v4 == 0) {
                return
            };
            let (v5, v6) = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::begin_rebalance_deposit_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, v1, v4, &v0);
            deposit_underlying<T0>(v5, arg2, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::borrow_cap_for_rebalance<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg3, arg4, arg5);
            0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::finish_rebalance_deposit_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, v6, 0x2::balance::zero<T0>(), &v0);
            return
        };
    }

    public fun rebalance_withdraw_from_alphalend<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::RebalanceReceipt<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND();
        let v2 = 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::select_withdraw_amount(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::get_amount(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::expected_withdraw_plan<T0>(arg1), v1), 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::get_underlying_balance(arg2, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::borrow_cap_for_rebalance<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg3, arg5), arg4);
        if (v2 == 0) {
            return
        };
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::add_rebalance_withdraw_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, v1, withdraw_underlying<T0>(v2, arg2, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::borrow_cap_for_rebalance<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg3, arg5, arg6), &v0);
    }

    public fun rebalance_withdraw_from_alphalend_sui<T0>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::RebalanceReceipt<0x2::sui::SUI>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<0x2::sui::SUI, T0>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2), arg3);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND();
        let v2 = 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::select_withdraw_amount(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::get_amount(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::expected_withdraw_plan<0x2::sui::SUI>(arg1), v1), 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::get_underlying_balance(arg2, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::borrow_cap_for_rebalance<0x2::sui::SUI, T0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg3, arg6), arg4);
        if (v2 == 0) {
            return
        };
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::add_rebalance_withdraw_leg<0x2::sui::SUI, T0, AlphaLendLegAuth>(arg1, arg0, v1, withdraw_underlying_sui(v2, arg2, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_rebalance::borrow_cap_for_rebalance<0x2::sui::SUI, T0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg3, arg5, arg6, arg7), &v0);
    }

    public fun register_alphalend_leg_auth<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::LLVGlobal, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::LLVPoolAdminCap) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::assert_version(arg0);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::register_protocol_leg_auth<T0, T1, AlphaLendLegAuth>(arg1, arg2, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND());
    }

    public fun sync_alphalend<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg1), arg2);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::keeper_sync_protocol_balance<T0, T1>(arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::get_underlying_balance(arg1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::borrow_cap_for_keeper<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), arg4), arg2, arg3), arg3, arg4);
    }

    public fun withdraw_from_alphalend<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::WithdrawReceipt<T0, T1>, arg2: u128, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<T0, T1>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg3), arg4);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::get_underlying_balance(arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::borrow_cap_for_withdraw<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg6);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::sync_for_withdraw<T0, T1, AlphaLendLegAuth>(arg0, arg1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), v1, arg6, &v0);
        let v2 = 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::select_withdraw_amount(arg2, v1, arg5);
        if (v2 == 0) {
            return
        };
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::add_withdraw_leg<T0, T1, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), withdraw_underlying<T0>(v2, arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::borrow_cap_for_withdraw<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg6, arg7), &v0);
    }

    public fun withdraw_from_alphalend_sui<T0>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::WithdrawReceipt<0x2::sui::SUI, T0>, arg2: u128, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_alphalend_config<0x2::sui::SUI, T0>(arg0, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg3), arg4);
        let v0 = AlphaLendLegAuth{dummy_field: false};
        let v1 = 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::get_underlying_balance(arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::borrow_cap_for_withdraw<0x2::sui::SUI, T0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg7);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::sync_for_withdraw<0x2::sui::SUI, T0, AlphaLendLegAuth>(arg0, arg1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), v1, arg7, &v0);
        let v2 = 0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::select_withdraw_amount(arg2, v1, arg5);
        if (v2 == 0) {
            return
        };
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::add_withdraw_leg<0x2::sui::SUI, T0, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), withdraw_underlying_sui(v2, arg3, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry::borrow_cap_for_withdraw<0x2::sui::SUI, T0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, AlphaLendLegAuth>(arg1, arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::alphalend_position_cap_key(), &v0), arg4, arg6, arg7, arg8), &v0);
    }

    public(friend) fun withdraw_underlying<T0>(arg0: u64, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::withdraw<T0>(arg1, arg2, arg3, arg0, arg4, arg5))
    }

    public(friend) fun withdraw_underlying_sui(arg0: u64, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::coin::into_balance<0x2::sui::SUI>(0xa5d4c940473f6c8949ec6c1f91381c4d5f58b5ad81f97eb034b44be9f3fa3a13::alphalend_adapter::withdraw_sui(arg1, arg2, arg3, arg0, arg4, arg5, arg6))
    }

    // decompiled from Move bytecode v6
}

