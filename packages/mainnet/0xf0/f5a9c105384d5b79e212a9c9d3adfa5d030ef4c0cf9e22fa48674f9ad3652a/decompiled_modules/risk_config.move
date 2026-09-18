module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config {
    struct RiskConfig has copy, drop, store {
        collateral_factor: u16,
        liquidation_threshold: u16,
        liquidation_max_limit: u16,
        withdraw_gap: u16,
        liquidation_penalty: u16,
        borrow_fee: u8,
    }

    public fun borrow_fee(arg0: &RiskConfig) : u8 {
        arg0.borrow_fee
    }

    public fun check_liquidation_max_limit_and_penalty(arg0: u16, arg1: u16) {
        assert!(arg0 + arg1 <= 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_liquidation_penalty(), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_value_above_limit());
    }

    public fun collateral_factor(arg0: &RiskConfig) : u16 {
        arg0.collateral_factor
    }

    public fun liquidation_max_limit(arg0: &RiskConfig) : u16 {
        arg0.liquidation_max_limit
    }

    public fun liquidation_penalty(arg0: &RiskConfig) : u16 {
        arg0.liquidation_penalty
    }

    public fun liquidation_threshold(arg0: &RiskConfig) : u16 {
        arg0.liquidation_threshold
    }

    public fun new(arg0: u16, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u8) : RiskConfig {
        check_liquidation_max_limit_and_penalty(arg2, arg4);
        let v0 = arg0 / 10;
        let v1 = arg1 / 10;
        let v2 = arg2 / 10;
        let v3 = arg3 / 10;
        let v4 = if (v0 >= v1) {
            true
        } else if (v1 >= v2) {
            true
        } else if ((v3 as u128) > 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::three_decimals()) {
            true
        } else if ((arg4 as u128) > 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::x10()) {
            true
        } else {
            arg5 > 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_borrow_fee()
        };
        assert!(!v4, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_value_above_limit());
        RiskConfig{
            collateral_factor     : v0,
            liquidation_threshold : v1,
            liquidation_max_limit : v2,
            withdraw_gap          : v3,
            liquidation_penalty   : arg4,
            borrow_fee            : arg5,
        }
    }

    public fun withdraw_gap(arg0: &RiskConfig) : u16 {
        arg0.withdraw_gap
    }

    // decompiled from Move bytecode v7
}

