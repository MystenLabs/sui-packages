module 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market_admin_entry {
    public entry fun create_market_typed<T0, T1>(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::farming_core::Farming, arg2: &0xefa479281ee250c8a8eeac213648fd19c77e23d805d8b4ff618276aa628ce2be::pyth_oracle::Oracle, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::farming_core::create_borrow_pool<T0>(arg1, arg0, 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::create_market_typed<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11), arg11);
    }

    public entry fun enable_lltv(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::enable_lltv(arg0, arg1, arg2);
    }

    public entry fun migrate(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: &0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::migrate(arg0, arg1);
    }

    public entry fun set_fee(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_fee(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_fee_recipient(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_fee_recipient(arg0, arg1, arg2);
    }

    public entry fun set_flashloan_fee(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_flashloan_fee(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_global_pause(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_global_pause(arg0, arg1, arg2);
    }

    public entry fun set_market_borrow_pause(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: vector<u64>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_market_borrow_pause(arg0, *0x1::vector::borrow<u64>(&arg1, v0), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun set_market_pause(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: vector<u64>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_market_pause(arg0, *0x1::vector::borrow<u64>(&arg1, v0), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun set_market_repay_pause(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: vector<u64>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_market_repay_pause(arg0, *0x1::vector::borrow<u64>(&arg1, v0), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun set_market_supply_collateral_pause(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: vector<u64>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_market_supply_collateral_pause(arg0, *0x1::vector::borrow<u64>(&arg1, v0), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun set_market_supply_pause(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: vector<u64>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_market_supply_pause(arg0, *0x1::vector::borrow<u64>(&arg1, v0), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun set_market_withdraw_collateral_pause(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: vector<u64>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_market_withdraw_collateral_pause(arg0, *0x1::vector::borrow<u64>(&arg1, v0), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun set_market_withdraw_pause(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: vector<u64>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_market_withdraw_pause(arg0, *0x1::vector::borrow<u64>(&arg1, v0), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun set_owner(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::set_owner(arg0, arg1, arg2);
    }

    public entry fun update_market_liquidation_bonus(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::update_market_liquidation_bonus(arg0, arg1, arg2, arg3);
    }

    public entry fun update_market_ltv(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::update_market_ltv(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

