module 0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::scallop_sui_proper {
    struct REBALANCE has drop {
        dummy_field: bool,
    }

    struct PROFIT_COMPOUND has drop {
        dummy_field: bool,
    }

    public fun collect_and_hand_over_profit(arg0: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg1: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::Strategy, arg2: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<0x2::sui::SUI, 0xb8dc843a816b51992ee10d2ddc6d28aab4f0a1d651cd7289a7897902eb631613::ysui::YSUI>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_compound(arg0, arg6);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::collect_and_hand_over_profit(0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::borrow_strategy_cap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::AdminCap>(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun rebalance(arg0: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg1: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::Strategy, arg2: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<0x2::sui::SUI, 0xb8dc843a816b51992ee10d2ddc6d28aab4f0a1d651cd7289a7897902eb631613::ysui::YSUI>, arg3: &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::RebalanceAmounts, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_rebalance(arg0, arg8);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::rebalance(0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::borrow_strategy_cap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::AdminCap>(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun skim_base_profits(arg0: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg1: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::Strategy, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_compound(arg0, arg6);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::skim_base_profits(0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::borrow_strategy_cap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::AdminCap>(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
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

    public entry fun put_strategy_cap_to_keychain(arg0: &0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::MasterCap, arg1: &mut 0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::Keychain, arg2: 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::AdminCap) {
        0x34adce5ef86f2af51ac26637f1d7f9ef3f5f7a800d49f2ec6c2452f17091eda9::keychain::master_put_strategy_cap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_sui_proper::AdminCap>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

