module 0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::optimizer {
    struct ExecutionPolicy has copy, drop, store {
        bolt: vector<0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::State>,
        fractional_input_fee: bool,
        omm_update_flag: bool,
        linear_rate_inversion: bool,
        input_minimum: u128,
        input_capacity: u128,
        output_capacity: u128,
        stop_at_zero_liquidity: bool,
        momentum_fee_round_nearest: bool,
        auxiliary_fee_rate: u64,
        auxiliary_fee_denominator: u64,
    }

    struct Hop has copy, drop, store {
        kind: u8,
        policy: ExecutionPolicy,
        fee_rate: u64,
        fee_denominator: u64,
        output_fee_rate: u64,
        output_fee_denominator: u64,
        reserve_in: u128,
        reserve_out: u128,
        sqrt_price_x64: u128,
        liquidity: u128,
        zero_for_one: bool,
        boundaries: vector<TickBoundary>,
        boundary_cursor: u64,
        orderbook_segments: vector<OrderbookSegment>,
        orderbook_cursor: u64,
        orderbook_lot_size: u128,
        orderbook_min_size: u128,
        orderbook_consumed_base: u128,
        orderbook_base_to_quote: bool,
        orderbook_has_more: bool,
        linear_segments: vector<LinearSegment>,
        linear_cursor: u64,
        linear_has_more: bool,
        stable_amp: u128,
        stable_scale_in: u128,
        stable_scale_out: u128,
        stable_admin_fee: u64,
        stable_lp_fee: u64,
        stable_th_fee: u64,
        stable_fee_on_input: bool,
        state_status: u8,
    }

    struct StagedHop has copy, drop, store {
        kind: u8,
        liquidity: u128,
        boundaries: vector<TickBoundary>,
        replacement: vector<Hop>,
    }

    struct OptimizeState has drop {
        route: vector<Hop>,
        validation_route: vector<Hop>,
        max_amount_in: u128,
        max_segments: u64,
        cursor: u128,
        cursor_output: u128,
        result: OptimizeResult,
        finished: bool,
    }

    struct BoltFixedHop has drop {
        is_bolt: bool,
        bolt: vector<0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::State>,
        input_capacity: u128,
        input_minimum: u128,
        output_capacity: u128,
        cpmm: PreparedCpmm,
    }

    struct AftermathSigned has copy, drop {
        negative: bool,
        magnitude: u256,
    }

    struct TickBoundary has copy, drop, store {
        sqrt_price_x64: u128,
        liquidity_net_abs: u128,
        negative: bool,
    }

    struct V3Prefix has copy, drop, store {
        cumulative_input: u128,
        crossing_input: u128,
        cumulative_output: u128,
        end_sqrt_price_x64: u128,
        liquidity_after: u128,
    }

    struct V3PrefixCache has drop {
        prefixes: vector<V3Prefix>,
        status: u8,
        boundary_cursor: u64,
        fee_denominator: u64,
        fee_rate: u64,
        liquidity: u128,
        policy_output_capacity: u128,
        policy_stop_at_zero_liquidity: bool,
        momentum_fee_round_nearest: bool,
        sqrt_price_x64: u128,
        zero_for_one: bool,
    }

    struct PreparedCpmm has drop {
        fractional: bool,
        reserves_valid: bool,
        reserve_in: u128,
        reserve_out: u256,
        scaled_reserve_in: u256,
        input_factor: u256,
        input_denominator: u256,
        output_factor: u256,
        output_denominator: u256,
    }

    struct OrderbookSegment has copy, drop, store {
        price: u128,
        remaining_base: u128,
    }

    struct LinearSegment has copy, drop, store {
        remaining_input: u128,
        remaining_output: u128,
        price_x64: u128,
        fee_rate: u64,
        fee_denominator: u64,
        forward: bool,
        exact_dlmm: bool,
    }

    struct OrderbookPrefix has copy, drop {
        minimum_input: u128,
        spent: u128,
        output: u128,
        base: u128,
    }

    struct OrderbookShortfall has copy, drop {
        prefixes: vector<OrderbookPrefix>,
        minimum_gross: u128,
        crossed: u64,
    }

    struct OptimizeResult has copy, drop, store {
        found: bool,
        complete: bool,
        coarse_rejected: bool,
        amount_in: u128,
        amount_out: u128,
        gross_profit: u128,
        segments: u64,
        crossed_ticks: u64,
        crossed_orders: u64,
        needs_more_hop: u64,
        status: u8,
        evaluations: u64,
    }

    struct ProgressiveSample has copy, drop {
        amount: u128,
        output: u128,
        fee: u256,
        work: u64,
        negative: bool,
        magnitude: u256,
        status: u8,
    }

    struct SearchTail has drop {
        maximum: u128,
        checks_left: u64,
        loss_input: u128,
        loss_output: u128,
    }

    public fun advance_empty_boundaries(arg0: &vector<TickBoundary>, arg1: &mut u64, arg2: &mut u128, arg3: &mut u128, arg4: bool) : u64 {
        let v0 = 0;
        while (*arg2 == 0 && *arg1 < 0x1::vector::length<TickBoundary>(arg0)) {
            let v1 = *0x1::vector::borrow<TickBoundary>(arg0, *arg1);
            *arg3 = v1.sqrt_price_x64;
            apply_boundary_liquidity(arg2, arg4, v1);
            *arg1 = *arg1 + 1;
            v0 = v0 + 1;
        };
        v0
    }

    fun advance_route(arg0: &mut vector<Hop>, arg1: u128) : (u128, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            let v4 = 0x1::vector::borrow_mut<Hop>(arg0, v3);
            let v5 = v0;
            if (v4.kind == 0) {
                let (v6, v7, v8) = advance_segment_v2(v4.output_fee_denominator, v4.output_fee_rate, v4.reserve_in, v4.reserve_out, effective_input(v0, v4.fee_rate, v4.fee_denominator));
                v4.reserve_in = v7;
                v4.reserve_out = v8;
                v0 = v6;
            } else if (v4.kind == 1) {
                let (v9, v10, v11, v12, v13) = advance_segment_v3(&v4.boundaries, v4.boundary_cursor, v4.liquidity, v4.policy.stop_at_zero_liquidity, v4.sqrt_price_x64, v4.zero_for_one, effective_input(v0, v4.fee_rate, v4.fee_denominator));
                v4.sqrt_price_x64 = v10;
                v4.liquidity = v11;
                v4.boundary_cursor = v12;
                v0 = v9;
                v1 = v1 + v13;
            } else if (v4.kind == 2) {
                let v14 = &mut v4.orderbook_segments;
                let (v15, v16, v17, v18) = advance_segment_orderbook(v4.kind, v4.orderbook_base_to_quote, v4.orderbook_consumed_base, v4.orderbook_cursor, v4.orderbook_has_more, v4.orderbook_lot_size, v14, effective_input(v0, v4.fee_rate, v4.fee_denominator));
                v4.orderbook_consumed_base = v16;
                v4.orderbook_cursor = v17;
                v0 = v15;
                v2 = v2 + v18;
            } else {
                assert!(v4.kind == 3, 1);
                let v19 = &mut v4.linear_segments;
                let (v20, v21) = advance_segment_linear(v4.kind, v4.linear_cursor, v4.linear_has_more, v19, effective_input(v0, v4.fee_rate, v4.fee_denominator));
                v4.linear_cursor = v21;
                v0 = v20;
            };
            assert!(v5 <= v4.policy.input_capacity && v0 <= v4.policy.output_capacity, 3);
            if (v4.policy.input_capacity < 340282366920938463463374607431768211455) {
                v4.policy.input_capacity = v4.policy.input_capacity - v5;
            };
            if (v4.policy.output_capacity < 340282366920938463463374607431768211455) {
                v4.policy.output_capacity = v4.policy.output_capacity - v0;
            };
            let v22 = if (v5 >= v4.policy.input_minimum) {
                0
            } else {
                v4.policy.input_minimum - v5
            };
            v4.policy.input_minimum = v22;
            v3 = v3 + 1;
        };
        (v0, v1, v2)
    }

    public fun advance_segment_linear(arg0: u8, arg1: u64, arg2: bool, arg3: &mut vector<LinearSegment>, arg4: u128) : (u128, u64) {
        assert!(!linear_terminal(arg0, arg1, arg2, arg3), 3);
        let v0 = quote_linear_segment(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x1::vector::borrow_mut<LinearSegment>(arg3, arg1);
        assert!(arg4 <= v1.remaining_input, 3);
        v1.remaining_input = v1.remaining_input - arg4;
        v1.remaining_output = v1.remaining_output - v0;
        if (v1.remaining_input == 0) {
            assert!(v1.remaining_output == 0, 3);
            arg1 = arg1 + 1;
        };
        (v0, arg1)
    }

    public fun advance_segment_orderbook(arg0: u8, arg1: bool, arg2: u128, arg3: u64, arg4: bool, arg5: u128, arg6: &mut vector<OrderbookSegment>, arg7: u128) : (u128, u128, u64, u64) {
        let v0 = 0;
        let v1 = v0;
        assert!(!orderbook_terminal(arg0, arg3, arg4, arg6), 3);
        let (v2, v3) = quote_orderbook_segment_and_consumed_base(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
        let v4 = 0x1::vector::borrow_mut<OrderbookSegment>(arg6, arg3);
        v4.remaining_base = v4.remaining_base - v3;
        if (v4.remaining_base == 0) {
            arg3 = arg3 + 1;
            v1 = v0 + 1;
        };
        (v2, arg2 + v3, arg3, v1)
    }

    public fun advance_segment_v2(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : (u128, u128, u128) {
        let v0 = mul_div_down(arg4, arg3, arg2 + arg4);
        (effective_output(v0, arg1, arg0), arg2 + arg4, arg3 - v0)
    }

    public fun advance_segment_v3(arg0: &vector<TickBoundary>, arg1: u64, arg2: u128, arg3: bool, arg4: u128, arg5: bool, arg6: u128) : (u128, u128, u128, u64, u64) {
        let v0 = 0;
        let v1 = v0;
        let v2 = *0x1::vector::borrow<TickBoundary>(arg0, arg1);
        let (v3, v4) = if (arg6 == 0) {
            let v3 = arg4;
            (v3, 0)
        } else {
            let v5 = next_sqrt_price(arg2, arg3, arg4, arg5, arg6, v2.sqrt_price_x64);
            let v6 = if (arg5) {
                mul_div_down(arg2, arg4 - v5, 18446744073709551616)
            } else {
                amount0_delta_down(arg4, v5, arg2)
            };
            (v5, v6)
        };
        arg4 = v3;
        if (v3 == v2.sqrt_price_x64) {
            let v7 = &mut arg2;
            apply_boundary_liquidity(v7, arg5, v2);
            let v8 = arg1;
            arg1 = v8 + 1;
            let v9 = &mut arg1;
            let v10 = &mut arg2;
            let v11 = &mut arg4;
            v1 = v0 + 1 + advance_empty_boundaries(arg0, v9, v10, v11, arg5);
        };
        (v4, arg4, arg2, arg1, v1)
    }

    public fun affine_linear(arg0: &vector<LinearSegment>) : (bool, u256, u256) {
        let v0 = 0x1::vector::borrow<LinearSegment>(arg0, 0);
        if (v0.exact_dlmm || v0.remaining_input != 18446744073709551616) {
            return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        };
        (true, saturating_add((v0.remaining_output as u256), 2), 0)
    }

    public fun affine_ratio(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u128, arg6: u128) : (bool, u256, u256) {
        let v0 = if (arg2 == 10 || arg2 == 11) {
            1
        } else {
            0
        };
        (true, mul_fraction_ceil(mul_fraction_ceil(mul_ratio_up_saturating(q64(), (arg6 as u256), (arg5 as u256)), ((arg0 - arg1) as u256), (arg0 as u256)), ((arg3 - arg4) as u256), (arg3 as u256)), v0)
    }

    public fun affine_steamm_cpmm(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128) : (bool, u256, u256) {
        let (v0, v1) = steamm_btoken_supplies(arg4);
        (true, mul_ratio_up_saturating(mul_fraction_ceil(mul_ratio_up_saturating(mul_ratio_up_saturating(q64(), (v0 as u256) * 1000000000000000000, (arg5 as u256)), (arg3 as u256), (arg2 as u256)), ((arg0 - arg1) as u256), (arg0 as u256)), (arg6 as u256), (v1 as u256) * 1000000000000000000), 0)
    }

    public fun affine_steamm_omm(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u128) : (bool, u256, u256) {
        let (_, v1) = steamm_btoken_supplies(arg5);
        let v2 = (arg7 as u256) / (v1 as u256);
        if (v2 == 0) {
            return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        };
        let v3 = mul_ratio_up_saturating(q64(), (arg3 as u256), (arg0 as u256));
        let v4 = 0;
        loop {
            let v5 = if (arg4 > arg6) {
                arg4 - arg6
            } else {
                arg6 - arg4
            };
            if (v4 < v5) {
                let v6 = if (arg4 > arg6) {
                    div_ceil(v3, 10)
                } else {
                    saturating_mul(v3, 10)
                };
                v3 = v6;
                v4 = v4 + 1;
            } else {
                break
            };
        };
        (true, mul_ratio_up_saturating(mul_fraction_ceil(v3, ((arg1 - arg2) as u256), (arg1 as u256)), (arg7 as u256), (v1 as u256) * v2), 0)
    }

    public fun affine_virtual_cpmm(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool) : (bool, u256, u256) {
        let v0 = if (arg8) {
            arg2
        } else {
            arg3
        };
        let v1 = (arg4 as u256) * (arg5 as u256);
        let v2 = v1 * v1 * (arg6 as u256) / (arg7 as u256);
        let v3 = v1 + (v0 as u256) - (arg4 as u256);
        if (v3 == 0 || v2 == 0) {
            return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        };
        let v4 = if (arg8) {
            if (v3 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v3) {
                return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
            };
            mul_ratio_up_saturating(q64(), v2, v3 * v3)
        } else {
            let v5 = v2 / v3;
            if (v5 == 0) {
                return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
            };
            mul_ratio_up_saturating(q64(), v3, v5)
        };
        (true, mul_fraction_ceil(v4, ((arg0 - arg1) as u256), (arg0 as u256)), 2)
    }

    public fun aftermath_a20(arg0: u64) : u256 {
        if (arg0 == 2) {
            7896296018268069516100000000000000
        } else if (arg0 == 3) {
            888611052050787263676000000
        } else if (arg0 == 4) {
            298095798704172827474000
        } else if (arg0 == 5) {
            5459815003314423907810
        } else if (arg0 == 6) {
            738905609893065022723
        } else if (arg0 == 7) {
            271828182845904523536
        } else if (arg0 == 8) {
            164872127070012814685
        } else if (arg0 == 9) {
            128402541668774148407
        } else if (arg0 == 10) {
            113314845306682631683
        } else {
            assert!(arg0 == 11, 3);
            106449445891785942956
        }
    }

    public fun aftermath_exp(arg0: AftermathSigned) : u256 {
        if (arg0.negative) {
            return 1000000000000000000 * 1000000000000000000 / aftermath_exp(aftermath_signed_neg(arg0))
        };
        let v0 = arg0.magnitude;
        let v1 = v0;
        let v2 = if (v0 >= 128000000000000000000) {
            v1 = v0 - 128000000000000000000;
            38877084059945950922200000000000000000000000000000000000
        } else if (v0 >= 64000000000000000000) {
            v1 = v0 - 64000000000000000000;
            6235149080811616882910000000
        } else {
            1
        };
        v1 = v1 * 100;
        let v3 = 100000000000000000000;
        let v4 = 2;
        while (v4 <= 9) {
            let v5 = aftermath_x20(v4);
            if (v1 >= v5) {
                v1 = v1 - v5;
                let v6 = v3 * aftermath_a20(v4);
                v3 = v6 / 100000000000000000000;
            };
            v4 = v4 + 1;
        };
        let v7 = v1;
        let v8 = 100000000000000000000 + v1;
        v4 = 2;
        while (v4 <= 12) {
            v7 = v7 * v1 / 100000000000000000000 / (v4 as u256);
            v8 = v8 + v7;
            v4 = v4 + 1;
        };
        v3 * v8 / 100000000000000000000 * v2 / 100
    }

    public fun aftermath_fixed_div_down(arg0: u256, arg1: u256) : u256 {
        arg0 * 1000000000000000000 / arg1
    }

    public fun aftermath_fixed_div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 * 1000000000000000000 - 1) / arg1 + 1
        }
    }

    public fun aftermath_fixed_mul_down(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000
    }

    public fun aftermath_fixed_mul_up(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 * arg1;
        if (v0 == 0) {
            0
        } else {
            (v0 - 1) / 1000000000000000000 + 1
        }
    }

    public fun aftermath_geometric_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: bool) : Hop {
        let v0 = if (!arg9) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if ((arg2 as u128) + (arg3 as u128) != (1000000000000000000 as u128)) {
            true
        } else if (arg6 == 0) {
            true
        } else if (arg7 == 0) {
            true
        } else if (arg4 >= (1000000000000000000 as u64)) {
            true
        } else if (arg5 >= (1000000000000000000 as u64)) {
            true
        } else {
            arg8 >= (1000000000000000000 as u64)
        };
        let v1 = if (v0) {
            5
        } else {
            0
        };
        let v2 = empty_hop(12);
        v2.fee_rate = arg4;
        v2.fee_denominator = (1000000000000000000 as u64);
        v2.output_fee_rate = arg5;
        v2.output_fee_denominator = (1000000000000000000 as u64);
        v2.reserve_in = arg0;
        v2.reserve_out = arg1;
        v2.stable_amp = (arg2 as u128) << 64 | (arg3 as u128);
        v2.stable_scale_in = arg6;
        v2.stable_scale_out = arg7;
        v2.stable_admin_fee = arg8;
        let v3 = if (v1 == 0) {
            (arg2 as u128) * (1000000000000000000 as u128) / (arg3 as u128)
        } else {
            0
        };
        v2.liquidity = v3;
        v2.state_status = v1;
        v2
    }

    public fun aftermath_ln(arg0: u256) : AftermathSigned {
        if (arg0 < 1000000000000000000) {
            return aftermath_signed_neg(aftermath_ln(1000000000000000000 * 1000000000000000000 / arg0))
        };
        let v0 = 0;
        let v1 = v0;
        if (arg0 >= 38877084059945950922200000000000000000000000000000000000 * 1000000000000000000) {
            arg0 = arg0 / 38877084059945950922200000000000000000000000000000000000;
            v1 = v0 + 128000000000000000000;
        };
        if (arg0 >= 6235149080811616882910000000 * 1000000000000000000) {
            arg0 = arg0 / 6235149080811616882910000000;
            v1 = v1 + 64000000000000000000;
        };
        v1 = v1 * 100;
        arg0 = arg0 * 100;
        let v2 = 2;
        while (v2 <= 11) {
            let v3 = aftermath_a20(v2);
            if (arg0 >= v3) {
                let v4 = arg0 * 100000000000000000000;
                arg0 = v4 / v3;
                v1 = v1 + aftermath_x20(v2);
            };
            v2 = v2 + 1;
        };
        let v5 = (arg0 - 100000000000000000000) * 100000000000000000000 / (arg0 + 100000000000000000000);
        let v6 = v5;
        let v7 = v5;
        v2 = 3;
        while (v2 <= 11) {
            v6 = v6 * v5 * v5 / 100000000000000000000 / 100000000000000000000;
            v7 = v7 + v6 / (v2 as u256);
            v2 = v2 + 2;
        };
        aftermath_signed((v1 + 2 * v7) / 100, false)
    }

    public fun aftermath_ln_36(arg0: u256) : AftermathSigned {
        let v0 = arg0 * 1000000000000000000;
        let v1 = 1000000000000000000 * 1000000000000000000;
        let v2 = if (v0 >= v1) {
            aftermath_signed(v0 - v1, false)
        } else {
            aftermath_signed(v1 - v0, true)
        };
        let v3 = aftermath_signed_div_u(aftermath_signed_mul_u(v2, v1), v0 + v1);
        let v4 = v3;
        let v5 = v3;
        let v6 = 3;
        while (v6 <= 15) {
            v4 = aftermath_signed_div_u(aftermath_signed_mul_u(v4, v3.magnitude * v3.magnitude / v1), v1);
            v5 = aftermath_signed_add(v5, aftermath_signed_div_u(v4, (v6 as u256)));
            v6 = v6 + 2;
        };
        aftermath_signed_mul_u(v5, 2)
    }

    public fun aftermath_log_exp_pow(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg1 == 0) {
            return (1000000000000000000, true)
        };
        if (arg0 == 0) {
            return (0, true)
        };
        let v0 = if (1000000000000000000 - 100000000000000000 < arg0 && arg0 < 1000000000000000000 + 100000000000000000) {
            let v1 = aftermath_ln_36(arg0);
            aftermath_signed_div_u(aftermath_signed_add(aftermath_signed_mul_u(aftermath_signed_div_u(v1, 1000000000000000000), arg1), aftermath_signed_div_u(aftermath_signed_mul_u(aftermath_signed_rem_u(v1, 1000000000000000000), arg1), 1000000000000000000)), 1000000000000000000)
        } else {
            aftermath_signed_div_u(aftermath_signed_mul_u(aftermath_ln(arg0), arg1), 1000000000000000000)
        };
        let v2 = v0;
        if (!v2.negative && v2.magnitude > 130 * 1000000000000000000 || v2.negative && v2.magnitude > 41 * 1000000000000000000) {
            return (0, false)
        };
        (aftermath_exp(v2), true)
    }

    public fun aftermath_pow_up(arg0: u256, arg1: u256) : (u256, bool) {
        let v0 = if (arg1 == 1000000000000000000) {
            arg0
        } else if (arg1 == 2 * 1000000000000000000) {
            aftermath_fixed_mul_up(arg0, arg0)
        } else if (arg1 == 4 * 1000000000000000000) {
            let v1 = aftermath_fixed_mul_up(arg0, arg0);
            aftermath_fixed_mul_up(v1, v1)
        } else {
            let (v2, v3) = aftermath_log_exp_pow(arg0, arg1);
            if (!v3) {
                return (0, false)
            };
            v2
        };
        let v4 = aftermath_fixed_mul_up(v0, 10000) + 1;
        if (v0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v4) {
            (0, false)
        } else {
            (v0 + v4, true)
        }
    }

    public fun aftermath_signed(arg0: u256, arg1: bool) : AftermathSigned {
        let v0 = arg1 && arg0 != 0;
        AftermathSigned{
            negative  : v0,
            magnitude : arg0,
        }
    }

    public fun aftermath_signed_add(arg0: AftermathSigned, arg1: AftermathSigned) : AftermathSigned {
        if (arg0.negative == arg1.negative) {
            aftermath_signed(arg0.magnitude + arg1.magnitude, arg0.negative)
        } else if (arg0.magnitude >= arg1.magnitude) {
            aftermath_signed(arg0.magnitude - arg1.magnitude, arg0.negative)
        } else {
            aftermath_signed(arg1.magnitude - arg0.magnitude, arg1.negative)
        }
    }

    public fun aftermath_signed_div_u(arg0: AftermathSigned, arg1: u256) : AftermathSigned {
        aftermath_signed(arg0.magnitude / arg1, arg0.negative)
    }

    public fun aftermath_signed_mul_u(arg0: AftermathSigned, arg1: u256) : AftermathSigned {
        aftermath_signed(arg0.magnitude * arg1, arg0.negative)
    }

    public fun aftermath_signed_neg(arg0: AftermathSigned) : AftermathSigned {
        aftermath_signed(arg0.magnitude, !arg0.negative)
    }

    public fun aftermath_signed_rem_u(arg0: AftermathSigned, arg1: u256) : AftermathSigned {
        aftermath_signed(arg0.magnitude % arg1, arg0.negative)
    }

    public fun aftermath_weights(arg0: u128) : (u64, u64) {
        (((arg0 >> 64) as u64), ((arg0 & (18446744073709551615 as u128)) as u64))
    }

    public fun aftermath_x20(arg0: u64) : u256 {
        if (arg0 == 2) {
            3200000000000000000000
        } else if (arg0 == 3) {
            1600000000000000000000
        } else if (arg0 == 4) {
            800000000000000000000
        } else if (arg0 == 5) {
            400000000000000000000
        } else if (arg0 == 6) {
            200000000000000000000
        } else if (arg0 == 7) {
            100000000000000000000
        } else if (arg0 == 8) {
            50000000000000000000
        } else if (arg0 == 9) {
            25000000000000000000
        } else if (arg0 == 10) {
            12500000000000000000
        } else {
            assert!(arg0 == 11, 3);
            6250000000000000000
        }
    }

    public fun aligned_in_range(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        let v0 = if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        };
        let v1 = v0 - v0 % arg3;
        let v2 = v1;
        if (v1 < arg1) {
            let v3 = arg1 % arg3;
            let v4 = if (v3 == 0) {
                arg1
            } else {
                let v5 = arg3 - v3;
                if (arg1 > 340282366920938463463374607431768211455 - v5) {
                    0
                } else {
                    arg1 + v5
                }
            };
            v2 = v4;
        };
        if (v2 > arg2) {
            0
        } else {
            v2
        }
    }

    public fun amount0_delta_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = (arg2 as u256) << 64;
        let v1 = v0 / (arg0 as u256);
        let v2 = div_up_u256(v0, (arg1 as u256));
        if (v1 <= v2) {
            0
        } else {
            to_u128(v1 - v2)
        }
    }

    public fun amount0_delta_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = (arg2 as u256) << 64;
        to_u128(div_up_u256(v0, (arg1 as u256)) - v0 / (arg0 as u256))
    }

    public fun amount_in(arg0: &OptimizeResult) : u128 {
        arg0.amount_in
    }

    public fun amount_lower_bound(arg0: &vector<u128>, arg1: u128) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u128>(arg0);
        while (v0 < v1) {
            v1 = v0 + (v1 - v0) / 2;
            if (*0x1::vector::borrow<u128>(arg0, v1) < arg1) {
                v0 = v1 + 1;
                continue
            };
        };
        v0
    }

    public fun amount_out(arg0: &OptimizeResult) : u128 {
        arg0.amount_out
    }

    public fun apply_boundary_liquidity(arg0: &mut u128, arg1: bool, arg2: TickBoundary) {
        if (arg1 && !arg2.negative || arg2.negative) {
            assert!(*arg0 >= arg2.liquidity_net_abs, 3);
            *arg0 = *arg0 - arg2.liquidity_net_abs;
        } else {
            *arg0 = *arg0 + arg2.liquidity_net_abs;
        };
    }

    fun apply_liquidity_net(arg0: &mut Hop, arg1: TickBoundary) {
        let v0 = &mut arg0.liquidity;
        apply_boundary_liquidity(v0, arg0.zero_for_one, arg1);
    }

    fun auxiliary_cost_x64(arg0: &vector<Hop>) : u256 {
        let v0 = q64();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.policy.auxiliary_fee_rate > 0) {
                v0 = saturating_add(v0, q64() * (v2.policy.auxiliary_fee_rate as u256) / (v2.policy.auxiliary_fee_denominator as u256));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun auxiliary_fee_estimate(arg0: &OptimizeResult) : u128 {
        if (arg0.found) {
            arg0.amount_out - arg0.amount_in - arg0.gross_profit
        } else {
            0
        }
    }

    fun bolt_cached_quote(arg0: &vector<BoltFixedHop>, arg1: u128, arg2: &mut u64) : (u128, u8) {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<BoltFixedHop>(arg0)) {
            if (v0 == 0) {
                return (0, 1)
            };
            let v2 = 0x1::vector::borrow<BoltFixedHop>(arg0, v1);
            if (v0 > v2.input_capacity) {
                return (0, 7)
            };
            if (v0 < v2.input_minimum) {
                return (0, 1)
            };
            if (*arg2 == 0) {
                return (0, 6)
            };
            *arg2 = *arg2 - 1;
            if (v2.is_bolt) {
                if (v0 > 18446744073709551615) {
                    return (0, 5)
                };
                let (v3, _, _, v6) = 0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::evaluate(0x1::vector::borrow<0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::State>(&v2.bolt, 0), (v0 as u64));
                if (v6 != 0) {
                    return (0, v6)
                };
                v0 = (v3 as u128);
            } else {
                v0 = quote_prepared_cpmm(&v2.cpmm, v0);
            };
            if (v0 > v2.output_capacity) {
                return (0, 7)
            };
            v1 = v1 + 1;
        };
        (v0, 0)
    }

    fun bolt_candidate_points(arg0: &vector<Hop>, arg1: vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: &mut u64) : (vector<u128>, u128) {
        let v0 = vector[];
        let v1 = arg2;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg1)) {
            if (*0x1::vector::borrow<u128>(&arg1, v2) >= arg2 && *0x1::vector::borrow<u128>(&arg1, v2) <= arg3) {
                let v3 = aligned_in_range(*0x1::vector::borrow<u128>(&arg1, v2), arg2, arg3, arg4);
                if (!0x1::vector::contains<u128>(&v0, &v3)) {
                    0x1::vector::push_back<u128>(&mut v0, v3);
                    v1 = 0x1::u128::max(v1, v3);
                };
            };
            v2 = v2 + 1;
        };
        if (0x1::vector::is_empty<u128>(&v0)) {
            0x1::vector::push_back<u128>(&mut v0, arg2);
        };
        (v0, v1)
    }

    fun bolt_data_status(arg0: &vector<Hop>) : u8 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (v1.state_status != 0) {
                return v1.state_status
            };
            if (v1.kind == 2 && 0x1::vector::is_empty<OrderbookSegment>(&v1.orderbook_segments)) {
                return if (v1.orderbook_has_more) {
                    3
                } else {
                    11
                }
            };
            v0 = v0 + 1;
        };
        0
    }

    fun bolt_fixed_cache(arg0: &vector<Hop>) : (vector<BoltFixedHop>, u8) {
        let v0 = 0x1::vector::empty<BoltFixedHop>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.state_status != 0) {
                return (0x1::vector::empty<BoltFixedHop>(), v2.state_status)
            };
            let v3 = BoltFixedHop{
                is_bolt         : v2.kind == 18,
                bolt            : v2.policy.bolt,
                input_capacity  : v2.policy.input_capacity,
                input_minimum   : v2.policy.input_minimum,
                output_capacity : v2.policy.output_capacity,
                cpmm            : prepare_cpmm(v2.reserve_in, v2.reserve_out, v2.fee_rate, v2.fee_denominator, v2.output_fee_rate, v2.output_fee_denominator, v2.policy.fractional_input_fee),
            };
            0x1::vector::push_back<BoltFixedHop>(&mut v0, v3);
            v1 = v1 + 1;
        };
        (v0, 0)
    }

    fun bolt_fixed_route(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (v1.kind != 0 && v1.kind != 18 || v1.policy.auxiliary_fee_rate != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun bolt_grid_search(arg0: &vector<BoltFixedHop>, arg1: u128, arg2: u128, arg3: u128, arg4: u64) : (OptimizeResult, vector<u128>) {
        let v0 = empty_result();
        let v1 = vector[];
        while (arg4 > 0) {
            0x1::vector::push_back<u128>(&mut v1, arg1);
            v0.evaluations = v0.evaluations + 1;
            let v2 = &mut arg4;
            let (v3, v4) = bolt_cached_quote(arg0, arg1, v2);
            if (v4 == 0) {
                let v5 = &mut v0;
                record_candidate_with_fee(arg1, v3, 0, v5);
            } else if (v4 != 1 && v4 != 7) {
                v0.status = v4;
            };
            let v6 = if (v4 == 2) {
                true
            } else if (v4 == 3) {
                true
            } else {
                v4 == 6
            };
            if (v6) {
                break
            };
            if (v4 == 5) {
                v0.status = 1;
            };
            if (arg1 == arg2) {
                break
            };
            arg1 = arg1 + arg3;
        };
        v0.complete = (0x1::vector::length<u128>(&v1) as u128) == (arg2 - arg1) / arg3 + 1;
        if (!v0.complete && (v0.status == 0 || v0.status == 1)) {
            let v7 = if (arg4 == 0) {
                6
            } else {
                9
            };
            v0.status = v7;
        };
        (v0, v1)
    }

    fun bolt_growth_point(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: bool) : u128 {
        let v0 = if (arg4) {
            4
        } else {
            8
        };
        let v1 = if (arg0 > arg2 / v0) {
            arg2
        } else {
            arg0 * v0
        };
        aligned_in_range(v1, arg1, arg2, arg3)
    }

    public fun bolt_hop(arg0: vector<u128>) : Hop {
        let v0 = 0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::decode(arg0);
        let v1 = lst_ratio_hop(1, 1, 0, 0, false, true);
        v1.kind = 18;
        v1.policy.input_capacity = 18446744073709551615;
        let v2 = if (0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::ready(&v0)) {
            0
        } else {
            2
        };
        v1.state_status = v2;
        0x1::vector::push_back<0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::State>(&mut v1.policy.bolt, v0);
        v1
    }

    fun bolt_search(arg0: vector<Hop>, arg1: vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64) : (OptimizeResult, vector<u128>) {
        let v0 = bolt_data_status(&arg0);
        if (v0 != 0) {
            let v1 = empty_result();
            v1.complete = false;
            v1.status = v0;
            return (v1, vector[])
        };
        let v2 = 0x1::u128::min(arg3, 0x1::vector::borrow<Hop>(&arg0, 0).policy.input_capacity);
        if (arg2 > v2) {
            return (empty_result(), vector[])
        };
        let v3 = aligned_in_range(arg2, arg2, v2, arg4);
        if (v3 == 0) {
            return (empty_result(), vector[])
        };
        let v4 = v2 - v2 % arg4;
        let v5 = bolt_fixed_route(&arg0);
        let (v6, v7) = if (v5) {
            bolt_fixed_cache(&arg0)
        } else {
            (0x1::vector::empty<BoltFixedHop>(), 0)
        };
        let v8 = v6;
        if (v7 != 0) {
            let v9 = empty_result();
            v9.complete = false;
            v9.status = v7;
            return (v9, vector[])
        };
        if ((v4 - v3) / arg4 + 1 <= (arg6 as u128) && v5) {
            return bolt_grid_search(&v8, v3, v4, arg4, arg7)
        };
        let (v10, v11, v12) = if (v5) {
            (0x1::vector::empty<V3PrefixCache>(), 0, 0)
        } else {
            prepare_v3_prefix_caches(&arg0, arg7)
        };
        let v13 = v10;
        let v14 = empty_result();
        if (v11 != 0) {
            v14.complete = false;
            v14.status = v11;
            return (v14, vector[])
        };
        let v15 = arg7 - v12;
        let v16 = if (v5) {
            0x1::vector::empty<OrderbookShortfall>()
        } else {
            let (v17, _) = orderbook_shortfall_memos(&arg0);
            v17
        };
        let v19 = v16;
        let v20 = vector[];
        let v21 = (v4 - v3) / arg4 + 1;
        let (v22, v23) = if (v21 <= (arg6 as u128)) {
            (v4, vector[])
        } else {
            let v24 = &mut v15;
            let (v25, v26) = bolt_candidate_points(&arg0, arg1, v3, v4, arg4, arg5, arg6, v24);
            (v26, v25)
        };
        let v27 = v22;
        let v28 = v23;
        let v29 = true;
        let v30 = if (v21 > (arg6 as u128) && numeric_bolt_prefix_supported(&arg0)) {
            let v31 = &mut v15;
            numeric_bolt_events(&arg0, v3, v4, arg4, v31)
        } else {
            vector[]
        };
        let v32 = v30;
        if (v21 <= (arg6 as u128)) {
            loop {
                0x1::vector::push_back<u128>(&mut v28, v3);
                if (v4 - v3 < arg4) {
                    break
                };
                v3 = v3 + arg4;
            };
        };
        let v33 = false;
        let v34 = 0;
        while (v14.evaluations < arg6 && v15 > 0) {
            let v35 = if (v34 < 0x1::vector::length<u128>(&v28)) {
                let v36 = aligned_in_range(*0x1::vector::borrow<u128>(&v28, v34), v3, v4, arg4);
                v34 = v34 + 1;
                v36
            } else {
                let v37 = if (v21 > (arg6 as u128)) {
                    if (v29) {
                        if (v27 < v4) {
                            v14.evaluations < 0x1::u64::min(arg6, 5) || v14.found && v14.amount_in >= v27
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v37) {
                    let v38 = bolt_growth_point(v27, v3, v4, arg4, v14.evaluations == 1);
                    v27 = v38;
                    v38
                } else {
                    let v39 = if (!v33) {
                        if (v14.found) {
                            if (amount_lower_bound(&v20, v14.amount_in) > 0) {
                                (v14.amount_in - *0x1::vector::borrow<u128>(&v20, amount_lower_bound(&v20, v14.amount_in) - 1)) / arg4 > 1
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v39) {
                        v33 = true;
                        aligned_in_range(midpoint(*0x1::vector::borrow<u128>(&v20, amount_lower_bound(&v20, v14.amount_in) - 1), v14.amount_in), v3, v27, arg4)
                    } else {
                        let v40 = 0;
                        while (!0x1::vector::is_empty<u128>(&v32) && v40 == 0) {
                            let v41 = 0x1::vector::pop_back<u128>(&mut v32);
                            if (v41 <= v27 && !contains_amount(&v20, v41)) {
                                v40 = v41;
                            };
                        };
                        if (v40 > 0) {
                            v40
                        } else {
                            let v42 = refinement_point(&v14, &v20, v3, v27, arg4, v14.evaluations);
                            if (!contains_amount(&v20, v42)) {
                                v42
                            } else {
                                largest_gap_midpoint(&v20, v3, v27, arg4)
                            }
                        }
                    }
                }
            };
            if (v35 == 0 || (0x1::vector::length<u128>(&v20) as u128) >= v21) {
                break
            };
            let v43 = amount_lower_bound(&v20, v35);
            if (v43 < 0x1::vector::length<u128>(&v20) && *0x1::vector::borrow<u128>(&v20, v43) == v35) {
                if (v34 >= 0x1::vector::length<u128>(&v28)) {
                    break
                } else {
                    continue
                };
            };
            let v44 = if (v5) {
                0x1::vector::insert<u128>(&mut v20, v35, v43);
                v14.evaluations = v14.evaluations + 1;
                let v45 = &mut v15;
                let (v46, v47) = bolt_cached_quote(&v8, v35, v45);
                if (v47 == 0) {
                    let v48 = &mut v14;
                    record_candidate_with_fee(v35, v46, 0, v48);
                } else if (v47 != 1 && v47 != 7) {
                    v14.status = v47;
                };
                ProgressiveSample{amount: v35, output: 0, fee: 0, work: 0, negative: false, magnitude: 0, status: v47}
            } else {
                let v49 = &mut v13;
                let v50 = &mut v19;
                let v51 = &mut v20;
                let v52 = &mut v15;
                let v53 = &mut v14;
                progressive_probe(&arg0, v49, v50, v35, v43, v51, v52, v53)
            };
            let v54 = v44;
            let v55 = if (v54.status == 2) {
                true
            } else if (v54.status == 3) {
                true
            } else if (v54.status == 6) {
                true
            } else {
                v54.status == 11
            };
            if (v55) {
                break
            };
            let v56 = if (v54.status == 7) {
                true
            } else if (v54.status == 12) {
                true
            } else {
                v54.status == 5 && v14.found
            };
            if (v56) {
                v29 = false;
            };
            if (v54.status == 5) {
                v14.status = 1;
            };
        };
        v14.complete = (0x1::vector::length<u128>(&v20) as u128) == v21;
        if (!v14.complete && (v14.status == 0 || v14.status == 1)) {
            let v57 = if (v15 == 0) {
                6
            } else {
                9
            };
            v14.status = v57;
        };
        (v14, v20)
    }

    public fun book_tail_affine(arg0: u64, arg1: u64, arg2: bool, arg3: &vector<OrderbookSegment>, arg4: u256) : (u256, u256) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::length<OrderbookSegment>(arg3);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = 0x1::vector::borrow<OrderbookSegment>(arg3, v4);
            let v6 = if (v5.price == 0) {
                true
            } else if (v5.price > 18446744073709551615) {
                true
            } else {
                v5.remaining_base > 18446744073709551615
            };
            if (v6) {
                return (115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
            };
            let v7 = (v5.price as u256);
            let v8 = (v5.remaining_base as u256) * v7;
            let v9 = v0 + (v5.remaining_base as u256);
            let v10 = v1 + v8 / 1000000000;
            if (arg2 && mul_fraction_ceil(arg4, ((arg0 - arg1) as u256), (arg0 as u256)) <= v9 || saturating_add(mul_fraction_ceil(arg4, ((arg0 - arg1) as u256), (arg0 as u256)), 100) <= v10 || v4 + 1 == v3) {
                let (v11, v12) = if (arg2) {
                    let v13 = v0 * v7 / 1000000000;
                    let v14 = if (v2 > v13) {
                        v2 - v13
                    } else {
                        0
                    };
                    (div_ceil(v7 * q64(), 1000000000), v14)
                } else {
                    let v15 = v1 * 1000000000 / v7;
                    let v16 = if (v0 > v15) {
                        v0 - v15
                    } else {
                        0
                    };
                    (div_ceil(1000000000 * q64(), v7), v16 + div_ceil(100000000000, v7))
                };
                return (mul_fraction_ceil(v11, ((arg0 - arg1) as u256), (arg0 as u256)), v12)
            };
            v0 = v9;
            v1 = v10;
            v2 = v2 + div_ceil(v8, 1000000000);
            v4 = v4 + 1;
        };
        (115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
    }

    fun bounded_affine_state_upper(arg0: &vector<Hop>) : (bool, u256, u256, bool) {
        let v0 = 0x1::vector::length<Hop>(arg0) > 0;
        let v1 = q64();
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            let v4 = 0x1::vector::borrow<Hop>(arg0, v3);
            if (v4.state_status == 2) {
                return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935, false)
            };
            if (v4.state_status != 0) {
                v0 = false;
            };
            if (v0) {
                let (v5, v6, v7) = hop_affine_upper(v4);
                v0 = v5;
                if (v5) {
                    let v8 = mul_q64_ceil(v1, v6);
                    v1 = v8;
                    let v9 = saturating_add(mul_q64_ceil(v2, v6), v7);
                    v2 = v9;
                    if (v8 == 115792089237316195423570985008687907853269984665640564039457584007913129639935 || v9 == 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                        v0 = false;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v0) {
            (true, v1, v2, true)
        } else {
            (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935, true)
        }
    }

    public fun bounded_affine_upper(arg0: &vector<Hop>) : (bool, u256, u256) {
        let (v0, v1, v2, _) = bounded_affine_state_upper(arg0);
        (v0, v1, v2)
    }

    public fun bounded_search_staged(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: vector<u128>, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64) : OptimizeResult {
        bounded_search_staged_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, true)
    }

    public fun bounded_search_staged_if(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: vector<u128>, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: bool) : OptimizeResult {
        if (!arg9) {
            coarse_rejection()
        } else {
            bounded_search_staged(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        }
    }

    fun bounded_search_staged_impl(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: vector<u128>, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: bool) : OptimizeResult {
        if (arg3 > 0 && arg4 < arg3) {
            return coarse_rejection()
        };
        let v0 = if (arg3 > 0) {
            if (arg3 <= arg4) {
                if (arg5 > 0) {
                    if (0x1::vector::length<u128>(&arg2) <= 4) {
                        if (arg6 <= 60) {
                            if (arg6 % 2 == 0) {
                                if (arg7 > 0) {
                                    if (arg7 <= 64) {
                                        arg8 > 0
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        let v1 = join_staged_route(arg0, arg1);
        if (contains_bolt(&v1)) {
            let (v2, _) = bolt_search(v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            return v2
        };
        let (v4, v5, v6) = prepare_v3_prefix_caches(&v1, arg8);
        let v7 = v4;
        let v8 = empty_result();
        if (v5 != 0) {
            v8.complete = false;
            v8.status = v5;
            return v8
        };
        let v9 = arg8 - v6;
        let v10 = vector[];
        let (v11, v12) = orderbook_shortfall_memos(&v1);
        let v13 = v11;
        let v14 = if (arg9 && v12) {
            4
        } else {
            0
        };
        let v15 = SearchTail{
            maximum     : arg4,
            checks_left : v14,
            loss_input  : 0,
            loss_output : 0,
        };
        let v16 = 0;
        while (v16 < 0x1::vector::length<u128>(&arg2) && v8.evaluations < arg7) {
            let v17 = &mut v7;
            let v18 = &mut v10;
            let v19 = &mut v9;
            let v20 = &mut v8;
            let v21 = &mut v13;
            let v22 = &mut v15;
            evaluate_bounded_probe(&v1, v17, aligned_in_range(*0x1::vector::borrow<u128>(&arg2, v16), arg3, arg4, arg5), v18, v19, v20, v21, v22);
            v16 = v16 + 1;
        };
        let v23 = 0;
        loop {
            let v24 = if (v23 < arg6) {
                if (v8.evaluations < arg7) {
                    if (v9 > 0) {
                        v15.maximum >= arg3
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v24) {
                let v25 = &mut v7;
                let v26 = &mut v10;
                let v27 = &mut v9;
                let v28 = &mut v8;
                let v29 = &mut v13;
                let v30 = &mut v15;
                evaluate_bounded_probe(&v1, v25, refinement_point(&v8, &v10, arg3, v15.maximum, arg5, v23), v26, v27, v28, v29, v30);
                v23 = v23 + 1;
            } else {
                break
            };
        };
        if (v16 < 0x1::vector::length<u128>(&arg2) || v23 < arg6 && v15.maximum >= arg3) {
            v8.complete = false;
            if (v8.status == 0 || v8.status == 1) {
                let v31 = if (v9 == 0) {
                    6
                } else {
                    9
                };
                v8.status = v31;
            };
        };
        v8
    }

    public fun bucket_psm_hop(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : Hop {
        let v0 = if (arg4) {
            if (arg0 <= 18) {
                if (arg1 <= 18) {
                    arg2 <= 1000000000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v1 = 1;
        let v2 = if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v3 = 0;
        while (v3 < v2) {
            v1 = v1 * 10;
            v3 = v3 + 1;
        };
        let v4 = empty_hop(13);
        v4.fee_rate = arg2;
        v4.fee_denominator = 1000000000;
        v4.reserve_in = (arg3 as u128);
        v4.zero_for_one = arg0 >= arg1;
        let v5 = if (arg0 >= arg1) {
            v1
        } else {
            1
        };
        v4.stable_scale_in = v5;
        let v6 = if (arg0 >= arg1) {
            1
        } else {
            v1
        };
        v4.stable_scale_out = v6;
        let v7 = if (!v0) {
            5
        } else if (!arg5) {
            2
        } else {
            0
        };
        v4.state_status = v7;
        v4
    }

    fun build_v3_prefix_caches(arg0: &vector<Hop>, arg1: u64) : (vector<V3PrefixCache>, u8, u64) {
        let v0 = 0x1::vector::empty<V3PrefixCache>();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            let v4 = 0x1::vector::borrow<Hop>(arg0, v3);
            if (v4.state_status != 0 && v2 == 0) {
                v2 = v4.state_status;
            };
            let v5 = new_prefixCache(0x1::vector::empty<V3Prefix>(), 0, v4.boundary_cursor, v4.fee_denominator, v4.fee_rate, v4.liquidity, v4.policy.output_capacity, v4.policy.stop_at_zero_liquidity, v4.sqrt_price_x64, v4.zero_for_one, v4.policy.momentum_fee_round_nearest);
            if (v4.kind == 1 && v2 == 0) {
                let v6 = 0x1::vector::length<TickBoundary>(&v4.boundaries) - v4.boundary_cursor;
                let v7 = if (v6 < arg1 - v1) {
                    v6
                } else {
                    arg1 - v1
                };
                let v8 = &mut v5;
                v1 = v1 + extend_v3_prefix_cache(&v4.boundaries, v8, 340282366920938463463374607431768211455, v7);
                if (v5.status != 0) {
                    v2 = v5.status;
                } else if (v7 < v6) {
                    v5.status = 6;
                    v2 = 6;
                };
            };
            0x1::vector::push_back<V3PrefixCache>(&mut v0, v5);
            v3 = v3 + 1;
        };
        (v0, v2, v1)
    }

    fun cached_quote_and_marginal(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: u128, arg3: &mut u64) : (u128, u256, u8, u64) {
        let v0 = arg2;
        let v1 = q64();
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            if (*arg3 == 0) {
                return (0, 0, 6, v2)
            };
            *arg3 = *arg3 - 1;
            let v4 = 0x1::vector::borrow<Hop>(arg0, v3);
            if (v4.state_status != 0) {
                return (0, 0, v4.state_status, v2)
            };
            if (v0 > v4.policy.input_capacity) {
                return (0, 0, 7, v2)
            };
            if (v0 < v4.policy.input_minimum) {
                return (0, 0, 1, v2)
            };
            let v5 = if (v4.kind == 0) {
                let (v6, v7) = quote_cpmm_cached_with_slope(v4.fee_denominator, v4.fee_rate, v4.output_fee_denominator, v4.output_fee_rate, v4.reserve_in, v4.reserve_out, v0);
                v0 = v6;
                v7
            } else if (v4.kind == 1) {
                let v8 = 0x1::vector::borrow_mut<V3PrefixCache>(arg1, v3);
                let (v9, v10, v11, v12) = quote_v3_cached_with_slope(&v4.boundaries, v8, v0, arg3);
                if (v11 != 0) {
                    return (0, 0, v11, v2 + v12)
                };
                v0 = v9;
                v2 = v2 + v12;
                v10
            } else {
                return (0, 0, 5, v2)
            };
            if (v0 > v4.policy.output_capacity) {
                return (0, 0, 7, v2)
            };
            v1 = mul_ratio_down_saturating(v1, mul_ratio_down_saturating(v5, ((v4.fee_denominator - v4.fee_rate) as u256), (v4.fee_denominator as u256)), q64());
            v3 = v3 + 1;
        };
        (v0, v1, 0, v2)
    }

    fun candidate_satisfies_orderbook_minimums(arg0: &vector<Hop>, arg1: u128) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (v1.kind == 2 && v1.orderbook_consumed_base + orderbook_segment_base_consumed(v1.kind, v1.orderbook_base_to_quote, v1.orderbook_cursor, v1.orderbook_has_more, v1.orderbook_lot_size, &v1.orderbook_segments, effective_input(arg1, v1.fee_rate, v1.fee_denominator)) < v1.orderbook_min_size) {
                return false
            };
            let v2 = if (arg1 < v1.policy.input_minimum) {
                true
            } else if (arg1 > v1.policy.input_capacity) {
                true
            } else {
                crosses_forbidden_zero(v1, arg1)
            };
            if (v2) {
                return false
            };
            let v3 = quote_hop(v1, arg1);
            arg1 = v3;
            if (v3 > v1.policy.output_capacity) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun cap_curvature_linear() : u256 {
        0
    }

    public fun cap_curvature_orderbook() : u256 {
        0
    }

    public fun cap_curvature_v2(arg0: u128, arg1: u256) : u256 {
        arg1 / (arg0 as u256)
    }

    public fun cap_curvature_v3(arg0: u128, arg1: u128, arg2: bool, arg3: u256) : u256 {
        if (arg2) {
            arg3 * (arg1 as u256) / q64() / (arg0 as u256)
        } else {
            arg3 * q64() / (arg1 as u256) / (arg0 as u256)
        }
    }

    public fun cap_inverse_linear(arg0: u64, arg1: u64, arg2: u64, arg3: &vector<LinearSegment>, arg4: u128) : (u128, bool) {
        let v0 = current_linear_segment(arg2, arg3);
        if (arg4 > v0.remaining_output) {
            return (0, false)
        };
        (gross_from_effective(mul_div_up(arg4, v0.remaining_input, v0.remaining_output), arg1, arg0), true)
    }

    public fun cap_inverse_orderbook(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u128, arg5: &vector<OrderbookSegment>, arg6: u128) : (u128, bool) {
        let v0 = current_orderbook_segment(arg3, arg5);
        if (arg6 > orderbook_segment_output_capacity(arg2, v0)) {
            return (0, false)
        };
        let v1 = if (arg2) {
            round_up_to_quantum(mul_div_up(arg6, 1000000000, v0.price), arg4)
        } else {
            mul_div_up(round_up_to_quantum(arg6, arg4), v0.price, 1000000000)
        };
        (gross_from_effective(v1, arg1, arg0), true)
    }

    public fun cap_inverse_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : (u128, bool) {
        let v0 = gross_from_effective(arg6, arg3, arg2);
        if (v0 >= arg5) {
            return (0, false)
        };
        (gross_from_effective(mul_div_up(arg4, v0, arg5 - v0), arg1, arg0), true)
    }

    public fun cap_inverse_v3(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: &TickBoundary, arg6: u128) : (u128, bool) {
        let v0 = arg5.sqrt_price_x64;
        let v1 = if (arg4) {
            if (arg6 > mul_div_down(arg2, arg3 - v0, 18446744073709551616)) {
                return (0, false)
            };
            let v2 = mul_div_up(arg6, 18446744073709551616, arg2);
            if (v2 >= arg3) {
                return (0, false)
            };
            let v3 = arg3 - v2;
            if (v3 < v0) {
                return (0, false)
            };
            amount0_delta_up(arg3, v3, arg2)
        } else {
            if (arg6 > amount0_delta_down(arg3, v0, arg2)) {
                return (0, false)
            };
            let v4 = (arg2 as u256) << 64;
            let v5 = v4 / (arg3 as u256);
            if ((arg6 as u256) >= v5) {
                return (0, false)
            };
            let v6 = to_u128(div_up_u256(v4, v5 - (arg6 as u256)));
            if (v6 > v0) {
                return (0, false)
            };
            mul_div_up(arg2, v6 - arg3, 18446744073709551616)
        };
        (gross_from_effective(v1, arg1, arg0), true)
    }

    public fun cap_marginal_aftermath_geometric(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: u128, arg5: u128) : u256 {
        let (v0, v1) = aftermath_weights(arg3);
        mul_ratio_down_saturating(mul_ratio_down_saturating(mul_ratio_down_saturating((arg1 as u256) * q64() / (arg0 as u256), (v0 as u256), (v1 as u256)), (arg4 as u256), (arg5 as u256)), 1000000000000000000 - (arg2 as u256), 1000000000000000000)
    }

    public fun cap_marginal_bucket_psm(arg0: u128, arg1: u128, arg2: bool) : u256 {
        if (arg2) {
            q64() / (arg0 as u256)
        } else {
            q64() * (arg1 as u256)
        }
    }

    public fun cap_marginal_linear(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<LinearSegment>) : u256 {
        if (linear_terminal(arg0, arg1, arg2, arg3)) {
            return 0
        };
        let (v0, v1) = linear_marginal_fraction(current_linear_segment(arg1, arg3));
        v0 / v1
    }

    public fun cap_marginal_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: &vector<OrderbookSegment>) : u256 {
        if (orderbook_terminal(arg0, arg2, arg3, arg4)) {
            return 0
        };
        if (arg1) {
            (current_orderbook_segment(arg2, arg4).price as u256) * q64() / 1000000000
        } else {
            1000000000 * q64() / (current_orderbook_segment(arg2, arg4).price as u256)
        }
    }

    public fun cap_marginal_v2(arg0: u128, arg1: u128) : u256 {
        (arg1 as u256) * q64() / (arg0 as u256)
    }

    public fun cap_marginal_v3(arg0: u128, arg1: bool) : u256 {
        let v0 = (arg0 as u256);
        if (arg1) {
            v0 * v0 / q64()
        } else {
            q64() * q64() * q64() / v0 * v0
        }
    }

    public fun cap_segment_quote_linear(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<LinearSegment>, arg4: u128) : u128 {
        quote_linear_segment(arg0, arg1, arg2, arg3, arg4)
    }

    public fun cap_segment_quote_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<OrderbookSegment>, arg6: u128) : u128 {
        quote_orderbook_segment(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_segment_quote_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: u128) : u128 {
        effective_output(v2_curve_output(arg0, arg1, arg4, arg5, arg6, arg7), arg3, arg2)
    }

    public fun cap_segment_quote_v3(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: &TickBoundary, arg5: u128) : u128 {
        if (arg3) {
            mul_div_down(arg0, arg2 - next_sqrt_price(arg0, arg1, arg2, arg3, arg5, arg4.sqrt_price_x64), 18446744073709551616)
        } else {
            amount0_delta_down(arg2, next_sqrt_price(arg0, arg1, arg2, arg3, arg5, arg4.sqrt_price_x64), arg0)
        }
    }

    fun cap_upper_aftermath_prepared(arg0: u128, arg1: u128, arg2: u64, arg3: u256, arg4: u128, arg5: u128) : u256 {
        mul_ratio_up_saturating(mul_ratio_up_saturating(mul_ratio_up_saturating(div_ceil((arg1 as u256) * q64(), (arg0 as u256)), arg3 + 1, 1000000000000000000), (arg4 as u256), (arg5 as u256)), 1000000000000000000 - (arg2 as u256), 1000000000000000000)
    }

    public fun cap_upper_bucket_psm(arg0: u128, arg1: u128, arg2: bool) : u256 {
        if (arg2) {
            div_ceil(q64(), (arg0 as u256))
        } else {
            q64() * (arg1 as u256)
        }
    }

    public fun cap_upper_linear(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<LinearSegment>) : u256 {
        if (linear_terminal(arg0, arg1, arg2, arg3)) {
            return 0
        };
        let (v0, v1) = linear_marginal_fraction(current_linear_segment(arg1, arg3));
        div_ceil(v0, v1)
    }

    public fun cap_upper_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: &vector<OrderbookSegment>) : u256 {
        if (orderbook_terminal(arg0, arg2, arg3, arg4)) {
            return 0
        };
        if (arg1) {
            div_ceil((current_orderbook_segment(arg2, arg4).price as u256) * q64(), 1000000000)
        } else {
            div_ceil(1000000000 * q64(), (current_orderbook_segment(arg2, arg4).price as u256))
        }
    }

    public fun cap_upper_v2(arg0: u128, arg1: u128) : u256 {
        div_ceil((arg1 as u256) * q64(), (arg0 as u256))
    }

    public fun cap_upper_v3(arg0: u128, arg1: bool) : u256 {
        let v0 = (arg0 as u256);
        if (arg1) {
            div_ceil(v0 * v0, q64())
        } else {
            div_ceil(q64() * q64() * q64(), v0 * v0)
        }
    }

    public fun capped_ratio_hop(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : Hop {
        let v0 = lst_ratio_hop(1, 1, 0, 0, !arg3, true);
        v0.kind = 17;
        v0.reserve_in = arg1;
        v0.reserve_out = arg0;
        v0.stable_scale_in = (arg2 as u128);
        let v1 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v1) {
            v0.state_status = 2;
        };
        v0
    }

    fun certified_tail_maximum(arg0: &vector<Hop>, arg1: u128, arg2: u128, arg3: &mut u64) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.state_status != 0) {
                return arg2
            };
            if (v2.kind == 2) {
                let v3 = 0x1::vector::length<OrderbookSegment>(&v2.orderbook_segments);
                let v4 = if (v3 == 0) {
                    true
                } else if (v3 > 100) {
                    true
                } else {
                    v2.orderbook_cursor != 0
                };
                if (v4) {
                    return arg2
                };
                v0 = v0 + v3;
            } else if (v2.kind == 12) {
                let (v5, v6) = aftermath_weights(v2.stable_amp);
                let v7 = if (v5 != v6) {
                    if (v5 != 2 * v6) {
                        v5 != 4 * v6
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v7) {
                    return arg2
                };
            } else if (v2.kind != 0 && v2.kind != 1) {
                return arg2
            };
            v1 = v1 + 1;
        };
        if (v0 == 0 || v0 > *arg3) {
            return arg2
        };
        *arg3 = *arg3 - v0;
        let v8 = q64();
        let v9 = 0;
        v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v10 = 0x1::vector::borrow<Hop>(arg0, v1);
            let (v11, v12) = if (v10.kind == 2) {
                orderbook_affine_at(v10, saturating_add(mul_ratio_up_saturating(v8, (arg1 as u256), q64()), v9))
            } else {
                (hop_marginal_upper_x64(v10), 0)
            };
            let v13 = mul_q64_ceil(v8, v11);
            v8 = v13;
            let v14 = saturating_add(mul_q64_ceil(v9, v11), v12);
            v9 = v14;
            if (v13 == 115792089237316195423570985008687907853269984665640564039457584007913129639935 || v14 == 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                return arg2
            };
            v1 = v1 + 1;
        };
        if (v8 >= q64()) {
            return arg2
        };
        let v15 = mul_ratio_up_saturating(v9, q64(), q64() - v8);
        if (v15 == 0) {
            0
        } else if (v15 <= (arg2 as u256)) {
            ((v15 - 1) as u128)
        } else {
            arg2
        }
    }

    public fun clmm_input_boundary(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: &TickBoundary) : u128 {
        let v0 = if (arg4) {
            amount0_delta_up(arg3, arg5.sqrt_price_x64, arg2)
        } else {
            mul_div_up(arg2, arg5.sqrt_price_x64 - arg3, 18446744073709551616)
        };
        gross_from_effective(v0, arg1, arg0)
    }

    public fun coarse_rejected(arg0: &OptimizeResult) : bool {
        arg0.coarse_rejected
    }

    public fun coarse_rejection() : OptimizeResult {
        let v0 = empty_result();
        v0.coarse_rejected = true;
        v0
    }

    public fun coefficient_root(arg0: u256, arg1: u256, arg2: u128) : u128 {
        if (arg1 == 0) {
            return arg2
        };
        let v0 = sqrt_down(arg0 * q64());
        if (v0 <= q64()) {
            return 0
        };
        let v1 = to_u128((v0 - q64()) / arg1);
        if (v1 > arg2) {
            arg2
        } else {
            v1
        }
    }

    public fun coefficient_state(arg0: vector<Hop>, arg1: u128, arg2: u64) : OptimizeState {
        assert!(0x1::vector::length<Hop>(&arg0) > 0, 5);
        assert!(arg1 > 0 && arg2 > 0, 6);
        let v0 = if (has_execution_bounds(&arg0)) {
            arg0
        } else {
            0x1::vector::empty<Hop>()
        };
        OptimizeState{
            route            : arg0,
            validation_route : v0,
            max_amount_in    : arg1,
            max_segments     : arg2,
            cursor           : 0,
            cursor_output    : 0,
            result           : empty_result(),
            finished         : false,
        }
    }

    public fun complete(arg0: &OptimizeResult) : bool {
        arg0.complete
    }

    public fun contains_amount(arg0: &vector<u128>, arg1: u128) : bool {
        if (arg1 == 0) {
            return true
        };
        let v0 = amount_lower_bound(arg0, arg1);
        v0 < 0x1::vector::length<u128>(arg0) && *0x1::vector::borrow<u128>(arg0, v0) == arg1
    }

    fun contains_bolt(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v0).kind == 18) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun crossed_orders(arg0: &OptimizeResult) : u64 {
        arg0.crossed_orders
    }

    public fun crossed_ticks(arg0: &OptimizeResult) : u64 {
        arg0.crossed_ticks
    }

    fun crosses_forbidden_zero(arg0: &Hop, arg1: u128) : bool {
        let v0 = if (!arg0.policy.stop_at_zero_liquidity) {
            true
        } else if (arg0.kind != 1) {
            true
        } else {
            arg0.boundary_cursor >= 0x1::vector::length<TickBoundary>(&arg0.boundaries)
        };
        if (v0) {
            return false
        };
        let (v1, v2) = liquidity_after_boundary(arg0.liquidity, *0x1::vector::borrow<TickBoundary>(&arg0.boundaries, arg0.boundary_cursor), arg0.zero_for_one);
        if (v2) {
            if (v1 == 0) {
                arg1 >= input_to_current_boundary(arg0)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun current_boundary(arg0: &Hop) : &TickBoundary {
        0x1::vector::borrow<TickBoundary>(&arg0.boundaries, arg0.boundary_cursor)
    }

    public fun current_linear_segment(arg0: u64, arg1: &vector<LinearSegment>) : &LinearSegment {
        0x1::vector::borrow<LinearSegment>(arg1, arg0)
    }

    public fun current_orderbook_segment(arg0: u64, arg1: &vector<OrderbookSegment>) : &OrderbookSegment {
        0x1::vector::borrow<OrderbookSegment>(arg1, arg0)
    }

    public fun div_ceil(arg0: u256, arg1: u256) : u256 {
        if (arg0 % arg1 == 0) {
            arg0 / arg1
        } else {
            arg0 / arg1 + 1
        }
    }

    public fun div_up_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun dlmm_hop_from_bins(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool) : Hop {
        dlmm_hop_from_bins_with_model(arg0, arg1, arg2, arg3, arg4, arg5, false)
    }

    public fun dlmm_hop_from_bins_with_model(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool, arg6: bool) : Hop {
        let v0 = 0x1::vector::empty<LinearSegment>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0)) {
            0x1::vector::push_back<LinearSegment>(&mut v0, dlmm_segment(*0x1::vector::borrow<u128>(&arg0, v1), *0x1::vector::borrow<u128>(&arg1, v1), *0x1::vector::borrow<u128>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1), arg4));
            v1 = v1 + 1;
        };
        linear_hop_impl(v0, arg5, arg6)
    }

    public fun dlmm_segment(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: bool) : LinearSegment {
        LinearSegment{
            remaining_input  : arg0,
            remaining_output : arg1,
            price_x64        : arg2,
            fee_rate         : arg3,
            fee_denominator  : 1000000000,
            forward          : arg4,
            exact_dlmm       : true,
        }
    }

    public fun dlmm_stage_from_bins_if(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool, arg6: bool) : StagedHop {
        if (!arg6) {
            return reuse_current_stage()
        };
        replacement_stage(dlmm_hop_from_bins(arg0, arg1, arg2, arg3, arg4, arg5))
    }

    public fun dlmm_stage_from_bins_with_model_if(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool, arg6: bool, arg7: bool) : StagedHop {
        if (!arg7) {
            return reuse_current_stage()
        };
        replacement_stage(dlmm_hop_from_bins_with_model(arg0, arg1, arg2, arg3, arg4, arg5, arg6))
    }

    public fun effective_input(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_down(arg0, ((arg2 - arg1) as u128), (arg2 as u128))
    }

    public fun effective_output(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_down(arg0, ((arg2 - arg1) as u128), (arg2 as u128))
    }

    fun empty_hop(arg0: u8) : Hop {
        let v0 = ExecutionPolicy{
            bolt                       : 0x1::vector::empty<0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::State>(),
            fractional_input_fee       : false,
            omm_update_flag            : false,
            linear_rate_inversion      : false,
            input_minimum              : 0,
            input_capacity             : 340282366920938463463374607431768211455,
            output_capacity            : 340282366920938463463374607431768211455,
            stop_at_zero_liquidity     : false,
            momentum_fee_round_nearest : false,
            auxiliary_fee_rate         : 0,
            auxiliary_fee_denominator  : 1,
        };
        Hop{
            kind                    : arg0,
            policy                  : v0,
            fee_rate                : 0,
            fee_denominator         : 1,
            output_fee_rate         : 0,
            output_fee_denominator  : 1,
            reserve_in              : 0,
            reserve_out             : 0,
            sqrt_price_x64          : 0,
            liquidity               : 0,
            zero_for_one            : false,
            boundaries              : 0x1::vector::empty<TickBoundary>(),
            boundary_cursor         : 0,
            orderbook_segments      : 0x1::vector::empty<OrderbookSegment>(),
            orderbook_cursor        : 0,
            orderbook_lot_size      : 1,
            orderbook_min_size      : 1,
            orderbook_consumed_base : 0,
            orderbook_base_to_quote : false,
            orderbook_has_more      : false,
            linear_segments         : 0x1::vector::empty<LinearSegment>(),
            linear_cursor           : 0,
            linear_has_more         : false,
            stable_amp              : 0,
            stable_scale_in         : 0,
            stable_scale_out        : 0,
            stable_admin_fee        : 0,
            stable_lp_fee           : 0,
            stable_th_fee           : 0,
            stable_fee_on_input     : false,
            state_status            : 0,
        }
    }

    public fun empty_progressive_sample() : ProgressiveSample {
        ProgressiveSample{
            amount    : 0,
            output    : 0,
            fee       : 0,
            work      : 0,
            negative  : false,
            magnitude : 0,
            status    : 1,
        }
    }

    public fun empty_result() : OptimizeResult {
        OptimizeResult{
            found           : false,
            complete        : true,
            coarse_rejected : false,
            amount_in       : 0,
            amount_out      : 0,
            gross_profit    : 0,
            segments        : 0,
            crossed_ticks   : 0,
            crossed_orders  : 0,
            needs_more_hop  : 18446744073709551615,
            status          : 1,
            evaluations     : 0,
        }
    }

    fun evaluate_bounded_probe(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: u128, arg3: &mut vector<u128>, arg4: &mut u64, arg5: &mut OptimizeResult, arg6: &mut vector<OrderbookShortfall>, arg7: &mut SearchTail) {
        if (arg2 == 0 || arg2 > arg7.maximum) {
            return
        };
        let v0 = amount_lower_bound(arg3, arg2);
        if (v0 < 0x1::vector::length<u128>(arg3) && *0x1::vector::borrow<u128>(arg3, v0) == arg2) {
            return
        };
        0x1::vector::insert<u128>(arg3, arg2, v0);
        arg5.evaluations = arg5.evaluations + 1;
        let (v1, v2, v3, v4) = quote_bounded_route_with_shortfalls(arg0, arg1, arg2, arg4, arg6, arg5.found);
        arg5.crossed_ticks = arg5.crossed_ticks + v3;
        arg5.crossed_orders = arg5.crossed_orders + v4;
        if (v2 == 0) {
            record_route_candidate(arg0, arg2, v1, arg5);
            let v5 = if (arg7.checks_left > 0) {
                if (v1 > 0) {
                    if (v1 <= arg2) {
                        arg7.loss_input == 0 || arg2 < arg7.loss_input
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                arg7.checks_left = arg7.checks_left - 1;
                arg7.loss_input = arg2;
                arg7.loss_output = v1;
                arg7.maximum = certified_tail_maximum(arg0, arg2, arg7.maximum, arg4);
            };
        } else if (v2 == 7) {
            arg7.maximum = 0x1::u128::min(arg7.maximum, arg2 - 1);
        } else {
            arg5.complete = false;
            if (arg5.status == 0 || arg5.status == 1) {
                arg5.status = v2;
            };
        };
    }

    public fun evaluations(arg0: &OptimizeResult) : u64 {
        arg0.evaluations
    }

    public fun extend_v3_prefix_cache(arg0: &vector<TickBoundary>, arg1: &mut V3PrefixCache, arg2: u128, arg3: u64) : u64 {
        let v0 = 0x1::vector::length<V3Prefix>(&arg1.prefixes);
        if (v0 == arg3) {
            return 0
        };
        let (v1, v2, v3, v4) = if (v0 == 0) {
            (0, 0, arg1.sqrt_price_x64, arg1.liquidity)
        } else {
            let v5 = 0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v0 - 1);
            (v5.cumulative_input, v5.cumulative_output, v5.end_sqrt_price_x64, v5.liquidity_after)
        };
        let v6 = v4;
        let v7 = v3;
        let v8 = v2;
        let v9 = v1;
        if (v0 > 0 && (0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v0 - 1).crossing_input > arg2 || arg1.policy_stop_at_zero_liquidity && v4 == 0)) {
            return 0
        };
        let v10 = arg1.boundary_cursor + v0;
        let v11 = v10;
        while (v11 < arg1.boundary_cursor + arg3) {
            let v12 = *0x1::vector::borrow<TickBoundary>(arg0, v11);
            let v13 = if (v6 == 0) {
                0
            } else if (arg1.zero_for_one) {
                amount0_delta_up(v7, v12.sqrt_price_x64, v6)
            } else {
                mul_div_up(v6, v12.sqrt_price_x64 - v7, 18446744073709551616)
            };
            let v14 = gross_from_effective(v13, arg1.fee_rate, arg1.fee_denominator);
            let v15 = if (v6 == 0) {
                0
            } else if (arg1.zero_for_one) {
                mul_div_down(v6, v7 - v12.sqrt_price_x64, 18446744073709551616)
            } else {
                amount0_delta_down(v7, v12.sqrt_price_x64, v6)
            };
            if (v9 > 340282366920938463463374607431768211455 - v14 || v8 > 340282366920938463463374607431768211455 - v15) {
                arg1.status = 5;
                return v11 - v10 + 1
            };
            let v16 = v9 + v14;
            let v17 = if (arg1.momentum_fee_round_nearest) {
                let v18 = ((arg1.fee_denominator - arg1.fee_rate) as u256);
                v13 + to_u128(((v13 as u256) * (arg1.fee_rate as u256) + v18 / 2) / v18)
            } else {
                v14
            };
            let v19 = v9 + v17;
            v9 = v19;
            let v20 = v8 + v15;
            v8 = v20;
            let (v21, v22) = liquidity_after_boundary(v6, v12, arg1.zero_for_one);
            if (!v22) {
                arg1.status = 5;
                return v11 - v10 + 1
            };
            v6 = v21;
            let v23 = v12.sqrt_price_x64;
            v7 = v23;
            let v24 = V3Prefix{
                cumulative_input   : v19,
                crossing_input     : v16,
                cumulative_output  : v20,
                end_sqrt_price_x64 : v23,
                liquidity_after    : v21,
            };
            0x1::vector::push_back<V3Prefix>(&mut arg1.prefixes, v24);
            v11 = v11 + 1;
            if (v16 > arg2 || arg1.policy_stop_at_zero_liquidity && v21 == 0) {
                break
            };
        };
        v11 - v10
    }

    fun finite_mk_search(arg0: vector<Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u64) : OptimizeResult {
        let (v0, v1, v2) = prepare_v3_prefix_caches(&arg0, arg6);
        let v3 = v0;
        let v4 = empty_result();
        if (v1 != 0) {
            v4.status = v1;
            v4.complete = false;
            return v4
        };
        let v5 = arg6 - v2;
        let (v6, _) = orderbook_shortfall_memos(&arg0);
        let v8 = v6;
        let v9 = 0x1::vector::borrow<Hop>(&arg0, 0);
        let v10 = if (v9.kind == 2) {
            if (v9.orderbook_base_to_quote) {
                if (v9.fee_rate == 0) {
                    v9.orderbook_lot_size % arg3 == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v11 = if (v10) {
            v9.orderbook_lot_size
        } else {
            arg3
        };
        let v12 = 0x1::u128::max(arg1, v9.policy.input_minimum);
        let v13 = 0;
        let v14 = vector[];
        let v15 = false;
        let v16 = 0;
        let v17 = 0x1::vector::length<Hop>(&arg0) * (2 * 0x1::vector::length<Hop>(&arg0) + 4);
        loop {
            let v18 = if (v13 < arg2) {
                if (v4.segments < arg4) {
                    if (v4.evaluations < arg5) {
                        v5 >= v17
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v18) {
                let v19 = first_missing_linear_segment(&arg0);
                let v20 = first_missing_orderbook_segment(&arg0);
                let v21 = first_missing_boundary(&arg0);
                let v22 = if (v19 != 18446744073709551615) {
                    true
                } else if (v20 != 18446744073709551615) {
                    true
                } else {
                    v21 != 18446744073709551615
                };
                if (v22) {
                    v4.needs_more_hop = 0x1::u64::min(0x1::u64::min(v19, v20), v21);
                    v4.status = 3;
                    v4.complete = false;
                    return v4
                };
                if (has_terminal_finite_hop(&arg0) || !orderbook_minimums_reachable(&arg0)) {
                    v15 = true;
                    break
                };
                let v23 = v5;
                v5 = v23 - v17;
                let (v24, v25) = route_coefficients_x64(&arg0);
                let (v26, _) = next_route_boundary(&arg0, arg2 - v13);
                if (v26 == 0) {
                    v15 = true;
                    break
                };
                v4.segments = v4.segments + 1;
                let v28 = finite_segment_minimum(&arg0, coefficient_root(mul_ratio_down_saturating(v24, q64(), auxiliary_cost_x64(&arg0)), v25, v26), v26);
                let v29 = v28 < v26;
                let v30 = if (v29) {
                    v28
                } else {
                    v26
                };
                let v31 = aligned_in_range(v13 + v30, v12, arg2, v11);
                let v32 = 0x1::vector::empty<u128>();
                0x1::vector::push_back<u128>(&mut v32, v31);
                if (v31 >= v12 && v31 - v12 >= v11) {
                    0x1::vector::push_back<u128>(&mut v32, v31 - v11);
                };
                if (v31 <= arg2 && arg2 - v31 >= v11) {
                    0x1::vector::push_back<u128>(&mut v32, v31 + v11);
                };
                let v33 = 0;
                loop {
                    let v34 = if (v33 < 0x1::vector::length<u128>(&v32)) {
                        if (v4.evaluations < arg5) {
                            v5 > 0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v34) {
                        let v35 = *0x1::vector::borrow<u128>(&v32, v33);
                        v33 = v33 + 1;
                        if (v35 == 0) {
                            continue
                        };
                        let v36 = amount_lower_bound(&v14, v35);
                        if (v36 < 0x1::vector::length<u128>(&v14) && *0x1::vector::borrow<u128>(&v14, v36) == v35) {
                            continue
                        };
                        let v37 = &mut v3;
                        let v38 = &mut v8;
                        let v39 = &mut v14;
                        let v40 = &mut v5;
                        let v41 = &mut v4;
                        let v42 = progressive_probe(&arg0, v37, v38, v35, v36, v39, v40, v41);
                        if (v42.status == 0 && v42.amount > 0) {
                            v16 = v35;
                        };
                        if (v42.status == 3 || v42.status == 7) {
                            let v43 = v16;
                            loop {
                                let v44 = if (v35 > v43) {
                                    if (v35 - v43 > v11) {
                                        if (v4.evaluations < arg5) {
                                            v5 > 0
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                };
                                if (v44) {
                                    let v45 = aligned_in_range(v43 + (v35 - v43) / 2, v12, arg2, v11);
                                    let v46 = amount_lower_bound(&v14, v45);
                                    if (v45 == 0 || v46 < 0x1::vector::length<u128>(&v14) && *0x1::vector::borrow<u128>(&v14, v46) == v45) {
                                        break
                                    };
                                    let v47 = &mut v3;
                                    let v48 = &mut v8;
                                    let v49 = &mut v14;
                                    let v50 = &mut v5;
                                    let v51 = &mut v4;
                                    let v52 = progressive_probe(&arg0, v47, v48, v45, v46, v49, v50, v51);
                                    if (v52.status == 0 || v52.status == 1) {
                                        v43 = v45;
                                        continue
                                    };
                                    v35 = v45;
                                } else {
                                    break
                                };
                            };
                            if (!v4.found) {
                                v4.status = v42.status;
                            };
                            v4.complete = false;
                            return v4
                        };
                        let v53 = if (v42.status == 2) {
                            true
                        } else if (v42.status == 5) {
                            true
                        } else if (v42.status == 6) {
                            true
                        } else {
                            v42.status == 12
                        };
                        if (v53) {
                            return v4
                        };
                    } else {
                        break
                    };
                };
                if (v29 || v13 + v26 == arg2) {
                    v15 = true;
                    break
                };
                let v54 = &mut arg0;
                let (_, v56, v57) = advance_route(v54, v26);
                v4.crossed_ticks = v4.crossed_ticks + v56;
                v4.crossed_orders = v4.crossed_orders + v57;
                v13 = v13 + v26;
            } else {
                break
            };
        };
        v4.complete = v15;
        if (!v15 && (v4.status == 0 || v4.status == 1)) {
            let v58 = if (v5 < v17) {
                6
            } else {
                9
            };
            v4.status = v58;
        };
        v4
    }

    fun finite_mk_window_fits(arg0: &vector<Hop>, arg1: u64, arg2: u64) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            let v3 = v0 + 0x1::vector::length<LinearSegment>(&v2.linear_segments) + 0x1::vector::length<OrderbookSegment>(&v2.orderbook_segments) + 0x1::vector::length<TickBoundary>(&v2.boundaries);
            v0 = v3;
            if (v3 > 0x1::u64::min(0x1::u64::min(arg1 / 3, arg2), 4) || v2.kind == 2 && v2.orderbook_lot_size > 1) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun finite_segment_minimum(arg0: &vector<Hop>, arg1: u128, arg2: u128) : u128 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            let v3 = v2.policy.input_minimum;
            let v4 = v3;
            if (v2.kind == 2 && v2.orderbook_consumed_base < v2.orderbook_min_size) {
                let v5 = round_up_to_quantum(v2.orderbook_min_size - v2.orderbook_consumed_base, v2.orderbook_lot_size);
                let v6 = 0x1::vector::borrow<OrderbookSegment>(&v2.orderbook_segments, v2.orderbook_cursor);
                if (v5 > v6.remaining_base) {
                    return arg2
                };
                let v7 = if (v2.orderbook_base_to_quote) {
                    v5
                } else {
                    mul_div_up(v5, v6.price, 1000000000)
                };
                v4 = 0x1::u128::max(v3, gross_from_effective(v7, v2.fee_rate, v2.fee_denominator));
            };
            if (v4 > 0) {
                let (v8, v9) = source_input_for_local(arg0, v1, v4);
                if (!v9) {
                    return arg2
                };
                v0 = 0x1::u128::max(v0, v8);
            };
            v1 = v1 + 1;
        };
        0x1::u128::min(v0, arg2)
    }

    fun first_missing_boundary(arg0: &vector<Hop>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (v1.kind == 1 && v1.boundary_cursor >= 0x1::vector::length<TickBoundary>(&v1.boundaries)) {
                return v0
            };
            let v2 = if (v1.kind == 2) {
                if (v1.orderbook_cursor >= 0x1::vector::length<OrderbookSegment>(&v1.orderbook_segments)) {
                    v1.orderbook_has_more
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return v0
            };
            let v3 = if (v1.kind == 3) {
                if (v1.linear_cursor >= 0x1::vector::length<LinearSegment>(&v1.linear_segments)) {
                    v1.linear_has_more
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                return v0
            };
            v0 = v0 + 1;
        };
        18446744073709551615
    }

    fun first_missing_linear_segment(arg0: &vector<Hop>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            let v2 = if (v1.kind == 3) {
                if (v1.linear_cursor >= 0x1::vector::length<LinearSegment>(&v1.linear_segments)) {
                    v1.linear_has_more
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return v0
            };
            v0 = v0 + 1;
        };
        18446744073709551615
    }

    fun first_missing_orderbook_segment(arg0: &vector<Hop>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            let v2 = if (v1.kind == 2) {
                if (v1.orderbook_cursor >= 0x1::vector::length<OrderbookSegment>(&v1.orderbook_segments)) {
                    v1.orderbook_has_more
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return v0
            };
            v0 = v0 + 1;
        };
        18446744073709551615
    }

    public fun flowx_v2_exact_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : Hop {
        let v0 = v2_hop(arg0, arg1, arg2, arg3);
        v0.policy.fractional_input_fee = true;
        v0
    }

    public fun found(arg0: &OptimizeResult) : bool {
        arg0.found
    }

    public fun gross_from_effective(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_up(arg0, (arg2 as u128), ((arg2 - arg1) as u128))
    }

    public fun gross_profit(arg0: &OptimizeResult) : u128 {
        arg0.gross_profit
    }

    fun has_execution_bounds(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            let v2 = if (v1.policy.input_minimum > 0) {
                true
            } else if (v1.policy.input_capacity < 340282366920938463463374607431768211455) {
                true
            } else {
                v1.policy.output_capacity < 340282366920938463463374607431768211455
            };
            if (v2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun has_terminal_finite_hop(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (orderbook_terminal(v1.kind, v1.orderbook_cursor, v1.orderbook_has_more, &v1.orderbook_segments) || linear_terminal(v1.kind, v1.linear_cursor, v1.linear_has_more, &v1.linear_segments)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun hasui_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: bool) : Hop {
        let v0 = arg0 != 0 && arg1 != 0;
        let (v1, v2) = if (!v0) {
            (1, 1)
        } else if (arg6) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        let v3 = if (arg6 && arg4 || arg5) {
            2
        } else if (arg2 > 10000000) {
            5
        } else {
            0
        };
        let v4 = empty_hop(10);
        let v5 = if (arg6) {
            0
        } else {
            arg2
        };
        v4.output_fee_rate = v5;
        v4.output_fee_denominator = 10000000;
        v4.reserve_in = (v1 as u128);
        v4.reserve_out = (v2 as u128);
        v4.zero_for_one = arg6;
        let v6 = if (arg6) {
            1000000000
        } else {
            1
        };
        v4.stable_amp = v6;
        let v7 = if (arg6) {
            0
        } else {
            1000000000
        };
        v4.stable_scale_in = v7;
        let v8 = if (arg6) {
            0
        } else {
            (arg3 as u128)
        };
        v4.stable_scale_out = v8;
        v4.state_status = v3;
        v4
    }

    public fun hawal_capacity_stage(arg0: u64) : StagedHop {
        StagedHop{
            kind        : 3,
            liquidity   : (arg0 as u128),
            boundaries  : 0x1::vector::empty<TickBoundary>(),
            replacement : 0x1::vector::empty<Hop>(),
        }
    }

    public fun hawal_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: bool, arg8: bool) : Hop {
        let v0 = arg0 != 0 && arg1 != 0;
        let (v1, v2) = if (!v0 && arg8) {
            (1, 1)
        } else if (arg8) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        let v3 = arg8 && (arg4 || arg6 == 0) || arg5;
        let v4 = if (!arg7) {
            5
        } else if (v3) {
            2
        } else if (arg2 > 10000000 || !arg8 && !v0) {
            5
        } else {
            0
        };
        let v5 = empty_hop(11);
        let v6 = if (arg8) {
            0
        } else {
            arg2
        };
        v5.output_fee_rate = v6;
        v5.output_fee_denominator = 10000000;
        v5.reserve_in = (v1 as u128);
        v5.reserve_out = (v2 as u128);
        v5.zero_for_one = arg8;
        v5.stable_amp = 1000000000;
        v5.stable_scale_in = 1;
        v5.stable_scale_out = (arg3 as u128);
        v5.state_status = v4;
        v5
    }

    fun hop_affine_upper(arg0: &Hop) : (bool, u256, u256) {
        let v0 = if (arg0.kind == 0) {
            true
        } else if (arg0.kind == 1) {
            true
        } else if (arg0.kind == 4) {
            true
        } else if (arg0.kind == 2) {
            true
        } else if (arg0.kind == 12) {
            true
        } else {
            arg0.kind == 13
        };
        let (v1, v2) = if (v0) {
            (hop_marginal_upper_x64(arg0), 0)
        } else {
            let v3 = if (arg0.kind == 9) {
                true
            } else if (arg0.kind == 17) {
                true
            } else if (arg0.kind == 10) {
                true
            } else {
                arg0.kind == 11
            };
            if (v3) {
                let (v4, v5, v6) = affine_ratio(arg0.fee_denominator, arg0.fee_rate, arg0.kind, arg0.output_fee_denominator, arg0.output_fee_rate, arg0.reserve_in, arg0.reserve_out);
                if (!v4) {
                    return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
                };
                (v5, v6)
            } else if (arg0.kind == 19) {
                let v7 = if (arg0.zero_for_one) {
                    0
                } else {
                    1
                };
                (meta_upper_rate(arg0), v7)
            } else if (arg0.kind == 14) {
                let (v8, v9, v10) = affine_steamm_cpmm(arg0.output_fee_denominator, arg0.output_fee_rate, arg0.reserve_in, arg0.reserve_out, arg0.stable_amp, arg0.stable_scale_in, arg0.stable_scale_out);
                if (!v8) {
                    return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
                };
                (v9, v10)
            } else if (arg0.kind == 15) {
                let (v11, v12, v13) = affine_steamm_omm(arg0.liquidity, arg0.output_fee_denominator, arg0.output_fee_rate, arg0.reserve_in, arg0.stable_admin_fee, arg0.stable_amp, arg0.stable_lp_fee, arg0.stable_scale_out);
                if (!v11) {
                    return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
                };
                (v12, v13)
            } else {
                let v14 = if (arg0.kind == 5) {
                    true
                } else if (arg0.kind == 6) {
                    true
                } else {
                    arg0.kind == 8
                };
                if (v14) {
                    (0, (arg0.reserve_out as u256))
                } else if (arg0.kind == 16) {
                    (0, (arg0.sqrt_price_x64 as u256))
                } else {
                    let (v15, v16) = if (arg0.kind == 7) {
                        let (v17, v18, v19) = affine_virtual_cpmm(arg0.fee_denominator, arg0.fee_rate, arg0.reserve_in, arg0.reserve_out, arg0.sqrt_price_x64, arg0.stable_amp, arg0.stable_scale_in, arg0.stable_scale_out, arg0.zero_for_one);
                        if (!v17) {
                            return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
                        };
                        (v19, v18)
                    } else {
                        let v20 = if (arg0.kind == 3) {
                            if (!arg0.linear_has_more) {
                                if (arg0.linear_cursor == 0) {
                                    0x1::vector::length<LinearSegment>(&arg0.linear_segments) == 1
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v20) {
                            let (v21, v22, v23) = affine_linear(&arg0.linear_segments);
                            if (!v21) {
                                return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
                            };
                            (v23, v22)
                        } else {
                            return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
                        }
                    };
                    (v16, v15)
                }
            }
        };
        (true, v1, v2)
    }

    fun hop_curvature_x64(arg0: &Hop) : u256 {
        if (arg0.kind == 0) {
            cap_curvature_v2(arg0.reserve_in, ((arg0.fee_denominator - arg0.fee_rate) as u256) * q64() / (arg0.fee_denominator as u256))
        } else if (arg0.kind == 1) {
            cap_curvature_v3(arg0.liquidity, arg0.sqrt_price_x64, arg0.zero_for_one, ((arg0.fee_denominator - arg0.fee_rate) as u256) * q64() / (arg0.fee_denominator as u256))
        } else if (arg0.kind == 2) {
            cap_curvature_orderbook()
        } else {
            assert!(arg0.kind == 3, 1);
            cap_curvature_linear()
        }
    }

    fun hop_marginal_upper_x64(arg0: &Hop) : u256 {
        if (arg0.kind == 19) {
            return meta_upper_rate(arg0)
        };
        if (arg0.kind == 18) {
            let v0 = 0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::price(0x1::vector::borrow<0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::State>(&arg0.policy.bolt, 0));
            return if (v0 == 0) {
                115792089237316195423570985008687907853269984665640564039457584007913129639935
            } else {
                div_ceil(1000000000000000000 * q64(), (v0 as u256))
            }
        };
        let v2 = if (arg0.kind == 0) {
            cap_upper_v2(arg0.reserve_in, arg0.reserve_out)
        } else if (arg0.kind == 1 || arg0.kind == 4) {
            cap_upper_v3(arg0.sqrt_price_x64, arg0.zero_for_one)
        } else if (arg0.kind == 2) {
            cap_upper_orderbook(arg0.kind, arg0.orderbook_base_to_quote, arg0.orderbook_cursor, arg0.orderbook_has_more, &arg0.orderbook_segments)
        } else if (arg0.kind == 3) {
            cap_upper_linear(arg0.kind, arg0.linear_cursor, arg0.linear_has_more, &arg0.linear_segments)
        } else if (arg0.kind == 12) {
            cap_upper_aftermath_prepared(arg0.reserve_in, arg0.reserve_out, arg0.stable_admin_fee, (arg0.liquidity as u256), arg0.stable_scale_in, arg0.stable_scale_out)
        } else {
            assert!(arg0.kind == 13, 1);
            cap_upper_bucket_psm(arg0.stable_scale_in, arg0.stable_scale_out, arg0.zero_for_one)
        };
        mul_fraction_ceil(mul_fraction_ceil(v2, ((arg0.fee_denominator - arg0.fee_rate) as u256), (arg0.fee_denominator as u256)), ((arg0.output_fee_denominator - arg0.output_fee_rate) as u256), (arg0.output_fee_denominator as u256))
    }

    fun hop_marginal_x64(arg0: &Hop) : u256 {
        let v0 = if (arg0.kind == 0) {
            cap_marginal_v2(arg0.reserve_in, arg0.reserve_out)
        } else if (arg0.kind == 1 || arg0.kind == 4) {
            cap_marginal_v3(arg0.sqrt_price_x64, arg0.zero_for_one)
        } else if (arg0.kind == 2) {
            cap_marginal_orderbook(arg0.kind, arg0.orderbook_base_to_quote, arg0.orderbook_cursor, arg0.orderbook_has_more, &arg0.orderbook_segments)
        } else if (arg0.kind == 3) {
            cap_marginal_linear(arg0.kind, arg0.linear_cursor, arg0.linear_has_more, &arg0.linear_segments)
        } else if (arg0.kind == 12) {
            cap_marginal_aftermath_geometric(arg0.reserve_in, arg0.reserve_out, arg0.stable_admin_fee, arg0.stable_amp, arg0.stable_scale_in, arg0.stable_scale_out)
        } else {
            assert!(arg0.kind == 13, 1);
            cap_marginal_bucket_psm(arg0.stable_scale_in, arg0.stable_scale_out, arg0.zero_for_one)
        };
        v0 * ((arg0.fee_denominator - arg0.fee_rate) as u256) / (arg0.fee_denominator as u256) * ((arg0.output_fee_denominator - arg0.output_fee_rate) as u256) / (arg0.output_fee_denominator as u256)
    }

    fun input_to_current_boundary(arg0: &Hop) : u128 {
        if (arg0.kind == 2) {
            return orderbook_input_boundary(arg0.fee_denominator, arg0.fee_rate, arg0.orderbook_base_to_quote, arg0.orderbook_cursor, &arg0.orderbook_segments)
        };
        if (arg0.kind == 3) {
            return linear_input_boundary(arg0.linear_cursor, &arg0.linear_segments)
        };
        clmm_input_boundary(arg0.fee_denominator, arg0.fee_rate, arg0.liquidity, arg0.sqrt_price_x64, arg0.zero_for_one, current_boundary(arg0))
    }

    fun inverse_hop(arg0: &Hop, arg1: u128) : (u128, bool) {
        if (arg1 == 0) {
            return (0, true)
        };
        if (arg0.kind == 0) {
            return cap_inverse_v2(arg0.fee_denominator, arg0.fee_rate, arg0.output_fee_denominator, arg0.output_fee_rate, arg0.reserve_in, arg0.reserve_out, arg1)
        };
        if (arg0.kind == 1) {
            return cap_inverse_v3(arg0.fee_denominator, arg0.fee_rate, arg0.liquidity, arg0.sqrt_price_x64, arg0.zero_for_one, current_boundary(arg0), arg1)
        };
        if (arg0.kind == 2) {
            return cap_inverse_orderbook(arg0.fee_denominator, arg0.fee_rate, arg0.orderbook_base_to_quote, arg0.orderbook_cursor, arg0.orderbook_lot_size, &arg0.orderbook_segments, arg1)
        };
        assert!(arg0.kind == 3, 1);
        cap_inverse_linear(arg0.fee_denominator, arg0.fee_rate, arg0.linear_cursor, &arg0.linear_segments, arg1)
    }

    public fun join_staged_route(arg0: vector<Hop>, arg1: vector<StagedHop>) : vector<Hop> {
        let v0 = 0x1::vector::empty<Hop>();
        while (0x1::vector::length<Hop>(&arg0) > 0) {
            let v1 = 0x1::vector::pop_back<Hop>(&mut arg0);
            let StagedHop {
                kind        : v2,
                liquidity   : v3,
                boundaries  : v4,
                replacement : v5,
            } = 0x1::vector::pop_back<StagedHop>(&mut arg1);
            let v6 = v5;
            if (v2 == 0) {
                0x1::vector::push_back<Hop>(&mut v0, v1);
                continue
            };
            if (v2 == 1) {
                v1.kind = 1;
                v1.liquidity = v3;
                0x1::vector::append<TickBoundary>(&mut v1.boundaries, v4);
                let v7 = &mut v1;
                normalize_v3_initial_boundary(v7);
                0x1::vector::push_back<Hop>(&mut v0, v1);
                continue
            };
            if (v2 == 3) {
                v1.stable_scale_out = v3;
                0x1::vector::push_back<Hop>(&mut v0, v1);
                continue
            };
            assert!(v2 == 2, 1);
            0x1::vector::push_back<Hop>(&mut v0, 0x1::vector::pop_back<Hop>(&mut v6));
        };
        0x1::vector::reverse<Hop>(&mut v0);
        v0
    }

    public fun kriya_v2_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: bool) : Hop {
        let (v0, v1, v2, v3) = if (arg8) {
            (arg0, arg1, arg5, arg6)
        } else {
            (arg1, arg0, arg6, arg5)
        };
        let v4 = if (!arg4 || v2 == 0) {
            0
        } else {
            (v0 as u256) * 100000000 / (v2 as u256)
        };
        let v5 = if (!arg4 || v3 == 0) {
            0
        } else {
            (v1 as u256) * 100000000 / (v3 as u256)
        };
        let v6 = if (!arg7) {
            2
        } else {
            let v7 = if (v0 == 0) {
                true
            } else if (v1 == 0) {
                true
            } else if ((arg2 as u128) + (arg3 as u128) >= 1000000) {
                true
            } else if (arg4) {
                if (v2 == 0) {
                    true
                } else if (v3 == 0) {
                    true
                } else if (v4 == 0) {
                    true
                } else if (v5 == 0) {
                    true
                } else if (v4 > 10000000000000000000) {
                    true
                } else {
                    v5 > 10000000000000000000
                }
            } else {
                false
            };
            if (v7) {
                5
            } else {
                0
            }
        };
        let v8 = empty_hop(8);
        v8.fee_rate = arg3;
        v8.fee_denominator = 1000000;
        v8.output_fee_rate = arg2;
        v8.output_fee_denominator = 1000000;
        v8.reserve_in = (v0 as u128);
        v8.reserve_out = (v1 as u128);
        v8.zero_for_one = arg8;
        v8.stable_amp = 100000000;
        v8.stable_scale_in = (v2 as u128);
        v8.stable_scale_out = (v3 as u128);
        v8.stable_fee_on_input = arg4;
        v8.state_status = v6;
        v8
    }

    public fun kriya_ve33_get_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        ve33_solve_y(arg0, arg1, arg2, arg3, 1)
    }

    public fun largest_gap_midpoint(arg0: &vector<u128>, arg1: u128, arg2: u128, arg3: u128) : u128 {
        let v0 = arg2;
        let v1 = 0;
        let v2 = 0x1::vector::length<u128>(arg0);
        let v3 = 0;
        while (v3 <= v2) {
            let v4 = if (v3 == v2) {
                arg2
            } else {
                let v5 = *0x1::vector::borrow<u128>(arg0, v3);
                if (v5 > arg2) {
                    arg2
                } else {
                    v5
                }
            };
            if (v4 > arg1) {
                if (v4 - arg1 > v1) {
                    v1 = v4 - arg1;
                    v0 = v4;
                };
            };
            if (v4 == arg2) {
                break
            };
            v3 = v3 + 1;
        };
        aligned_in_range(midpoint(arg1, v0), arg1, arg2, arg3)
    }

    fun limited_segment_input(arg0: &vector<Hop>, arg1: u128) : (u128, bool) {
        if (!segment_within_capacity(arg0, arg1)) {
            let v0 = arg1;
            let v1 = 0;
            while (v1 < 0x1::vector::length<Hop>(arg0)) {
                let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
                if (v2.policy.input_capacity < 340282366920938463463374607431768211455) {
                    let (v3, v4) = source_input_for_local(arg0, v1, v2.policy.input_capacity + 1);
                    if (v4) {
                        v0 = 0x1::u128::min(v0, v3);
                    };
                };
                if (v2.policy.output_capacity < 340282366920938463463374607431768211455) {
                    let (v5, v6) = inverse_hop(v2, v2.policy.output_capacity + 1);
                    if (v6) {
                        let (v7, v8) = source_input_for_local(arg0, v1, v5);
                        if (v8) {
                            v0 = 0x1::u128::min(v0, v7);
                        };
                    };
                };
                v1 = v1 + 1;
            };
            if (segment_within_capacity(arg0, v0)) {
                return (v0, true)
            };
            let v9 = 0;
            let v10 = 0;
            while (v0 - v9 > 1 && v10 < 12) {
                let v11 = v9 + (v0 - v9) / 2;
                if (segment_within_capacity(arg0, v11)) {
                    v9 = v11;
                } else {
                    v0 = v11;
                };
                v10 = v10 + 1;
            };
            return (v9, true)
        };
        (arg1, false)
    }

    public fun linear_hop(arg0: vector<LinearSegment>, arg1: bool) : Hop {
        linear_hop_impl(arg0, arg1, false)
    }

    public fun linear_hop_from_capacities(arg0: vector<u128>, arg1: vector<u128>, arg2: bool) : Hop {
        let v0 = 0x1::vector::empty<LinearSegment>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0)) {
            0x1::vector::push_back<LinearSegment>(&mut v0, linear_segment(*0x1::vector::borrow<u128>(&arg0, v1), *0x1::vector::borrow<u128>(&arg1, v1)));
            v1 = v1 + 1;
        };
        linear_hop(v0, arg2)
    }

    fun linear_hop_impl(arg0: vector<LinearSegment>, arg1: bool, arg2: bool) : Hop {
        let v0 = empty_hop(3);
        v0.linear_segments = arg0;
        v0.linear_has_more = arg1;
        v0.policy.linear_rate_inversion = arg2;
        v0
    }

    public fun linear_input_boundary(arg0: u64, arg1: &vector<LinearSegment>) : u128 {
        current_linear_segment(arg0, arg1).remaining_input
    }

    public fun linear_marginal_fraction(arg0: &LinearSegment) : (u256, u256) {
        if (!arg0.exact_dlmm) {
            return ((arg0.remaining_output as u256) * q64(), (arg0.remaining_input as u256))
        };
        if (arg0.forward) {
            ((arg0.price_x64 as u256) * ((arg0.fee_denominator - arg0.fee_rate) as u256), (arg0.fee_denominator as u256))
        } else {
            (q64() * q64() * ((arg0.fee_denominator - arg0.fee_rate) as u256), (arg0.price_x64 as u256) * (arg0.fee_denominator as u256))
        }
    }

    public fun linear_rate_hop(arg0: u128) : Hop {
        let v0 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v0, 18446744073709551616);
        let v1 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v1, arg0);
        linear_hop_from_capacities(v0, v1, false)
    }

    public fun linear_segment(arg0: u128, arg1: u128) : LinearSegment {
        LinearSegment{
            remaining_input  : arg0,
            remaining_output : arg1,
            price_x64        : 0,
            fee_rate         : 0,
            fee_denominator  : 1,
            forward          : true,
            exact_dlmm       : false,
        }
    }

    public fun linear_stage_from_capacities_if(arg0: vector<u128>, arg1: vector<u128>, arg2: bool, arg3: bool) : StagedHop {
        if (!arg3) {
            return reuse_current_stage()
        };
        replacement_stage(linear_hop_from_capacities(arg0, arg1, arg2))
    }

    public fun linear_terminal(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<LinearSegment>) : bool {
        if (arg0 == 3) {
            if (arg1 >= 0x1::vector::length<LinearSegment>(arg3)) {
                !arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun liquidity_after_boundary(arg0: u128, arg1: TickBoundary, arg2: bool) : (u128, bool) {
        if (arg2 && !arg1.negative || arg1.negative) {
            if (arg0 < arg1.liquidity_net_abs) {
                (0, false)
            } else {
                (arg0 - arg1.liquidity_net_abs, true)
            }
        } else if (arg0 > 340282366920938463463374607431768211455 - arg1.liquidity_net_abs) {
            (0, false)
        } else {
            (arg0 + arg1.liquidity_net_abs, true)
        }
    }

    public fun log2_down(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >> 128 > 0) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >> 64 > 0) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >> 32 > 0) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >> 16 > 0) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >> 8 > 0) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >> 4 > 0) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >> 2 > 0) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >> 1 > 0) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun lst_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : Hop {
        lst_ratio_hop_with_minimum(arg0, arg1, arg2, arg3, arg4, arg5, 0)
    }

    public fun lst_ratio_hop_with_minimum(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64) : Hop {
        let (v0, v1, v2) = if (arg5) {
            (arg0, arg1, arg2)
        } else {
            (arg1, arg0, arg3)
        };
        let v3 = if (arg4) {
            2
        } else {
            let v4 = if (v0 == 0) {
                true
            } else if (v1 == 0) {
                true
            } else if (arg2 > 10000) {
                true
            } else {
                arg3 > 10000
            };
            if (v4) {
                5
            } else {
                0
            }
        };
        let v5 = empty_hop(9);
        v5.fee_rate = v2;
        v5.fee_denominator = 10000;
        v5.reserve_in = (v0 as u128);
        v5.reserve_out = (v1 as u128);
        v5.zero_for_one = arg5;
        v5.stable_amp = (arg6 as u128);
        v5.stable_scale_in = 1;
        v5.stable_scale_out = 1;
        v5.stable_fee_on_input = arg5;
        v5.state_status = v3;
        v5
    }

    fun meta_exchange(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : (u128, u8) {
        let v0 = if (arg4 > arg3) {
            (arg0 as u256) * (arg4 as u256) / (arg3 as u256)
        } else {
            (arg0 as u256)
        };
        if (v0 > (18446744073709551615 as u256)) {
            return (0, 12)
        };
        let v1 = v0 * (arg1 as u256) / (arg2 as u256);
        if (v1 > (18446744073709551615 as u256)) {
            return (0, 12)
        };
        let v2 = if (arg4 < arg3) {
            if (v1 > 0) {
                v1 < ((arg3 / arg4) as u256)
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            return (0, 10)
        };
        let v3 = if (arg4 < arg3) {
            ((v1 / ((arg3 / arg4) as u256)) as u128)
        } else {
            (v1 as u128)
        };
        (v3, 0)
    }

    fun meta_upper_rate(arg0: &Hop) : u256 {
        if (arg0.state_status != 0 || arg0.policy.input_capacity == 0) {
            return 0
        };
        let (v0, v1, v2, v3) = if (arg0.zero_for_one) {
            (arg0.liquidity, 1000000000000000000, arg0.stable_scale_out, arg0.stable_scale_in)
        } else {
            (1000000000000000000, arg0.liquidity, arg0.stable_scale_in, arg0.stable_scale_out)
        };
        if (arg0.zero_for_one) {
            mul_ratio_up_saturating(mul_ratio_up_saturating(q64(), (v0 as u256), (v1 as u256)), (v3 as u256), (v2 as u256))
        } else {
            mul_ratio_up_saturating(mul_ratio_up_saturating(mul_ratio_up_saturating(q64(), (v0 as u256), (v1 as u256)), (v3 as u256), (v2 as u256)), 1000000000000000000 - (arg0.stable_admin_fee as u256), 1000000000000000000)
        }
    }

    public fun metastable_hop(arg0: vector<u128>, arg1: u8, arg2: bool) : Hop {
        let v0 = empty_hop(19);
        v0.state_status = arg1;
        if (arg1 != 0) {
            return v0
        };
        v0.reserve_in = *0x1::vector::borrow<u128>(&arg0, 0);
        v0.reserve_out = *0x1::vector::borrow<u128>(&arg0, 1);
        v0.stable_amp = *0x1::vector::borrow<u128>(&arg0, 2);
        let v1 = if (*0x1::vector::borrow<u128>(&arg0, 10) == 1) {
            *0x1::vector::borrow<u128>(&arg0, 3)
        } else if (arg2) {
            0x1::u128::min(*0x1::vector::borrow<u128>(&arg0, 3), 1000000000000000000)
        } else {
            0x1::u128::max(*0x1::vector::borrow<u128>(&arg0, 3), 1000000000000000000)
        };
        v0.liquidity = v1;
        v0.stable_admin_fee = (*0x1::vector::borrow<u128>(&arg0, 4) as u64);
        v0.stable_lp_fee = (*0x1::vector::borrow<u128>(&arg0, 5) as u64);
        v0.stable_scale_in = 0x1::u128::pow(10, (*0x1::vector::borrow<u128>(&arg0, 8) as u8));
        v0.stable_scale_out = 0x1::u128::pow(10, (*0x1::vector::borrow<u128>(&arg0, 9) as u8));
        v0.zero_for_one = arg2;
        if (!arg2) {
            let v2 = (*0x1::vector::borrow<u128>(&arg0, 2) as u256) * (*0x1::vector::borrow<u128>(&arg0, 6) as u256) / (*0x1::vector::borrow<u128>(&arg0, 7) as u256);
            if (v2 > (18446744073709551615 as u256)) {
                v0.state_status = 12;
                return v0
            };
            let (v3, v4) = meta_exchange((v2 as u128), 1000000000000000000, *0x1::vector::borrow<u128>(&arg0, 3), v0.stable_scale_in, v0.stable_scale_out);
            v0.sqrt_price_x64 = v3;
            v0.state_status = v4;
        };
        let v5 = if (arg2) {
            if (*0x1::vector::borrow<u128>(&arg0, 1) > *0x1::vector::borrow<u128>(&arg0, 0)) {
                *0x1::vector::borrow<u128>(&arg0, 1) - *0x1::vector::borrow<u128>(&arg0, 0)
            } else {
                0
            }
        } else {
            *0x1::vector::borrow<u128>(&arg0, 2)
        };
        v0.policy.input_capacity = v5;
        v0.policy.output_capacity = 18446744073709551615;
        v0
    }

    public fun midpoint(arg0: u128, arg1: u128) : u128 {
        arg0 + (arg1 - arg0) / 2
    }

    public fun momentum_v3_current_hop(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : Hop {
        let v0 = v3_current_hop(arg0, arg1, arg2, arg3);
        v0.policy.momentum_fee_round_nearest = true;
        v0.policy.output_capacity = 18446744073709551615;
        v0
    }

    public fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        to_u128((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        to_u128(div_up_u256((arg0 as u256) * (arg1 as u256), (arg2 as u256)))
    }

    public fun mul_fraction_ceil(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0 && arg1 <= arg2, 2);
        arg0 / arg2 * arg1 + div_ceil(arg0 % arg2 * arg1, arg2)
    }

    public fun mul_q64_ceil(arg0: u256, arg1: u256) : u256 {
        let v0 = q64();
        let v1 = arg0 % v0;
        saturating_add(saturating_add(saturating_mul(arg0 / v0, arg1), v1 * arg1 / v0), div_ceil(v1 * arg1 % v0, v0))
    }

    public fun mul_ratio_down_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 * arg1 / arg2
        }
    }

    public fun mul_ratio_up_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            div_ceil(arg0 * arg1, arg2)
        }
    }

    public fun needs_more_hop(arg0: &OptimizeResult) : u64 {
        arg0.needs_more_hop
    }

    public fun new_prefixCache(arg0: vector<V3Prefix>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: bool, arg10: bool) : V3PrefixCache {
        V3PrefixCache{
            prefixes                      : arg0,
            status                        : arg1,
            boundary_cursor               : arg2,
            fee_denominator               : arg3,
            fee_rate                      : arg4,
            liquidity                     : arg5,
            policy_output_capacity        : arg6,
            policy_stop_at_zero_liquidity : arg7,
            momentum_fee_round_nearest    : arg10,
            sqrt_price_x64                : arg8,
            zero_for_one                  : arg9,
        }
    }

    public fun new_shortfall(arg0: vector<OrderbookPrefix>, arg1: u128, arg2: u64) : OrderbookShortfall {
        OrderbookShortfall{
            prefixes      : arg0,
            minimum_gross : arg1,
            crossed       : arg2,
        }
    }

    fun next_route_boundary(arg0: &vector<Hop>, arg1: u128) : (u128, u64) {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            let v3 = if (v2.kind == 1) {
                true
            } else if (v2.kind == 2 && !orderbook_terminal(v2.kind, v2.orderbook_cursor, v2.orderbook_has_more, &v2.orderbook_segments)) {
                true
            } else {
                v2.kind == 3 && !linear_terminal(v2.kind, v2.linear_cursor, v2.linear_has_more, &v2.linear_segments)
            };
            if (v3) {
                let (v4, v5) = source_input_to_boundary(arg0, v1);
                if (v5 && v4 < arg1) {
                    v0 = v4;
                };
            };
            v1 = v1 + 1;
        };
        (v0, 18446744073709551615)
    }

    public fun next_sqrt_price(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: u128, arg5: u128) : u128 {
        let v0 = if (arg3) {
            amount0_delta_up(arg2, arg5, arg0)
        } else {
            mul_div_up(arg0, arg5 - arg2, 18446744073709551616)
        };
        if (arg4 >= v0) {
            return arg5
        };
        next_sqrt_price_partial(arg2, arg0, arg3, arg4, arg1)
    }

    public fun next_sqrt_price_partial(arg0: u128, arg1: u128, arg2: bool, arg3: u128, arg4: bool) : u128 {
        if (arg2) {
            let v1 = (arg0 as u256);
            let v2 = (arg3 as u256) * v1;
            arg0 - ((v2 * v1 / (((arg1 as u256) << 64) + v2)) as u128)
        } else {
            arg0 + mul_div_down(arg3, 18446744073709551616, arg1)
        }
    }

    fun normalize_v3_initial_boundary(arg0: &mut Hop) {
        let v0 = if (0x1::vector::is_empty<TickBoundary>(&arg0.boundaries)) {
            true
        } else {
            let v1 = *0x1::vector::borrow<TickBoundary>(&arg0.boundaries, 0);
            v1.sqrt_price_x64 != arg0.sqrt_price_x64
        };
        if (v0) {
            return
        };
        let v2 = *0x1::vector::borrow<TickBoundary>(&arg0.boundaries, 0);
        apply_liquidity_net(arg0, v2);
        arg0.boundary_cursor = 1;
        skip_empty_v3_boundaries(arg0);
    }

    fun numeric_bolt_events(arg0: &vector<Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: &mut u64) : vector<u128> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.kind == 18) {
                let v3 = 0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::input_breakpoints(0x1::vector::borrow<0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::State>(&v2.policy.bolt, 0));
                let v4 = 0;
                while (v4 < 0x1::vector::length<u128>(&v3) && *arg4 >= v1 + 1) {
                    *arg4 = *arg4 - v1 - 1;
                    let (v5, v6) = numeric_bolt_source(arg0, v1, *0x1::vector::borrow<u128>(&v3, v4));
                    let v7 = if (v6) {
                        if (v5 >= arg1) {
                            v5 <= arg2
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v7) {
                        let v8 = aligned_in_range(v5, arg1, arg2, arg3);
                        if (v8 > 0) {
                            if (arg2 - v8 >= arg3) {
                                0x1::vector::push_back<u128>(&mut v0, v8 + arg3);
                            };
                            if (v8 - arg1 >= arg3) {
                                0x1::vector::push_back<u128>(&mut v0, v8 - arg3);
                            };
                            0x1::vector::push_back<u128>(&mut v0, v8);
                        };
                    };
                    v4 = v4 + 1;
                };
            };
            if (v2.kind != 0) {
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun numeric_bolt_prefix_supported(arg0: &vector<Hop>) : bool {
        let v0 = false;
        let v1 = true;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v2).kind == 18) {
                if (v0 || !v1) {
                    return false
                };
                v0 = true;
            };
            let v3 = v1 && 0x1::vector::borrow<Hop>(arg0, v2).kind == 0;
            v1 = v3;
            v2 = v2 + 1;
        };
        true
    }

    fun numeric_bolt_source(arg0: &vector<Hop>, arg1: u64, arg2: u128) : (u128, bool) {
        while (arg1 > 0) {
            arg1 = arg1 - 1;
            let v0 = 0x1::vector::borrow<Hop>(arg0, arg1);
            if (v0.policy.fractional_input_fee) {
                let v1 = gross_from_effective(arg2, v0.output_fee_rate, v0.output_fee_denominator);
                if (v1 >= v0.reserve_out) {
                    return (0, false)
                };
                arg2 = to_u128(div_ceil((v1 as u256) * (v0.reserve_in as u256) * (v0.fee_denominator as u256), ((v0.reserve_out - v1) as u256) * ((v0.fee_denominator - v0.fee_rate) as u256)));
                continue
            };
            let (v2, v3) = inverse_hop(v0, arg2);
            if (!v3) {
                return (0, false)
            };
            arg2 = v2;
        };
        (arg2, true)
    }

    fun numeric_probe(arg0: &vector<Hop>, arg1: &vector<BoltFixedHop>, arg2: &mut vector<V3PrefixCache>, arg3: &mut vector<OrderbookShortfall>, arg4: u128, arg5: u64, arg6: &mut vector<u128>, arg7: &mut u64, arg8: &mut OptimizeResult) : ProgressiveSample {
        if (0x1::vector::is_empty<BoltFixedHop>(arg1)) {
            return progressive_probe(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        };
        0x1::vector::insert<u128>(arg6, arg4, arg5);
        arg8.evaluations = arg8.evaluations + 1;
        let v0 = *arg7;
        let (v1, v2) = bolt_cached_quote(arg1, arg4, arg7);
        if (v2 == 0) {
            record_candidate_with_fee(arg4, v1, 0, arg8);
        } else if (v2 != 1 && v2 != 7) {
            arg8.complete = false;
            arg8.status = v2;
        };
        let v3 = if (v2 == 0 && v1 > 0) {
            arg4
        } else {
            0
        };
        let v4 = if (v1 < arg4) {
            ((arg4 - v1) as u256)
        } else {
            ((v1 - arg4) as u256)
        };
        ProgressiveSample{
            amount    : v3,
            output    : v1,
            fee       : 0,
            work      : v0 - *arg7,
            negative  : v1 < arg4,
            magnitude : v4,
            status    : v2,
        }
    }

    fun numeric_refinement_point(arg0: &vector<u128>, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u8) : u128 {
        let v0 = amount_lower_bound(arg0, arg1);
        let v1 = if (v0 == 0) {
            arg2
        } else {
            *0x1::vector::borrow<u128>(arg0, v0 - 1)
        };
        let v2 = if (v0 + 1 == 0x1::vector::length<u128>(arg0)) {
            arg3
        } else {
            0x1::u128::min(*0x1::vector::borrow<u128>(arg0, v0 + 1), arg3)
        };
        let v3 = if (arg5 == 2) {
            382
        } else {
            1
        };
        let v4 = if (arg5 == 2) {
            1000
        } else {
            3
        };
        let v5 = arg1 - v1 >= v2 - arg1;
        let v6 = if (v5) {
            arg1 - v1
        } else {
            v2 - arg1
        };
        let v7 = if (v5) {
            arg1 - mul_div_down(v6, v3, v4)
        } else {
            arg1 + mul_div_down(v6, v3, v4)
        };
        let v8 = aligned_in_range(v7, arg2, arg3, arg4);
        if (contains_amount(arg0, v8)) {
            largest_gap_midpoint(arg0, arg2, arg3, arg4)
        } else {
            v8
        }
    }

    fun numeric_search_route_impl(arg0: vector<Hop>, arg1: vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: bool) : (OptimizeResult, vector<u128>) {
        if (arg2 > 0 && arg3 < arg2) {
            return (coarse_rejection(), vector[])
        };
        let v0 = if (arg2 > 0) {
            if (arg2 <= arg3) {
                if (arg4 > 0) {
                    if (arg6 > 0) {
                        if (arg6 <= 64) {
                            if (arg5 <= 60) {
                                if (arg7 > 0) {
                                    0x1::vector::length<u128>(&arg1) <= 2
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        assert!(!0x1::vector::is_empty<Hop>(&arg0), 5);
        let v1 = contains_bolt(&arg0);
        if (v1 && (arg8 == 0 || !numeric_bolt_prefix_supported(&arg0))) {
            return bolt_search(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
        };
        let v2 = if (arg8 != 0) {
            if (v1) {
                bolt_fixed_route(&arg0)
            } else {
                false
            }
        } else {
            false
        };
        let (v3, v4) = if (v2) {
            bolt_fixed_cache(&arg0)
        } else {
            (0x1::vector::empty<BoltFixedHop>(), 0)
        };
        let v5 = v3;
        let (v6, v7, v8) = if (v2) {
            (0, 0x1::vector::empty<V3PrefixCache>(), v4)
        } else {
            let (v9, v10, v11) = prepare_v3_prefix_caches(&arg0, arg7);
            (v11, v9, v10)
        };
        let v12 = v7;
        let v13 = empty_result();
        if (v8 != 0) {
            v13.complete = false;
            v13.status = v8;
            return (v13, vector[])
        };
        let v14 = arg7 - v6;
        let (v15, _) = orderbook_shortfall_memos(&arg0);
        let v17 = v15;
        let v18 = 0x1::vector::borrow<Hop>(&arg0, 0);
        let v19 = if (v18.kind == 2) {
            if (v18.orderbook_base_to_quote) {
                if (v18.fee_rate == 0) {
                    v18.orderbook_lot_size % arg4 == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v20 = if (v19) {
            v18.orderbook_lot_size
        } else {
            arg4
        };
        let v21 = if (0x1::vector::is_empty<u128>(&arg1)) {
            arg2
        } else {
            *0x1::vector::borrow<u128>(&arg1, 0)
        };
        let v22 = if (v18.kind == 2) {
            if (v18.orderbook_base_to_quote) {
                v18.fee_rate == 0
            } else {
                false
            }
        } else {
            false
        };
        let v23 = if (v22) {
            0x1::u128::max(0x1::u128::max(v21, v18.policy.input_minimum), v18.orderbook_min_size)
        } else {
            0x1::u128::max(v21, v18.policy.input_minimum)
        };
        let v24 = if (0x1::vector::length<u128>(&arg1) == 2) {
            *0x1::vector::borrow<u128>(&arg1, 1)
        } else {
            0
        };
        let v25 = aligned_in_range(v23, arg2, arg3, v20);
        let v26 = v25;
        let v27 = vector[];
        let v28 = empty_progressive_sample();
        let v29 = empty_progressive_sample();
        let v30 = if (arg8 == 0) {
            4
        } else {
            2
        };
        let v31 = arg6 - 0x1::u64::min(arg5, arg6 / v30);
        let v32 = v25;
        let v33 = false;
        let v34 = false;
        let v35 = false;
        while (v13.evaluations < v31 && v14 > 0) {
            if (v26 == 0 || v26 > arg3) {
                break
            };
            let v36 = amount_lower_bound(&v27, v26);
            if (v36 < 0x1::vector::length<u128>(&v27) && *0x1::vector::borrow<u128>(&v27, v36) == v26) {
                break
            };
            v32 = v26;
            let v37 = &mut v12;
            let v38 = &mut v17;
            let v39 = &mut v27;
            let v40 = &mut v14;
            let v41 = &mut v13;
            v28 = numeric_probe(&arg0, &v5, v37, v38, v26, v36, v39, v40, v41);
            if (v28.status == 3 || v28.status == 7) {
                if (!v13.found) {
                    v13.status = v28.status;
                    v13.complete = false;
                };
                v33 = true;
                break
            };
            let v42 = if (v28.status != 0) {
                if (v28.status != 1) {
                    v28.status != 10
                } else {
                    false
                }
            } else {
                false
            };
            if (v42) {
                return (v13, v27)
            };
            if (v28.amount == 0) {
                if (v28.amount > 0) {
                    v33 = true;
                    break
                } else {
                    let v43 = 0x1::u128::min(arg3, v18.policy.input_capacity);
                    let v44 = if (v28.status == 10) {
                        if (!v34) {
                            if (v13.evaluations < v31) {
                                if (v14 > 0) {
                                    v26 <= v43 / 10
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    let v45;
                    if (v44) {
                        v45 = aligned_in_range(v26 * 10, arg2, v43, v20);
                        if (v45 > v26) {
                            /* goto 123 */
                        };
                    };
                    v13.complete = false;
                    let v46 = if (v28.status == 10) {
                        10
                    } else {
                        8
                    };
                    v13.status = v46;
                    v35 = true;
                    v33 = true;
                    break;
                    /* label 123 */
                    v34 = true;
                    v26 = v45;
                    continue
                };
            };
            if (v29.amount == 0 || progressive_better(&v28, &v29)) {
                v29 = v28;
            };
            if (v28.amount > 0 && progressive_better(&v28, &v28)) {
                v33 = true;
                break
            };
            if (v26 == arg3) {
                v33 = true;
                break
            };
            let v47 = if (arg8 == 0) {
                4
            } else {
                16
            };
            let v48 = if (v26 > arg3 / v47) {
                arg3
            } else {
                v26 * v47
            };
            let v49 = v48;
            if (v24 > v26 && v24 < v48) {
                v49 = v24;
            };
            let v50 = aligned_in_range(v49, arg2, arg3, v20);
            if (v50 <= v26) {
                v33 = true;
                break
            };
            v26 = v50;
        };
        let v51 = if (arg8 == 0) {
            true
        } else if (arg5 == 0) {
            true
        } else if (v13.evaluations == arg6) {
            true
        } else {
            v35
        };
        let v52 = if (v51) {
            vector[]
        } else {
            let v53 = &mut v14;
            numeric_bolt_events(&arg0, arg2, v32, v20, v53)
        };
        let v54 = v52;
        let v55 = 0;
        loop {
            let v56 = if (!v35) {
                if (v55 < arg5) {
                    if (v13.evaluations < arg6) {
                        if (v14 > 0) {
                            v32 > arg2
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v56) {
                let v57 = empty_result();
                v57.found = v29.amount > 0;
                v57.amount_in = v29.amount;
                let v58 = if (!0x1::vector::is_empty<u128>(&v54)) {
                    0x1::vector::pop_back<u128>(&mut v54)
                } else if (arg8 > 1 && v29.amount > 0) {
                    numeric_refinement_point(&v27, v29.amount, arg2, v32, v20, arg8)
                } else {
                    refinement_point(&v57, &v27, arg2, v32, v20, 0)
                };
                if (v58 == 0 || v58 > v32) {
                    break
                };
                let v59 = amount_lower_bound(&v27, v58);
                if (v59 < 0x1::vector::length<u128>(&v27) && *0x1::vector::borrow<u128>(&v27, v59) == v58) {
                    if (!0x1::vector::is_empty<u128>(&v54)) {
                        continue
                    } else {
                        break
                    };
                };
                let v60 = &mut v12;
                let v61 = &mut v17;
                let v62 = &mut v27;
                let v63 = &mut v14;
                let v64 = &mut v13;
                let v65 = numeric_probe(&arg0, &v5, v60, v61, v58, v59, v62, v63, v64);
                if (v65.amount > 0 && (v29.amount == 0 || progressive_better(&v65, &v29))) {
                    v29 = v65;
                };
                let v66 = if (v65.status != 0) {
                    if (v65.status != 1) {
                        if (v65.status != 3) {
                            if (v65.status != 7) {
                                v65.status != 10
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v66) {
                    return (v13, v27)
                };
                v55 = v55 + 1;
            } else {
                break
            };
        };
        if (!v33 && v13.complete) {
            v13.complete = false;
            let v67 = if (v14 == 0) {
                6
            } else {
                9
            };
            v13.status = v67;
        };
        (v13, v27)
    }

    public fun numeric_search_staged_if(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: vector<u128>, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: bool, arg11: bool) : OptimizeResult {
        if (!arg11) {
            return coarse_rejection()
        };
        assert!(arg9 >= 1 && arg9 <= 3, 6);
        let (v0, _) = numeric_search_route_impl(join_staged_route(arg0, arg1), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        v0
    }

    public fun obric_virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: bool) : Hop {
        let v0 = virtual_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg8, 1, 1, 1);
        if (arg9) {
            v0.state_status = 5;
        };
        v0
    }

    public fun optimize(arg0: vector<Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        optimize_coefficients(arg0, arg1, arg2)
    }

    public fun optimize_adaptive_staged_if(arg0: bool, arg1: vector<Hop>, arg2: vector<StagedHop>, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : OptimizeResult {
        if (arg3 == 0) {
            return coarse_rejection()
        };
        if (!arg0) {
            return coarse_rejection()
        };
        let v0 = join_staged_route(arg1, arg2);
        let v1 = 0;
        let v2 = true;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(&v0)) {
            let v4 = 0x1::vector::borrow<Hop>(&v0, v3);
            if (v4.kind != 0 && v4.kind != 1) {
                v2 = false;
            };
            v1 = v1 + 0x1::vector::length<TickBoundary>(&v4.boundaries);
            v3 = v3 + 1;
        };
        let v5 = if (!v2) {
            true
        } else if (v1 <= 16) {
            true
        } else {
            arg5 == 0
        };
        if (v5) {
            return optimize(v0, arg3, arg4)
        };
        let v6 = optimize_shallow_mk(&v0, arg3);
        if (v6.complete) {
            return v6
        };
        optimize_cached(v0, arg3, arg5, arg6, arg7)
    }

    public fun optimize_cached(arg0: vector<Hop>, arg1: u128, arg2: u64, arg3: u64, arg4: u64) : OptimizeResult {
        let v0 = if (arg1 > 0) {
            if (arg1 <= (18446744073709551615 as u128)) {
                if (arg2 > 0) {
                    if (arg2 <= 1000) {
                        if (arg3 > 0) {
                            if (arg3 <= 64) {
                                arg4 > 0
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        let v1 = empty_result();
        let (v2, v3, v4) = build_v3_prefix_caches(&arg0, arg4);
        let v5 = v2;
        if (v3 != 0) {
            v1.complete = false;
            v1.status = v3;
            return v1
        };
        let v6 = arg4 - v4;
        let v7 = 0;
        let v8 = arg1;
        let v9 = false;
        while (v1.evaluations < arg3 && v6 > 0) {
            let v10 = &mut v5;
            let v11 = &mut v6;
            let (v12, v13, v14, v15) = cached_quote_and_marginal(&arg0, v10, arg1, v11);
            v1.evaluations = v1.evaluations + 1;
            if (v14 == 0) {
                let v16 = &mut v1;
                record_route_candidate(&arg0, arg1, v12, v16);
                if (v1.amount_in == arg1) {
                    v1.crossed_ticks = v15;
                };
                if (v13 > auxiliary_cost_x64(&arg0)) {
                    v7 = arg1;
                } else {
                    v8 = arg1;
                };
            } else if (v14 == 7) {
                v8 = arg1;
            } else if (v14 == 1) {
                v7 = arg1;
            } else if (v14 == 3) {
                v8 = arg1;
                v9 = true;
            } else {
                v1.complete = false;
                v1.status = v14;
                return v1
            };
            let v17 = if (v9 && arg2 > 25) {
                25
            } else {
                arg2
            };
            let v18 = mul_div_down(v7, (v17 as u128), 10000);
            let v19 = if (v18 > 1) {
                v18
            } else {
                1
            };
            if (v8 - v7 <= v19) {
                v1.complete = !v9;
                if (v9) {
                    v1.status = 3;
                };
                let v20 = &mut v5;
                let v21 = &mut v6;
                let v22 = &mut v1;
                trim_cached_v2_plateau(&arg0, v20, v21, arg3, arg1, v12, v22);
                return v1
            };
            arg1 = v7 + (v8 - v7) / 2;
        };
        v1.complete = false;
        let v23 = if (v6 == 0) {
            6
        } else {
            9
        };
        v1.status = v23;
        v1
    }

    public fun optimize_coefficients(arg0: vector<Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        let v0 = coefficient_state(arg0, arg1, arg2);
        let v1 = &mut v0;
        resume_coefficients(v1);
        progress_result(&v0)
    }

    public fun optimize_finite_staged_if(arg0: bool, arg1: vector<Hop>, arg2: vector<StagedHop>, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : OptimizeResult {
        if (!arg0) {
            return coarse_rejection()
        };
        let v0 = join_staged_route(arg1, arg2);
        assert!(!0x1::vector::is_empty<Hop>(&v0), 5);
        let v1 = if (arg3 > 0) {
            if (arg3 <= arg4) {
                if (arg5 > 0) {
                    if (arg6 > 0) {
                        if (arg8 > 0) {
                            if (arg8 <= 64) {
                                arg9 > 0
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 6);
        if (route_model(&v0) != 0 || !finite_mk_window_fits(&v0, arg8, arg6)) {
            let v2 = 0x1::vector::empty<u128>();
            0x1::vector::push_back<u128>(&mut v2, arg3);
            let (v3, _) = progressive_search_route_impl(v0, v2, arg3, arg4, arg5, arg7, arg8, arg9);
            return v3
        };
        finite_mk_search(v0, arg3, arg4, arg5, arg6, arg8, arg9)
    }

    fun optimize_shallow_mk(arg0: &vector<Hop>, arg1: u128) : OptimizeResult {
        let v0 = 0x1::vector::empty<Hop>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.state_status != 0) {
                let v3 = empty_result();
                v3.complete = false;
                v3.status = v2.state_status;
                return v3
            };
            let v4 = if (v2.kind == 0) {
                v2_hop_split_fee(v2.reserve_in, v2.reserve_out, v2.fee_rate, v2.fee_denominator, v2.output_fee_rate, v2.output_fee_denominator)
            } else {
                let v5 = 0x1::vector::empty<TickBoundary>();
                let v6 = v2.boundary_cursor;
                while (v6 < 0x1::vector::length<TickBoundary>(&v2.boundaries) && 0x1::vector::length<TickBoundary>(&v5) < 3) {
                    0x1::vector::push_back<TickBoundary>(&mut v5, *0x1::vector::borrow<TickBoundary>(&v2.boundaries, v6));
                    v6 = v6 + 1;
                };
                v3_hop(v2.sqrt_price_x64, v2.liquidity, v2.fee_rate, v2.fee_denominator, v2.zero_for_one, v5)
            };
            let v7 = v4;
            v7.policy.stop_at_zero_liquidity = v2.policy.stop_at_zero_liquidity;
            v7.policy.input_minimum = v2.policy.input_minimum;
            v7.policy.input_capacity = v2.policy.input_capacity;
            v7.policy.output_capacity = v2.policy.output_capacity;
            0x1::vector::push_back<Hop>(&mut v0, v7);
            v1 = v1 + 1;
        };
        optimize(v0, arg1, 3)
    }

    public fun optimize_staged(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: u128, arg3: u64) : OptimizeResult {
        optimize_coefficients(join_staged_route(arg0, arg1), arg2, arg3)
    }

    public fun optimize_staged_if(arg0: bool, arg1: vector<Hop>, arg2: vector<StagedHop>, arg3: u128, arg4: u64) : OptimizeResult {
        if (!arg0) {
            coarse_rejection()
        } else {
            optimize_staged(arg1, arg2, arg3, arg4)
        }
    }

    fun orderbook_affine_at(arg0: &Hop, arg1: u256) : (u256, u256) {
        book_tail_affine(arg0.fee_denominator, arg0.fee_rate, arg0.orderbook_base_to_quote, &arg0.orderbook_segments, arg1)
    }

    public fun orderbook_hop(arg0: vector<OrderbookSegment>, arg1: u64, arg2: u64, arg3: bool, arg4: bool) : Hop {
        let v0 = empty_hop(2);
        v0.orderbook_segments = arg0;
        v0.orderbook_lot_size = (arg1 as u128);
        v0.orderbook_min_size = (arg2 as u128);
        v0.orderbook_base_to_quote = arg3;
        v0.orderbook_has_more = arg4;
        v0
    }

    public fun orderbook_hop_from_vectors(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : Hop {
        let v0 = 0x1::vector::empty<OrderbookSegment>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<OrderbookSegment>(&mut v0, orderbook_segment(*0x1::vector::borrow<u64>(&arg0, v1), *0x1::vector::borrow<u64>(&arg1, v1)));
            v1 = v1 + 1;
        };
        orderbook_hop(v0, arg2, arg3, arg4, arg5)
    }

    public fun orderbook_hop_from_vectors_with_auxiliary_fee(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64) : Hop {
        let v0 = orderbook_hop_from_vectors(arg0, arg1, arg2, arg3, arg4, arg5);
        v0.policy.auxiliary_fee_rate = arg6;
        v0.policy.auxiliary_fee_denominator = arg7;
        v0
    }

    public fun orderbook_hop_from_vectors_with_input_fee(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64) : Hop {
        let v0 = orderbook_hop_from_vectors(arg0, arg1, arg2, arg3, arg4, arg5);
        v0.fee_rate = arg6;
        v0.fee_denominator = arg7;
        v0
    }

    public fun orderbook_input_boundary(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: &vector<OrderbookSegment>) : u128 {
        let v0 = current_orderbook_segment(arg3, arg4);
        let v1 = if (arg2) {
            v0.remaining_base
        } else {
            mul_div_up(v0.remaining_base, v0.price, 1000000000)
        };
        gross_from_effective(v1, arg1, arg0)
    }

    fun orderbook_minimums_reachable(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            let v2 = if (v1.kind == 2) {
                if (v1.orderbook_consumed_base < v1.orderbook_min_size) {
                    orderbook_terminal(v1.kind, v1.orderbook_cursor, v1.orderbook_has_more, &v1.orderbook_segments)
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun orderbook_minimums_satisfied(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (v1.kind == 2 && v1.orderbook_consumed_base < v1.orderbook_min_size) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun orderbook_rate_hop(arg0: u64, arg1: bool) : Hop {
        let v0 = vector[];
        let v1 = vector[];
        if (arg0 > 0) {
            0x1::vector::push_back<u64>(&mut v0, arg0);
            0x1::vector::push_back<u64>(&mut v1, 1);
        };
        orderbook_hop_from_vectors(v0, v1, 1, 1, arg1, false)
    }

    public fun orderbook_rate_hop_with_auxiliary_fee(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : Hop {
        let v0 = orderbook_rate_hop(arg0, arg1);
        v0.policy.auxiliary_fee_rate = arg2;
        v0.policy.auxiliary_fee_denominator = arg3;
        v0
    }

    public fun orderbook_rate_hop_with_input_fee(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : Hop {
        let v0 = vector[];
        let v1 = vector[];
        if (arg0 > 0) {
            0x1::vector::push_back<u64>(&mut v0, arg0);
            0x1::vector::push_back<u64>(&mut v1, 1);
        };
        orderbook_hop_from_vectors_with_input_fee(v0, v1, 1, 1, arg1, false, arg2, arg3)
    }

    public fun orderbook_segment(arg0: u64, arg1: u64) : OrderbookSegment {
        OrderbookSegment{
            price          : (arg0 as u128),
            remaining_base : (arg1 as u128),
        }
    }

    public fun orderbook_segment_base_consumed(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<OrderbookSegment>, arg6: u128) : u128 {
        if (arg6 == 0 || orderbook_terminal(arg0, arg2, arg3, arg5)) {
            return 0
        };
        let v0 = current_orderbook_segment(arg2, arg5);
        if (arg1) {
            let v2 = round_down_to_quantum(arg6, arg4);
            if (v2 < v0.remaining_base) {
                v2
            } else {
                v0.remaining_base
            }
        } else {
            let v3 = round_down_to_quantum(mul_div_down(arg6, 1000000000, v0.price), arg4);
            if (v3 < v0.remaining_base) {
                v3
            } else {
                v0.remaining_base
            }
        }
    }

    public fun orderbook_segment_output_capacity(arg0: bool, arg1: &OrderbookSegment) : u128 {
        if (arg0) {
            mul_div_down(arg1.remaining_base, arg1.price, 1000000000)
        } else {
            arg1.remaining_base
        }
    }

    fun orderbook_shortfall_memos(arg0: &vector<Hop>) : (vector<OrderbookShortfall>, bool) {
        let v0 = 0;
        let v1 = false;
        let v2 = false;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v0).kind == 2) {
                v1 = true;
            };
            if (0x1::vector::borrow<Hop>(arg0, v0).kind == 3) {
                v2 = true;
            };
            v0 = v0 + 1;
        };
        let v3 = 0x1::vector::empty<OrderbookShortfall>();
        if (!v1 && !v2) {
            return (v3, false)
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            0x1::vector::push_back<OrderbookShortfall>(&mut v3, new_shortfall(0x1::vector::empty<OrderbookPrefix>(), 0, 0));
            v0 = v0 + 1;
        };
        (v3, v1)
    }

    public fun orderbook_stage_from_vectors_with_auxiliary_fee_if(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: bool) : StagedHop {
        if (!arg8) {
            return reuse_current_stage()
        };
        replacement_stage(orderbook_hop_from_vectors_with_auxiliary_fee(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    public fun orderbook_stage_from_vectors_with_input_fee_if(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: bool) : StagedHop {
        if (!arg8) {
            return reuse_current_stage()
        };
        replacement_stage(orderbook_hop_from_vectors_with_input_fee(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    public fun orderbook_terminal(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<OrderbookSegment>) : bool {
        if (arg0 == 2) {
            if (arg1 >= 0x1::vector::length<OrderbookSegment>(arg3)) {
                !arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun passes_bounded_profit_gate(arg0: &vector<Hop>, arg1: u128) : bool {
        let (v0, v1, v2, v3) = bounded_affine_state_upper(arg0);
        if (!v3) {
            return false
        };
        if (!v0 || v1 > auxiliary_cost_x64(arg0)) {
            return true
        };
        let v4 = v2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v5).policy.auxiliary_fee_rate > 0) {
                v4 = saturating_add(v4, 1);
            };
            v5 = v5 + 1;
        };
        let v6 = v4 == 0 || v4 < (arg1 as u256);
        !v6
    }

    public fun passes_marginal_gate(arg0: &vector<Hop>, arg1: u256) : bool {
        assert!(0x1::vector::length<Hop>(arg0) > 0, 5);
        let v0 = q64();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.state_status == 2) {
                return false
            };
            v0 = mul_q64_ceil(v0, hop_marginal_upper_x64(v2));
            v1 = v1 + 1;
        };
        v0 > saturating_add(arg1, auxiliary_cost_x64(arg0) - q64())
    }

    public fun passes_state_gate(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v0).state_status == 2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun prefix_upper_bound_virtual(arg0: &vector<V3Prefix>, arg1: u64, arg2: u128, arg3: &mut u64) : (u64, u8) {
        if (arg1 <= 8) {
            let v0 = 0;
            while (v0 < arg1) {
                if (*arg3 == 0) {
                    return (v0, 6)
                };
                *arg3 = *arg3 - 1;
                if (v0 >= 0x1::vector::length<V3Prefix>(arg0) || 0x1::vector::borrow<V3Prefix>(arg0, v0).crossing_input > arg2) {
                    break
                };
                v0 = v0 + 1;
            };
            return (v0, 0)
        };
        let v1 = 0;
        while (v1 < arg1) {
            if (*arg3 == 0) {
                return (v1, 6)
            };
            *arg3 = *arg3 - 1;
            let v2 = v1 + (arg1 - v1) / 2;
            if (v2 < 0x1::vector::length<V3Prefix>(arg0) && 0x1::vector::borrow<V3Prefix>(arg0, v2).crossing_input <= arg2) {
                v1 = v2 + 1;
                continue
            };
            arg1 = v2;
        };
        (v1, 0)
    }

    public fun prepare_cpmm(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : PreparedCpmm {
        let v0 = arg0 <= 18446744073709551615 && arg1 <= 18446744073709551615;
        PreparedCpmm{
            fractional         : arg6,
            reserves_valid     : v0,
            reserve_in         : arg0,
            reserve_out        : (arg1 as u256),
            scaled_reserve_in  : (arg0 as u256) * (arg3 as u256),
            input_factor       : ((arg3 - arg2) as u256),
            input_denominator  : (arg3 as u256),
            output_factor      : ((arg5 - arg4) as u256),
            output_denominator : (arg5 as u256),
        }
    }

    fun prepare_v3_prefix_caches(arg0: &vector<Hop>, arg1: u64) : (vector<V3PrefixCache>, u8, u64) {
        let v0 = 0x1::vector::empty<V3PrefixCache>();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            let v4 = 0x1::vector::borrow<Hop>(arg0, v3);
            if (v4.state_status != 0 && v2 == 0) {
                v2 = v4.state_status;
            };
            if (v4.kind == 1) {
                while (0x1::vector::length<V3PrefixCache>(&v0) < v3) {
                    0x1::vector::push_back<V3PrefixCache>(&mut v0, new_prefixCache(0x1::vector::empty<V3Prefix>(), 0, 0, 1, 0, 0, 340282366920938463463374607431768211455, false, 0, false, false));
                };
                let v5 = new_prefixCache(0x1::vector::empty<V3Prefix>(), 0, v4.boundary_cursor, v4.fee_denominator, v4.fee_rate, v4.liquidity, v4.policy.output_capacity, v4.policy.stop_at_zero_liquidity, v4.sqrt_price_x64, v4.zero_for_one, v4.policy.momentum_fee_round_nearest);
                if (v2 == 0) {
                    let v6 = &mut v5;
                    let (v7, v8) = reserve_prefix_window(&v4.boundaries, v6, v1, arg1);
                    if (v8) {
                        return build_v3_prefix_caches(arg0, arg1)
                    };
                    v1 = v7;
                    v2 = v5.status;
                };
                0x1::vector::push_back<V3PrefixCache>(&mut v0, v5);
            };
            v3 = v3 + 1;
        };
        (v0, v2, v1)
    }

    public fun progress_result(arg0: &OptimizeState) : OptimizeResult {
        if (0x1::vector::is_empty<Hop>(&arg0.validation_route) || !arg0.result.found) {
            return arg0.result
        };
        let v0 = &arg0.validation_route;
        let (v1, v2, v3) = prepare_v3_prefix_caches(v0, 16384);
        let v4 = v1;
        let v5 = arg0.result;
        v5.found = false;
        v5.amount_in = 0;
        v5.amount_out = 0;
        v5.gross_profit = 0;
        if (v5.status == 0) {
            v5.status = 1;
        };
        if (v2 != 0) {
            v5.complete = false;
            v5.status = v2;
            return v5
        };
        let v6 = 16384 - v3;
        let v7 = 0;
        let v8 = arg0.result.amount_in;
        let v9 = v8;
        let v10 = 0;
        while (v10 < 13 && v6 > 0) {
            let v11 = &mut v4;
            let v12 = &mut v6;
            let (v13, v14, _, _) = quote_bounded_route(v0, v11, v8, v12);
            let v17 = v10 + 1;
            v10 = v17;
            v5.evaluations = v5.evaluations + 1;
            if (v14 == 0) {
                let v18 = &mut v5;
                record_route_candidate(v0, v8, v13, v18);
                if (v17 == 1) {
                    return v5
                };
                v7 = v8;
            } else if (v14 == 7 || v14 == 3) {
                v9 = v8;
                if (v14 == 3) {
                    v5.complete = false;
                    v5.status = v14;
                };
            } else if (v14 == 1) {
                v7 = v8;
            } else {
                v5.complete = false;
                v5.status = v14;
                return v5
            };
            if (v9 - v7 <= 1) {
                break
            };
            v8 = v7 + (v9 - v7) / 2;
        };
        v5
    }

    public fun progressive_better(arg0: &ProgressiveSample, arg1: &ProgressiveSample) : bool {
        if (arg0.negative != arg1.negative) {
            return !arg0.negative
        };
        arg0.negative && arg0.magnitude < arg1.magnitude || arg0.magnitude > arg1.magnitude
    }

    fun progressive_probe(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: &mut vector<OrderbookShortfall>, arg3: u128, arg4: u64, arg5: &mut vector<u128>, arg6: &mut u64, arg7: &mut OptimizeResult) : ProgressiveSample {
        0x1::vector::insert<u128>(arg5, arg3, arg4);
        arg7.evaluations = arg7.evaluations + 1;
        let v0 = *arg6;
        let (v1, v2, v3, v4) = quote_bounded_route_with_shortfalls(arg0, arg1, arg3, arg6, arg2, arg7.found);
        arg7.crossed_ticks = arg7.crossed_ticks + v3;
        arg7.crossed_orders = arg7.crossed_orders + v4;
        if (v2 != 0 || v1 == 0) {
            let v5 = if (v2 != 0) {
                if (v2 != 1) {
                    if (v2 != 7) {
                        v2 != 10
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                arg7.complete = false;
                if (arg7.status == 0 || arg7.status == 1) {
                    arg7.status = v2;
                };
            };
            let v6 = empty_progressive_sample();
            v6.status = v2;
            v6.output = v1;
            v6.work = v0 - *arg6;
            return v6
        };
        let v7 = route_auxiliary_fee(arg0, arg3);
        record_candidate_with_fee(arg3, v1, v7, arg7);
        let v8 = saturating_add((arg3 as u256), v7);
        let v9 = v8 > (v1 as u256);
        let v10 = if (v9) {
            v8 - (v1 as u256)
        } else {
            (v1 as u256) - v8
        };
        ProgressiveSample{
            amount    : arg3,
            output    : v1,
            fee       : v7,
            work      : v0 - *arg6,
            negative  : v9,
            magnitude : v10,
            status    : v2,
        }
    }

    fun progressive_search_impl(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: vector<u128>, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64) : (OptimizeResult, vector<u128>) {
        progressive_search_route_impl(join_staged_route(arg0, arg1), arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    fun progressive_search_route_impl(arg0: vector<Hop>, arg1: vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64) : (OptimizeResult, vector<u128>) {
        numeric_search_route_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0, false)
    }

    public fun progressive_search_staged(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: vector<u128>, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64) : OptimizeResult {
        let (v0, _) = progressive_search_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        v0
    }

    public fun progressive_search_staged_if(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: vector<u128>, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: bool) : OptimizeResult {
        if (!arg9) {
            return coarse_rejection()
        };
        progressive_search_staged(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun q64() : u256 {
        (18446744073709551616 as u256)
    }

    fun quote_aftermath_with_exponent(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u64, arg5: u256, arg6: u128, arg7: u128, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        if (arg8 == 0) {
            return (0, 0, 0)
        };
        if (arg8 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg9 < 40) {
            return (0, 6, 0)
        };
        *arg9 = *arg9 - 40;
        let v0 = (effective_input(arg8, arg4, (1000000000000000000 as u64)) as u256) * (arg6 as u256);
        if (v0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / 1000000000000000000) {
            return (0, 5, 0)
        };
        let v1 = aftermath_fixed_mul_down(v0, 1000000000000000000 - (arg0 as u256));
        let v2 = (arg2 as u256);
        if (v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v2) {
            return (0, 5, 0)
        };
        let (v3, v4) = aftermath_pow_up(aftermath_fixed_div_up(v2, v2 + v1), arg5);
        if (!v4) {
            return (0, 5, 0)
        };
        let v5 = if (v3 < 1000000000000000000) {
            1000000000000000000 - v3
        } else {
            0
        };
        let v6 = aftermath_fixed_mul_down(aftermath_fixed_mul_down((arg3 as u256), v5), 1000000000000000000 - (arg1 as u256)) / (arg7 as u256);
        if (v6 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v6 as u128), 0, 0)
    }

    fun quote_bounded_route(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: u128, arg3: &mut u64) : (u128, u8, u64, u64) {
        let v0 = 0x1::vector::empty<OrderbookShortfall>();
        let v1 = &mut v0;
        quote_bounded_route_with_shortfalls(arg0, arg1, arg2, arg3, v1, false)
    }

    fun quote_bounded_route_with_shortfalls(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: u128, arg3: &mut u64, arg4: &mut vector<OrderbookShortfall>, arg5: bool) : (u128, u8, u64, u64) {
        let v0 = arg2;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            if (v0 == 0) {
                return (0, 0, v1, v2)
            };
            let v4 = 0x1::vector::borrow<Hop>(arg0, v3);
            if (v4.state_status != 0) {
                return (0, v4.state_status, v1, v2)
            };
            if (v0 > v4.policy.input_capacity) {
                return (0, 7, v1, v2)
            };
            if (v0 < v4.policy.input_minimum) {
                return (0, 1, v1, v2)
            };
            let (v5, v6, v7) = if (v4.kind == 0) {
                if (*arg3 == 0) {
                    return (0, 6, v1, v2)
                };
                *arg3 = *arg3 - 1;
                let v5 = effective_output(v2_curve_output(v4.fee_denominator, v4.fee_rate, v4.policy.fractional_input_fee, v4.reserve_in, v4.reserve_out, v0), v4.output_fee_rate, v4.output_fee_denominator);
                (v5, 0, 0)
            } else if (v4.kind == 5) {
                while (0x1::vector::length<V3PrefixCache>(arg1) <= v3) {
                    0x1::vector::push_back<V3PrefixCache>(arg1, new_prefixCache(0x1::vector::empty<V3Prefix>(), 0, 0, 1, 0, 0, 340282366920938463463374607431768211455, false, 0, false, false));
                };
                let v8 = &mut 0x1::vector::borrow_mut<V3PrefixCache>(arg1, v3).liquidity;
                quote_stable_with_d(v4.reserve_in, v4.reserve_out, v4.stable_admin_fee, v4.stable_amp, v4.stable_fee_on_input, v4.stable_lp_fee, v4.stable_scale_in, v4.stable_scale_out, v4.stable_th_fee, v0, arg3, v8)
            } else if (v4.kind == 6) {
                quote_ve33_stable_hop(v4.fee_denominator, v4.fee_rate, v4.reserve_in, v4.reserve_out, v4.stable_amp, v4.stable_scale_in, v4.stable_scale_out, v0, arg3)
            } else if (v4.kind == 7) {
                quote_virtual_cpmm_hop(v4.fee_denominator, v4.fee_rate, v4.reserve_in, v4.reserve_out, v4.sqrt_price_x64, v4.stable_amp, v4.stable_scale_in, v4.stable_scale_out, v4.zero_for_one, v0, arg3)
            } else if (v4.kind == 8) {
                quote_kriya_v2_hop(v4.fee_denominator, v4.fee_rate, v4.output_fee_denominator, v4.output_fee_rate, v4.reserve_in, v4.reserve_out, v4.stable_amp, v4.stable_fee_on_input, v4.stable_scale_in, v4.stable_scale_out, v0, arg3)
            } else if (v4.kind == 18) {
                if (*arg3 == 0) {
                    return (0, 6, v1, v2)
                };
                *arg3 = *arg3 - 1;
                let (v9, _, _, v12) = 0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::evaluate(0x1::vector::borrow<0x6008af624696faec3fe10f4306a7afb9989678b47042a234811c57549f6c197b::curve::State>(&v4.policy.bolt, 0), (v0 as u64));
                ((v9 as u128), v12, 0)
            } else if (v4.kind == 17) {
                quote_capped_ratio_hop(v4.reserve_in, v4.reserve_out, v4.stable_scale_in, v0, arg3)
            } else if (v4.kind == 9) {
                quote_lst_ratio_hop(v4.fee_denominator, v4.fee_rate, v4.reserve_in, v4.reserve_out, v4.stable_amp, v4.zero_for_one, v0, arg3)
            } else if (v4.kind == 10) {
                quote_hasui_ratio_hop(v4.output_fee_denominator, v4.output_fee_rate, v4.reserve_in, v4.reserve_out, v4.stable_amp, v4.stable_scale_in, v4.stable_scale_out, v4.zero_for_one, v0, arg3)
            } else if (v4.kind == 11) {
                quote_hawal_ratio_hop(v4.output_fee_denominator, v4.output_fee_rate, v4.reserve_in, v4.reserve_out, v4.stable_amp, v4.stable_scale_out, v4.zero_for_one, v0, arg3)
            } else if (v4.kind == 12) {
                quote_aftermath_with_exponent(v4.fee_rate, v4.output_fee_rate, v4.reserve_in, v4.reserve_out, v4.stable_admin_fee, (v4.liquidity as u256), v4.stable_scale_in, v4.stable_scale_out, v0, arg3)
            } else if (v4.kind == 13) {
                quote_bucket_psm_hop(v4.fee_denominator, v4.fee_rate, v4.reserve_in, v4.stable_scale_in, v4.stable_scale_out, v4.zero_for_one, v0, arg3)
            } else if (v4.kind == 19) {
                quote_metastable(v4, v0, arg3)
            } else if (v4.kind == 14) {
                quote_steamm_cpmm_hop(v4.liquidity, v4.output_fee_denominator, v4.output_fee_rate, v4.reserve_in, v4.reserve_out, v4.sqrt_price_x64, v4.stable_amp, v4.stable_scale_in, v4.stable_scale_out, v0, arg3)
            } else if (v4.kind == 15) {
                quote_steamm_omm_hop(v4.liquidity, v4.output_fee_denominator, v4.output_fee_rate, v4.reserve_in, v4.reserve_out, v4.sqrt_price_x64, v4.stable_admin_fee, v4.stable_amp, v4.stable_lp_fee, v4.stable_scale_in, v4.stable_scale_out, v0, arg3)
            } else if (v4.kind == 16) {
                while (0x1::vector::length<V3PrefixCache>(arg1) <= v3) {
                    0x1::vector::push_back<V3PrefixCache>(arg1, new_prefixCache(0x1::vector::empty<V3Prefix>(), 0, 0, 1, 0, 0, 340282366920938463463374607431768211455, false, 0, false, false));
                };
                let v13 = 0x1::vector::borrow_mut<V3PrefixCache>(arg1, v3);
                quote_steamm_omm_v2_prepared(v4.liquidity, v4.orderbook_lot_size, v4.output_fee_denominator, v4.output_fee_rate, v4.reserve_in, v4.reserve_out, v4.sqrt_price_x64, v4.stable_admin_fee, v4.stable_amp, v4.stable_lp_fee, v4.stable_scale_in, v4.stable_scale_out, v4.stable_th_fee, v4.zero_for_one, v4.policy.omm_update_flag, v0, arg3, v13)
            } else if (v4.kind == 2) {
                let (v14, v15, v16) = if (0x1::vector::is_empty<OrderbookShortfall>(arg4)) {
                    quote_orderbook_hop_bounded(v4.fee_denominator, v4.fee_rate, v4.orderbook_base_to_quote, v4.orderbook_cursor, v4.orderbook_has_more, v4.orderbook_lot_size, v4.orderbook_min_size, &v4.orderbook_segments, v0, arg3)
                } else {
                    let v17 = 0x1::vector::borrow_mut<OrderbookShortfall>(arg4, v3);
                    quote_orderbook_with_shortfall(v4.fee_denominator, v4.fee_rate, v4.orderbook_base_to_quote, v4.orderbook_cursor, v4.orderbook_has_more, v4.orderbook_lot_size, v4.orderbook_min_size, &v4.orderbook_segments, v0, arg3, v17, arg5)
                };
                v2 = v2 + v16;
                (v14, v15, 0)
            } else if (v4.kind == 3) {
                if (0x1::vector::is_empty<LinearSegment>(&v4.linear_segments)) {
                    let v18 = if (v4.linear_has_more) {
                        3
                    } else {
                        11
                    };
                    return (0, v18, v1, v2)
                };
                if (0x1::vector::is_empty<OrderbookShortfall>(arg4)) {
                    quote_linear_hop_bounded(v4, v0, arg3)
                } else {
                    let v19 = 0x1::vector::borrow_mut<OrderbookShortfall>(arg4, v3);
                    quote_linear_with_shortfall(v4.linear_cursor, v4.linear_has_more, &v4.linear_segments, v0, arg3, v19)
                }
            } else {
                let (v20, v21, v22) = if (v4.kind == 1) {
                    if (v3 >= 0x1::vector::length<V3PrefixCache>(arg1)) {
                        return (0, 5, v1, v2)
                    };
                    let v23 = 0x1::vector::borrow_mut<V3PrefixCache>(arg1, v3);
                    let (v24, v25, v26) = quote_v3_cached(&v4.boundaries, v23, v0, arg3);
                    (v25, v26, v24)
                } else {
                    (5, 0, 0)
                };
                (v22, v20, v21)
            };
            if (v6 != 0) {
                return (0, v6, v1 + v7, v2)
            };
            if (v5 == 0 && v4.kind == 3) {
                return (0, 10, v1 + v7, v2)
            };
            if (v5 > v4.policy.output_capacity) {
                return (0, 7, v1 + v7, v2)
            };
            v0 = v5;
            v1 = v1 + v7;
            v3 = v3 + 1;
        };
        (v0, 0, v1, v2)
    }

    public fun quote_bucket_psm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: &mut u64) : (u128, u8, u64) {
        if (arg6 == 0) {
            return (0, 0, 0)
        };
        if (*arg7 == 0) {
            return (0, 6, 0)
        };
        *arg7 = *arg7 - 1;
        if (arg6 > arg2) {
            return (0, 7, 0)
        };
        let v0 = if (arg5) {
            arg6 / arg3
        } else {
            if (arg6 > 340282366920938463463374607431768211455 / arg4) {
                return (0, 5, 0)
            };
            arg6 * arg4
        };
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = div_ceil((v0 as u256) * (arg1 as u256), (arg0 as u256));
        if (v1 > (v0 as u256)) {
            return (0, 0, 0)
        };
        ((((v0 as u256) - v1) as u128), 0, 0)
    }

    public fun quote_capped_ratio_hop(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: &mut u64) : (u128, u8, u64) {
        if (arg3 > arg2) {
            return (0, 7, 0)
        };
        if (*arg4 == 0) {
            return (0, 6, 0)
        };
        *arg4 = *arg4 - 1;
        let v0 = (arg3 as u256) * (arg1 as u256) / (arg0 as u256);
        if (v0 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v0 as u128), 0, 0)
    }

    public fun quote_cpmm_cached_with_slope(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : (u128, u256) {
        let v0 = effective_input(arg6, arg1, arg0);
        let v1 = arg4 + v0;
        (effective_output(mul_div_down(v0, arg5, v1), arg3, arg2), mul_ratio_down_saturating(mul_ratio_down_saturating((arg5 as u256) * q64() / (v1 as u256), (arg4 as u256), (v1 as u256)), ((arg2 - arg3) as u256), (arg2 as u256)))
    }

    public fun quote_exact(arg0: vector<Hop>, arg1: u128, arg2: u64) : (u128, u8, u64) {
        let (v0, v1, v2) = prepare_v3_prefix_caches(&arg0, arg2);
        let v3 = v0;
        if (v1 != 0) {
            return (0, v1, v2)
        };
        let v4 = arg2 - v2;
        let v5 = &mut v3;
        let v6 = &mut v4;
        let (v7, v8, _, _) = quote_bounded_route(&arg0, v5, arg1, v6);
        (v7, v8, arg2 - v4)
    }

    public fun quote_hasui_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        if (arg8 == 0) {
            return (0, 0, 0)
        };
        if (arg8 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg9 == 0) {
            return (0, 6, 0)
        };
        *arg9 = *arg9 - 1;
        if (arg8 < arg4) {
            return (0, 10, 0)
        };
        let v0 = (arg8 as u256) * (arg3 as u256) / (arg2 as u256);
        if (v0 == 0) {
            return (0, 10, 0)
        };
        if (v0 > (18446744073709551615 as u256)) {
            return (0, 12, 0)
        };
        if (!arg7) {
            if (v0 > (arg6 as u256)) {
                return (0, 7, 0)
            };
            if (v0 < (arg5 as u256)) {
                return (0, 10, 0)
            };
        };
        let v1 = v0 * (arg1 as u256) / (arg0 as u256);
        if (v1 > v0) {
            return (0, 5, 0)
        };
        (((v0 - v1) as u128), 0, 0)
    }

    public fun quote_hawal_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: bool, arg7: u128, arg8: &mut u64) : (u128, u8, u64) {
        if (arg7 == 0) {
            return (0, 0, 0)
        };
        if (arg7 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg8 == 0) {
            return (0, 6, 0)
        };
        *arg8 = *arg8 - 1;
        if (arg6 && arg7 < arg4) {
            return (0, 0, 0)
        };
        let v0 = (arg7 as u256) * (arg3 as u256) / (arg2 as u256);
        if (v0 == 0 || v0 > (18446744073709551615 as u256)) {
            return (0, 0, 0)
        };
        let v1 = if (!arg6) {
            if (v0 < (arg4 as u256)) {
                true
            } else if (v0 > (arg3 as u256)) {
                true
            } else {
                v0 > (arg5 as u256)
            }
        } else {
            false
        };
        if (v1) {
            return (0, 0, 0)
        };
        let v2 = v0 * (arg1 as u256) / (arg0 as u256);
        if (v2 > v0) {
            return (0, 5, 0)
        };
        (((v0 - v2) as u128), 0, 0)
    }

    fun quote_hop(arg0: &Hop, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = effective_input(arg1, arg0.fee_rate, arg0.fee_denominator);
        if (v0 == 0 && !arg0.policy.fractional_input_fee) {
            return 0
        };
        if (arg0.kind == 0) {
            cap_segment_quote_v2(arg0.fee_denominator, arg0.fee_rate, arg0.output_fee_denominator, arg0.output_fee_rate, arg0.policy.fractional_input_fee, arg0.reserve_in, arg0.reserve_out, arg1)
        } else if (arg0.kind == 1) {
            cap_segment_quote_v3(arg0.liquidity, arg0.policy.stop_at_zero_liquidity, arg0.sqrt_price_x64, arg0.zero_for_one, current_boundary(arg0), v0)
        } else if (arg0.kind == 2) {
            cap_segment_quote_orderbook(arg0.kind, arg0.orderbook_base_to_quote, arg0.orderbook_cursor, arg0.orderbook_has_more, arg0.orderbook_lot_size, &arg0.orderbook_segments, v0)
        } else {
            assert!(arg0.kind == 3, 1);
            cap_segment_quote_linear(arg0.kind, arg0.linear_cursor, arg0.linear_has_more, &arg0.linear_segments, v0)
        }
    }

    public fun quote_kriya_v2_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: u128, arg10: u128, arg11: &mut u64) : (u128, u8, u64) {
        if (arg10 == 0) {
            return (0, 0, 0)
        };
        if (arg10 > 18446744073709551615) {
            return (0, 5, 0)
        };
        let v0 = arg10 - arg10 * (arg1 as u128) / (arg0 as u128);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        if (!arg7) {
            if (*arg11 == 0) {
                return (0, 6, 0)
            };
            *arg11 = *arg11 - 1;
            let v1 = (v0 as u256) * ((arg2 - arg3) as u256);
            let v2 = (arg4 as u256) * (arg2 as u256) + v1;
            if (v2 == 0) {
                return (0, 5, 0)
            };
            let v3 = v1 * (arg5 as u256) / v2;
            if (v3 > (18446744073709551615 as u256)) {
                return (0, 5, 0)
            };
            return ((v3 as u128), 0, 0)
        };
        let v4 = (arg6 as u256);
        let v5 = (arg8 as u256);
        let v6 = (arg9 as u256);
        let v7 = (arg4 as u256) * v4 / v5;
        let v8 = (arg5 as u256) * v4 / v6;
        let v9 = (v0 as u256) * v4 / v5 * ((arg2 - arg3) as u256) / (arg2 as u256);
        if (v9 > 10000000000000000000 || v7 > 10000000000000000000 - v9) {
            return (0, 5, 0)
        };
        let (v10, v11) = kriya_ve33_get_y(v7 + v9, ve33_invariant(v7, v8), v8, arg11);
        if (v11 != 0) {
            return (0, v11, 0)
        };
        if (v10 > v8) {
            return (0, 5, 0)
        };
        let v12 = (v8 - v10) * v6 / v4;
        if (v12 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v12 as u128), 0, 0)
    }

    fun quote_linear_hop_bounded(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        let (v0, v1, v2, _) = quote_linear_hop_bounded_impl(arg0.linear_cursor, arg0.linear_has_more, &arg0.linear_segments, arg1, arg2);
        (v0, v1, v2)
    }

    public fun quote_linear_hop_bounded_impl(arg0: u64, arg1: bool, arg2: &vector<LinearSegment>, arg3: u128, arg4: &mut u64) : (u128, u8, u64, u128) {
        if (arg3 == 0) {
            return (0, 0, 0, 0)
        };
        let v0 = arg3;
        let v1 = 0;
        let v2 = 0;
        while (v0 > 0 && arg0 < 0x1::vector::length<LinearSegment>(arg2)) {
            if (*arg4 == 0) {
                return (0, 6, v2, v0)
            };
            *arg4 = *arg4 - 1;
            let v3 = 0x1::vector::borrow<LinearSegment>(arg2, arg0);
            let v4 = v0 >= v3.remaining_input;
            let v5 = if (v4) {
                v3.remaining_input
            } else {
                v0
            };
            let v6 = if (v4) {
                v3.remaining_output
            } else {
                quote_linear_segment_value(v3, v5)
            };
            if (v1 > 340282366920938463463374607431768211455 - v6) {
                return (0, 5, v2, v0)
            };
            v1 = v1 + v6;
            v0 = v0 - v5;
            if (v4) {
                v2 = v2 + 1;
                arg0 = arg0 + 1;
            } else {
                break
            };
        };
        let (v7, v8) = if (v0 > 0) {
            if (arg1) {
                (0, 3)
            } else {
                (0, 0)
            }
        } else {
            (v1, 0)
        };
        (v7, v8, v2, v0)
    }

    public fun quote_linear_segment(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<LinearSegment>, arg4: u128) : u128 {
        if (arg4 == 0 || linear_terminal(arg0, arg1, arg2, arg3)) {
            return 0
        };
        quote_linear_segment_value(current_linear_segment(arg1, arg3), arg4)
    }

    public fun quote_linear_segment_value(arg0: &LinearSegment, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 0
        };
        if (arg1 >= arg0.remaining_input) {
            arg0.remaining_output
        } else if (arg0.exact_dlmm) {
            let v1 = if (arg0.forward) {
                (effective_input(arg1, arg0.fee_rate, arg0.fee_denominator) as u256) * (arg0.price_x64 as u256) / (18446744073709551616 as u256)
            } else {
                (effective_input(arg1, arg0.fee_rate, arg0.fee_denominator) as u256) * (18446744073709551616 as u256) / (arg0.price_x64 as u256)
            };
            let v2 = if (v1 > (arg0.remaining_output as u256)) {
                (arg0.remaining_output as u256)
            } else {
                v1
            };
            to_u128(v2)
        } else {
            mul_div_down(arg1, arg0.remaining_output, arg0.remaining_input)
        }
    }

    public fun quote_linear_with_shortfall(arg0: u64, arg1: bool, arg2: &vector<LinearSegment>, arg3: u128, arg4: &mut u64, arg5: &mut OrderbookShortfall) : (u128, u8, u64) {
        if (arg5.minimum_gross > 0 && arg3 >= arg5.minimum_gross) {
            if (*arg4 < arg5.crossed) {
                *arg4 = 0;
                return (0, 6, *arg4)
            };
            *arg4 = *arg4 - arg5.crossed;
            let v0 = if (arg1) {
                3
            } else {
                0
            };
            return (0, v0, arg5.crossed)
        };
        let (v1, v2, v3, v4) = quote_linear_hop_bounded_impl(arg0, arg1, arg2, arg3, arg4);
        if (v4 > 0 && (v2 == 3 || v2 == 0)) {
            arg5.minimum_gross = arg3 - v4 + 1;
            arg5.crossed = v3;
        };
        (v1, v2, v3)
    }

    public fun quote_lst_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: &mut u64) : (u128, u8, u64) {
        if (arg6 == 0) {
            return (0, 0, 0)
        };
        if (arg6 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg7 == 0) {
            return (0, 6, 0)
        };
        *arg7 = *arg7 - 1;
        if (arg6 < arg4) {
            return (0, 0, 0)
        };
        let v0 = (arg0 as u256);
        let v1 = div_ceil((arg6 as u256) * (arg1 as u256), v0);
        let v2 = if (arg5) {
            if (v1 > (arg6 as u256)) {
                return (0, 5, 0)
            };
            ((arg6 as u256) - v1) * (arg3 as u256) / (arg2 as u256)
        } else {
            let v3 = (arg6 as u256) * (arg3 as u256) / (arg2 as u256);
            let v4 = div_ceil(v3 * (arg1 as u256), v0);
            if (v4 > v3) {
                return (0, 5, 0)
            };
            v3 - v4
        };
        if (v2 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v2 as u128), 0, 0)
    }

    fun quote_metastable(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (*arg2 == 0) {
            return (0, 6, 0)
        };
        *arg2 = *arg2 - 1;
        let (v0, v1) = if (arg0.zero_for_one) {
            meta_exchange(arg1, arg0.liquidity, 1000000000000000000, arg0.stable_scale_out, arg0.stable_scale_in)
        } else {
            meta_exchange(arg1, 1000000000000000000, arg0.liquidity, arg0.stable_scale_in, arg0.stable_scale_out)
        };
        if (v1 != 0) {
            return (0, v1, 0)
        };
        if (v0 == 0) {
            return (0, 10, 0)
        };
        if (arg0.zero_for_one) {
            if (v0 > 18446744073709551615 - arg0.stable_amp) {
                return (0, 7, 0)
            };
            return (v0, 0, 0)
        };
        if (v0 > arg0.reserve_in) {
            return (0, 7, 0)
        };
        let v2 = arg0.reserve_in - v0;
        let v3 = if (v2 >= arg0.sqrt_price_x64) {
            (arg0.stable_admin_fee as u128)
        } else {
            (arg0.stable_lp_fee as u128) - ((arg0.stable_lp_fee - arg0.stable_admin_fee) as u128) * v2 / arg0.sqrt_price_x64
        };
        let v4 = v0 - v0 * v3 / 1000000000000000000;
        let v5 = if (v4 == 0) {
            10
        } else {
            0
        };
        (v4, v5, 0)
    }

    public fun quote_orderbook_hop_bounded(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<OrderbookSegment>, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        let v0 = effective_input(arg8, arg1, arg0);
        let v1 = 0;
        let v2 = 0;
        let v3 = arg3;
        let v4 = 0;
        while (v0 > 0 && v3 < 0x1::vector::length<OrderbookSegment>(arg7)) {
            if (*arg9 == 0) {
                return (0, 6, v4)
            };
            *arg9 = *arg9 - 1;
            let v5 = 0x1::vector::borrow<OrderbookSegment>(arg7, v3);
            let v6 = if (arg2) {
                v0
            } else {
                mul_div_down(v0, 1000000000, v5.price)
            };
            let v7 = round_down_to_quantum(v6, arg5);
            let v8 = if (v7 < v5.remaining_base) {
                v7
            } else {
                v5.remaining_base
            };
            if (v8 == 0) {
                break
            };
            let v9 = mul_div_down(v8, v5.price, 1000000000);
            let v10 = if (arg2) {
                v8
            } else {
                v9
            };
            if (v10 > v0) {
                return (0, 5, v4)
            };
            v0 = v0 - v10;
            let v11 = if (arg2) {
                v9
            } else {
                v8
            };
            v1 = v1 + v11;
            v2 = v2 + v8;
            if (v8 < v5.remaining_base) {
                break
            };
            v4 = v4 + 1;
            v3 = v3 + 1;
        };
        if (v2 < arg6) {
            return (0, 1, v4)
        };
        let v12 = if (v0 > 0) {
            if (v3 == 0x1::vector::length<OrderbookSegment>(arg7)) {
                arg4
            } else {
                false
            }
        } else {
            false
        };
        if (v12) {
            return (0, 3, v4)
        };
        (v1, 0, v4)
    }

    public fun quote_orderbook_prefix(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<OrderbookSegment>, arg8: u128, arg9: &mut u64, arg10: &mut vector<OrderbookPrefix>) : (u128, u8, u64) {
        let v0 = effective_input(arg8, arg1, arg0);
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        let v4 = arg3;
        let v5 = 0;
        let v6 = 0;
        let v7 = if (0x1::vector::length<OrderbookPrefix>(arg10) < *arg9) {
            0x1::vector::length<OrderbookPrefix>(arg10)
        } else {
            *arg9
        };
        let v8 = v7;
        while (v6 < v8) {
            v8 = v6 + (v8 - v6) / 2;
            if (0x1::vector::borrow<OrderbookPrefix>(arg10, v8).minimum_input <= v0) {
                v6 = v8 + 1;
                continue
            };
        };
        if (v6 > 0) {
            let v9 = 0x1::vector::borrow<OrderbookPrefix>(arg10, v6 - 1);
            v1 = v0 - v9.spent;
            v2 = v9.output;
            v3 = v9.base;
            v4 = arg3 + v6;
            v5 = v6;
            *arg9 = *arg9 - v6;
        };
        while (v1 > 0 && v4 < 0x1::vector::length<OrderbookSegment>(arg7)) {
            if (*arg9 == 0) {
                return (0, 6, v5)
            };
            *arg9 = *arg9 - 1;
            let v10 = 0x1::vector::borrow<OrderbookSegment>(arg7, v4);
            let v11 = if (arg2) {
                v1
            } else {
                mul_div_down(v1, 1000000000, v10.price)
            };
            let v12 = round_down_to_quantum(v11, arg5);
            let v13 = if (v12 < v10.remaining_base) {
                v12
            } else {
                v10.remaining_base
            };
            if (v13 == 0) {
                break
            };
            let v14 = mul_div_down(v13, v10.price, 1000000000);
            let v15 = if (arg2) {
                v13
            } else {
                v14
            };
            if (v15 > v1) {
                return (0, 5, v5)
            };
            let v16 = v0 - v1;
            let v17 = v1 - v15;
            v1 = v17;
            let v18 = if (arg2) {
                v14
            } else {
                v13
            };
            let v19 = v2 + v18;
            v2 = v19;
            let v20 = v3 + v13;
            v3 = v20;
            if (v13 < v10.remaining_base) {
                break
            };
            let v21 = v5 + 1;
            v5 = v21;
            v4 = v4 + 1;
            if (v21 == 0x1::vector::length<OrderbookPrefix>(arg10) + 1) {
                let v22 = if (arg2) {
                    round_up_to_quantum(v10.remaining_base, arg5)
                } else {
                    mul_div_up(round_up_to_quantum(v10.remaining_base, arg5), v10.price, 1000000000)
                };
                if (v16 <= 340282366920938463463374607431768211455 - v22) {
                    let v23 = v16 + v22;
                    let v24 = if (v21 == 1) {
                        0
                    } else {
                        0x1::vector::borrow<OrderbookPrefix>(arg10, v21 - 2).minimum_input
                    };
                    let v25 = if (v23 > v24) {
                        v23
                    } else {
                        v24
                    };
                    let v26 = OrderbookPrefix{
                        minimum_input : v25,
                        spent         : v0 - v17,
                        output        : v19,
                        base          : v20,
                    };
                    0x1::vector::push_back<OrderbookPrefix>(arg10, v26);
                    continue
                } else {
                    continue
                };
            };
        };
        if (v3 < arg6) {
            return (0, 1, v5)
        };
        let v27 = if (v1 > 0) {
            if (v4 == 0x1::vector::length<OrderbookSegment>(arg7)) {
                arg4
            } else {
                false
            }
        } else {
            false
        };
        if (v27) {
            return (0, 3, v5)
        };
        (v2, 0, v5)
    }

    public fun quote_orderbook_segment(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<OrderbookSegment>, arg6: u128) : u128 {
        let (v0, _) = quote_orderbook_segment_and_consumed_base(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        v0
    }

    public fun quote_orderbook_segment_and_consumed_base(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<OrderbookSegment>, arg6: u128) : (u128, u128) {
        if (arg6 == 0 || orderbook_terminal(arg0, arg2, arg3, arg5)) {
            return (0, 0)
        };
        let v0 = current_orderbook_segment(arg2, arg5);
        if (arg1) {
            let v3 = round_down_to_quantum(arg6, arg4);
            let v4 = if (v3 < v0.remaining_base) {
                v3
            } else {
                v0.remaining_base
            };
            (mul_div_down(v4, v0.price, 1000000000), v4)
        } else {
            let v5 = round_down_to_quantum(mul_div_down(arg6, 1000000000, v0.price), arg4);
            let v6 = if (v5 < v0.remaining_base) {
                v5
            } else {
                v0.remaining_base
            };
            (v6, v6)
        }
    }

    public fun quote_orderbook_with_shortfall(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<OrderbookSegment>, arg8: u128, arg9: &mut u64, arg10: &mut OrderbookShortfall, arg11: bool) : (u128, u8, u64) {
        if (arg10.minimum_gross > 0 && arg8 >= arg10.minimum_gross) {
            if (*arg9 < arg10.crossed) {
                *arg9 = 0;
                return (0, 6, *arg9)
            };
            *arg9 = *arg9 - arg10.crossed;
            return (0, 3, arg10.crossed)
        };
        let (v0, v1, v2) = if (!arg11 || 0x1::vector::length<OrderbookSegment>(arg7) < 8) {
            quote_orderbook_hop_bounded(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
        } else {
            let v3 = &mut arg10.prefixes;
            quote_orderbook_prefix(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v3)
        };
        if (v1 == 3 && arg8 > 0) {
            arg10.minimum_gross = arg8;
            arg10.crossed = v2;
        };
        (v0, v1, v2)
    }

    public fun quote_prepared_cpmm(arg0: &PreparedCpmm, arg1: u128) : u128 {
        if (arg0.fractional && (!arg0.reserves_valid || arg1 > 18446744073709551615)) {
            return 0
        };
        let v0 = (arg1 as u256) * arg0.input_factor;
        let v1 = if (arg0.fractional) {
            let v2 = arg0.scaled_reserve_in + v0;
            if (v2 == 0) {
                0
            } else {
                ((v0 * arg0.reserve_out / v2) as u128)
            }
        } else {
            let v3 = ((v0 / arg0.input_denominator) as u128);
            if (v3 == 0) {
                0
            } else {
                (((v3 as u256) * arg0.reserve_out / ((arg0.reserve_in + v3) as u256)) as u128)
            }
        };
        if (arg0.output_factor == arg0.output_denominator && arg0.output_denominator > 0) {
            v1
        } else {
            (((v1 as u256) * arg0.output_factor / arg0.output_denominator) as u128)
        }
    }

    fun quote_route(arg0: &vector<Hop>, arg1: u128) : u128 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            v0 = quote_hop(0x1::vector::borrow<Hop>(arg0, v1), v0);
            v1 = v1 + 1;
        };
        v0
    }

    fun quote_stable_with_d(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: bool, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: u128, arg10: &mut u64, arg11: &mut u128) : (u128, u8, u64) {
        if (arg9 == 0) {
            return (0, 0, 0)
        };
        if (arg9 > 18446744073709551615) {
            return (0, 5, 0)
        };
        let v0 = arg9;
        if (arg4) {
            v0 = stable_fee_remainder(stable_fee_remainder(arg9, arg2), arg8);
        };
        let v1 = stable_fee_remainder(v0, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let v2 = (arg0 as u256) * (arg6 as u256);
        let v3 = (arg1 as u256) * (arg7 as u256);
        let v4 = (v1 as u256) * (arg6 as u256);
        if (v2 + v4 > 1267650600228229401496703205376) {
            return (0, 5, 0)
        };
        let v5 = if (*arg11 > 0) {
            (*arg11 as u256)
        } else {
            let (v6, v7) = stable_compute_d(v2, v3, (arg3 as u256), arg10);
            if (v7 != 0) {
                return (0, v7, 0)
            };
            *arg11 = (v6 as u128);
            v6
        };
        let (v8, v9) = stable_compute_y(v2 + v4, v5, (arg3 as u256), arg10);
        if (v9 != 0) {
            return (0, v9, 0)
        };
        if (v3 <= v8 + 1) {
            return (0, 0, 0)
        };
        let v10 = (v3 - v8 - 1) / (arg7 as u256);
        if (v10 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        let v11 = (v10 as u128);
        let v12 = v11;
        if (!arg4) {
            v12 = stable_fee_remainder(stable_fee_remainder(v11, arg2), arg8);
        };
        (v12, 0, 0)
    }

    public fun quote_steamm_cpmm_hop(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        if (arg9 == 0) {
            return (0, 0, 0)
        };
        if (arg9 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg10 == 0) {
            return (0, 6, 0)
        };
        *arg10 = *arg10 - 1;
        let (v0, v1) = steamm_btoken_supplies(arg6);
        let v2 = (arg9 as u256) * (v0 as u256) * 1000000000000000000 / (arg7 as u256);
        if (v2 == 0 || v2 > (18446744073709551615 as u256)) {
            return (0, 0, 0)
        };
        let v3 = (arg4 as u256) * v2 / ((arg3 as u256) + v2);
        if (v3 == 0 || v3 > (arg0 as u256)) {
            return (0, 0, 0)
        };
        let v4 = div_ceil(v3 * (arg2 as u256), (arg1 as u256));
        if (v4 >= v3) {
            return (0, 0, 0)
        };
        let v5 = steamm_btoken_burn_amount(v3 - v4, v1);
        if (v5 == 0) {
            return (0, 0, 0)
        };
        let v6 = v5 * (arg8 as u256) / (v1 as u256) * 1000000000000000000;
        if (v6 > (arg5 as u256) || v6 > (18446744073709551615 as u256)) {
            return (0, 0, 0)
        };
        ((v6 as u128), 0, 0)
    }

    public fun quote_steamm_omm_hop(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128, arg8: u64, arg9: u128, arg10: u128, arg11: u128, arg12: &mut u64) : (u128, u8, u64) {
        if (arg11 == 0) {
            return (0, 0, 0)
        };
        if (arg11 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg12 == 0) {
            return (0, 6, 0)
        };
        *arg12 = *arg12 - 1;
        let (v0, v1) = steamm_btoken_supplies(arg7);
        let v2 = (arg11 as u256) * (v0 as u256) * 1000000000000000000 / (arg9 as u256);
        let v3 = if (v2 == 0) {
            true
        } else if (v2 > (18446744073709551615 as u256)) {
            true
        } else {
            v2 > ((18446744073709551615 - (v0 as u128)) as u256)
        };
        if (v3) {
            return (0, 0, 0)
        };
        let v4 = ((arg9 as u256) + (arg11 as u256) * 1000000000000000000) / ((v0 as u256) + v2);
        let v5 = (arg10 as u256) / (v1 as u256);
        if (v4 == 0 || v5 == 0) {
            return (0, 5, 0)
        };
        let (v6, v7) = steamm_decimal_mul(v2 * 1000000000000000000, v4);
        if (!v7) {
            return (0, 5, 0)
        };
        let (v8, v9) = steamm_decimal_mul(v6, (arg3 as u256));
        if (!v9) {
            return (0, 5, 0)
        };
        let (v10, v11) = steamm_decimal_div(v8, (arg0 as u256));
        if (!v11) {
            return (0, 5, 0)
        };
        let (v12, v13) = steamm_decimal_div(v10, v5);
        let v14 = v12;
        if (!v13) {
            return (0, 5, 0)
        };
        let v15 = (arg6 as u8);
        let v16 = (arg8 as u8);
        let v17 = if (v15 >= v16) {
            v15 - v16
        } else {
            v16 - v15
        };
        let v18 = 1;
        let v19 = 0;
        while (v19 < v17) {
            v18 = v18 * 10;
            v19 = v19 + 1;
        };
        if (v15 > v16) {
            v14 = v12 / v18;
        } else if (v16 > v15) {
            if (v12 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v18) {
                return (0, 5, 0)
            };
            v14 = v12 * v18;
        };
        let v20 = v14 / 1000000000000000000;
        let v21 = if (v20 == 0) {
            true
        } else if (v20 >= (arg4 as u256)) {
            true
        } else {
            v20 > (18446744073709551615 as u256)
        };
        if (v21) {
            return (0, 0, 0)
        };
        let v22 = div_ceil(v20 * (arg2 as u256), (arg1 as u256));
        if (v22 >= v20) {
            return (0, 0, 0)
        };
        let v23 = steamm_btoken_burn_amount(v20 - v22, v1);
        if (v23 == 0) {
            return (0, 0, 0)
        };
        let v24 = v23 * (arg10 as u256) / (v1 as u256) * 1000000000000000000;
        if (v24 > (arg5 as u256) || v24 > (18446744073709551615 as u256)) {
            return (0, 0, 0)
        };
        ((v24 as u128), 0, 0)
    }

    public fun quote_steamm_omm_v2_legacy_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u128, arg9: u64, arg10: u128, arg11: u128, arg12: u64, arg13: bool, arg14: u128, arg15: &mut u64) : (u128, u8, u64) {
        quote_steamm_omm_v2_with_migration(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, false, arg14, arg15)
    }

    fun quote_steamm_omm_v2_prepared(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u128, arg9: u64, arg10: u128, arg11: u128, arg12: u64, arg13: bool, arg14: bool, arg15: u128, arg16: &mut u64, arg17: &mut V3PrefixCache) : (u128, u8, u64) {
        if (arg15 == 0) {
            return (0, 0, 0)
        };
        if (arg15 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg16 == 0) {
            return (0, 6, 0)
        };
        *arg16 = *arg16 - 1;
        let (v0, v1) = steamm_btoken_supplies(arg8);
        let v2 = (arg15 as u256) * (v0 as u256) * 1000000000000000000 / (arg10 as u256);
        if (v2 == 0) {
            return (0, 10, 0)
        };
        if (v2 > (18446744073709551615 as u256) || v2 > ((18446744073709551615 - (v0 as u128)) as u256)) {
            return (0, 12, 0)
        };
        let v3 = ((arg10 as u256) + (arg15 as u256) * 1000000000000000000) / ((v0 as u256) + v2);
        let v4 = if (arg17.fee_rate > 0) {
            (arg17.fee_rate as u256)
        } else {
            let v5 = (arg11 as u256) / (v1 as u256);
            if (v5 <= (18446744073709551615 as u256)) {
                arg17.fee_rate = (v5 as u64);
            };
            v5
        };
        if (v3 == 0 || v4 == 0) {
            return (0, 5, 0)
        };
        let v6 = if (arg13) {
            v3
        } else {
            v4
        };
        let v7 = if (arg13) {
            v4
        } else {
            v3
        };
        let v8 = (arg4 as u256) * v6;
        let v9 = (arg5 as u256) * v7;
        let (v10, v11) = steamm_q_from_decimal(v8);
        let (v12, v13) = steamm_q_from_decimal(v9);
        let (v14, v15) = steamm_q_from_decimal(v2 * v3);
        let (v16, v17) = steamm_effective_amp(arg12, arg14, v8, v9, arg0, arg1, (arg7 as u8), (arg9 as u8));
        if (!v17) {
            return (0, 12, 0)
        };
        let (v18, v19) = steamm_q_from_integer((v16 as u128));
        let v20 = if (!v11) {
            true
        } else if (!v13) {
            true
        } else if (!v15) {
            true
        } else {
            !v19
        };
        if (v20) {
            return (0, 5, 0)
        };
        let (v21, v22, v23) = if (arg17.boundary_cursor == 1) {
            (arg17.liquidity, arg17.sqrt_price_x64, arg17.policy_output_capacity)
        } else {
            let (v24, v25) = steamm_q_from_decimal((arg0 as u256));
            let (v26, v27) = steamm_q_from_decimal((arg1 as u256));
            if (!v25 || !v27) {
                return (0, 5, 0)
            };
            let v28 = (arg7 as u8);
            let v29 = (arg9 as u8);
            let v30 = if (v28 >= v29) {
                v28 - v29
            } else {
                v29 - v28
            };
            let v31 = 1;
            let v32 = 0;
            while (v32 < v30) {
                v31 = v31 * 10;
                v32 = v32 + 1;
            };
            let (v33, v34) = steamm_q_from_integer(v31);
            if (!v34) {
                return (0, 5, 0)
            };
            let v35 = if (v28 >= v29) {
                v33
            } else {
                let (v36, v37) = steamm_q_div(18446744073709551616, v33);
                if (!v37) {
                    return (0, 5, 0)
                };
                v36
            };
            arg17.liquidity = v24;
            arg17.sqrt_price_x64 = v26;
            arg17.policy_output_capacity = v35;
            arg17.boundary_cursor = 1;
            (v24, v26, v35)
        };
        let (v38, v39) = if (arg13) {
            steamm_q_multiply_divide(v14, v21, v12, v22, v23, false)
        } else {
            steamm_q_multiply_divide(v14, v23, v22, v10, v21, true)
        };
        if (!v39) {
            return (0, 5, 0)
        };
        let (v40, v41) = steamm_q_newton(v38, v18);
        if (!v41) {
            return (0, 5, 0)
        };
        let v42 = if (arg13) {
            v12
        } else {
            v10
        };
        let (v43, v44) = steamm_q_mul(v40, v42);
        if (!v44) {
            return (0, 5, 0)
        };
        let v45 = ((v43 >> 64) as u256) * 1000000000000000000 / v4;
        let v46 = if (arg13) {
            arg5
        } else {
            arg4
        };
        if (v45 == 0) {
            return (0, 10, 0)
        };
        if (v45 >= (v46 as u256)) {
            return (0, 7, 0)
        };
        let (v47, v48) = steamm_omm_v2_linear_btoken_output(arg0, arg1, arg7, arg9, arg13, v2, v3, v4);
        if (!v48 || v45 > v47) {
            return (0, 12, 0)
        };
        if (v45 == v47) {
            return (0, 10, 0)
        };
        let v49 = div_ceil(v45 * (arg3 as u256), (arg2 as u256));
        if (v49 >= v45) {
            return (0, 10, 0)
        };
        let v50 = steamm_btoken_burn_amount(v45 - v49, v1);
        if (v50 == 0) {
            return (0, 10, 0)
        };
        let v51 = v50 * (arg11 as u256) / (v1 as u256) * 1000000000000000000;
        if (v51 > (18446744073709551615 as u256)) {
            return (0, 12, 0)
        };
        if (v51 > (arg6 as u256)) {
            return (0, 7, 0)
        };
        ((v51 as u128), 0, 0)
    }

    public fun quote_steamm_omm_v2_with_migration(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u128, arg9: u64, arg10: u128, arg11: u128, arg12: u64, arg13: bool, arg14: bool, arg15: u128, arg16: &mut u64) : (u128, u8, u64) {
        if (arg15 == 0) {
            return (0, 0, 0)
        };
        let v0 = new_prefixCache(0x1::vector::empty<V3Prefix>(), 0, 0, 1, 0, 0, 340282366920938463463374607431768211455, false, 0, false, false);
        let v1 = &mut v0;
        quote_steamm_omm_v2_prepared(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v1)
    }

    public fun quote_v3_cached(arg0: &vector<TickBoundary>, arg1: &mut V3PrefixCache, arg2: u128, arg3: &mut u64) : (u128, u8, u64) {
        if (arg1.status != 0) {
            return (0, arg1.status, 0)
        };
        if (arg2 == 0) {
            return (0, 0, 0)
        };
        let v0 = 0x1::vector::length<TickBoundary>(arg0) - arg1.boundary_cursor;
        if (v0 == 0) {
            return (0, 3, 0)
        };
        if (*arg3 == 0) {
            return (0, 6, 0)
        };
        extend_v3_prefix_cache(arg0, arg1, arg2, v0);
        if (arg1.status != 0) {
            return (0, arg1.status, 0)
        };
        let v1 = 0x1::vector::length<V3Prefix>(&arg1.prefixes);
        if (v1 == 0) {
            return (0, 3, 0)
        };
        let (v2, v3) = prefix_upper_bound_virtual(&arg1.prefixes, v0, arg2, arg3);
        if (v3 != 0) {
            return (0, v3, v2)
        };
        let (v4, v5, v6, v7) = if (v2 == 0) {
            (0, 0, arg1.sqrt_price_x64, arg1.liquidity)
        } else {
            let v8 = 0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v2 - 1);
            (v8.cumulative_input, v8.cumulative_output, v8.end_sqrt_price_x64, v8.liquidity_after)
        };
        let v9 = if (arg1.policy_stop_at_zero_liquidity) {
            if (v2 > 0) {
                v7 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v9) {
            return (0, 7, v2)
        };
        if (arg2 == v4) {
            return (v5, 0, v2)
        };
        if (v5 > arg1.policy_output_capacity) {
            return (0, 7, v2)
        };
        if (v2 == v1 || v7 == 0) {
            return (0, 3, v2)
        };
        if (*arg3 == 0) {
            return (0, 6, v2)
        };
        *arg3 = *arg3 - 1;
        let v10 = effective_input(arg2 - v4, arg1.fee_rate, arg1.fee_denominator);
        let v11 = if (v10 == 0) {
            v6
        } else {
            next_sqrt_price_partial(v6, v7, arg1.zero_for_one, v10, arg1.policy_stop_at_zero_liquidity)
        };
        let v12 = if (arg1.zero_for_one) {
            mul_div_down(v7, v6 - v11, 18446744073709551616)
        } else {
            amount0_delta_down(v6, v11, v7)
        };
        let (v13, v14) = if (v5 > 340282366920938463463374607431768211455 - v12) {
            (5, 0)
        } else {
            (0, v5 + v12)
        };
        (v14, v13, v2)
    }

    public fun quote_v3_cached_with_slope(arg0: &vector<TickBoundary>, arg1: &mut V3PrefixCache, arg2: u128, arg3: &mut u64) : (u128, u256, u8, u64) {
        let (v0, v1, v2) = quote_v3_cached(arg0, arg1, arg2, arg3);
        if (v1 != 0) {
            return (0, 0, v1, v2)
        };
        let (v3, v4, v5) = if (v2 == 0) {
            (0, arg1.sqrt_price_x64, arg1.liquidity)
        } else {
            let v6 = 0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v2 - 1);
            (v6.cumulative_input, v6.end_sqrt_price_x64, v6.liquidity_after)
        };
        let v7 = if (arg2 == v3) {
            v4
        } else {
            next_sqrt_price_partial(v4, v5, arg1.zero_for_one, effective_input(arg2 - v3, arg1.fee_rate, arg1.fee_denominator), arg1.policy_stop_at_zero_liquidity)
        };
        let v8 = if (arg1.zero_for_one) {
            (v7 as u256) * (v7 as u256) / q64()
        } else {
            q64() * q64() / (v7 as u256) * q64() / (v7 as u256)
        };
        (v0, v8, 0, v2)
    }

    public fun quote_ve33_stable_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: &mut u64) : (u128, u8, u64) {
        if (arg7 == 0) {
            return (0, 0, 0)
        };
        if (arg7 > 18446744073709551615) {
            return (0, 5, 0)
        };
        let v0 = arg7 - arg7 * (arg1 as u128) / (arg0 as u128);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = (arg4 as u256);
        let v2 = (arg2 as u256) * v1 / (arg5 as u256);
        let v3 = (arg3 as u256) * v1 / (arg6 as u256);
        let v4 = (v0 as u256) * v1 / (arg5 as u256);
        if (v4 > 10000000000000000000 || v2 > 10000000000000000000 - v4) {
            return (0, 5, 0)
        };
        let (v5, v6) = ve33_get_y(v2 + v4, ve33_invariant(v2, v3), v3, arg8);
        if (v6 != 0) {
            return (0, v6, 0)
        };
        if (v5 > v3) {
            return (0, 5, 0)
        };
        let v7 = (v3 - v5) * (arg6 as u256) / v1;
        if (v7 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v7 as u128), 0, 0)
    }

    public fun quote_virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        if (arg9 == 0) {
            return (0, 0, 0)
        };
        if (*arg10 == 0) {
            return (0, 6, 0)
        };
        *arg10 = *arg10 - 1;
        let v0 = if (arg8) {
            arg2
        } else {
            arg3
        };
        let v1 = if (arg8) {
            arg3
        } else {
            arg2
        };
        let v2 = (arg4 as u256) * (arg5 as u256);
        let v3 = v2 * v2 * (arg6 as u256) / (arg7 as u256);
        let v4 = v2 + (v0 as u256) - (arg4 as u256);
        if (v4 == 0 || v3 == 0) {
            return (0, 5, 0)
        };
        let v5 = (arg9 as u256);
        let v6 = if (arg8) {
            if (v4 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v5) {
                return (0, 5, 0)
            };
            v3 / v4 - v3 / (v4 + v5)
        } else {
            let v7 = v3 / v4;
            if (v7 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v5) {
                return (0, 5, 0)
            };
            let v8 = v3 / (v7 + v5);
            if (v8 >= v4) {
                0
            } else {
                v4 - v8
            }
        };
        let v9 = if (arg8) {
            v1
        } else {
            v0
        };
        if (v6 >= (v9 as u256)) {
            return (0, 7, 0)
        };
        let v10 = v6 - v6 * (arg1 as u256) / (arg0 as u256);
        if (v10 > (340282366920938463463374607431768211455 as u256)) {
            return (0, 5, 0)
        };
        ((v10 as u128), 0, 0)
    }

    public fun reader_price_square_limit(arg0: &vector<Hop>, arg1: u64) : u256 {
        assert!(arg1 < 0x1::vector::length<Hop>(arg0), 6);
        let v0 = 0x1::vector::borrow<Hop>(arg0, arg1);
        if (v0.kind != 4 && v0.kind != 1) {
            return 0
        };
        let v1 = q64();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Hop>(arg0)) {
            let v3 = 0x1::vector::borrow<Hop>(arg0, v2);
            let v4 = if (v3.kind != 0) {
                if (v3.kind != 4) {
                    v3.kind != 1
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                return 0
            };
            if (v2 != arg1) {
                v1 = mul_q64_ceil(v1, hop_marginal_upper_x64(v3));
            };
            v2 = v2 + 1;
        };
        if (v1 == 0 || v1 == 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
            return 0
        };
        if (v0.zero_for_one) {
            q64() * q64() * q64() / v1
        } else {
            saturating_mul(v1, q64())
        }
    }

    fun record_candidate_if_valid(arg0: &vector<Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: &mut OptimizeResult) {
        if (!candidate_satisfies_orderbook_minimums(arg0, arg1)) {
            return
        };
        record_route_candidate(arg0, arg2, arg3, arg4);
    }

    public fun record_candidate_with_fee(arg0: u128, arg1: u128, arg2: u256, arg3: &mut OptimizeResult) {
        if (arg1 <= arg0 || ((arg1 - arg0) as u256) <= arg2) {
            return
        };
        let v0 = arg1 - arg0 - (arg2 as u128);
        if (!arg3.found || v0 > arg3.gross_profit) {
            arg3.found = true;
            arg3.status = 0;
            arg3.amount_in = arg0;
            arg3.amount_out = arg1;
            arg3.gross_profit = v0;
        };
    }

    fun record_mapped_local_candidate(arg0: &vector<Hop>, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: &mut OptimizeResult) {
        if (arg2 == 0) {
            return
        };
        let (v0, v1) = source_input_for_local(arg0, arg1, arg2);
        let v2 = if (!v1) {
            true
        } else if (v0 == 0) {
            true
        } else {
            v0 > arg5
        };
        if (v2) {
            return
        };
        record_candidate_if_valid(arg0, v0, arg3 + v0, arg4 + quote_route(arg0, v0), arg6);
        if (v0 > 1) {
            let v3 = v0 - 1;
            record_candidate_if_valid(arg0, v3, arg3 + v3, arg4 + quote_route(arg0, v3), arg6);
        };
        if (v0 < arg5) {
            let v4 = v0 + 1;
            record_candidate_if_valid(arg0, v4, arg3 + v4, arg4 + quote_route(arg0, v4), arg6);
        };
    }

    fun record_nearby_candidates(arg0: &vector<Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: &mut OptimizeResult) {
        let v0 = if (arg3 == 0) {
            1
        } else {
            arg3
        };
        if (v0 <= arg4) {
            record_candidate_if_valid(arg0, v0, arg1 + v0, arg2 + quote_route(arg0, v0), arg5);
        };
        if (v0 > 1) {
            let v1 = v0 - 1;
            record_candidate_if_valid(arg0, v1, arg1 + v1, arg2 + quote_route(arg0, v1), arg5);
        };
        if (v0 < arg4) {
            let v2 = v0 + 1;
            record_candidate_if_valid(arg0, v2, arg1 + v2, arg2 + quote_route(arg0, v2), arg5);
        };
        record_orderbook_quantized_candidates(arg0, arg1, arg2, v0, arg4, arg5);
    }

    fun record_orderbook_quantized_candidates(arg0: &vector<Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: &mut OptimizeResult) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (v1.kind == 2 && !orderbook_terminal(v1.kind, v1.orderbook_cursor, v1.orderbook_has_more, &v1.orderbook_segments)) {
                let v2 = current_orderbook_segment(v1.orderbook_cursor, &v1.orderbook_segments);
                let (v3, v4) = if (v1.orderbook_base_to_quote) {
                    let v5 = round_down_to_quantum(arg3, v1.orderbook_lot_size);
                    (v5, v5 + v1.orderbook_lot_size)
                } else {
                    let v6 = round_down_to_quantum(mul_div_down(arg3, 1000000000, v2.price), v1.orderbook_lot_size);
                    let v7 = if (v6 == 0) {
                        0
                    } else {
                        mul_div_up(v6, v2.price, 1000000000)
                    };
                    (v7, mul_div_up(v6 + v1.orderbook_lot_size, v2.price, 1000000000))
                };
                record_mapped_local_candidate(arg0, v0, v3, arg1, arg2, arg4, arg5);
                record_mapped_local_candidate(arg0, v0, v4, arg1, arg2, arg4, arg5);
                let v8 = if (v1.orderbook_consumed_base >= v1.orderbook_min_size) {
                    0
                } else {
                    round_up_to_quantum(v1.orderbook_min_size - v1.orderbook_consumed_base, v1.orderbook_lot_size)
                };
                let v9 = if (v1.orderbook_base_to_quote) {
                    v8
                } else {
                    mul_div_up(v8, v2.price, 1000000000)
                };
                record_mapped_local_candidate(arg0, v0, v9, arg1, arg2, arg4, arg5);
            };
            arg3 = quote_hop(v1, arg3);
            v0 = v0 + 1;
        };
    }

    fun record_route_candidate(arg0: &vector<Hop>, arg1: u128, arg2: u128, arg3: &mut OptimizeResult) {
        if (arg2 <= arg1) {
            return
        };
        record_candidate_with_fee(arg1, arg2, route_auxiliary_fee(arg0, arg1), arg3);
    }

    fun record_v2_plateau_candidate(arg0: &vector<Hop>, arg1: u128, arg2: u128, arg3: &mut OptimizeResult) {
        if (arg2 == 0) {
            return
        };
        let (v0, v1) = v2_minimum_input_for_output(arg0, arg2);
        let v2 = if (v1) {
            if (v0 > 0) {
                v0 < arg1
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            record_route_candidate(arg0, v0, quote_route(arg0, v0), arg3);
        };
    }

    public fun refinement_point(arg0: &OptimizeResult, arg1: &vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64) : u128 {
        let v0 = if (arg0.found) {
            arg0.amount_in
        } else {
            midpoint(arg2, arg3)
        };
        let v1 = amount_lower_bound(arg1, v0);
        let v2 = if (v1 == 0) {
            arg2
        } else {
            *0x1::vector::borrow<u128>(arg1, v1 - 1)
        };
        let v3 = 0x1::vector::length<u128>(arg1);
        let v4 = if (v1 < v3 && *0x1::vector::borrow<u128>(arg1, v1) == v0) {
            v1 + 1
        } else {
            v1
        };
        let v5 = if (v4 == v3) {
            arg3
        } else {
            let v6 = *0x1::vector::borrow<u128>(arg1, v4);
            if (v6 > arg3) {
                arg3
            } else {
                v6
            }
        };
        if (!arg0.found || arg5 % 4 == 3) {
            return largest_gap_midpoint(arg1, arg2, arg3, arg4)
        };
        let v7 = if (v0 - v2 >= v5 - v0) {
            midpoint(v2, v0)
        } else {
            midpoint(v0, v5)
        };
        let v8 = aligned_in_range(v7, arg2, arg3, arg4);
        if (!contains_amount(arg1, v8)) {
            v8
        } else {
            largest_gap_midpoint(arg1, arg2, arg3, arg4)
        }
    }

    public fun replacement_stage(arg0: Hop) : StagedHop {
        let v0 = 0x1::vector::empty<Hop>();
        0x1::vector::push_back<Hop>(&mut v0, arg0);
        StagedHop{
            kind        : 2,
            liquidity   : 0,
            boundaries  : 0x1::vector::empty<TickBoundary>(),
            replacement : v0,
        }
    }

    public fun reserve_prefix_window(arg0: &vector<TickBoundary>, arg1: &mut V3PrefixCache, arg2: u64, arg3: u64) : (u64, bool) {
        let v0 = if (0x1::vector::length<TickBoundary>(arg0) - arg1.boundary_cursor > 1024) {
            true
        } else if (arg1.liquidity > 1208925819614629174706176) {
            true
        } else if (arg1.sqrt_price_x64 < 4294967296) {
            true
        } else if (arg1.sqrt_price_x64 > 79228162514264337593543950336) {
            true
        } else {
            arg1.fee_rate > arg1.fee_denominator - arg1.fee_rate
        };
        if (v0) {
            return (arg2, true)
        };
        let v1 = arg1.liquidity;
        let v2 = arg1.boundary_cursor;
        while (v2 < 0x1::vector::length<TickBoundary>(arg0)) {
            if (arg2 >= arg3) {
                arg1.status = 6;
                break
            };
            let v3 = arg2 + 1;
            arg2 = v3;
            let v4 = *0x1::vector::borrow<TickBoundary>(arg0, v2);
            if (v4.sqrt_price_x64 < 4294967296 || v4.sqrt_price_x64 > 79228162514264337593543950336) {
                return (v3, true)
            };
            let (v5, v6) = liquidity_after_boundary(v1, v4, arg1.zero_for_one);
            if (!v6) {
                arg1.status = 5;
                break
            };
            if (v5 > 1208925819614629174706176) {
                return (v3, true)
            };
            v1 = v5;
            v2 = v2 + 1;
        };
        (arg2, false)
    }

    public fun resume_coefficients(arg0: &mut OptimizeState) {
        if (arg0.finished) {
            return
        };
        arg0.result.complete = true;
        arg0.result.needs_more_hop = 18446744073709551615;
        let v0 = auxiliary_cost_x64(&arg0.route);
        let v1 = has_execution_bounds(&arg0.route);
        while (arg0.cursor < arg0.max_amount_in && arg0.result.segments < arg0.max_segments) {
            let v2 = first_missing_orderbook_segment(&arg0.route);
            if (v2 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v2;
                return
            };
            let v3 = first_missing_linear_segment(&arg0.route);
            if (v3 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v3;
                return
            };
            if (!orderbook_minimums_reachable(&arg0.route)) {
                arg0.finished = true;
                return
            };
            let v4 = first_missing_boundary(&arg0.route);
            if (v4 != 18446744073709551615) {
                while (v4 < 0x1::vector::length<Hop>(&arg0.route)) {
                    if (0x1::vector::borrow<Hop>(&arg0.route, v4).kind == 1 && 0x1::vector::borrow<Hop>(&arg0.route, v4).liquidity == 0) {
                        arg0.result.complete = false;
                        arg0.result.needs_more_hop = v4;
                        return
                    };
                    v4 = v4 + 1;
                };
            };
            let v5 = orderbook_minimums_satisfied(&arg0.route);
            let (v6, v7) = route_coefficients_x64(&arg0.route);
            let v8 = if (v0 == q64()) {
                v6
            } else {
                mul_ratio_down_saturating(v6, q64(), v0)
            };
            if (v8 <= q64()) {
                if (arg0.cursor == 0) {
                    arg0.result.coarse_rejected = true;
                    arg0.finished = true;
                    return
                };
                if (v5) {
                    arg0.finished = true;
                    return
                };
            };
            if (v4 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v4;
                return
            };
            let v9 = arg0.max_amount_in - arg0.cursor;
            let (v10, _) = next_route_boundary(&arg0.route, v9);
            assert!(v10 > 0, 3);
            arg0.result.segments = arg0.result.segments + 1;
            let v12 = q64() + v7 * (v10 as u256);
            if (v8 * q64() <= v12 * v12) {
                let v13 = if (v1) {
                    segment_minimum_input(&arg0.route, coefficient_root(v8, v7, v10), v10)
                } else {
                    coefficient_root(v8, v7, v10)
                };
                let (v14, v15) = if (v1) {
                    limited_segment_input(&arg0.route, v13)
                } else {
                    (v13, false)
                };
                let v16 = &mut arg0.result;
                record_nearby_candidates(&arg0.route, arg0.cursor, arg0.cursor_output, v14, v10, v16);
                let v17 = if (v15) {
                    true
                } else if (v5) {
                    true
                } else {
                    candidate_satisfies_orderbook_minimums(&arg0.route, v10)
                };
                if (v17) {
                    arg0.finished = true;
                    return
                };
            };
            if (v1) {
                let (v18, v19) = limited_segment_input(&arg0.route, v10);
                if (v19) {
                    if (v18 > 0) {
                        let v20 = &mut arg0.result;
                        record_nearby_candidates(&arg0.route, arg0.cursor, arg0.cursor_output, v18, v18, v20);
                    };
                    arg0.finished = true;
                    return
                };
            };
            if (v10 == v9) {
                let v21 = quote_route(&arg0.route, v10);
                let v22 = &mut arg0.result;
                record_candidate_if_valid(&arg0.route, v10, arg0.cursor + v10, arg0.cursor_output + v21, v22);
                if (arg0.cursor == 0) {
                    let v23 = &mut arg0.result;
                    record_v2_plateau_candidate(&arg0.route, v10, v21, v23);
                };
                arg0.finished = true;
                return
            };
            let v24 = &mut arg0.route;
            let (v25, v26, v27) = advance_route(v24, v10);
            arg0.cursor = arg0.cursor + v10;
            arg0.cursor_output = arg0.cursor_output + v25;
            arg0.result.crossed_ticks = arg0.result.crossed_ticks + v26;
            arg0.result.crossed_orders = arg0.result.crossed_orders + v27;
            let v28 = &mut arg0.result;
            record_candidate_if_valid(&arg0.route, 0, arg0.cursor, arg0.cursor_output, v28);
        };
        if (arg0.cursor < arg0.max_amount_in) {
            arg0.result.complete = false;
        };
        arg0.finished = true;
    }

    public fun reuse_current_stage() : StagedHop {
        StagedHop{
            kind        : 0,
            liquidity   : 0,
            boundaries  : 0x1::vector::empty<TickBoundary>(),
            replacement : 0x1::vector::empty<Hop>(),
        }
    }

    public fun round_down_to_quantum(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 > 0, 3);
        arg0 - arg0 % arg1
    }

    public fun round_up_to_quantum(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 > 0, 3);
        if (arg0 == 0) {
            0
        } else {
            arg0 + (arg1 - arg0 % arg1) % arg1
        }
    }

    fun route_auxiliary_fee(arg0: &vector<Hop>, arg1: u128) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.policy.auxiliary_fee_rate > 0) {
                v0 = saturating_add(v0, (arg1 as u256) * (v2.policy.auxiliary_fee_rate as u256) / (v2.policy.auxiliary_fee_denominator as u256));
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun route_coefficients_x64(arg0: &vector<Hop>) : (u256, u256) {
        let v0 = q64();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Hop>(arg0)) {
            let v3 = 0x1::vector::borrow<Hop>(arg0, v2);
            v1 = v1 + hop_curvature_x64(v3) * v0 / q64();
            let v4 = v0 * hop_marginal_x64(v3);
            v0 = v4 / q64();
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun route_marginal_upper_x64(arg0: &vector<Hop>) : u256 {
        let v0 = q64();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            v0 = mul_q64_ceil(v0, hop_marginal_upper_x64(0x1::vector::borrow<Hop>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun route_model(arg0: &vector<Hop>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.policy.linear_rate_inversion) {
                v0 = 2;
            } else {
                let v3 = if (v2.kind != 0) {
                    if (v2.kind != 1) {
                        if (v2.kind != 3) {
                            v2.kind != 2
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    return 1
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun saturating_add(arg0: u256, arg1: u256) : u256 {
        if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 + arg1
        }
    }

    public fun saturating_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 * arg1
        }
    }

    public fun search_rejection_code(arg0: u8) : u64 {
        if (arg0 == 10) {
            return 418
        };
        if (arg0 == 7) {
            return 419
        };
        if (arg0 == 11) {
            return 420
        };
        if (arg0 == 12) {
            return 421
        };
        if (arg0 == 8) {
            return 416
        };
        if (arg0 == 9) {
            return 417
        };
        if (arg0 == 6) {
            return 406
        };
        if (arg0 == 5) {
            return 407
        };
        if (arg0 == 3) {
            return 408
        };
        if (arg0 == 4) {
            return 409
        };
        if (arg0 == 2) {
            return 410
        };
        412
    }

    fun segment_minimum_input(arg0: &vector<Hop>, arg1: u128, arg2: u128) : u128 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v1).policy.input_minimum > 0) {
                let (v2, v3) = source_input_for_local(arg0, v1, 0x1::vector::borrow<Hop>(arg0, v1).policy.input_minimum);
                if (v3) {
                    v0 = 0x1::u128::max(v0, v2);
                };
            };
            v1 = v1 + 1;
        };
        0x1::u128::min(v0, arg2)
    }

    fun segment_within_capacity(arg0: &vector<Hop>, arg1: u128) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (arg1 > v1.policy.input_capacity || crosses_forbidden_zero(v1, arg1)) {
                return false
            };
            let v2 = quote_hop(v1, arg1);
            arg1 = v2;
            if (v2 > v1.policy.output_capacity) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun segments(arg0: &OptimizeResult) : u64 {
        arg0.segments
    }

    fun skip_empty_v3_boundaries(arg0: &mut Hop) : u64 {
        let v0 = &mut arg0.boundary_cursor;
        let v1 = &mut arg0.liquidity;
        let v2 = &mut arg0.sqrt_price_x64;
        advance_empty_boundaries(&arg0.boundaries, v0, v1, v2, arg0.zero_for_one)
    }

    fun source_input_for_local(arg0: &vector<Hop>, arg1: u64, arg2: u128) : (u128, bool) {
        let v0 = arg2;
        let v1 = true;
        while (arg1 > 0 && v1) {
            let v2 = arg1 - 1;
            arg1 = v2;
            let (v3, v4) = inverse_hop(0x1::vector::borrow<Hop>(arg0, v2), v0);
            if (v4) {
                v0 = v3;
                continue
            };
            v1 = false;
        };
        (v0, v1)
    }

    fun source_input_to_boundary(arg0: &vector<Hop>, arg1: u64) : (u128, bool) {
        source_input_for_local(arg0, arg1, input_to_current_boundary(0x1::vector::borrow<Hop>(arg0, arg1)))
    }

    public fun sqrt_down(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1 << ((log2_down(arg0) >> 1) as u8);
        let v1 = v0 + arg0 / v0 >> 1;
        let v2 = v1 + arg0 / v1 >> 1;
        let v3 = v2 + arg0 / v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        let v8 = arg0 / v7;
        if (v7 < v8) {
            v7
        } else {
            v8
        }
    }

    public fun stable_abs_diff(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg1 - arg0
        } else {
            arg0 - arg1
        }
    }

    public fun stable_compute_d(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        stable_compute_d_with_limit(arg0, arg1, arg2, arg3, 256)
    }

    public fun stable_compute_d_with_limit(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64, arg4: u64) : (u256, u8) {
        let v0 = arg0 + arg1;
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v1) {
            return (0, 5)
        };
        let v2 = arg2 * 2;
        let v3 = 0;
        while (v3 < arg4) {
            if (*arg3 == 0) {
                return (0, 6)
            };
            *arg3 = *arg3 - 1;
            let v4 = v0;
            let v5 = v0 * v0 / arg0 * 2 * v0 / arg1 * 2;
            let v6 = v0 * (v2 - 1) + v5 * 3;
            if (v6 == 0) {
                return (0, 5)
            };
            let v7 = v0 * (v5 * 2 + v0 * v2) / v6;
            v0 = v7;
            if (stable_abs_diff(v7, v4) <= 1) {
                return (v7, 0)
            };
            v3 = v3 + 1;
        };
        (0, 4)
    }

    public fun stable_compute_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return (0, 5)
        };
        let v1 = arg2 * 2;
        let v2 = 0;
        while (v2 < 256) {
            if (*arg3 == 0) {
                return (0, 6)
            };
            *arg3 = *arg3 - 1;
            let v3 = arg1;
            let v4 = arg1 * 2 + arg1 / v1 + arg0 - arg1;
            if (v4 == 0) {
                return (0, 5)
            };
            let v5 = (arg1 * arg1 + arg1 * arg1 / arg0 * 2 * arg1 / v1 * 2) / v4;
            arg1 = v5;
            if (stable_abs_diff(v5, v3) <= 1) {
                return (v5, 0)
            };
            v2 = v2 + 1;
        };
        (0, 4)
    }

    public fun stable_fee_remainder(arg0: u128, arg1: u64) : u128 {
        arg0 - arg0 * (arg1 as u128) / 10000
    }

    public fun status(arg0: &OptimizeResult) : u8 {
        arg0.status
    }

    public fun steamm_btoken_burn_amount(arg0: u256, arg1: u64) : u256 {
        if (arg1 <= 1000) {
            return 0
        };
        if (arg0 >= (arg1 as u256)) {
            return 0
        };
        if ((arg1 as u256) - arg0 < 1000) {
            (arg1 as u256) - 1000
        } else {
            arg0
        }
    }

    public fun steamm_btoken_supplies(arg0: u128) : (u64, u64) {
        (((arg0 >> 64) as u64), ((arg0 & 18446744073709551615) as u64))
    }

    public fun steamm_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: u64, arg10: bool, arg11: bool) : Hop {
        let v0 = if (arg10) {
            0
        } else {
            (arg2 as u128)
        };
        let v1 = (arg0 as u128) + v0;
        let v2 = if (arg10) {
            (arg2 as u128)
        } else {
            0
        };
        let v3 = (arg1 as u128) + v2;
        let v4 = if (arg11) {
            if (arg0 > 0) {
                if (arg1 > 0) {
                    if (v1 > 0) {
                        if (v3 > 0) {
                            if (arg3 < 10000) {
                                if (arg4 > 0) {
                                    if (arg5 > 0) {
                                        if (arg7 > 0) {
                                            if (arg8 > 1000) {
                                                arg9 > 0
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v5 = empty_hop(14);
        v5.output_fee_rate = arg3;
        v5.output_fee_denominator = 10000;
        v5.reserve_in = v1;
        v5.reserve_out = v3;
        v5.sqrt_price_x64 = (arg9 as u128);
        v5.liquidity = (arg1 as u128);
        v5.zero_for_one = arg10;
        v5.stable_amp = (arg5 as u128) << 64 | (arg8 as u128);
        v5.stable_scale_in = arg4;
        v5.stable_scale_out = arg7;
        v5.stable_lp_fee = arg6;
        let v6 = if (v4) {
            0
        } else {
            5
        };
        v5.state_status = v6;
        v5
    }

    public fun steamm_decimal_div(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg1 == 0 || arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / 1000000000000000000) {
            return (0, false)
        };
        (arg0 * 1000000000000000000 / arg1, true)
    }

    public fun steamm_decimal_mul(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg1 != 0 && arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            return (0, false)
        };
        (arg0 * arg1 / 1000000000000000000, true)
    }

    public fun steamm_effective_amp(arg0: u64, arg1: bool, arg2: u256, arg3: u256, arg4: u128, arg5: u128, arg6: u8, arg7: u8) : (u64, bool) {
        if (arg0 == 50 || arg0 == 100) {
            return (arg0, true)
        };
        if (arg0 != 20 && arg0 != 30) {
            return (arg0, false)
        };
        if (arg1) {
            return (arg0, true)
        };
        if (arg6 > 18 || arg7 > 18) {
            return (arg0, false)
        };
        let (v0, v1) = steamm_decimal_mul(arg2, (arg4 as u256));
        let (v2, v3) = steamm_decimal_mul(arg3, (arg5 as u256));
        if (!v1 || !v3) {
            return (arg0, false)
        };
        let v4 = v0 / (0x1::u64::pow(10, arg6) as u256);
        let v5 = v2 / (0x1::u64::pow(10, arg7) as u256);
        if (v4 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v5 || v4 + v5 == 0) {
            return (arg0, false)
        };
        let (v6, v7) = steamm_decimal_mul(v4, 100 * 1000000000000000000);
        if (!v7) {
            return (arg0, false)
        };
        let (v8, v9) = steamm_decimal_div(v6, v4 + v5);
        if (!v9) {
            return (arg0, false)
        };
        if (v8 >= 40 * 1000000000000000000 && v8 <= 60 * 1000000000000000000) {
            let v12 = if (arg0 == 20) {
                50
            } else {
                100
            };
            (v12, true)
        } else {
            (arg0, true)
        }
    }

    public fun steamm_omm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u8, arg10: u8, arg11: bool) : Hop {
        let v0 = if (arg11) {
            if (arg0 > 0) {
                if (arg1 < 10000) {
                    if (arg2 > 0) {
                        if (arg3 > 0) {
                            if (arg4 > 0) {
                                if (arg5 > 1000) {
                                    if (arg6 > 0) {
                                        if (arg7 > 0) {
                                            if (arg8 > 0) {
                                                if (arg9 <= 18) {
                                                    arg10 <= 18
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v1 = empty_hop(15);
        v1.output_fee_rate = arg1;
        v1.output_fee_denominator = 10000;
        v1.reserve_in = arg7;
        v1.reserve_out = (arg0 as u128);
        v1.sqrt_price_x64 = (arg6 as u128);
        v1.liquidity = arg8;
        v1.zero_for_one = arg9 >= arg10;
        v1.stable_amp = (arg3 as u128) << 64 | (arg5 as u128);
        v1.stable_scale_in = arg2;
        v1.stable_scale_out = arg4;
        v1.stable_admin_fee = (arg9 as u64);
        v1.stable_lp_fee = (arg10 as u64);
        let v2 = if (v0) {
            0
        } else {
            5
        };
        v1.state_status = v2;
        v1
    }

    public fun steamm_omm_v2_legacy_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: bool, arg15: bool) : Hop {
        let v0 = arg15 && (arg12 == 50 || arg12 == 100);
        steamm_omm_v2_legacy_hop_with_migration(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v0, true)
    }

    public fun steamm_omm_v2_legacy_hop_with_migration(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: bool, arg15: bool, arg16: bool) : Hop {
        let v0 = if (arg2 >= arg13) {
            arg2
        } else {
            arg13
        };
        let v1 = if (arg15) {
            if (arg0 > 0) {
                if (arg1 > 0) {
                    if (v0 < 10000) {
                        if (arg3 > 0) {
                            if (arg4 > 0) {
                                if (arg5 > 0) {
                                    if (arg6 > 1000) {
                                        if (arg7 > 0) {
                                            if (arg8 > 0) {
                                                if (arg9 > 0) {
                                                    if (arg10 <= 18) {
                                                        if (arg11 <= 18) {
                                                            if (arg12 == 20) {
                                                                true
                                                            } else if (arg12 == 30) {
                                                                true
                                                            } else if (arg12 == 50) {
                                                                true
                                                            } else {
                                                                arg12 == 100
                                                            }
                                                        } else {
                                                            false
                                                        }
                                                    } else {
                                                        false
                                                    }
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v2 = empty_hop(16);
        v2.output_fee_rate = v0;
        v2.output_fee_denominator = 10000;
        v2.reserve_in = (arg0 as u128);
        v2.reserve_out = (arg1 as u128);
        v2.sqrt_price_x64 = (arg7 as u128);
        v2.liquidity = arg8;
        v2.zero_for_one = arg14;
        v2.orderbook_lot_size = arg9;
        v2.stable_amp = (arg4 as u128) << 64 | (arg6 as u128);
        v2.stable_scale_in = arg3;
        v2.stable_scale_out = arg5;
        v2.stable_admin_fee = (arg10 as u64);
        v2.stable_lp_fee = (arg11 as u64);
        v2.stable_th_fee = arg12;
        let v3 = if (v1) {
            0
        } else {
            5
        };
        v2.state_status = v3;
        v2.policy.omm_update_flag = arg16;
        v2
    }

    public fun steamm_omm_v2_linear_btoken_output(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool, arg5: u256, arg6: u256, arg7: u256) : (u256, bool) {
        let v0 = if (arg4) {
            (arg0 as u256)
        } else {
            (arg1 as u256)
        };
        let v1 = if (arg4) {
            (arg1 as u256)
        } else {
            (arg0 as u256)
        };
        let v2 = if (arg4) {
            (arg2 as u8)
        } else {
            (arg3 as u8)
        };
        let v3 = if (arg4) {
            (arg3 as u8)
        } else {
            (arg2 as u8)
        };
        let (v4, v5) = steamm_decimal_mul(arg5 * 1000000000000000000, arg6);
        if (!v5) {
            return (0, false)
        };
        let (v6, v7) = steamm_decimal_mul(v4, v0);
        if (!v7) {
            return (0, false)
        };
        let (v8, v9) = steamm_decimal_div(v6, v1);
        if (!v9) {
            return (0, false)
        };
        let (v10, v11) = steamm_decimal_div(v8, arg7);
        let v12 = v10;
        if (!v11) {
            return (0, false)
        };
        let v13 = if (v2 >= v3) {
            v2 - v3
        } else {
            v3 - v2
        };
        let v14 = 1;
        let v15 = 0;
        while (v15 < v13) {
            v14 = v14 * 10;
            v15 = v15 + 1;
        };
        if (v2 > v3) {
            v12 = v10 / v14;
        } else if (v3 > v2) {
            if (v10 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v14) {
                return (0, false)
            };
            v12 = v10 * v14;
        };
        (v12 / 1000000000000000000, true)
    }

    public fun steamm_q_compute_f(arg0: u128, arg1: u128, arg2: u128) : (u128, bool, bool) {
        if (arg0 > 18446744073709551616) {
            return (0, false, false)
        };
        let (v0, v1) = steamm_q_mul(arg0, 18446744073709551616 - arg1);
        if (!v1) {
            return (0, false, false)
        };
        let (v2, v3) = steamm_q_ln_plus_64ln2(18446744073709551616 - arg0);
        if (!v3) {
            return (0, false, false)
        };
        let v4 = 818323753292969962240;
        if (v2 > v4) {
            return (0, false, false)
        };
        let (v5, v6) = steamm_q_mul(arg1, v4 - v2);
        if (!v6 || v0 > 340282366920938463463374607431768211455 - v5) {
            return (0, false, false)
        };
        let v7 = v0 + v5;
        if (v7 >= arg2) {
            (v7 - arg2, true, true)
        } else {
            (arg2 - v7, false, true)
        }
    }

    public fun steamm_q_compute_f_prime(arg0: u128, arg1: u128, arg2: u128) : (u128, bool) {
        if (arg0 >= 18446744073709551616) {
            return (0, false)
        };
        let (v0, v1) = steamm_q_mul(arg1, 18446744073709551616 - arg0);
        if (!v1) {
            return (0, false)
        };
        let (v2, v3) = steamm_q_div(18446744073709551616, v0);
        if (!v3 || 18446744073709551616 - arg2 > 340282366920938463463374607431768211455 - v2) {
            return (0, false)
        };
        (18446744073709551616 - arg2 + v2, true)
    }

    public fun steamm_q_div(arg0: u128, arg1: u128) : (u128, bool) {
        if (arg1 == 0) {
            return (0, false)
        };
        if (arg0 == 0) {
            return (0, true)
        };
        let v0 = ((arg0 as u256) << 64) / (arg1 as u256);
        if (v0 == 0 || v0 > (340282366920938463463374607431768211455 as u256)) {
            (0, false)
        } else {
            ((v0 as u128), true)
        }
    }

    public fun steamm_q_floor_log2(arg0: u128) : u8 {
        let v0 = 0;
        let v1 = 64;
        while (v1 > 0) {
            if (arg0 >= 1 << v1) {
                arg0 = arg0 >> v1;
                v0 = v0 + v1;
            };
            v1 = v1 >> 1;
        };
        v0
    }

    public fun steamm_q_from_decimal(arg0: u256) : (u128, bool) {
        if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / (18446744073709551616 as u256)) {
            return (0, false)
        };
        let v0 = arg0 * (18446744073709551616 as u256) / 1000000000000000000;
        if (v0 > (340282366920938463463374607431768211455 as u256) || arg0 != 0 && v0 == 0) {
            (0, false)
        } else {
            ((v0 as u128), true)
        }
    }

    public fun steamm_q_from_integer(arg0: u128) : (u128, bool) {
        if (arg0 > 340282366920938463463374607431768211455 >> 64) {
            (0, false)
        } else {
            (arg0 << 64, true)
        }
    }

    public fun steamm_q_ln_plus_64ln2(arg0: u128) : (u128, bool) {
        if (arg0 == 0) {
            return (0, false)
        };
        let v0 = steamm_q_floor_log2(arg0);
        let v1 = if (arg0 >= 9223372036854775808) {
            arg0 >> v0 - 63
        } else {
            arg0 << 63 - v0
        };
        let v2 = v1;
        let v3 = 0;
        let v4 = 12;
        while (v4 != 0) {
            let v5 = v2 * v2 >> 63;
            let v6 = v5 >> 64;
            let v7 = v5 >> (v6 as u8);
            let v8 = v7 * v7 >> 63;
            let v9 = v8 >> 64;
            let v10 = v8 >> (v9 as u8);
            let v11 = v10 * v10 >> 63;
            let v12 = v11 >> 64;
            let v13 = v11 >> (v12 as u8);
            let v14 = v13 * v13 >> 63;
            let v15 = v14 >> 64;
            v2 = v14 >> (v15 as u8);
            let v16 = (((v3 << 1 | v6) << 1 | v9) << 1 | v12) << 1;
            v3 = v16 | v15;
            v4 = v4 - 1;
        };
        let v17 = ((((v0 as u128) << 64) + (v3 << 16)) as u256) * 12786308645202655660 >> 64;
        if (v17 > (340282366920938463463374607431768211455 as u256)) {
            (0, false)
        } else {
            ((v17 as u128), true)
        }
    }

    public fun steamm_q_mul(arg0: u128, arg1: u128) : (u128, bool) {
        let v0 = (arg0 as u256) * (arg1 as u256) >> 64;
        if (v0 > (340282366920938463463374607431768211455 as u256)) {
            (0, false)
        } else {
            ((v0 as u128), true)
        }
    }

    fun steamm_q_multiply_divide(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: bool) : (u128, bool) {
        if (arg0 > arg1) {
            let v0 = arg0;
            arg0 = arg1;
            arg1 = v0;
        };
        if (arg3 < arg4) {
            let v1 = arg3;
            arg3 = arg4;
            arg4 = v1;
        };
        if (arg5) {
            if (arg1 > arg2) {
                let v2 = arg1;
                arg1 = arg2;
                arg2 = v2;
            };
            if (arg0 > arg1) {
                let v3 = arg0;
                arg0 = arg1;
                arg1 = v3;
            };
        } else {
            if (arg2 < arg3) {
                let v4 = arg2;
                arg2 = arg3;
                arg3 = v4;
            };
            if (arg3 < arg4) {
                let v5 = arg3;
                arg3 = arg4;
                arg4 = v5;
            };
        };
        let v6 = if (arg5) {
            3
        } else {
            2
        };
        let v7 = if (arg5) {
            2
        } else {
            3
        };
        let v8 = 0;
        let v9 = 0;
        let v10 = 18446744073709551616;
        while (v8 < v6 || v9 < v7) {
            if (v8 < v6) {
                let v11 = if (v8 == 0) {
                    arg0
                } else if (v8 == 1) {
                    arg1
                } else {
                    arg2
                };
                let (v12, v13) = steamm_q_mul(v10, v11);
                if (v13) {
                    v10 = v12;
                    v8 = v8 + 1;
                    continue
                };
            };
            if (v9 == v7) {
                return (0, false)
            };
            let v14 = if (arg5) {
                if (v9 == 0) {
                    arg4
                } else {
                    arg3
                }
            } else if (v9 == 0) {
                arg4
            } else if (v9 == 1) {
                arg3
            } else {
                arg2
            };
            let (v15, v16) = steamm_q_div(v10, v14);
            if (!v16) {
                return (0, false)
            };
            v10 = v15;
            v9 = v9 + 1;
        };
        (v10, true)
    }

    public fun steamm_q_newton(arg0: u128, arg1: u128) : (u128, bool) {
        let (v0, v1) = steamm_q_div(18446744073709551616, arg1);
        if (!v1 || v0 > 18446744073709551616) {
            return (0, false)
        };
        let v2 = 18446744073709551616 / 100000;
        let v3 = 18446744073709551597;
        let v4 = 18446744073709551616 / 100000000000000;
        let v5 = 18446744071864877208;
        let v6 = if (arg0 > v5) {
            v5
        } else {
            arg0
        };
        let v7 = v6;
        let v8 = 0;
        while (v8 < 20) {
            let (v9, v10, v11) = steamm_q_compute_f(v7, v0, arg0);
            if (!v11) {
                return (0, false)
            };
            if (v9 < v4) {
                return (v7, true)
            };
            let (v12, v13) = steamm_q_compute_f_prime(v7, arg1, v0);
            if (!v13 || v12 < 18446744073709551616 / 10000000000) {
                return (0, false)
            };
            let (v14, v15) = steamm_q_div(v9, v12);
            if (!v15) {
                return (0, false)
            };
            let v16 = if (v14 >= 18446744073709551616) {
                v14 / 2
            } else {
                v14
            };
            let v17 = v10 && v7 > v16 || v7 <= 340282366920938463463374607431768211455 - v16;
            let v18 = if (!v17) {
                0
            } else if (v10) {
                v7 - v16
            } else {
                v7 + v16
            };
            let v19 = v18;
            let v20 = if (!v17) {
                true
            } else if (v18 == 0) {
                true
            } else {
                v18 >= 18446744073709551616
            };
            if (v20) {
                let v21 = v14 / 2;
                let v22 = v10 && v6 > v21 || v6 <= 340282366920938463463374607431768211455 - v21;
                if (!v22) {
                    return (0, false)
                };
                let v23 = if (v10) {
                    v6 - v21
                } else {
                    v6 + v21
                };
                v19 = v23;
                if (v23 < v2) {
                    v19 = v2;
                } else if (v23 > v3) {
                    v19 = v3;
                };
            };
            let v24 = if (v19 >= v6) {
                v19 - v6
            } else {
                v6 - v19
            };
            if (v24 < v4) {
                return (v6, true)
            };
            v7 = v19;
            v8 = v8 + 1;
        };
        (v7, true)
    }

    public fun suidex_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : Hop {
        with_suidex_execution_bounds(v2_hop(arg0, arg1, arg2, arg3))
    }

    public fun suiswap_stable_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: bool, arg11: u8) : Hop {
        let v0 = if (arg11 & 1 != 0) {
            2
        } else {
            let v1 = if (arg0 == 0) {
                true
            } else if (arg1 == 0) {
                true
            } else if (arg2 == 0) {
                true
            } else if (arg3 == 0) {
                true
            } else if (arg4 == 0) {
                true
            } else if (arg4 > 4294967295) {
                true
            } else if (arg8 != 101) {
                true
            } else if (arg9 != 200 && arg9 != 201) {
                true
            } else if ((arg5 as u128) + (arg6 as u128) + (arg7 as u128) >= 10000) {
                true
            } else if ((arg0 as u256) * (arg2 as u256) > 1267650600228229401496703205376) {
                true
            } else {
                (arg1 as u256) * (arg3 as u256) > 1267650600228229401496703205376
            };
            if (v1) {
                5
            } else {
                0
            }
        };
        let v2 = if (arg10) {
            200
        } else {
            201
        };
        let v3 = empty_hop(5);
        v3.reserve_in = (arg0 as u128);
        v3.reserve_out = (arg1 as u128);
        v3.stable_amp = (arg4 as u128);
        v3.stable_scale_in = (arg2 as u128);
        v3.stable_scale_out = (arg3 as u128);
        v3.stable_admin_fee = arg5;
        v3.stable_lp_fee = arg6;
        v3.stable_th_fee = arg7;
        v3.stable_fee_on_input = arg9 == v2;
        v3.state_status = v0;
        v3
    }

    public fun tick_boundary(arg0: u128, arg1: u128, arg2: bool) : TickBoundary {
        TickBoundary{
            sqrt_price_x64    : arg0,
            liquidity_net_abs : arg1,
            negative          : arg2,
        }
    }

    public fun to_u128(arg0: u256) : u128 {
        (arg0 as u128)
    }

    fun trim_cached_v2_plateau(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: &mut u64, arg3: u64, arg4: u128, arg5: u128, arg6: &mut OptimizeResult) {
        if (arg6.evaluations >= arg3) {
            return
        };
        let v0 = 0x1::vector::length<Hop>(arg0);
        if (*arg2 < v0 * 2) {
            return
        };
        let v1 = 0;
        while (v1 < v0) {
            if (0x1::vector::borrow<Hop>(arg0, v1).kind != 0) {
                return
            };
            v1 = v1 + 1;
        };
        let v2 = if (arg6.found) {
            arg6.amount_in
        } else {
            arg4
        };
        let v3 = if (arg6.found) {
            arg6.amount_out
        } else {
            arg5
        };
        if (v3 == 0) {
            return
        };
        let v4 = v3;
        while (v1 > 0) {
            let v5 = v1 - 1;
            v1 = v5;
            *arg2 = *arg2 - 1;
            let (v6, v7) = inverse_hop(0x1::vector::borrow<Hop>(arg0, v5), v4);
            if (!v7) {
                return
            };
            v4 = v6;
        };
        if (v4 == 0 || v4 >= v2) {
            return
        };
        let (v8, v9, _, _) = quote_bounded_route(arg0, arg1, v4, arg2);
        arg6.evaluations = arg6.evaluations + 1;
        if (v9 == 0) {
            record_route_candidate(arg0, v4, v8, arg6);
        };
    }

    public fun v2_curve_output(arg0: u64, arg1: u64, arg2: bool, arg3: u128, arg4: u128, arg5: u128) : u128 {
        if (arg2) {
            let v1 = if (arg5 > 18446744073709551615) {
                true
            } else if (arg3 > 18446744073709551615) {
                true
            } else {
                arg4 > 18446744073709551615
            };
            if (v1) {
                return 0
            };
            let v2 = (arg5 as u256) * ((arg0 - arg1) as u256);
            let v3 = (arg3 as u256) * (arg0 as u256) + v2;
            if (v3 == 0) {
                return 0
            };
            ((v2 * (arg4 as u256) / v3) as u128)
        } else {
            let v4 = effective_input(arg5, arg1, arg0);
            if (v4 == 0) {
                0
            } else {
                mul_div_down(v4, arg4, arg3 + v4)
            }
        }
    }

    public fun v2_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : Hop {
        v2_hop_with_gate(arg0, arg1, arg2, arg3, true)
    }

    public fun v2_hop_split_fee(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : Hop {
        let v0 = empty_hop(0);
        v0.fee_rate = arg2;
        v0.fee_denominator = arg3;
        v0.output_fee_rate = arg4;
        v0.output_fee_denominator = arg5;
        v0.reserve_in = arg0;
        v0.reserve_out = arg1;
        v0
    }

    public fun v2_hop_with_gate(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool) : Hop {
        let v0 = if (!arg4) {
            2
        } else {
            let v1 = if (arg0 == 0) {
                true
            } else if (arg1 == 0) {
                true
            } else if (arg3 == 0) {
                true
            } else {
                arg2 >= arg3
            };
            if (v1) {
                5
            } else {
                0
            }
        };
        let v2 = empty_hop(0);
        v2.fee_rate = arg2;
        v2.fee_denominator = arg3;
        v2.reserve_in = arg0;
        v2.reserve_out = arg1;
        v2.state_status = v0;
        v2
    }

    fun v2_minimum_input_for_output(arg0: &vector<Hop>, arg1: u128) : (u128, bool) {
        let v0 = 0x1::vector::length<Hop>(arg0);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (v1.kind != 0) {
                return (0, false)
            };
            let (v2, v3) = inverse_hop(v1, arg1);
            if (!v3) {
                return (0, false)
            };
            arg1 = v2;
        };
        (arg1, true)
    }

    public fun v3_current_hop(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : Hop {
        let v0 = empty_hop(4);
        v0.fee_rate = arg1;
        v0.fee_denominator = arg2;
        v0.sqrt_price_x64 = arg0;
        v0.zero_for_one = arg3;
        v0
    }

    public fun v3_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool, arg5: vector<TickBoundary>) : Hop {
        let v0 = empty_hop(1);
        v0.fee_rate = arg2;
        v0.fee_denominator = arg3;
        v0.sqrt_price_x64 = arg0;
        v0.liquidity = arg1;
        v0.zero_for_one = arg4;
        v0.boundaries = arg5;
        let v1 = &mut v0;
        normalize_v3_initial_boundary(v1);
        v0
    }

    public fun v3_window_stage(arg0: u128, arg1: vector<TickBoundary>) : StagedHop {
        StagedHop{
            kind        : 1,
            liquidity   : arg0,
            boundaries  : arg1,
            replacement : 0x1::vector::empty<Hop>(),
        }
    }

    public fun v3_window_stage_from_vectors_if(arg0: u128, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<bool>, arg4: bool) : StagedHop {
        if (!arg4) {
            return reuse_current_stage()
        };
        let v0 = 0x1::vector::length<u128>(&arg1);
        assert!(arg0 > 0 && v0 > 0, 3);
        assert!(0x1::vector::length<u128>(&arg2) == v0 && 0x1::vector::length<bool>(&arg3) == v0, 3);
        let v1 = 0x1::vector::empty<TickBoundary>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<TickBoundary>(&mut v1, tick_boundary(*0x1::vector::borrow<u128>(&arg1, v2), *0x1::vector::borrow<u128>(&arg2, v2), *0x1::vector::borrow<bool>(&arg3, v2)));
            v2 = v2 + 1;
        };
        v3_window_stage(arg0, v1)
    }

    public fun ve33_derivative(arg0: u256, arg1: u256) : u256 {
        3 * arg0 * arg1 * arg1 + arg0 * arg0 * arg0
    }

    public fun ve33_get_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        ve33_solve_y(arg0, arg1, arg2, arg3, 0)
    }

    public fun ve33_invariant(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * (arg0 * arg0 + arg1 * arg1)
    }

    fun ve33_solve_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64, arg4: u256) : (u256, u8) {
        let v0 = arg0 * arg0 * arg0;
        let v1 = 0;
        while (v1 < 255) {
            if (*arg3 == 0) {
                return (0, 6)
            };
            *arg3 = *arg3 - 1;
            if (arg0 > 10000000000000000000 || arg2 > 10000000000000000000) {
                return (0, 5)
            };
            let v2 = arg0 * arg2 * arg2;
            let v3 = arg2 * (v2 + v0);
            let v4 = 3 * v2 + v0;
            if (v4 == 0) {
                return (0, 5)
            };
            let v5 = if (v3 < arg1) {
                let v6 = (arg1 - v3) / v4 + 1;
                if (v6 > 10000000000000000000 - arg2) {
                    return (0, 5)
                };
                arg2 = arg2 + v6;
                v6
            } else {
                let v7 = (v3 - arg1) / v4 + arg4;
                if (v7 > arg2) {
                    return (0, 5)
                };
                arg2 = arg2 - v7;
                v7
            };
            if (v5 <= 1) {
                return (arg2, 0)
            };
            v1 = v1 + 1;
        };
        (0, 4)
    }

    public fun ve33_stable_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool) : Hop {
        let v0 = if (arg2 == 0) {
            0
        } else {
            (arg0 as u256) * (arg4 as u256) / (arg2 as u256)
        };
        let v1 = if (arg3 == 0) {
            0
        } else {
            (arg1 as u256) * (arg4 as u256) / (arg3 as u256)
        };
        let v2 = if (arg7) {
            2
        } else {
            let v3 = if (arg0 == 0) {
                true
            } else if (arg1 == 0) {
                true
            } else if (arg2 == 0) {
                true
            } else if (arg3 == 0) {
                true
            } else if (arg4 == 0) {
                true
            } else if (arg6 == 0) {
                true
            } else if (arg5 >= arg6) {
                true
            } else if (v0 == 0) {
                true
            } else if (v1 == 0) {
                true
            } else if (v0 > 10000000000000000000) {
                true
            } else {
                v1 > 10000000000000000000
            };
            if (v3) {
                5
            } else {
                0
            }
        };
        let v4 = empty_hop(6);
        v4.fee_rate = arg5;
        v4.fee_denominator = arg6;
        v4.reserve_in = (arg0 as u128);
        v4.reserve_out = (arg1 as u128);
        v4.stable_amp = (arg4 as u128);
        v4.stable_scale_in = (arg2 as u128);
        v4.stable_scale_out = (arg3 as u128);
        v4.stable_fee_on_input = true;
        v4.state_status = v2;
        v4
    }

    public fun ve33_value(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * arg1 * arg1 + arg0 * arg0 * arg0 * arg1
    }

    public fun virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: u64) : Hop {
        let v0 = empty_hop(7);
        v0.fee_rate = arg7;
        v0.fee_denominator = 1000000;
        let v1 = if (arg8) {
            (arg0 as u128)
        } else {
            (arg1 as u128)
        };
        v0.reserve_in = v1;
        let v2 = if (arg8) {
            (arg1 as u128)
        } else {
            (arg0 as u128)
        };
        v0.reserve_out = v2;
        v0.sqrt_price_x64 = (arg4 as u128);
        v0.liquidity = (arg5 as u128);
        v0.zero_for_one = arg8;
        v0.stable_amp = (arg6 as u128);
        v0.stable_scale_in = (arg2 as u128);
        v0.stable_scale_out = (arg3 as u128);
        v0.state_status = virtual_cpmm_state_status(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11, arg12);
        v0
    }

    public fun virtual_cpmm_state_status(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64) : u8 {
        if (arg8) {
            return 2
        };
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg6 == 0) {
            true
        } else {
            arg7 >= 1000000
        };
        if (v0) {
            return 5
        };
        let v1 = (arg4 as u256) * (arg6 as u256);
        let v2 = if (v1 == 0) {
            true
        } else if (v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v1) {
            true
        } else {
            v1 * v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / (arg2 as u256)
        };
        if (v2) {
            return 5
        };
        let v3 = (arg0 as u256) * (arg2 as u256);
        let v4 = (arg1 as u256) * (arg3 as u256);
        let v5 = (arg4 as u256) * (arg2 as u256);
        if (v3 + v4 < v5) {
            return 5
        };
        let v6 = (v3 + v4 - v5) / (arg3 as u256);
        let v7 = if (arg5 > 0) {
            if (v6 < (arg5 as u256)) {
                ((arg5 as u256) - v6) * 10000 / (arg5 as u256) > 500
            } else {
                false
            }
        } else {
            false
        };
        if (v7) {
            return 2
        };
        let v8 = if (arg9 >= arg10) {
            arg9 - arg10
        } else {
            0
        };
        let v9 = if (arg11 == 0) {
            true
        } else if (arg10 == 0) {
            true
        } else {
            v8 >= arg11
        };
        if (v9) {
            2
        } else {
            0
        }
    }

    public fun with_lst_redemption_bounds(arg0: Hop) : Hop {
        if (!arg0.zero_for_one) {
            let v0 = if (arg0.reserve_out > 1000) {
                arg0.reserve_out - 1000
            } else {
                0
            };
            let v1 = if (arg0.reserve_out == 0) {
                0
            } else {
                mul_div_down(v0, arg0.reserve_in, arg0.reserve_out)
            };
            arg0.policy.input_capacity = 0x1::u128::min(arg0.policy.input_capacity, v1);
        };
        arg0
    }

    public fun with_pool_balances(arg0: Hop, arg1: u64, arg2: u64) : Hop {
        arg0.policy.input_capacity = 0x1::u128::min(arg0.policy.input_capacity, 18446744073709551615 - (arg1 as u128));
        arg0.policy.output_capacity = 0x1::u128::min(arg0.policy.output_capacity, (arg2 as u128));
        arg0
    }

    public fun with_suidex_execution_bounds(arg0: Hop) : Hop {
        let v0 = arg0.reserve_in;
        let v1 = arg0.reserve_out;
        let v2 = arg0.fee_denominator;
        let v3 = 1000;
        if (arg0.state_status != 0) {
            return arg0
        };
        let v4 = if (v0 < v3) {
            true
        } else if (v1 < v3) {
            true
        } else if (v0 > (18446744073709551615 as u128)) {
            true
        } else {
            v1 > (18446744073709551615 as u128)
        };
        if (v4) {
            arg0.state_status = 2;
            return arg0
        };
        let v5 = div_ceil(((v1 - v3 + 1) as u256) * (v0 as u256) * (v2 as u256), ((v3 - 1) as u256) * ((v2 - arg0.fee_rate) as u256));
        arg0.policy.input_minimum = 1000;
        let v6 = if (v5 > (18446744073709551615 as u256)) {
            (18446744073709551615 as u128)
        } else {
            (v5 as u128) - 1
        };
        arg0.policy.input_capacity = 0x1::u128::min(v6, (18446744073709551615 as u128) - v0);
        arg0
    }

    public fun with_turbos_pool_balances(arg0: Hop, arg1: u64, arg2: u64) : Hop {
        let v0 = with_pool_balances(arg0, arg1, arg2);
        v0.policy.stop_at_zero_liquidity = true;
        v0
    }

    // decompiled from Move bytecode v7
}

