module 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::strategy {
    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_center_bin: u32,
        new_center_bin: u32,
        bins_removed: u64,
        bins_added: u64,
    }

    struct KeeperRebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_center_bin: u32,
        new_center_bin: u32,
        bins_deployed: u64,
        total_x_deployed: u64,
        total_y_deployed: u64,
        twap_bin: u32,
        active_bin: u32,
    }

    public fun assert_calm_zone<T0, T1, T2>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &0x2::clock::Clock) {
        assert!(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::in_calm_zone<T0, T1, T2>(arg1, arg0, arg2), 103);
    }

    fun assert_keeper_gates_configured<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>) {
        let v0 = 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::strategy_config<T0, T1, T2>(arg0);
        assert!(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::strategy_calm_zone_bins(v0) > 0 && 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::strategy_twap_seconds(v0) > 0, 110);
    }

    fun assert_keeper_price<T0, T1, T2>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &0x2::clock::Clock) {
        assert_calm_zone<T0, T1, T2>(arg0, arg1, arg2);
        let v0 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::active_bin_id<T0, T1>(arg0);
        let v1 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::oracle_bin_id<T0, T1>(arg0);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            v1 - v0
        };
        assert!(v2 <= 2, 117);
    }

    fun assert_position_bin_capacity<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg1: &vector<u32>) {
        let v0 = 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position<T0, T1, T2>(arg0);
        let v1 = 0x1::vector::length<u32>(0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_ids(v0));
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(arg1)) {
            if (!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::has_bin(v0, *0x1::vector::borrow<u32>(arg1, v2))) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        assert!(v1 <= 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::max_bins_per_position(), 115);
    }

    fun assert_residual_idle<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>) {
        assert!(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::residual_idle_ratio_bps<T0, T1, T2>(arg0, arg1) <= 1000, 113);
    }

    fun emergency_epilogue<T0, T1, T2>(arg0: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u32, arg4: u32, arg5: u64, arg6: &0x2::clock::Clock) {
        0x2::balance::join<T0>(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_balance_x_mut<T0, T1, T2>(arg0), 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_balance_y_mut<T0, T1, T2>(arg0), 0x2::coin::into_balance<T1>(arg2));
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::set_last_rebalance_ts<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg6));
        let v0 = RebalanceEvent{
            vault_id       : 0x2::object::id<0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>>(arg0),
            old_center_bin : arg3,
            new_center_bin : arg4,
            bins_removed   : arg5,
            bins_added     : 0,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    public fun emergency_exit<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_admin<T0, T1, T2>(arg0, arg2);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_version<T0, T1, T2>(arg2);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::set_exit_only<T0, T1, T2>(arg2);
        emergency_withdraw_to_idle<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun emergency_exit_x_sui<T0, T1>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::VaultAdminCap, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<0x2::sui::SUI, T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_admin<0x2::sui::SUI, T0, T1>(arg0, arg2);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_version<0x2::sui::SUI, T0, T1>(arg2);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::set_exit_only<0x2::sui::SUI, T0, T1>(arg2);
        emergency_withdraw_to_idle_x_sui<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun emergency_withdraw_to_idle<T0, T1, T2>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_pool_matches<T0, T1, T2>(arg1, arg0);
        let v0 = *0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_ids(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position<T0, T1, T2>(arg1));
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::vec_sort::sort_u32(&mut v0);
        let v1 = 0x1::vector::length<u32>(&v0);
        let v2 = if (v1 > 0) {
            *0x1::vector::borrow<u32>(&v0, v1 / 2)
        } else {
            0
        };
        let (v3, v4) = if (v1 > 0) {
            0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::remove_liquidity<T0, T1>(arg0, 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position_mut<T0, T1, T2>(arg1), arg2, v0, position_shares<T0, T1, T2>(arg1, &v0), 0, 0, 4102444800000, arg3, arg4)
        } else {
            (0x2::coin::zero<T0>(arg4), 0x2::coin::zero<T1>(arg4))
        };
        emergency_epilogue<T0, T1, T2>(arg1, v3, v4, v2, 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::active_bin_id<T0, T1>(arg0), v1, arg3);
    }

    fun emergency_withdraw_to_idle_x_sui<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<0x2::sui::SUI, T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_pool_matches<0x2::sui::SUI, T0, T1>(arg1, arg0);
        let v0 = *0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_ids(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position<0x2::sui::SUI, T0, T1>(arg1));
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::vec_sort::sort_u32(&mut v0);
        let v1 = 0x1::vector::length<u32>(&v0);
        let v2 = if (v1 > 0) {
            *0x1::vector::borrow<u32>(&v0, v1 / 2)
        } else {
            0
        };
        let (v3, v4) = if (v1 > 0) {
            0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::remove_liquidity_x_sui<T0>(arg0, 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position_mut<0x2::sui::SUI, T0, T1>(arg1), arg2, v0, position_shares<0x2::sui::SUI, T0, T1>(arg1, &v0), arg3, 0, 0, 4102444800000, arg4, arg5)
        } else {
            (0x2::coin::zero<0x2::sui::SUI>(arg5), 0x2::coin::zero<T0>(arg5))
        };
        emergency_epilogue<0x2::sui::SUI, T0, T1>(arg1, v3, v4, v2, 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::active_bin_id<0x2::sui::SUI, T0>(arg0), v1, arg4);
    }

    public fun guardian_emergency_exit<T0, T1, T2>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_guardian<T0, T1, T2>(arg1, arg4);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_version<T0, T1, T2>(arg1);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::set_exit_only<T0, T1, T2>(arg1);
        emergency_withdraw_to_idle<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun guardian_emergency_exit_x_sui<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<0x2::sui::SUI, T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_guardian<0x2::sui::SUI, T0, T1>(arg1, arg5);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_version<0x2::sui::SUI, T0, T1>(arg1);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::set_exit_only<0x2::sui::SUI, T0, T1>(arg1);
        emergency_withdraw_to_idle_x_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun keeper_deploy<T0, T1, T2>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_version<T0, T1, T2>(arg1);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_keeper<T0, T1, T2>(arg1, arg7);
        assert!(!0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::keeper_ops_paused<T0, T1, T2>(arg1), 102);
        assert_keeper_gates_configured<T0, T1, T2>(arg1);
        assert_keeper_price<T0, T1, T2>(arg0, arg1, arg6);
        let v0 = position_center<T0, T1, T2>(arg1);
        validate_and_deploy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7);
    }

    public(friend) fun keeper_rebalance<T0, T1, T2>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_version<T0, T1, T2>(arg1);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_keeper<T0, T1, T2>(arg1, arg7);
        assert!(!0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::keeper_ops_paused<T0, T1, T2>(arg1), 102);
        assert_keeper_gates_configured<T0, T1, T2>(arg1);
        assert_keeper_price<T0, T1, T2>(arg0, arg1, arg6);
        let v0 = rebalance_withdraw<T0, T1, T2>(arg0, arg1, arg2, arg6, arg7);
        validate_and_deploy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7);
        assert_residual_idle<T0, T1, T2>(arg1, arg0);
    }

    public(friend) fun keeper_rebalance_x_sui<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<0x2::sui::SUI, T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_version<0x2::sui::SUI, T0, T1>(arg1);
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_keeper<0x2::sui::SUI, T0, T1>(arg1, arg8);
        assert!(!0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::keeper_ops_paused<0x2::sui::SUI, T0, T1>(arg1), 102);
        assert_keeper_gates_configured<0x2::sui::SUI, T0, T1>(arg1);
        assert_keeper_price<0x2::sui::SUI, T0, T1>(arg0, arg1, arg7);
        let v0 = rebalance_withdraw_x_sui<T0, T1>(arg0, arg1, arg2, arg6, arg7, arg8);
        validate_and_deploy<0x2::sui::SUI, T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg7, arg8);
        assert_residual_idle<0x2::sui::SUI, T0, T1>(arg1, arg0);
    }

    public fun max_residual_idle_bps() : u64 {
        1000
    }

    fun position_center<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>) : u32 {
        sorted_center(*0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_ids(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position<T0, T1, T2>(arg0)))
    }

    fun position_shares<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg1: &vector<u32>) : vector<u128> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(arg1)) {
            0x1::vector::push_back<u128>(&mut v0, 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::shares_in_bin(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position<T0, T1, T2>(arg0), *0x1::vector::borrow<u32>(arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun rebalance_epilogue<T0, T1, T2>(arg0: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u32, arg4: u32, arg5: u64, arg6: u64) {
        0x2::balance::join<T0>(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_balance_x_mut<T0, T1, T2>(arg0), 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_balance_y_mut<T0, T1, T2>(arg0), 0x2::coin::into_balance<T1>(arg2));
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::set_last_rebalance_ts<T0, T1, T2>(arg0, arg6);
        let v0 = RebalanceEvent{
            vault_id       : 0x2::object::id<0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>>(arg0),
            old_center_bin : arg3,
            new_center_bin : arg4,
            bins_removed   : arg5,
            bins_added     : 0,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    fun rebalance_prologue<T0, T1, T2>(arg0: &0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg1: &0x2::clock::Clock) : (vector<u32>, u64, u32, u64) {
        0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::assert_version<T0, T1, T2>(arg0);
        assert!(!0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::is_paused<T0, T1, T2>(arg0), 102);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::last_rebalance_ts<T0, T1, T2>(arg0) + 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::strategy_rebalance_cooldown_secs(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::strategy_config<T0, T1, T2>(arg0)) * 1000, 101);
        let v1 = *0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_ids(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position<T0, T1, T2>(arg0));
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::vec_sort::sort_u32(&mut v1);
        let v2 = 0x1::vector::length<u32>(&v1);
        let v3 = if (v2 > 0) {
            *0x1::vector::borrow<u32>(&v1, v2 / 2)
        } else {
            0
        };
        (v1, v2, v3, v0)
    }

    public(friend) fun rebalance_withdraw<T0, T1, T2>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u32 {
        let (v0, v1, v2, v3) = rebalance_prologue<T0, T1, T2>(arg1, arg3);
        let v4 = v0;
        let (v5, v6) = if (v1 > 0) {
            0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::remove_liquidity<T0, T1>(arg0, 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position_mut<T0, T1, T2>(arg1), arg2, v4, position_shares<T0, T1, T2>(arg1, &v4), 0, 0, 4102444800000, arg3, arg4)
        } else {
            (0x2::coin::zero<T0>(arg4), 0x2::coin::zero<T1>(arg4))
        };
        rebalance_epilogue<T0, T1, T2>(arg1, v5, v6, v2, 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::active_bin_id<T0, T1>(arg0), v1, v3);
        v2
    }

    public(friend) fun rebalance_withdraw_x_sui<T0, T1>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<0x2::sui::SUI, T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u32 {
        let (v0, v1, v2, v3) = rebalance_prologue<0x2::sui::SUI, T0, T1>(arg1, arg4);
        let v4 = v0;
        let (v5, v6) = if (v1 > 0) {
            0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::remove_liquidity_x_sui<T0>(arg0, 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position_mut<0x2::sui::SUI, T0, T1>(arg1), arg2, v4, position_shares<0x2::sui::SUI, T0, T1>(arg1, &v4), arg3, 0, 0, 4102444800000, arg4, arg5)
        } else {
            (0x2::coin::zero<0x2::sui::SUI>(arg5), 0x2::coin::zero<T0>(arg5))
        };
        rebalance_epilogue<0x2::sui::SUI, T0, T1>(arg1, v5, v6, v2, 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::active_bin_id<0x2::sui::SUI, T0>(arg0), v1, v3);
        v2
    }

    fun sorted_center(arg0: vector<u32>) : u32 {
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::vec_sort::sort_u32(&mut arg0);
        if (0x1::vector::length<u32>(&arg0) > 0) {
            *0x1::vector::borrow<u32>(&arg0, 0x1::vector::length<u32>(&arg0) / 2)
        } else {
            0
        }
    }

    fun validate_and_deploy<T0, T1, T2>(arg0: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: &mut 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: u32, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u32>(&arg3);
        if (v0 == 0) {
            return
        };
        assert!(0x1::vector::length<u64>(&arg4) == v0 && 0x1::vector::length<u64>(&arg5) == v0, 107);
        let v1 = *0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::strategy_config<T0, T1, T2>(arg1);
        let v2 = 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::strategy_max_center_drift(&v1);
        assert!((v0 as u32) <= 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::strategy_num_bins(&v1), 106);
        let v3 = 1;
        while (v3 < v0) {
            assert!(*0x1::vector::borrow<u32>(&arg3, v3) == *0x1::vector::borrow<u32>(&arg3, v3 - 1) + 1, 105);
            v3 = v3 + 1;
        };
        assert_position_bin_capacity<T0, T1, T2>(arg1, &arg3);
        let v4 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::active_bin_id<T0, T1>(arg0);
        assert!(v4 >= *0x1::vector::borrow<u32>(&arg3, 0) && v4 <= *0x1::vector::borrow<u32>(&arg3, v0 - 1), 108);
        if (v2 > 0) {
            let v5 = *0x1::vector::borrow<u32>(&arg3, 0) + (v0 as u32) / 2;
            let v6 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::oracle_bin_id<T0, T1>(arg0);
            assert_keeper_gates_configured<T0, T1, T2>(arg1);
            assert_calm_zone<T0, T1, T2>(arg0, arg1, arg7);
            let v7 = if (v5 > v6) {
                v5 - v6
            } else {
                v6 - v5
            };
            assert!(v7 <= v2, 104);
        };
        let v8 = 0;
        let v9 = 0;
        v3 = 0;
        while (v3 < v0) {
            v8 = v8 + *0x1::vector::borrow<u64>(&arg4, v3);
            v9 = v9 + *0x1::vector::borrow<u64>(&arg5, v3);
            v3 = v3 + 1;
        };
        let (v10, v11) = 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::vault_balances<T0, T1, T2>(arg1);
        assert!(v8 <= v10 && v9 <= v11, 109);
        let (_, v13, v14) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::add_liquidity<T0, T1>(arg0, 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_position_mut<T0, T1, T2>(arg1), arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_balance_x_mut<T0, T1, T2>(arg1), v8), arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_balance_y_mut<T0, T1, T2>(arg1), v9), arg8), (((v8 as u128) * (9960 as u128) / (0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::bps_denom() as u128)) as u64), (((v9 as u128) * (9960 as u128) / (0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::bps_denom() as u128)) as u64), vector[], 0, 4294967295, arg7, arg8);
        let v15 = v14;
        let v16 = v13;
        0x2::balance::join<T0>(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_balance_x_mut<T0, T1, T2>(arg1), 0x2::coin::into_balance<T0>(v16));
        0x2::balance::join<T1>(0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::borrow_balance_y_mut<T0, T1, T2>(arg1), 0x2::coin::into_balance<T1>(v15));
        let v17 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::oracle_bin_id<T0, T1>(arg0);
        let v18 = if (v17 > 0) {
            v17
        } else {
            v4
        };
        let v19 = KeeperRebalanceEvent{
            vault_id         : 0x2::object::id<0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault::Vault<T0, T1, T2>>(arg1),
            old_center_bin   : arg6,
            new_center_bin   : *0x1::vector::borrow<u32>(&arg3, 0) + (v0 as u32) / 2,
            bins_deployed    : (v0 as u64),
            total_x_deployed : v8 - 0x2::coin::value<T0>(&v16),
            total_y_deployed : v9 - 0x2::coin::value<T1>(&v15),
            twap_bin         : v18,
            active_bin       : v4,
        };
        0x2::event::emit<KeeperRebalanceEvent>(v19);
    }

    // decompiled from Move bytecode v7
}

