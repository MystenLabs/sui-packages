module 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::rebase_math {
    struct SignedMagnitude has copy, drop, store {
        magnitude: u256,
        positive: bool,
    }

    struct RatioScaleResult has copy, drop, store {
        quotient: u128,
        remainder: u128,
    }

    struct StepFloorResult has copy, drop, store {
        value: u128,
        dust: u128,
    }

    struct TickRoundResult has copy, drop, store {
        value: u128,
        rounded_up: bool,
        distance: u128,
    }

    struct BaseMulResult has copy, drop, store {
        value: u128,
        residual: u128,
    }

    struct EquityResult has copy, drop, store {
        signed: SignedMagnitude,
        equity: u128,
        deficit: u128,
    }

    public fun absolute_deviation(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun add(arg0: SignedMagnitude, arg1: SignedMagnitude) : SignedMagnitude {
        if (arg0.positive == arg1.positive) {
            signed(arg0.magnitude + arg1.magnitude, arg0.positive)
        } else if (arg0.magnitude >= arg1.magnitude) {
            signed(arg0.magnitude - arg1.magnitude, arg0.positive)
        } else {
            signed(arg1.magnitude - arg0.magnitude, arg1.positive)
        }
    }

    public fun base_mul(arg0: u128, arg1: u128) : BaseMulResult {
        let v0 = (arg0 as u256) * (arg1 as u256);
        BaseMulResult{
            value    : checked_u128(v0 / 1000000000),
            residual : checked_u128(v0 % 1000000000),
        }
    }

    public fun base_mul_residual(arg0: BaseMulResult) : u128 {
        arg0.residual
    }

    public fun base_mul_value(arg0: BaseMulResult) : u128 {
        arg0.value
    }

    public fun checked_u128(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 3105);
        (arg0 as u128)
    }

    public fun equity(arg0: u128, arg1: SignedMagnitude, arg2: SignedMagnitude) : EquityResult {
        let v0 = add(add(signed_from_u128(arg0, true), arg1), arg2);
        let v1 = checked_u128(v0.magnitude);
        let v2 = if (v0.positive) {
            v1
        } else {
            0
        };
        let v3 = if (v0.positive) {
            0
        } else {
            v1
        };
        EquityResult{
            signed  : v0,
            equity  : v2,
            deficit : v3,
        }
    }

    public fun equity_deficit(arg0: EquityResult) : u128 {
        arg0.deficit
    }

    public fun equity_signed(arg0: EquityResult) : SignedMagnitude {
        arg0.signed
    }

    public fun equity_value(arg0: EquityResult) : u128 {
        arg0.equity
    }

    public fun gcd(arg0: u128, arg1: u128) : u128 {
        while (arg1 != 0) {
            arg1 = arg0 % arg1;
            arg0 = arg1;
        };
        arg0
    }

    public fun is_zero(arg0: SignedMagnitude) : bool {
        arg0.magnitude == 0
    }

    public fun negate(arg0: SignedMagnitude) : SignedMagnitude {
        signed(arg0.magnitude, !arg0.positive)
    }

    public fun optimal_step_quantity(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg1 > 0, 3121);
        assert!(arg2 > 0, 3102);
        let v0 = checked_u128((arg0 as u256) * 1000000000 / (arg1 as u256));
        let v1 = v0 - v0 % arg2;
        let v2 = (v1 as u256) + (arg2 as u256);
        if (v2 > 340282366920938463463374607431768211455) {
            return v1
        };
        let v3 = (v2 as u128);
        if (absolute_deviation(arg0, base_mul_value(base_mul(v1, arg1))) <= absolute_deviation(arg0, base_mul_value(base_mul(v3, arg1)))) {
            v1
        } else {
            v3
        }
    }

    public fun ratio_quotient(arg0: RatioScaleResult) : u128 {
        arg0.quotient
    }

    public fun ratio_remainder(arg0: RatioScaleResult) : u128 {
        arg0.remainder
    }

    public fun reduce_ratio(arg0: u128, arg1: u128) : (u128, u128) {
        assert!(arg0 > 0 && arg1 > 0, 3100);
        assert!(arg0 != arg1, 3101);
        let v0 = gcd(arg0, arg1);
        (arg0 / v0, arg1 / v0)
    }

    public fun round_to_step(arg0: u128, arg1: u128) : StepFloorResult {
        assert!(arg1 > 0, 3102);
        let v0 = arg0 % arg1;
        if (v0 == 0) {
            return StepFloorResult{
                value : arg0,
                dust  : 0,
            }
        };
        let v1 = arg1 - v0;
        let v2 = v0 <= v1;
        let v3 = if (v2) {
            arg0 - v0
        } else {
            checked_u128(((arg0 - v0) as u256) + (arg1 as u256))
        };
        let v4 = if (v2) {
            v0
        } else {
            v1
        };
        StepFloorResult{
            value : v3,
            dust  : v4,
        }
    }

    public fun round_to_tick(arg0: u128, arg1: u128) : TickRoundResult {
        assert!(arg1 > 0, 3103);
        let v0 = arg0 % arg1;
        if (v0 == 0) {
            return TickRoundResult{
                value      : arg0,
                rounded_up : false,
                distance   : 0,
            }
        };
        if ((v0 as u256) * 2 > (arg1 as u256)) {
            let v2 = arg1 - v0;
            TickRoundResult{value: checked_u128((arg0 as u256) + (v2 as u256)), rounded_up: true, distance: v2}
        } else {
            TickRoundResult{value: arg0 - v0, rounded_up: false, distance: v0}
        }
    }

    public fun scale_ratio(arg0: u128, arg1: u128, arg2: u128) : RatioScaleResult {
        assert!(arg1 > 0 && arg2 > 0, 3100);
        let v0 = (arg0 as u256) * (arg1 as u256);
        let v1 = (arg2 as u256);
        RatioScaleResult{
            quotient  : checked_u128(v0 / v1),
            remainder : checked_u128(v0 % v1),
        }
    }

    public fun signed(arg0: u256, arg1: bool) : SignedMagnitude {
        let v0 = arg0 == 0 || arg1;
        SignedMagnitude{
            magnitude : arg0,
            positive  : v0,
        }
    }

    public fun signed_from_u128(arg0: u128, arg1: bool) : SignedMagnitude {
        signed((arg0 as u256), arg1)
    }

    public fun signed_magnitude(arg0: SignedMagnitude) : u256 {
        arg0.magnitude
    }

    public fun signed_positive(arg0: SignedMagnitude) : bool {
        arg0.positive
    }

    public fun step_dust(arg0: StepFloorResult) : u128 {
        arg0.dust
    }

    public fun step_rounding_delta_numerator(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : SignedMagnitude {
        let v0 = (arg0 as u256) * (arg3 as u256);
        let v1 = (arg1 as u256) * (arg2 as u256);
        if (v0 >= v1) {
            signed(v0 - v1, true)
        } else {
            signed(v1 - v0, false)
        }
    }

    public fun step_value(arg0: StepFloorResult) : u128 {
        arg0.value
    }

    public fun subtract(arg0: SignedMagnitude, arg1: SignedMagnitude) : SignedMagnitude {
        add(arg0, negate(arg1))
    }

    public fun tick_distance(arg0: TickRoundResult) : u128 {
        arg0.distance
    }

    public fun tick_rounded_up(arg0: TickRoundResult) : bool {
        arg0.rounded_up
    }

    public fun tick_value(arg0: TickRoundResult) : u128 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

