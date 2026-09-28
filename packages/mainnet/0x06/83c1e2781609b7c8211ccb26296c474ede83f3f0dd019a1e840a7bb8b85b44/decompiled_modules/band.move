module 0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::band {
    struct Params has copy, drop, store {
        margin_bps: u64,
        lo_bps: u64,
        hi_bps: u64,
        drift_bps: u64,
    }

    struct Plan has copy, drop {
        due: bool,
        cash_to_margin: u64,
        margin_to_cash: u64,
        grow_notional: u64,
        shrink_notional: u64,
    }

    public fun check(arg0: &Params) {
        let v0 = if (arg0.lo_bps < arg0.margin_bps) {
            if (arg0.margin_bps < arg0.hi_bps) {
                arg0.hi_bps < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 400);
        assert!(arg0.drift_bps > 0 && arg0.drift_bps <= 5000, 400);
    }

    public fun default_params() : Params {
        Params{
            margin_bps : 8000,
            lo_bps     : 7500,
            hi_bps     : 8500,
            drift_bps  : 1000,
        }
    }

    public fun defend_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div_up(arg1, 10000, arg2);
        let v1 = 0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div_up(0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div_up(0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div_up(arg1, arg3, 10000), arg4, 10000), 12000, 10000);
        let v2 = if (v0 > v1) {
            v0
        } else {
            v1
        };
        let v3 = if (v2 > arg0) {
            v2 - arg0
        } else {
            0
        };
        if (v3 > arg5) {
            arg5
        } else {
            v3
        }
    }

    public fun in_danger(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg1 == 0) {
            return false
        };
        arg0 < 0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div(0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div(arg1, arg2, 10000), arg3, 10000)
    }

    public fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : Params {
        let v0 = Params{
            margin_bps : arg0,
            lo_bps     : arg1,
            hi_bps     : arg2,
            drift_bps  : arg3,
        };
        check(&v0);
        v0
    }

    public fun plan(arg0: &Params, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Plan {
        let v0 = Plan{
            due             : false,
            cash_to_margin  : 0,
            margin_to_cash  : 0,
            grow_notional   : 0,
            shrink_notional : 0,
        };
        if (arg1 == 0) {
            return v0
        };
        let v1 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            0
        };
        let v2 = 0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div(v1, 10000, arg1);
        let v3 = target_margin(arg0, arg1);
        let v4 = 0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div(v3, arg4, 10000);
        let v5 = v4 == 0 && arg3 == 0 || 0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div(0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::diff(arg3, v4), 10000, v4) <= arg0.drift_bps;
        let v6 = if (v2 >= arg0.lo_bps) {
            if (v2 <= arg0.hi_bps) {
                v5
            } else {
                false
            }
        } else {
            false
        };
        if (v6) {
            return v0
        };
        let v7 = if (v3 > v1) {
            v3 - v1
        } else {
            0
        };
        let v8 = if (v1 > v3) {
            v1 - v3
        } else {
            0
        };
        let v9 = if (v4 > arg3) {
            v4 - arg3
        } else {
            0
        };
        let v10 = if (arg3 > v4) {
            arg3 - v4
        } else {
            0
        };
        Plan{
            due             : true,
            cash_to_margin  : v7,
            margin_to_cash  : v8,
            grow_notional   : v9,
            shrink_notional : v10,
        }
    }

    public fun plan_parts(arg0: &Plan) : (bool, u64, u64, u64, u64) {
        (arg0.due, arg0.cash_to_margin, arg0.margin_to_cash, arg0.grow_notional, arg0.shrink_notional)
    }

    public fun target_margin(arg0: &Params, arg1: u64) : u64 {
        0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div(arg1, arg0.margin_bps, 10000)
    }

    public fun target_notional(arg0: &Params, arg1: u64, arg2: u64) : u64 {
        0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::math::mul_div(target_margin(arg0, arg1), arg2, 10000)
    }

    // decompiled from Move bytecode v7
}

