module 0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::kai_leverage_supply_pool {
    struct REBALANCE has drop {
        dummy_field: bool,
    }

    struct PROFIT_COMPOUND has drop {
        dummy_field: bool,
    }

    public fun collect_and_hand_over_profit<T0, T1, T2>(arg0: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::Strategy<T0, T1>, arg1: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg2: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<T0, T2>, arg3: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::SupplyPool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_compound(arg1, arg5);
        let v0 = 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::admin_cap_id<T0, T1>(arg0);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::collect_and_hand_over_profit<T0, T1, T2>(arg0, 0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::borrow_strategy_cap_by_id<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::AdminCap>(arg1, &v0), arg2, arg3, arg4);
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::Strategy<T0, T1>, arg1: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg2: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<T0, T2>, arg3: &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::RebalanceAmounts, arg4: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::SupplyPool<T0, T1>, arg5: &0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::Policy, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_rebalance(arg1, arg8);
        let v0 = 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::admin_cap_id<T0, T1>(arg0);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::rebalance<T0, T1, T2>(arg0, 0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::borrow_strategy_cap_by_id<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::AdminCap>(arg1, &v0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun allow_profit_compound_for_address(arg0: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::MasterCap, arg1: &mut 0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg2: address) {
        let v0 = PROFIT_COMPOUND{dummy_field: false};
        0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::allow_action_for_address<PROFIT_COMPOUND>(arg0, arg1, arg2, v0);
    }

    public entry fun allow_rebalance_for_address(arg0: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::MasterCap, arg1: &mut 0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg2: address) {
        let v0 = REBALANCE{dummy_field: false};
        0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::allow_action_for_address<REBALANCE>(arg0, arg1, arg2, v0);
    }

    fun assert_compound(arg0: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg1: &0x2::tx_context::TxContext) {
        assert!(0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::action_allowed<PROFIT_COMPOUND>(arg0, 0x2::tx_context::sender(arg1)), 1);
    }

    fun assert_rebalance(arg0: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg1: &0x2::tx_context::TxContext) {
        assert!(0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::action_allowed<REBALANCE>(arg0, 0x2::tx_context::sender(arg1)), 0);
    }

    public entry fun put_strategy_cap_to_keychain(arg0: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::MasterCap, arg1: &mut 0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg2: 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::AdminCap) {
        0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::master_put_strategy_cap_by_id<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::AdminCap>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

