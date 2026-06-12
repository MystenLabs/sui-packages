module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator {
    struct SignedValue has copy, drop, store {
        value: u64,
        is_negative: bool,
    }

    struct MarginSummary has copy, drop, store {
        notional_value: u64,
        initial_margin_required: u64,
        maintenance_margin_required: u64,
        unrealized_pnl: SignedValue,
        account_equity: SignedValue,
        margin_ratio_scaled: 0x1::option::Option<u64>,
        meets_initial_margin: bool,
        meets_maintenance_margin: bool,
    }

    public fun compute_account_equity(arg0: u64, arg1: SignedValue, arg2: u64) : SignedValue {
        let v0 = (arg0 as u128);
        let v1 = v0;
        let v2 = (arg2 as u128);
        let v3 = v2;
        if (arg1.is_negative) {
            v3 = v2 + (arg1.value as u128);
        } else {
            v1 = v0 + (arg1.value as u128);
        };
        if (v1 >= v3) {
            SignedValue{value: ((v1 - v3) as u64), is_negative: false}
        } else {
            SignedValue{value: ((v3 - v1) as u64), is_negative: true}
        }
    }

    public fun compute_initial_margin(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 1);
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun compute_maintenance_margin(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 2);
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun compute_margin_ratio(arg0: SignedValue, arg1: u64) : 0x1::option::Option<u64> {
        assert!(arg1 > 0, 0);
        if (arg0.is_negative) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((((arg0.value as u128) * 1000000000 / (arg1 as u128)) as u64))
    }

    public fun compute_margin_summary(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : MarginSummary {
        let v0 = compute_notional_value(arg0, arg2);
        let v1 = compute_initial_margin(v0, arg6);
        let v2 = compute_maintenance_margin(v0, arg7);
        let v3 = compute_unrealized_pnl(arg0, arg1, arg2, arg3);
        let v4 = compute_account_equity(arg4, v3, arg5);
        let v5 = if (v0 == 0) {
            0x1::option::none<u64>()
        } else {
            compute_margin_ratio(v4, v0)
        };
        let v6 = v4.is_negative && false || v4.value >= v1;
        let v7 = v4.is_negative && false || v4.value >= v2;
        MarginSummary{
            notional_value              : v0,
            initial_margin_required     : v1,
            maintenance_margin_required : v2,
            unrealized_pnl              : v3,
            account_equity              : v4,
            margin_ratio_scaled         : v5,
            meets_initial_margin        : v6,
            meets_maintenance_margin    : v7,
        }
    }

    public fun compute_notional_value(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    public fun compute_unrealized_pnl(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : SignedValue {
        let (v0, v1) = if (arg3) {
            if (arg2 >= arg1) {
                (arg2 - arg1, false)
            } else {
                (arg1 - arg2, true)
            }
        } else if (arg1 >= arg2) {
            (arg1 - arg2, false)
        } else {
            (arg2 - arg1, true)
        };
        SignedValue{
            value       : (((arg0 as u128) * (v0 as u128) / 1000000000) as u64),
            is_negative : v1,
        }
    }

    public fun direction_long() : bool {
        true
    }

    public fun direction_short() : bool {
        false
    }

    public fun signed_is_negative(arg0: &SignedValue) : bool {
        arg0.is_negative
    }

    public fun signed_value(arg0: &SignedValue) : u64 {
        arg0.value
    }

    public fun summary_account_equity(arg0: &MarginSummary) : SignedValue {
        arg0.account_equity
    }

    public fun summary_initial_margin_required(arg0: &MarginSummary) : u64 {
        arg0.initial_margin_required
    }

    public fun summary_is_underwater(arg0: &MarginSummary) : bool {
        arg0.notional_value > 0 && arg0.account_equity.is_negative
    }

    public fun summary_maintenance_margin_required(arg0: &MarginSummary) : u64 {
        arg0.maintenance_margin_required
    }

    public fun summary_margin_ratio_scaled(arg0: &MarginSummary) : 0x1::option::Option<u64> {
        arg0.margin_ratio_scaled
    }

    public fun summary_meets_initial_margin(arg0: &MarginSummary) : bool {
        arg0.meets_initial_margin
    }

    public fun summary_meets_maintenance_margin(arg0: &MarginSummary) : bool {
        arg0.meets_maintenance_margin
    }

    public fun summary_notional_value(arg0: &MarginSummary) : u64 {
        arg0.notional_value
    }

    public fun summary_unrealized_pnl(arg0: &MarginSummary) : SignedValue {
        arg0.unrealized_pnl
    }

    // decompiled from Move bytecode v7
}

