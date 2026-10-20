module 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer {
    struct ExecutionPolicy has copy, drop, store {
        bolt: vector<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>,
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
        real_boundary_limit: u64,
        status: u8,
        boundary_cursor: u64,
        fee_denominator: u64,
        fee_rate: u64,
        liquidity: u128,
        policy_output_capacity: u128,
        policy_stop_at_zero_liquidity: bool,
        reject_empty_endpoint: bool,
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
        price_scale: u128,
    }

    struct OrderbookPrefix has copy, drop {
        minimum_input: u128,
        spent: u128,
        output: u128,
        base: u128,
    }

    struct LinearPrefix has copy, drop {
        spent: u128,
        output: u128,
    }

    struct OrderbookShortfall has copy, drop {
        linear_prefixes: vector<LinearPrefix>,
        prefixes: vector<OrderbookPrefix>,
        minimum_gross: u128,
        crossed: u64,
    }

    public fun advance_segment_v2(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : (u128, u128, u128) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::advance_segment_v2(arg0, arg1, arg2, arg3, arg4)
    }

    public fun affine_ratio(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u128, arg6: u128) : (bool, u256, u256) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::affine_ratio(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun aligned_in_range(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aligned_in_range(arg0, arg1, arg2, arg3)
    }

    public fun amount0_delta_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::amount0_delta_down(arg0, arg1, arg2)
    }

    public fun amount0_delta_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::amount0_delta_up(arg0, arg1, arg2)
    }

    public fun cap_inverse_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::cap_inverse_v2(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_inverse_v3(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: &TickBoundary, arg6: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::cap_inverse_v3(arg0, arg1, arg2, arg3, arg4, arg5.sqrt_price_x64, arg6)
    }

    public fun cap_marginal_aftermath_geometric(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: u128, arg5: u128) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::cap_marginal_aftermath_geometric(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun cap_marginal_bucket_psm(arg0: u128, arg1: u128, arg2: bool) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::cap_marginal_bucket_psm(arg0, arg1, arg2)
    }

    public fun cap_segment_quote_v3(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: &TickBoundary, arg5: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::cap_segment_quote_v3(arg0, arg1, arg2, arg3, arg4.sqrt_price_x64, arg5)
    }

    public fun cap_upper_bucket_psm(arg0: u128, arg1: u128, arg2: bool) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::cap_upper_bucket_psm(arg0, arg1, arg2)
    }

    public fun cap_upper_v3(arg0: u128, arg1: bool) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::cap_upper_v3(arg0, arg1)
    }

    public fun clmm_input_boundary(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: &TickBoundary) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::clmm_input_boundary(arg0, arg1, arg2, arg3, arg4, arg5.sqrt_price_x64)
    }

    public fun div_up_u256(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::div_up_u256(arg0, arg1)
    }

    public fun gross_from_effective(arg0: u128, arg1: u64, arg2: u64) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::gross_from_effective(arg0, arg1, arg2)
    }

    public fun liquidity_after_boundary(arg0: u128, arg1: &TickBoundary, arg2: bool) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::liquidity_after_boundary(arg0, arg1.negative, arg1.liquidity_net_abs, arg2)
    }

    public fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        to_u128((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::mul_div_up(arg0, arg1, arg2)
    }

    public fun mul_q64_ceil(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::mul_q64_ceil(arg0, arg1)
    }

    public fun mul_ratio_down_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::mul_ratio_down_saturating(arg0, arg1, arg2)
    }

    public fun next_sqrt_price(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: u128, arg5: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::next_sqrt_price(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun next_sqrt_price_partial(arg0: u128, arg1: u128, arg2: bool, arg3: u128, arg4: bool) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::next_sqrt_price_partial(arg0, arg1, arg2, arg3, arg4)
    }

    public fun saturating_add(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::saturating_add(arg0, arg1)
    }

    public fun v2_curve_output(arg0: u64, arg1: u64, arg2: bool, arg3: u128, arg4: u128, arg5: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::v2_curve_output(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun a0(arg0: u8) : Hop {
        let v0 = ExecutionPolicy{
            bolt                       : 0x1::vector::empty<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(),
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

    public fun a1(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: bool) : LinearSegment {
        if (arg3 >= 9223372036854775808) {
            let v0 = arg3 - 9223372036854775808;
            let v1 = v0 & 255;
            let v2 = if (arg2 > 0) {
                if (v1 > 1) {
                    v1 <= 16
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v2, 3);
            return LinearSegment{
                remaining_input  : arg0,
                remaining_output : arg1,
                price_x64        : arg2,
                fee_rate         : v1 | (v0 >> 8 & 65535) << 8,
                fee_denominator  : v0 >> 24,
                forward          : arg4,
                exact_dlmm       : false,
                price_scale      : 18446744073709551616,
            }
        };
        dlmm_segment(arg0, arg1, arg2, arg3, arg4)
    }

    public fun a2(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v0).kind == 18) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun a5(arg0: &Hop, arg1: u128) : u128 {
        let v0 = 0x1::u128::max(arg1, arg0.policy.input_minimum);
        let v1 = v0;
        if (arg0.kind == 2 && arg0.orderbook_cursor < 0x1::vector::length<OrderbookSegment>(&arg0.orderbook_segments)) {
            let v2 = if (0x1::vector::length<OrderbookSegment>(&arg0.orderbook_segments) == 1) {
                if (arg0.orderbook_base_to_quote) {
                    effective_input(v0, arg0.fee_rate, arg0.fee_denominator)
                } else {
                    mul_div_up(effective_input(v0, arg0.fee_rate, arg0.fee_denominator), 1000000000, 0x1::vector::borrow<OrderbookSegment>(&arg0.orderbook_segments, arg0.orderbook_cursor).price)
                }
            } else {
                0
            };
            let v3 = if (arg0.orderbook_base_to_quote) {
                round_up_to_quantum(0x1::u128::max(0x1::u128::max(v2, arg0.orderbook_min_size), arg0.orderbook_lot_size), arg0.orderbook_lot_size)
            } else {
                mul_div_up(round_up_to_quantum(0x1::u128::max(0x1::u128::max(v2, arg0.orderbook_min_size), arg0.orderbook_lot_size), arg0.orderbook_lot_size), 0x1::vector::borrow<OrderbookSegment>(&arg0.orderbook_segments, arg0.orderbook_cursor).price, 1000000000)
            };
            v1 = 0x1::u128::max(v0, gross_from_effective(v3, arg0.fee_rate, arg0.fee_denominator));
        };
        v1
    }

    public fun a6(arg0: u8) : u8 {
        if (arg0 == 1) {
            10
        } else if (arg0 == 5) {
            12
        } else {
            arg0
        }
    }

    public fun a7(arg0: &vector<Hop>) : bool {
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

    public fun a8(arg0: &vector<Hop>, arg1: u64, arg2: u128) : (u128, bool) {
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
            let (v2, v3) = g0(v0, arg2);
            if (!v3) {
                return (0, false)
            };
            arg2 = v2;
        };
        (arg2, true)
    }

    public fun a9(arg0: &vector<Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: &mut u64) : vector<u128> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.kind == 18) {
                let v3 = 0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::input_breakpoints(0x1::vector::borrow<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(&v2.policy.bolt, 0));
                let v4 = 0;
                while (v4 < 0x1::vector::length<u128>(&v3) && *arg4 >= v1 + 1) {
                    *arg4 = *arg4 - v1 - 1;
                    let (v5, v6) = a8(arg0, v1, *0x1::vector::borrow<u128>(&v3, v4));
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
        let v1 = if (v0.price_x64 > 0) {
            true
        } else if (v0.exact_dlmm) {
            true
        } else {
            v0.remaining_input != 18446744073709551616
        };
        if (v1) {
            return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        };
        (true, saturating_add((v0.remaining_output as u256), 2), 0)
    }

    public fun aftermath_exp(arg0: AftermathSigned) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_exp_parts(arg0.negative, arg0.magnitude)
    }

    public fun aftermath_ln(arg0: u256) : AftermathSigned {
        let (v0, v1) = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_ln_parts(arg0);
        AftermathSigned{
            negative  : v0,
            magnitude : v1,
        }
    }

    public fun aftermath_ln_36(arg0: u256) : AftermathSigned {
        let (v0, v1) = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_ln_36_parts(arg0);
        AftermathSigned{
            negative  : v0,
            magnitude : v1,
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

    public fun apply_boundary_liquidity(arg0: &mut u128, arg1: bool, arg2: TickBoundary) {
        if (arg1 && !arg2.negative || arg2.negative) {
            assert!(*arg0 >= arg2.liquidity_net_abs, 3);
            *arg0 = *arg0 - arg2.liquidity_net_abs;
        } else {
            *arg0 = *arg0 + arg2.liquidity_net_abs;
        };
    }

    public fun b0(arg0: &vector<Hop>) : bool {
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

    public fun b3(arg0: &vector<Hop>, arg1: vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: &mut u64) : (vector<u128>, u128) {
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

    public fun b4(arg0: &vector<Hop>) : u8 {
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

    fun book_buy_segments(arg0: u128, arg1: u128, arg2: u128, arg3: &vector<OrderbookSegment>, arg4: u64, arg5: u128, arg6: u128, arg7: &vector<u128>) : u128 {
        let v0 = 0x1::vector::length<OrderbookSegment>(arg3);
        if (arg1 == 0 || arg4 >= v0) {
            return arg0
        };
        while (arg4 < v0) {
            let v1 = 0x1::vector::borrow<OrderbookSegment>(arg3, arg4);
            let v2 = if (v1.price == 0) {
                true
            } else if (v1.remaining_base % arg1 != 0) {
                true
            } else {
                arg4 > arg4 && v1.price < 0x1::vector::borrow<OrderbookSegment>(arg3, arg4 - 1).price
            };
            if (v2) {
                return arg0
            };
            arg4 = arg4 + 1;
        };
        let v3 = 0;
        let v4 = 0;
        while (arg4 < v0) {
            let v5 = 0x1::vector::borrow<OrderbookSegment>(arg3, arg4);
            if (v5.price == 0 || arg1 == 0) {
                return arg0
            };
            let v6 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::mul_div_down(arg0, 1000000000, v5.price) / arg1 * arg1;
            if (v6 < v5.remaining_base) {
                let v7 = if (v6 == 0) {
                    true
                } else if (0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::book_buy_add_base(v4, v6) < arg2) {
                    true
                } else {
                    (v5.price as u256) * (arg1 as u256) % 1000000000 != 0
                };
                if (v7) {
                    return arg0
                };
                let v8 = 0x1::u128::min(v3 + 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::mul_div_up(v6, v5.price, 1000000000), arg0);
                let v9 = if (v8 < arg5) {
                    true
                } else if (arg6 == 0) {
                    true
                } else {
                    v8 % arg6 != 0
                };
                if (v9) {
                    return arg0
                };
                let v10 = 0;
                let v11 = 0x1::vector::length<u128>(arg7);
                while (v10 < v11) {
                    v11 = v10 + (v11 - v10) / 2;
                    if (*0x1::vector::borrow<u128>(arg7, v11) < v8) {
                        v10 = v11 + 1;
                        continue
                    };
                };
                return if (v10 < 0x1::vector::length<u128>(arg7) && *0x1::vector::borrow<u128>(arg7, v10) == v8) {
                    arg0
                } else {
                    v8
                }
            };
            let v13 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::mul_div_down(v5.remaining_base, v5.price, 1000000000);
            if (v13 > arg0) {
                return arg0
            };
            arg0 = arg0 - v13;
            v3 = v3 + v13;
            v4 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::book_buy_add_base(v4, v5.remaining_base);
            arg4 = arg4 + 1;
        };
        arg0
    }

    public fun borrow_ExecutionPolicy_bolt(arg0: &ExecutionPolicy) : &vector<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State> {
        &arg0.bolt
    }

    public fun borrow_ExecutionPolicy_fractional_input_fee(arg0: &ExecutionPolicy) : &bool {
        &arg0.fractional_input_fee
    }

    public fun borrow_ExecutionPolicy_input_capacity(arg0: &ExecutionPolicy) : &u128 {
        &arg0.input_capacity
    }

    public fun borrow_ExecutionPolicy_input_minimum(arg0: &ExecutionPolicy) : &u128 {
        &arg0.input_minimum
    }

    public fun borrow_ExecutionPolicy_linear_rate_inversion(arg0: &ExecutionPolicy) : &bool {
        &arg0.linear_rate_inversion
    }

    public fun borrow_ExecutionPolicy_output_capacity(arg0: &ExecutionPolicy) : &u128 {
        &arg0.output_capacity
    }

    public fun borrow_Hop_boundaries(arg0: &Hop) : &vector<TickBoundary> {
        &arg0.boundaries
    }

    public fun borrow_Hop_boundary_cursor(arg0: &Hop) : &u64 {
        &arg0.boundary_cursor
    }

    public fun borrow_Hop_fee_denominator(arg0: &Hop) : &u64 {
        &arg0.fee_denominator
    }

    public fun borrow_Hop_fee_rate(arg0: &Hop) : &u64 {
        &arg0.fee_rate
    }

    public fun borrow_Hop_kind(arg0: &Hop) : &u8 {
        &arg0.kind
    }

    public fun borrow_Hop_linear_cursor(arg0: &Hop) : &u64 {
        &arg0.linear_cursor
    }

    public fun borrow_Hop_linear_has_more(arg0: &Hop) : &bool {
        &arg0.linear_has_more
    }

    public fun borrow_Hop_linear_segments(arg0: &Hop) : &vector<LinearSegment> {
        &arg0.linear_segments
    }

    public fun borrow_Hop_liquidity(arg0: &Hop) : &u128 {
        &arg0.liquidity
    }

    public fun borrow_Hop_orderbook_base_to_quote(arg0: &Hop) : &bool {
        &arg0.orderbook_base_to_quote
    }

    public fun borrow_Hop_orderbook_consumed_base(arg0: &Hop) : &u128 {
        &arg0.orderbook_consumed_base
    }

    public fun borrow_Hop_orderbook_cursor(arg0: &Hop) : &u64 {
        &arg0.orderbook_cursor
    }

    public fun borrow_Hop_orderbook_has_more(arg0: &Hop) : &bool {
        &arg0.orderbook_has_more
    }

    public fun borrow_Hop_orderbook_lot_size(arg0: &Hop) : &u128 {
        &arg0.orderbook_lot_size
    }

    public fun borrow_Hop_orderbook_min_size(arg0: &Hop) : &u128 {
        &arg0.orderbook_min_size
    }

    public fun borrow_Hop_orderbook_segments(arg0: &Hop) : &vector<OrderbookSegment> {
        &arg0.orderbook_segments
    }

    public fun borrow_Hop_output_fee_denominator(arg0: &Hop) : &u64 {
        &arg0.output_fee_denominator
    }

    public fun borrow_Hop_output_fee_rate(arg0: &Hop) : &u64 {
        &arg0.output_fee_rate
    }

    public fun borrow_Hop_policy(arg0: &Hop) : &ExecutionPolicy {
        &arg0.policy
    }

    public fun borrow_Hop_reserve_in(arg0: &Hop) : &u128 {
        &arg0.reserve_in
    }

    public fun borrow_Hop_reserve_out(arg0: &Hop) : &u128 {
        &arg0.reserve_out
    }

    public fun borrow_Hop_sqrt_price_x64(arg0: &Hop) : &u128 {
        &arg0.sqrt_price_x64
    }

    public fun borrow_Hop_stable_amp(arg0: &Hop) : &u128 {
        &arg0.stable_amp
    }

    public fun borrow_Hop_stable_scale_in(arg0: &Hop) : &u128 {
        &arg0.stable_scale_in
    }

    public fun borrow_Hop_stable_scale_out(arg0: &Hop) : &u128 {
        &arg0.stable_scale_out
    }

    public fun borrow_Hop_state_status(arg0: &Hop) : &u8 {
        &arg0.state_status
    }

    public fun borrow_Hop_zero_for_one(arg0: &Hop) : &bool {
        &arg0.zero_for_one
    }

    public fun borrow_LinearSegment_exact_dlmm(arg0: &LinearSegment) : &bool {
        &arg0.exact_dlmm
    }

    public fun borrow_LinearSegment_fee_rate(arg0: &LinearSegment) : &u64 {
        &arg0.fee_rate
    }

    public fun borrow_LinearSegment_forward(arg0: &LinearSegment) : &bool {
        &arg0.forward
    }

    public fun borrow_LinearSegment_price_x64(arg0: &LinearSegment) : &u128 {
        &arg0.price_x64
    }

    public fun borrow_LinearSegment_remaining_input(arg0: &LinearSegment) : &u128 {
        &arg0.remaining_input
    }

    public fun borrow_OrderbookSegment_price(arg0: &OrderbookSegment) : &u128 {
        &arg0.price
    }

    public fun borrow_OrderbookSegment_remaining_base(arg0: &OrderbookSegment) : &u128 {
        &arg0.remaining_base
    }

    public fun borrow_OrderbookShortfall_crossed(arg0: &OrderbookShortfall) : &u64 {
        &arg0.crossed
    }

    public fun borrow_OrderbookShortfall_minimum_gross(arg0: &OrderbookShortfall) : &u128 {
        &arg0.minimum_gross
    }

    public fun borrow_V3PrefixCache_boundary_cursor(arg0: &V3PrefixCache) : &u64 {
        &arg0.boundary_cursor
    }

    public fun borrow_V3PrefixCache_liquidity(arg0: &V3PrefixCache) : &u128 {
        &arg0.liquidity
    }

    public fun borrow_V3PrefixCache_policy_output_capacity(arg0: &V3PrefixCache) : &u128 {
        &arg0.policy_output_capacity
    }

    public fun borrow_V3PrefixCache_prefixes(arg0: &V3PrefixCache) : &vector<V3Prefix> {
        &arg0.prefixes
    }

    public fun borrow_V3PrefixCache_real_boundary_limit(arg0: &V3PrefixCache) : &u64 {
        &arg0.real_boundary_limit
    }

    public fun borrow_V3PrefixCache_status(arg0: &V3PrefixCache) : &u8 {
        &arg0.status
    }

    public fun borrow_V3Prefix_crossing_input(arg0: &V3Prefix) : &u128 {
        &arg0.crossing_input
    }

    public fun borrow_V3Prefix_cumulative_input(arg0: &V3Prefix) : &u128 {
        &arg0.cumulative_input
    }

    public fun borrow_V3Prefix_liquidity_after(arg0: &V3Prefix) : &u128 {
        &arg0.liquidity_after
    }

    public fun borrow_mut_ExecutionPolicy_auxiliary_fee_denominator(arg0: &mut ExecutionPolicy) : &mut u64 {
        &mut arg0.auxiliary_fee_denominator
    }

    public fun borrow_mut_ExecutionPolicy_auxiliary_fee_rate(arg0: &mut ExecutionPolicy) : &mut u64 {
        &mut arg0.auxiliary_fee_rate
    }

    public fun borrow_mut_ExecutionPolicy_bolt(arg0: &mut ExecutionPolicy) : &mut vector<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State> {
        &mut arg0.bolt
    }

    public fun borrow_mut_ExecutionPolicy_fractional_input_fee(arg0: &mut ExecutionPolicy) : &mut bool {
        &mut arg0.fractional_input_fee
    }

    public fun borrow_mut_ExecutionPolicy_input_capacity(arg0: &mut ExecutionPolicy) : &mut u128 {
        &mut arg0.input_capacity
    }

    public fun borrow_mut_ExecutionPolicy_input_minimum(arg0: &mut ExecutionPolicy) : &mut u128 {
        &mut arg0.input_minimum
    }

    public fun borrow_mut_ExecutionPolicy_linear_rate_inversion(arg0: &mut ExecutionPolicy) : &mut bool {
        &mut arg0.linear_rate_inversion
    }

    public fun borrow_mut_ExecutionPolicy_momentum_fee_round_nearest(arg0: &mut ExecutionPolicy) : &mut bool {
        &mut arg0.momentum_fee_round_nearest
    }

    public fun borrow_mut_ExecutionPolicy_omm_update_flag(arg0: &mut ExecutionPolicy) : &mut bool {
        &mut arg0.omm_update_flag
    }

    public fun borrow_mut_ExecutionPolicy_output_capacity(arg0: &mut ExecutionPolicy) : &mut u128 {
        &mut arg0.output_capacity
    }

    public fun borrow_mut_ExecutionPolicy_stop_at_zero_liquidity(arg0: &mut ExecutionPolicy) : &mut bool {
        &mut arg0.stop_at_zero_liquidity
    }

    public fun borrow_mut_Hop_boundaries(arg0: &mut Hop) : &mut vector<TickBoundary> {
        &mut arg0.boundaries
    }

    public fun borrow_mut_Hop_fee_denominator(arg0: &mut Hop) : &mut u64 {
        &mut arg0.fee_denominator
    }

    public fun borrow_mut_Hop_fee_rate(arg0: &mut Hop) : &mut u64 {
        &mut arg0.fee_rate
    }

    public fun borrow_mut_Hop_kind(arg0: &mut Hop) : &mut u8 {
        &mut arg0.kind
    }

    public fun borrow_mut_Hop_linear_has_more(arg0: &mut Hop) : &mut bool {
        &mut arg0.linear_has_more
    }

    public fun borrow_mut_Hop_linear_segments(arg0: &mut Hop) : &mut vector<LinearSegment> {
        &mut arg0.linear_segments
    }

    public fun borrow_mut_Hop_liquidity(arg0: &mut Hop) : &mut u128 {
        &mut arg0.liquidity
    }

    public fun borrow_mut_Hop_orderbook_base_to_quote(arg0: &mut Hop) : &mut bool {
        &mut arg0.orderbook_base_to_quote
    }

    public fun borrow_mut_Hop_orderbook_has_more(arg0: &mut Hop) : &mut bool {
        &mut arg0.orderbook_has_more
    }

    public fun borrow_mut_Hop_orderbook_lot_size(arg0: &mut Hop) : &mut u128 {
        &mut arg0.orderbook_lot_size
    }

    public fun borrow_mut_Hop_orderbook_min_size(arg0: &mut Hop) : &mut u128 {
        &mut arg0.orderbook_min_size
    }

    public fun borrow_mut_Hop_orderbook_segments(arg0: &mut Hop) : &mut vector<OrderbookSegment> {
        &mut arg0.orderbook_segments
    }

    public fun borrow_mut_Hop_output_fee_denominator(arg0: &mut Hop) : &mut u64 {
        &mut arg0.output_fee_denominator
    }

    public fun borrow_mut_Hop_output_fee_rate(arg0: &mut Hop) : &mut u64 {
        &mut arg0.output_fee_rate
    }

    public fun borrow_mut_Hop_policy(arg0: &mut Hop) : &mut ExecutionPolicy {
        &mut arg0.policy
    }

    public fun borrow_mut_Hop_reserve_in(arg0: &mut Hop) : &mut u128 {
        &mut arg0.reserve_in
    }

    public fun borrow_mut_Hop_reserve_out(arg0: &mut Hop) : &mut u128 {
        &mut arg0.reserve_out
    }

    public fun borrow_mut_Hop_sqrt_price_x64(arg0: &mut Hop) : &mut u128 {
        &mut arg0.sqrt_price_x64
    }

    public fun borrow_mut_Hop_stable_admin_fee(arg0: &mut Hop) : &mut u64 {
        &mut arg0.stable_admin_fee
    }

    public fun borrow_mut_Hop_stable_amp(arg0: &mut Hop) : &mut u128 {
        &mut arg0.stable_amp
    }

    public fun borrow_mut_Hop_stable_fee_on_input(arg0: &mut Hop) : &mut bool {
        &mut arg0.stable_fee_on_input
    }

    public fun borrow_mut_Hop_stable_lp_fee(arg0: &mut Hop) : &mut u64 {
        &mut arg0.stable_lp_fee
    }

    public fun borrow_mut_Hop_stable_scale_in(arg0: &mut Hop) : &mut u128 {
        &mut arg0.stable_scale_in
    }

    public fun borrow_mut_Hop_stable_scale_out(arg0: &mut Hop) : &mut u128 {
        &mut arg0.stable_scale_out
    }

    public fun borrow_mut_Hop_stable_th_fee(arg0: &mut Hop) : &mut u64 {
        &mut arg0.stable_th_fee
    }

    public fun borrow_mut_Hop_state_status(arg0: &mut Hop) : &mut u8 {
        &mut arg0.state_status
    }

    public fun borrow_mut_Hop_zero_for_one(arg0: &mut Hop) : &mut bool {
        &mut arg0.zero_for_one
    }

    public fun borrow_mut_LinearSegment_price_scale(arg0: &mut LinearSegment) : &mut u128 {
        &mut arg0.price_scale
    }

    public fun borrow_mut_OrderbookShortfall_crossed(arg0: &mut OrderbookShortfall) : &mut u64 {
        &mut arg0.crossed
    }

    public fun borrow_mut_OrderbookShortfall_minimum_gross(arg0: &mut OrderbookShortfall) : &mut u128 {
        &mut arg0.minimum_gross
    }

    public fun borrow_mut_V3PrefixCache_prefixes(arg0: &mut V3PrefixCache) : &mut vector<V3Prefix> {
        &mut arg0.prefixes
    }

    public fun borrow_mut_V3PrefixCache_real_boundary_limit(arg0: &mut V3PrefixCache) : &mut u64 {
        &mut arg0.real_boundary_limit
    }

    public fun borrow_mut_V3PrefixCache_reject_empty_endpoint(arg0: &mut V3PrefixCache) : &mut bool {
        &mut arg0.reject_empty_endpoint
    }

    public fun borrow_mut_V3PrefixCache_status(arg0: &mut V3PrefixCache) : &mut u8 {
        &mut arg0.status
    }

    public fun c1(arg0: &Hop) : (bool, u256, u256) {
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
            (e7(arg0), 0)
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
                (j1(arg0), v7)
            } else if (arg0.kind == 14) {
                let (v8, v9, v10) = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::affine_steamm_cpmm(arg0.output_fee_denominator, arg0.output_fee_rate, arg0.reserve_in, arg0.reserve_out, arg0.stable_amp, arg0.stable_scale_in, arg0.stable_scale_out);
                if (!v8) {
                    return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
                };
                (v9, v10)
            } else if (arg0.kind == 15) {
                let (v11, v12, v13) = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::affine_steamm_omm(arg0.liquidity, arg0.output_fee_denominator, arg0.output_fee_rate, arg0.reserve_in, arg0.stable_admin_fee, arg0.stable_amp, arg0.stable_lp_fee, arg0.stable_scale_out);
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
                        let (v17, v18, v19) = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::affine_virtual_cpmm(arg0.fee_denominator, arg0.fee_rate, arg0.reserve_in, arg0.reserve_out, arg0.sqrt_price_x64, arg0.stable_amp, arg0.stable_scale_in, arg0.stable_scale_out, arg0.zero_for_one);
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

    public fun c2(arg0: &vector<Hop>) : (bool, u256, u256, bool) {
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
                let (v5, v6, v7) = c1(v4);
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

    public fun c3(arg0: &vector<Hop>, arg1: u256, arg2: u128) : bool {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v1).policy.auxiliary_fee_rate > 0) {
                v0 = saturating_add(v0, 1);
            };
            v1 = v1 + 1;
        };
        let v2 = v0 == 0 || v0 < (arg2 as u256);
        !v2
    }

    public fun c4(arg0: &mut Hop) {
        let v0 = if (!0x1::vector::is_empty<TickBoundary>(&arg0.boundaries)) {
            let v1 = *0x1::vector::borrow<TickBoundary>(&arg0.boundaries, 0);
            v1.sqrt_price_x64 == arg0.sqrt_price_x64
        } else {
            false
        };
        if (v0) {
            let v2 = *0x1::vector::borrow<TickBoundary>(&arg0.boundaries, 0);
            g4(arg0, v2);
            arg0.boundary_cursor = 1;
        };
        g5(arg0);
    }

    public fun c5(arg0: &vector<Hop>) : u64 {
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

    public fun c6(arg0: &vector<Hop>) : u64 {
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

    public fun c7(arg0: &vector<Hop>) : u64 {
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

    public fun c8(arg0: &Hop) : &TickBoundary {
        0x1::vector::borrow<TickBoundary>(&arg0.boundaries, arg0.boundary_cursor)
    }

    public fun c9(arg0: &vector<Hop>) : bool {
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

    public fun cap_segment_quote_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<OrderbookSegment>, arg6: u128) : u128 {
        quote_orderbook_segment(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_segment_quote_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: u128) : u128 {
        effective_output(v2_curve_output(arg0, arg1, arg4, arg5, arg6, arg7), arg3, arg2)
    }

    public fun cap_upper_linear(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<LinearSegment>) : u256 {
        if (linear_terminal(arg0, arg1, arg2, arg3)) {
            return 0
        };
        let v0 = current_linear_segment(arg1, arg3);
        if (!v0.exact_dlmm && v0.price_x64 > 0) {
            return 115792089237316195423570985008687907853269984665640564039457584007913129639935
        };
        let (v1, v2) = linear_marginal_fraction(current_linear_segment(arg1, arg3));
        div_ceil(v1, v2)
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

    public fun current_linear_segment(arg0: u64, arg1: &vector<LinearSegment>) : &LinearSegment {
        0x1::vector::borrow<LinearSegment>(arg1, arg0)
    }

    public fun current_orderbook_segment(arg0: u64, arg1: &vector<OrderbookSegment>) : &OrderbookSegment {
        0x1::vector::borrow<OrderbookSegment>(arg1, arg0)
    }

    public fun d0(arg0: &vector<Hop>) : bool {
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

    public fun d1(arg0: &vector<Hop>) : bool {
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

    public fun d2(arg0: &vector<Hop>, arg1: u128) : bool {
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
                e9(v1, arg1)
            };
            if (v2) {
                return false
            };
            let v3 = g2(v1, arg1, true);
            arg1 = v3;
            if (v3 > v1.policy.output_capacity) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun d3(arg0: &vector<Hop>, arg1: u64) : (vector<V3PrefixCache>, u8, u64) {
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
                let v6 = &mut v5;
                m4(v4, v6);
                if (v2 == 0) {
                    let v7 = &mut v5;
                    let (v8, v9) = reserve_prefix_window(&v4.boundaries, v7, v1, arg1);
                    if (v9) {
                        return d4(arg0, arg1)
                    };
                    v1 = v8;
                    v2 = v5.status;
                };
                if (v5.status == 0 && v5.real_boundary_limit != 18446744073709551615) {
                    v5.status = 13;
                };
                0x1::vector::push_back<V3PrefixCache>(&mut v0, v5);
            };
            v3 = v3 + 1;
        };
        (v0, v2, v1)
    }

    public fun d4(arg0: &vector<Hop>, arg1: u64) : (vector<V3PrefixCache>, u8, u64) {
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
            let v6 = &mut v5;
            m4(v4, v6);
            if (v4.kind == 1 && v2 == 0) {
                let v7 = 0x1::vector::length<TickBoundary>(&v4.boundaries) - v4.boundary_cursor;
                let v8 = if (v7 < arg1 - v1) {
                    v7
                } else {
                    arg1 - v1
                };
                let v9 = &mut v5;
                v1 = v1 + extend_v3_prefix_cache(&v4.boundaries, v9, 340282366920938463463374607431768211455, v8);
                if (v5.status != 0) {
                    v2 = v5.status;
                } else if (v8 < v7) {
                    v5.status = 6;
                    v2 = 6;
                };
            };
            if (v5.status == 0 && v5.real_boundary_limit != 18446744073709551615) {
                v5.status = 13;
            };
            0x1::vector::push_back<V3PrefixCache>(&mut v0, v5);
            v3 = v3 + 1;
        };
        (v0, v2, v1)
    }

    public fun d5(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: u128, arg3: &mut u64) : (u128, u8, u64, u64) {
        let v0 = 0x1::vector::empty<OrderbookShortfall>();
        let v1 = &mut v0;
        d6(arg0, arg1, arg2, arg3, v1, false)
    }

    public fun d6(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: u128, arg3: &mut u64, arg4: &mut vector<OrderbookShortfall>, arg5: bool) : (u128, u8, u64, u64) {
        let (v0, v1, v2, v3, _, _) = e1(arg0, arg1, arg2, 0, arg3, arg4, arg5);
        (v0, v1, v2, v3)
    }

    public fun d7(arg0: &LinearSegment) : u256 {
        div_ceil((arg0.price_x64 as u256) * ((10000 + (arg0.fee_rate >> 8 & 65535)) as u256), 10000)
    }

    public fun d8(arg0: &Hop, arg1: u128, arg2: &mut u64, arg3: &vector<LinearPrefix>) : (u128, u8) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = arg0.linear_cursor;
        let v3 = v2;
        if (arg1 > 0 && !0x1::vector::is_empty<LinearPrefix>(arg3)) {
            let v4 = 0;
            let v5 = 0x1::u64::min(0x1::vector::length<LinearPrefix>(arg3), *arg2);
            while (v4 < v5) {
                v5 = v4 + (v5 - v4) / 2;
                if (0x1::vector::borrow<LinearPrefix>(arg3, v5).spent < arg1) {
                    v4 = v5 + 1;
                    continue
                };
            };
            let v6 = if (v4 < 0x1::u64::min(0x1::vector::length<LinearPrefix>(arg3), *arg2) && 0x1::vector::borrow<LinearPrefix>(arg3, v4).spent == arg1) {
                v4 + 1
            } else {
                v4
            };
            *arg2 = *arg2 - v6;
            v3 = v2 + v6;
            if (v6 > 0) {
                v0 = arg1 - 0x1::vector::borrow<LinearPrefix>(arg3, v6 - 1).spent;
                v1 = 0x1::vector::borrow<LinearPrefix>(arg3, v6 - 1).output;
            };
        };
        while (v0 > 0 && v3 < 0x1::vector::length<LinearSegment>(&arg0.linear_segments)) {
            if (*arg2 == 0) {
                return (0, 6)
            };
            *arg2 = *arg2 - 1;
            let v7 = 0x1::vector::borrow<LinearSegment>(&arg0.linear_segments, v3);
            let v8 = 0x1::u128::min(v0, v7.remaining_input);
            let v9 = if (v8 == v7.remaining_input) {
                v7.remaining_output
            } else if (!v7.exact_dlmm && v7.price_x64 > 0) {
                to_u128(0x1::u256::min(mul_ratio_up_saturating((v8 as u256), d7(v7), q64()), (v7.remaining_output as u256)))
            } else {
                quote_linear_segment_value(v7, v8)
            };
            if (v1 > 340282366920938463463374607431768211455 - v9) {
                return (0, 5)
            };
            v1 = v1 + v9;
            v0 = v0 - v8;
            v3 = v3 + 1;
        };
        if (v0 > 0) {
            let v12 = if (arg0.linear_has_more) {
                3
            } else {
                7
            };
            (0, v12)
        } else {
            (v1, 0)
        }
    }

    public fun d9(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: u128, arg3: u64, arg4: &mut u64, arg5: &vector<OrderbookShortfall>) : (u8, u64, u128) {
        while (arg3 < 0x1::vector::length<Hop>(arg0)) {
            let v0 = 0x1::vector::borrow<Hop>(arg0, arg3);
            if (v0.state_status != 0) {
                return (v0.state_status, arg3, arg2)
            };
            if (arg2 > v0.policy.input_capacity) {
                return (7, arg3, arg2)
            };
            let (v1, v2) = if (v0.kind == 0) {
                if (*arg4 == 0) {
                    return (6, arg3, arg2)
                };
                *arg4 = *arg4 - 1;
                let v1 = effective_output(v2_curve_output(v0.fee_denominator, v0.fee_rate, v0.policy.fractional_input_fee, v0.reserve_in, v0.reserve_out, arg2), v0.output_fee_rate, v0.output_fee_denominator);
                (v1, 0)
            } else if (v0.kind == 1) {
                if (arg3 >= 0x1::vector::length<V3PrefixCache>(arg1)) {
                    return (5, arg3, arg2)
                };
                0x1::vector::borrow_mut<V3PrefixCache>(arg1, arg3).reject_empty_endpoint = true;
                let v3 = 0x1::vector::borrow_mut<V3PrefixCache>(arg1, arg3);
                let (_, v5, _) = quote_v3_cached(&v0.boundaries, v3, arg2, arg4);
                (to_u128(0x1::u256::min(mul_ratio_up_saturating((arg2 as u256), cap_upper_v3(v0.sqrt_price_x64, v0.zero_for_one), q64()), (v0.policy.output_capacity as u256))), v5)
            } else {
                let (v7, v8) = if (v0.kind == 3) {
                    let (v9, v10) = if (arg3 < 0x1::vector::length<OrderbookShortfall>(arg5)) {
                        d8(v0, arg2, arg4, &0x1::vector::borrow<OrderbookShortfall>(arg5, arg3).linear_prefixes)
                    } else {
                        let v11 = 0x1::vector::empty<LinearPrefix>();
                        d8(v0, arg2, arg4, &v11)
                    };
                    (v10, v9)
                } else if (v0.kind == 2) {
                    let (v12, v13, _) = quote_orderbook_hop_bounded(v0.fee_denominator, v0.fee_rate, v0.orderbook_base_to_quote, v0.orderbook_cursor, v0.orderbook_has_more, v0.orderbook_lot_size, v0.orderbook_min_size, &v0.orderbook_segments, arg2, arg4);
                    (v13, v12)
                } else {
                    return (5, arg3, arg2)
                };
                (v8, v7)
            };
            if (v2 != 0) {
                return (v2, arg3, arg2)
            };
            arg2 = v1;
            arg3 = arg3 + 1;
        };
        (0, 18446744073709551615, 0)
    }

    public fun div_ceil(arg0: u256, arg1: u256) : u256 {
        if (arg0 % arg1 == 0) {
            arg0 / arg1
        } else {
            arg0 / arg1 + 1
        }
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
            price_scale      : 18446744073709551616,
        }
    }

    public fun e0(arg0: bool, arg1: &vector<Hop>, arg2: &mut vector<V3PrefixCache>, arg3: u128, arg4: u64, arg5: &mut u64, arg6: &mut vector<OrderbookShortfall>, arg7: bool) : (u128, u8, u64, u64, u64, u128) {
        if (arg0) {
            let (v0, v1, v2) = d9(arg1, arg2, arg3, arg4, arg5, arg6);
            if (v0 != 0) {
                return (0, v0, 0, 0, v1, v2)
            };
        };
        e1(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun e1(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: u128, arg3: u64, arg4: &mut u64, arg5: &mut vector<OrderbookShortfall>, arg6: bool) : (u128, u8, u64, u64, u64, u128) {
        let v0 = arg2;
        let v1 = 0;
        let v2 = 0;
        while (arg3 < 0x1::vector::length<Hop>(arg0)) {
            if (v0 == 0) {
                return (0, 10, v1, v2, arg3, v0)
            };
            let v3 = 0x1::vector::borrow<Hop>(arg0, arg3);
            if (v3.state_status != 0) {
                return (0, v3.state_status, v1, v2, arg3, v0)
            };
            if (v0 > v3.policy.input_capacity) {
                return (0, 7, v1, v2, arg3, v0)
            };
            if (v0 < v3.policy.input_minimum) {
                return (0, 10, v1, v2, arg3, v0)
            };
            let (v4, v5, v6) = if (v3.kind <= 3) {
                if (v3.kind == 0) {
                    if (*arg4 == 0) {
                        return (0, 6, v1, v2, arg3, v0)
                    };
                    *arg4 = *arg4 - 1;
                    (effective_output(v2_curve_output(v3.fee_denominator, v3.fee_rate, v3.policy.fractional_input_fee, v3.reserve_in, v3.reserve_out, v0), v3.output_fee_rate, v3.output_fee_denominator), 0, 0)
                } else if (v3.kind == 1) {
                    if (arg3 >= 0x1::vector::length<V3PrefixCache>(arg1)) {
                        return (0, 5, v1, v2, arg3, v0)
                    };
                    let v7 = 0x1::vector::borrow_mut<V3PrefixCache>(arg1, arg3);
                    quote_v3_cached(&v3.boundaries, v7, v0, arg4)
                } else if (v3.kind == 2) {
                    let (v8, v9, v10) = if (0x1::vector::is_empty<OrderbookShortfall>(arg5)) {
                        quote_orderbook_hop_bounded(v3.fee_denominator, v3.fee_rate, v3.orderbook_base_to_quote, v3.orderbook_cursor, v3.orderbook_has_more, v3.orderbook_lot_size, v3.orderbook_min_size, &v3.orderbook_segments, v0, arg4)
                    } else {
                        let v11 = 0x1::vector::borrow_mut<OrderbookShortfall>(arg5, arg3);
                        quote_orderbook_with_shortfall(v3.fee_denominator, v3.fee_rate, v3.orderbook_base_to_quote, v3.orderbook_cursor, v3.orderbook_has_more, v3.orderbook_lot_size, v3.orderbook_min_size, &v3.orderbook_segments, v0, arg4, v11, arg6)
                    };
                    v2 = v2 + v10;
                    (v8, v9, 0)
                } else {
                    if (0x1::vector::is_empty<LinearSegment>(&v3.linear_segments)) {
                        let v12 = if (v3.linear_has_more) {
                            3
                        } else {
                            11
                        };
                        return (0, v12, v1, v2, arg3, v0)
                    };
                    let (v13, v14, v15) = if (0x1::vector::is_empty<OrderbookShortfall>(arg5)) {
                        e3(v3, v0, arg4)
                    } else {
                        let v16 = 0x1::vector::borrow_mut<OrderbookShortfall>(arg5, arg3);
                        quote_linear_with_shortfall(v3.linear_cursor, v3.linear_has_more, &v3.linear_segments, v0, arg4, v16)
                    };
                    let (v17, v18) = if (v13 > v3.policy.output_capacity) {
                        (7, 0)
                    } else {
                        (v14, m6(v3, v13))
                    };
                    (v18, v17, v15)
                }
            } else if (v3.kind == 18) {
                if (*arg4 == 0) {
                    return (0, 6, v1, v2, arg3, v0)
                };
                *arg4 = *arg4 - 1;
                let (v19, _, _, v22) = 0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::evaluate(0x1::vector::borrow<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(&v3.policy.bolt, 0), (v0 as u64));
                let v23 = if (v22 == 0) {
                    0
                } else {
                    a6(v22)
                };
                ((v19 as u128), v23, 0)
            } else if (v3.kind == 5) {
                while (0x1::vector::length<V3PrefixCache>(arg1) <= arg3) {
                    0x1::vector::push_back<V3PrefixCache>(arg1, new_prefixCache(0x1::vector::empty<V3Prefix>(), 0, 0, 1, 0, 0, 340282366920938463463374607431768211455, false, 0, false, false));
                };
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_stable_with_d(v3.reserve_in, v3.reserve_out, v3.stable_admin_fee, v3.stable_amp, v3.stable_fee_on_input, v3.stable_lp_fee, v3.stable_scale_in, v3.stable_scale_out, v3.stable_th_fee, v0, arg4, &mut 0x1::vector::borrow_mut<V3PrefixCache>(arg1, arg3).liquidity)
            } else if (v3.kind == 6) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_ve33_stable_hop(v3.fee_denominator, v3.fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_amp, v3.stable_scale_in, v3.stable_scale_out, v0, arg4)
            } else if (v3.kind == 7) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_virtual_cpmm_hop(v3.fee_denominator, v3.fee_rate, v3.reserve_in, v3.reserve_out, v3.sqrt_price_x64, v3.stable_amp, v3.stable_scale_in, v3.stable_scale_out, v3.zero_for_one, v0, arg4)
            } else if (v3.kind == 8) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_kriya_v2_hop(v3.fee_denominator, v3.fee_rate, v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_amp, v3.stable_fee_on_input, v3.stable_scale_in, v3.stable_scale_out, v0, arg4)
            } else if (v3.kind == 17) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_capped_ratio_hop(v3.reserve_in, v3.reserve_out, v3.stable_scale_in, v0, arg4)
            } else if (v3.kind == 9) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_lst_ratio_hop(v3.fee_denominator, v3.fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_amp, v3.zero_for_one, v0, arg4)
            } else if (v3.kind == 10) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_hasui_ratio_hop(v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_amp, v3.stable_scale_in, v3.stable_scale_out, v3.zero_for_one, v0, arg4)
            } else if (v3.kind == 11) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_hawal_ratio_hop(v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_amp, v3.stable_scale_out, v3.zero_for_one, v0, arg4)
            } else if (v3.kind == 12) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_aftermath_with_exponent(v3.fee_rate, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_admin_fee, (v3.liquidity as u256), v3.stable_scale_in, v3.stable_scale_out, v0, arg4)
            } else if (v3.kind == 13) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_bucket_psm_hop(v3.fee_denominator, v3.fee_rate, v3.reserve_in, v3.stable_scale_in, v3.stable_scale_out, v3.zero_for_one, v0, arg4)
            } else if (v3.kind == 19) {
                j0(v3, v0, arg4)
            } else if (v3.kind == 14) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_steamm_cpmm_hop(v3.liquidity, v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.sqrt_price_x64, v3.stable_amp, v3.stable_scale_in, v3.stable_scale_out, v0, arg4)
            } else if (v3.kind == 15) {
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_steamm_omm_hop(v3.liquidity, v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.sqrt_price_x64, v3.stable_admin_fee, v3.stable_amp, v3.stable_lp_fee, v3.stable_scale_in, v3.stable_scale_out, v0, arg4)
            } else if (v3.kind == 16) {
                while (0x1::vector::length<V3PrefixCache>(arg1) <= arg3) {
                    0x1::vector::push_back<V3PrefixCache>(arg1, new_prefixCache(0x1::vector::empty<V3Prefix>(), 0, 0, 1, 0, 0, 340282366920938463463374607431768211455, false, 0, false, false));
                };
                let v24 = 0x1::vector::borrow_mut<V3PrefixCache>(arg1, arg3);
                0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_steamm_omm_v2_prepared(v3.liquidity, v3.orderbook_lot_size, v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.sqrt_price_x64, v3.stable_admin_fee, v3.stable_amp, v3.stable_lp_fee, v3.stable_scale_in, v3.stable_scale_out, v3.stable_th_fee, v3.zero_for_one, v3.policy.omm_update_flag, v0, arg4, &mut v24.fee_rate, &mut v24.boundary_cursor, &mut v24.liquidity, &mut v24.sqrt_price_x64, &mut v24.policy_output_capacity)
            } else {
                (0, 5, 0)
            };
            if (v5 != 0) {
                return (0, v5, v1 + v6, v2, arg3, arg2)
            };
            if (v4 == 0) {
                return (0, 10, v1 + v6, v2, arg3, arg2)
            };
            if (v4 > v3.policy.output_capacity) {
                return (0, 7, v1 + v6, v2, arg3, arg2)
            };
            v0 = v4;
            v1 = v1 + v6;
            arg3 = arg3 + 1;
        };
        (v0, 0, v1, v2, 18446744073709551615, 0)
    }

    public fun e2(arg0: &vector<Hop>) : (vector<OrderbookShortfall>, bool) {
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

    public fun e3(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        let (v0, v1, v2, _) = quote_linear_hop_bounded_impl(arg0.linear_cursor, arg0.linear_has_more, &arg0.linear_segments, arg1, arg2);
        (v0, v1, v2)
    }

    public fun e4(arg0: &vector<Hop>) : u256 {
        let v0 = q64();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = v0 * e6(0x1::vector::borrow<Hop>(arg0, v1));
            v0 = v2 / q64();
            v1 = v1 + 1;
        };
        v0
    }

    public fun e5(arg0: &vector<Hop>) : (u256, u256) {
        let v0 = q64();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Hop>(arg0)) {
            let v3 = 0x1::vector::borrow<Hop>(arg0, v2);
            v1 = v1 + f8(v3) * v0 / q64();
            let v4 = v0 * e6(v3);
            v0 = v4 / q64();
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun e6(arg0: &Hop) : u256 {
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

    public fun e7(arg0: &Hop) : u256 {
        if (arg0.kind == 19) {
            return j1(arg0)
        };
        if (arg0.kind == 18) {
            let v0 = 0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::price(0x1::vector::borrow<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(&arg0.policy.bolt, 0));
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
            h5(arg0.reserve_in, arg0.reserve_out, arg0.stable_admin_fee, (arg0.liquidity as u256), arg0.stable_scale_in, arg0.stable_scale_out)
        } else {
            assert!(arg0.kind == 13, 1);
            cap_upper_bucket_psm(arg0.stable_scale_in, arg0.stable_scale_out, arg0.zero_for_one)
        };
        mul_fraction_ceil(mul_fraction_ceil(v2, ((arg0.fee_denominator - arg0.fee_rate) as u256), (arg0.fee_denominator as u256)), ((arg0.output_fee_denominator - arg0.output_fee_rate) as u256), (arg0.output_fee_denominator as u256))
    }

    public fun e8(arg0: &vector<Hop>) : bool {
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

    public fun e9(arg0: &Hop, arg1: u128) : bool {
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
        let (v1, v2) = liquidity_after_boundary(arg0.liquidity, 0x1::vector::borrow<TickBoundary>(&arg0.boundaries, arg0.boundary_cursor), arg0.zero_for_one);
        if (v2) {
            if (v1 == 0) {
                arg1 >= f9(arg0)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun effective_input(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_down(arg0, ((arg2 - arg1) as u128), (arg2 as u128))
    }

    public fun effective_output(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_down(arg0, ((arg2 - arg1) as u128), (arg2 as u128))
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
            let (v21, v22) = liquidity_after_boundary(v6, &v12, arg1.zero_for_one);
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

    public fun f0(arg0: &vector<Hop>, arg1: u128) : bool {
        let v0 = (arg1 as u256);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            let v3 = if (v2.kind == 3) {
                true
            } else if (v2.policy.stop_at_zero_liquidity) {
                true
            } else {
                v0 > (v2.policy.input_capacity as u256)
            };
            if (v3) {
                return false
            };
            v0 = mul_ratio_up_saturating(v0, e7(v2), q64());
            if (v0 > (v2.policy.output_capacity as u256)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun f1(arg0: &vector<Hop>, arg1: u128) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (arg1 > v1.policy.input_capacity || e9(v1, arg1)) {
                return false
            };
            let v2 = g2(v1, arg1, true);
            arg1 = v2;
            if (v2 > v1.policy.output_capacity) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun f2(arg0: &vector<Hop>, arg1: u128) : (u128, bool) {
        if (!f1(arg0, arg1)) {
            let v0 = arg1;
            let v1 = 0;
            while (v1 < 0x1::vector::length<Hop>(arg0)) {
                let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
                if (v2.policy.input_capacity < 340282366920938463463374607431768211455) {
                    let (v3, v4) = f6(arg0, v1, v2.policy.input_capacity + 1);
                    if (v4) {
                        v0 = 0x1::u128::min(v0, v3);
                    };
                };
                if (v2.policy.output_capacity < 340282366920938463463374607431768211455) {
                    let (v5, v6) = g0(v2, v2.policy.output_capacity + 1);
                    if (v6) {
                        let (v7, v8) = f6(arg0, v1, v5);
                        if (v8) {
                            v0 = 0x1::u128::min(v0, v7);
                        };
                    };
                };
                v1 = v1 + 1;
            };
            if (f1(arg0, v0)) {
                return (v0, true)
            };
            let v9 = 0;
            let v10 = 0;
            while (v0 - v9 > 1 && v10 < 12) {
                let v11 = v9 + (v0 - v9) / 2;
                if (f1(arg0, v11)) {
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

    public fun f3(arg0: &vector<Hop>, arg1: u128, arg2: u128) : u128 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v1).policy.input_minimum > 0) {
                let (v2, v3) = f6(arg0, v1, 0x1::vector::borrow<Hop>(arg0, v1).policy.input_minimum);
                if (v3) {
                    v0 = 0x1::u128::max(v0, v2);
                };
            };
            v1 = v1 + 1;
        };
        0x1::u128::min(v0, arg2)
    }

    public fun f4(arg0: &vector<Hop>, arg1: u128) : (u128, u64) {
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
                let (v4, v5) = f5(arg0, v1);
                if (v5 && v4 < arg1) {
                    v0 = v4;
                };
            };
            v1 = v1 + 1;
        };
        (v0, 18446744073709551615)
    }

    public fun f5(arg0: &vector<Hop>, arg1: u64) : (u128, bool) {
        f6(arg0, arg1, f9(0x1::vector::borrow<Hop>(arg0, arg1)))
    }

    public fun f6(arg0: &vector<Hop>, arg1: u64, arg2: u128) : (u128, bool) {
        let v0 = arg2;
        let v1 = true;
        while (arg1 > 0 && v1) {
            let v2 = arg1 - 1;
            arg1 = v2;
            let (v3, v4) = g0(0x1::vector::borrow<Hop>(arg0, v2), v0);
            if (v4) {
                v0 = v3;
                continue
            };
            v1 = false;
        };
        (v0, v1)
    }

    public fun f7(arg0: &vector<Hop>, arg1: u128) : (u128, u64, u256, u256) {
        let v0 = 18446744073709551615;
        let v1 = q64();
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            let v4 = 0x1::vector::borrow<Hop>(arg0, v3);
            let v5 = if (v4.kind == 1) {
                true
            } else if (v4.kind == 2 && !orderbook_terminal(v4.kind, v4.orderbook_cursor, v4.orderbook_has_more, &v4.orderbook_segments)) {
                true
            } else {
                v4.kind == 3 && !linear_terminal(v4.kind, v4.linear_cursor, v4.linear_has_more, &v4.linear_segments)
            };
            if (v5) {
                let v6 = f9(v4);
                let v7 = v2 * (v6 as u256);
                if (v1 > v7) {
                };
            };
            v2 = v2 + f8(v4) * v1 / q64();
            let v8 = v1 * e6(v4);
            v1 = v8 / q64();
            v3 = v3 + 1;
        };
        if (v0 == 18446744073709551615) {
            return (arg1, 18446744073709551615, v1, v2)
        };
        let (v9, v10) = f5(arg0, v0);
        let (v11, v12) = if (v10 && v9 < arg1) {
            (v9, v0)
        } else {
            (arg1, 18446744073709551615)
        };
        (v11, v12, v1, v2)
    }

    public fun f8(arg0: &Hop) : u256 {
        if (arg0.kind == 3 || arg0.kind == 2) {
            return 0
        };
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

    public fun f9(arg0: &Hop) : u128 {
        if (arg0.kind == 2) {
            return orderbook_input_boundary(arg0.fee_denominator, arg0.fee_rate, arg0.orderbook_base_to_quote, arg0.orderbook_cursor, &arg0.orderbook_segments)
        };
        if (arg0.kind == 3) {
            return linear_input_boundary(arg0.linear_cursor, &arg0.linear_segments)
        };
        clmm_input_boundary(arg0.fee_denominator, arg0.fee_rate, arg0.liquidity, arg0.sqrt_price_x64, arg0.zero_for_one, c8(arg0))
    }

    public fun g0(arg0: &Hop, arg1: u128) : (u128, bool) {
        if (arg1 == 0) {
            return (0, true)
        };
        if (arg0.kind == 0) {
            return cap_inverse_v2(arg0.fee_denominator, arg0.fee_rate, arg0.output_fee_denominator, arg0.output_fee_rate, arg0.reserve_in, arg0.reserve_out, arg1)
        };
        if (arg0.kind == 1) {
            return cap_inverse_v3(arg0.fee_denominator, arg0.fee_rate, arg0.liquidity, arg0.sqrt_price_x64, arg0.zero_for_one, c8(arg0), arg1)
        };
        if (arg0.kind == 2) {
            return cap_inverse_orderbook(arg0.fee_denominator, arg0.fee_rate, arg0.orderbook_base_to_quote, arg0.orderbook_cursor, arg0.orderbook_lot_size, &arg0.orderbook_segments, arg1)
        };
        assert!(arg0.kind == 3, 1);
        cap_inverse_linear(arg0.fee_denominator, arg0.fee_rate, arg0.linear_cursor, &arg0.linear_segments, arg1)
    }

    public fun g1(arg0: &vector<Hop>, arg1: u128) : u128 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            v0 = g2(0x1::vector::borrow<Hop>(arg0, v1), v0, false);
            v1 = v1 + 1;
        };
        v0
    }

    public fun g2(arg0: &Hop, arg1: u128, arg2: bool) : u128 {
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
            cap_segment_quote_v3(arg0.liquidity, arg0.policy.stop_at_zero_liquidity, arg0.sqrt_price_x64, arg0.zero_for_one, c8(arg0), v0)
        } else if (arg0.kind == 2) {
            cap_segment_quote_orderbook(arg0.kind, arg0.orderbook_base_to_quote, arg0.orderbook_cursor, arg0.orderbook_has_more, arg0.orderbook_lot_size, &arg0.orderbook_segments, v0)
        } else {
            assert!(arg0.kind == 3, 1);
            let v2 = (18446744073709551615 as u64);
            let v3 = &mut v2;
            let (v4, _, _, _) = quote_linear_hop_bounded_impl(arg0.linear_cursor, arg0.linear_has_more, &arg0.linear_segments, v0, v3);
            if (arg2 && v4 > arg0.policy.output_capacity) {
                340282366920938463463374607431768211455
            } else {
                m6(arg0, v4)
            }
        }
    }

    public fun g3(arg0: &mut vector<Hop>, arg1: u128) : (u128, u64, u64) {
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
                /* goto 23 */
            };
            assert!(v5 <= v4.policy.input_capacity && v0 <= v4.policy.output_capacity, 3);
            if (v4.policy.input_capacity < 340282366920938463463374607431768211455) {
                v4.policy.input_capacity = v4.policy.input_capacity - v5;
            };
            if (v4.policy.output_capacity < 340282366920938463463374607431768211455) {
                v4.policy.output_capacity = v4.policy.output_capacity - v0;
            };
            let v19 = if (v5 >= v4.policy.input_minimum) {
                0
            } else {
                v4.policy.input_minimum - v5
            };
            v4.policy.input_minimum = v19;
            v3 = v3 + 1;
        };
        (v0, v1, v2)
    }

    public fun g4(arg0: &mut Hop, arg1: TickBoundary) {
        let v0 = &mut arg0.liquidity;
        apply_boundary_liquidity(v0, arg0.zero_for_one, arg1);
    }

    public fun g5(arg0: &mut Hop) : u64 {
        let v0 = &mut arg0.boundary_cursor;
        let v1 = &mut arg0.liquidity;
        let v2 = &mut arg0.sqrt_price_x64;
        advance_empty_boundaries(&arg0.boundaries, v0, v1, v2, arg0.zero_for_one)
    }

    public fun h0(arg0: &vector<Hop>, arg1: u128) : u256 {
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

    public fun h1(arg0: &vector<Hop>) : u256 {
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

    public fun h4(arg0: &vector<Hop>, arg1: u128) : (u128, bool) {
        let v0 = 0x1::vector::length<Hop>(arg0);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (v1.kind != 0) {
                return (0, false)
            };
            let (v2, v3) = g0(v1, arg1);
            if (!v3) {
                return (0, false)
            };
            arg1 = v2;
        };
        (arg1, true)
    }

    public fun h5(arg0: u128, arg1: u128, arg2: u64, arg3: u256, arg4: u128, arg5: u128) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::cap_upper_aftermath_prepared(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun h6(arg0: u128, arg1: bool) : u256 {
        if (arg1) {
            (arg0 as u256) * (arg0 as u256) / q64()
        } else {
            q64() * q64() / (arg0 as u256) * q64() / (arg0 as u256)
        }
    }

    public fun h7(arg0: &vector<Hop>) : u256 {
        if (!true) {
            return 5
        };
        if (c7(arg0) != 18446744073709551615 || c6(arg0) != 18446744073709551615) {
            return 0
        };
        let v0 = e4(arg0);
        let v1 = h1(arg0);
        if (v0 <= v1) {
            return 0
        };
        (v0 - v1) * 10000 / v0 / 10 * (0x1::vector::length<Hop>(arg0) as u256)
    }

    public fun h8(arg0: &vector<Hop>, arg1: u64) : u128 {
        let v0 = false;
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.state_status != 0) {
                return 0
            };
            if (v2.kind == 1 && (v2.liquidity == 0 || v2.boundary_cursor >= 0x1::vector::length<TickBoundary>(&v2.boundaries))) {
                return 0
            };
            if (v2.kind == 2) {
                v0 = true;
                if (v2.orderbook_cursor >= 0x1::vector::length<OrderbookSegment>(&v2.orderbook_segments)) {
                    return 0
                };
            };
            if (v2.kind == 3 && v2.linear_cursor >= 0x1::vector::length<LinearSegment>(&v2.linear_segments)) {
                return 0
            };
            v1 = v1 + 1;
        };
        if (!v0) {
            return 0
        };
        let v3 = 1;
        let v4 = 0;
        while (v4 < arg1) {
            let v5 = 0x1::vector::borrow<Hop>(arg0, v4);
            if (v5.kind == 2 && v5.orderbook_cursor < 0x1::vector::length<OrderbookSegment>(&v5.orderbook_segments)) {
                let v6 = if (v5.orderbook_base_to_quote) {
                    v5.orderbook_lot_size
                } else {
                    mul_div_up(v5.orderbook_lot_size, 0x1::vector::borrow<OrderbookSegment>(&v5.orderbook_segments, v5.orderbook_cursor).price, 1000000000)
                };
                let (v7, v8) = f6(arg0, v4, gross_from_effective(v6, v5.fee_rate, v5.fee_denominator));
                if (v8) {
                    v3 = 0x1::u128::max(v3, v7);
                };
            };
            v4 = v4 + 1;
        };
        v3
    }

    public fun h9(arg0: &vector<Hop>, arg1: u64) : u128 {
        let v0 = h8(arg0, arg1);
        let v1 = 0;
        while (v1 < arg1 && v0 > 0) {
            v0 = g2(0x1::vector::borrow<Hop>(arg0, v1), v0, false);
            v1 = v1 + 1;
        };
        v0
    }

    public fun i1(arg0: &vector<Hop>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.kind == 0) {
                v0 = v0 + 1;
            } else if (v2.kind == 2) {
                if (v2.orderbook_cursor > 0x1::vector::length<OrderbookSegment>(&v2.orderbook_segments)) {
                    return 0
                };
                v0 = v0 + ((0x1::vector::length<OrderbookSegment>(&v2.orderbook_segments) - v2.orderbook_cursor) as u128);
            } else if (v2.kind == 3) {
                if (v2.linear_cursor > 0x1::vector::length<LinearSegment>(&v2.linear_segments)) {
                    return 0
                };
                v0 = v0 + ((0x1::vector::length<LinearSegment>(&v2.linear_segments) - v2.linear_cursor) as u128);
            } else if (v2.kind == 1) {
                if (v2.boundary_cursor > 0x1::vector::length<TickBoundary>(&v2.boundaries)) {
                    return 0
                };
                let v3 = v0 + 2 * ((0x1::vector::length<TickBoundary>(&v2.boundaries) - v2.boundary_cursor) as u128);
                v0 = v3 + 1;
            } else {
                return 0
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun i2(arg0: &vector<LinearSegment>, arg1: u256, arg2: u128) : vector<LinearSegment> {
        i3(arg0, arg1, true, arg2, 0)
    }

    public fun i3(arg0: &vector<LinearSegment>, arg1: u256, arg2: bool, arg3: u128, arg4: u64) : vector<LinearSegment> {
        let v0 = 0x1::vector::empty<LinearSegment>();
        let v1 = 0x1::vector::length<LinearSegment>(arg0);
        let v2 = v1;
        if (arg2 && arg4 < 0x1::vector::length<LinearSegment>(arg0)) {
            let v3 = v1 - 1;
            v2 = v3;
            let v4 = 0x1::vector::borrow<LinearSegment>(arg0, v3).remaining_input;
            while (v2 > arg4 && v4 < arg3) {
                let v5 = v2 - 1;
                v2 = v5;
                let v6 = 0x1::vector::borrow<LinearSegment>(arg0, v5).remaining_input;
                if (v4 > 340282366920938463463374607431768211455 - v6) {
                    v2 = arg4;
                    break
                };
                v4 = v4 + v6;
            };
        };
        while (arg4 < 0x1::vector::length<LinearSegment>(arg0)) {
            let v7 = *0x1::vector::borrow<LinearSegment>(arg0, arg4);
            let v8 = v7.remaining_input;
            let v9 = v7.remaining_output;
            let v10 = if (v7.remaining_input > 0 && arg4 + 1 < 0x1::vector::length<LinearSegment>(arg0)) {
                (v7.remaining_output as u256) * q64() / (v7.remaining_input as u256)
            } else {
                0
            };
            let v11 = v7;
            let v12 = arg4 + 1;
            while (v12 < 0x1::vector::length<LinearSegment>(arg0)) {
                if (arg2 && v12 >= v2) {
                    break
                };
                v11 = *0x1::vector::borrow<LinearSegment>(arg0, v12);
                if (v11.remaining_input == 0 || v7.remaining_input == 0) {
                    break
                };
                let v13 = if (v11.exact_dlmm) {
                    if (v11.exact_dlmm) {
                        v11.fee_rate < v11.fee_rate
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v13) {
                    break
                };
                let v14 = (v11.remaining_output as u256) * q64() / (v11.remaining_input as u256);
                let v15 = if (!(v14 <= v10)) {
                    true
                } else if (!(v14 * 10000 >= v10 * (10000 - arg1))) {
                    true
                } else if (v8 > 340282366920938463463374607431768211455 - v11.remaining_input) {
                    true
                } else {
                    v9 > 340282366920938463463374607431768211455 - v11.remaining_output
                };
                if (v15) {
                    break
                };
                v8 = v8 + v11.remaining_input;
                v9 = v9 + v11.remaining_output;
                v12 = v12 + 1;
            };
            let v16 = if (v12 == arg4 + 1) {
                v7
            } else {
                linear_segment(v8, v9)
            };
            0x1::vector::push_back<LinearSegment>(&mut v0, v16);
            arg4 = v12;
        };
        v0
    }

    public fun i4(arg0: u64, arg1: &mut vector<LinearSegment>, arg2: u128) : (u128, u64) {
        let v0 = 0;
        while (arg2 > 0) {
            let v1 = 0x1::vector::borrow_mut<LinearSegment>(arg1, arg0);
            let v2 = 0x1::u128::min(arg2, v1.remaining_input);
            let v3 = quote_linear_segment_value(v1, v2);
            v1.remaining_input = v1.remaining_input - v2;
            v1.remaining_output = v1.remaining_output - v3;
            arg2 = arg2 - v2;
            v0 = v0 + v3;
            if (v1.remaining_input == 0) {
                arg0 = arg0 + 1;
            };
        };
        (v0, arg0)
    }

    public fun j0(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::meta_quote(arg0.zero_for_one, arg0.liquidity, arg0.stable_scale_out, arg0.stable_scale_in, arg0.stable_amp, arg0.reserve_in, arg0.sqrt_price_x64, arg0.stable_admin_fee, arg0.stable_lp_fee, arg1, arg2)
    }

    public fun j1(arg0: &Hop) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::meta_rate(arg0.state_status, arg0.policy.input_capacity, arg0.zero_for_one, arg0.liquidity, arg0.stable_scale_out, arg0.stable_scale_in, arg0.stable_admin_fee)
    }

    public fun j3(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v0).kind == 2 || 0x1::vector::borrow<Hop>(arg0, v0).kind == 3) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun j4(arg0: &vector<Hop>) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            let v3 = if (v2.state_status != 0) {
                true
            } else if (v2.policy.fractional_input_fee) {
                true
            } else if (v2.kind != 0) {
                if (v2.kind != 1) {
                    v2.kind != 3
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                return false
            };
            if (v2.kind == 3) {
                if (v2.policy.linear_rate_inversion || v2.linear_cursor >= 0x1::vector::length<LinearSegment>(&v2.linear_segments)) {
                    return false
                };
            } else if (v2.kind == 1) {
                if (v2.liquidity == 0 || v2.boundary_cursor >= 0x1::vector::length<TickBoundary>(&v2.boundaries)) {
                    return false
                };
                v0 = true;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun j6(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v0).kind != 0 && 0x1::vector::borrow<Hop>(arg0, v0).kind != 1) {
                return false
            };
            let v2 = v1 || 0x1::vector::borrow<Hop>(arg0, v0).kind == 1;
            v1 = v2;
            v0 = v0 + 1;
        };
        v1
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
            if (v2 == 1 || v2 == 4) {
                v1.kind = 1;
                v1.liquidity = v3;
                0x1::vector::append<TickBoundary>(&mut v1.boundaries, v4);
                if (v2 == 4) {
                    v1.stable_amp = (0x1::vector::length<TickBoundary>(&v1.boundaries) as u128);
                };
                let v7 = &mut v1;
                c4(v7);
                if (v2 == 4) {
                    v1.orderbook_cursor = v1.boundary_cursor;
                };
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

    public fun k1(arg0: &vector<Hop>) : bool {
        if (route_model(arg0) == 1) {
            return false
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = false;
        let v3 = false;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v4 = 0x1::vector::borrow<Hop>(arg0, v1);
            let v5 = if (v4.state_status != 0) {
                true
            } else if (v4.kind == 3 && v4.linear_cursor >= 0x1::vector::length<LinearSegment>(&v4.linear_segments)) {
                true
            } else if (v4.kind == 2 && v4.orderbook_cursor >= 0x1::vector::length<OrderbookSegment>(&v4.orderbook_segments)) {
                true
            } else {
                v4.kind == 1 && (v4.liquidity == 0 || v4.boundary_cursor >= 0x1::vector::length<TickBoundary>(&v4.boundaries))
            };
            if (v5) {
                return false
            };
            let v6 = v2 || 0x1::vector::borrow<Hop>(arg0, v1).kind == 2;
            v2 = v6;
            let v7 = v3 || 0x1::vector::borrow<Hop>(arg0, v1).kind == 3;
            v3 = v7;
            v0 = v0 + 0x1::vector::length<LinearSegment>(&0x1::vector::borrow<Hop>(arg0, v1).linear_segments);
            v1 = v1 + 1;
        };
        if (v2) {
            if (v3) {
                v0 <= 2 * 0x1::vector::length<Hop>(arg0)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun k2(arg0: &vector<Hop>, arg1: u128) : u128 {
        let v0 = q64();
        let v1 = 0;
        let v2 = arg1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            let v4 = 0x1::vector::borrow<Hop>(arg0, v3);
            let v5 = 340282366920938463463374607431768211455;
            if (v4.kind == 3) {
                v5 = 0;
                let v6 = v4.linear_cursor;
                while (v6 < 0x1::vector::length<LinearSegment>(&v4.linear_segments)) {
                    let v7 = 0x1::vector::borrow<LinearSegment>(&v4.linear_segments, v6).remaining_input;
                    let v8 = if (v5 > 340282366920938463463374607431768211455 - v7) {
                        340282366920938463463374607431768211455
                    } else {
                        v5 + v7
                    };
                    v5 = v8;
                    v6 = v6 + 1;
                };
            } else if (v4.kind == 2) {
                v5 = 0;
                let v9 = v4.orderbook_cursor;
                while (v9 < 0x1::vector::length<OrderbookSegment>(&v4.orderbook_segments)) {
                    let v10 = 0x1::vector::borrow<OrderbookSegment>(&v4.orderbook_segments, v9);
                    let v11 = if (v4.orderbook_base_to_quote) {
                        v10.remaining_base
                    } else {
                        mul_div_up(v10.remaining_base, v10.price, 1000000000)
                    };
                    let v12 = if (v5 > 340282366920938463463374607431768211455 - v11) {
                        340282366920938463463374607431768211455
                    } else {
                        v5 + v11
                    };
                    v5 = v12;
                    v9 = v9 + 1;
                };
            };
            let v13 = if (v5 > 0) {
                if (v5 != 340282366920938463463374607431768211455) {
                    v1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / (v5 as u256)
                } else {
                    false
                }
            } else {
                false
            };
            if (v13) {
                let v14 = v1 * (v5 as u256);
                if (v0 > v14) {
                    v2 = 0x1::u128::min(v2, to_u128(0x1::u256::min((v5 as u256) * q64() / (v0 - v14), (340282366920938463463374607431768211455 as u256))));
                };
            };
            v1 = v1 + f8(v4) * v0 / q64();
            let v15 = v0 * e6(v4);
            v0 = v15 / q64();
            v3 = v3 + 1;
        };
        0x1::u128::max(v2, 1)
    }

    public fun k3(arg0: &Hop, arg1: u128, arg2: u128, arg3: u128, arg4: &vector<u128>) : u128 {
        let v0 = if (arg0.kind != 2) {
            true
        } else if (arg0.orderbook_base_to_quote) {
            true
        } else if (arg0.fee_rate != 0) {
            true
        } else {
            arg0.orderbook_cursor >= 0x1::vector::length<OrderbookSegment>(&arg0.orderbook_segments)
        };
        if (v0) {
            return arg1
        };
        book_buy_segments(arg1, arg0.orderbook_lot_size, arg0.orderbook_min_size, &arg0.orderbook_segments, arg0.orderbook_cursor, 0x1::u128::max(arg2, arg0.policy.input_minimum), arg3, arg4)
    }

    public fun k4(arg0: &vector<Hop>, arg1: u128) : bool {
        let v0 = false;
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Hop>(arg0)) {
            let v3 = 0x1::vector::borrow<Hop>(arg0, v2);
            let v4 = if (v3.state_status != 0) {
                true
            } else if (v3.kind == 3 && v3.linear_cursor >= 0x1::vector::length<LinearSegment>(&v3.linear_segments)) {
                true
            } else if (v3.kind == 2 && v3.orderbook_cursor >= 0x1::vector::length<OrderbookSegment>(&v3.orderbook_segments)) {
                true
            } else if (v3.kind == 1 && (v3.liquidity == 0 || v3.boundary_cursor >= 0x1::vector::length<TickBoundary>(&v3.boundaries))) {
                true
            } else if (v3.kind != 3) {
                if (v3.kind != 2) {
                    if (v3.kind != 1) {
                        v3.kind != 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                return false
            };
            let v5 = v0 || 0x1::vector::borrow<Hop>(arg0, v2).kind == 2;
            v0 = v5;
            let v6 = v1 || 0x1::vector::borrow<Hop>(arg0, v2).kind == 3;
            v1 = v6;
            v2 = v2 + 1;
        };
        if (!v0 || !v1) {
            return false
        };
        let v7 = q64();
        let v8 = (k2(arg0, arg1) as u256);
        let v9 = 0;
        while (v9 < 0x1::vector::length<Hop>(arg0)) {
            let v10 = 0x1::vector::borrow<Hop>(arg0, v9);
            if (v10.state_status != 0) {
                return false
            };
            let v11 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
            let v12 = 0;
            if (v10.kind == 2) {
                v0 = true;
                let v13 = v10.orderbook_cursor;
                if (v13 >= 0x1::vector::length<OrderbookSegment>(&v10.orderbook_segments)) {
                    return false
                };
                while (v13 < 0x1::vector::length<OrderbookSegment>(&v10.orderbook_segments)) {
                    let v14 = if (v10.orderbook_base_to_quote) {
                        (0x1::vector::borrow<OrderbookSegment>(&v10.orderbook_segments, v13).price as u256) * q64() / 1000000000
                    } else {
                        1000000000 * q64() / (0x1::vector::borrow<OrderbookSegment>(&v10.orderbook_segments, v13).price as u256)
                    };
                    v11 = 0x1::u256::min(v11, v14);
                    v12 = 0x1::u256::max(v12, v14);
                    v13 = v13 + 1;
                };
            } else if (v10.kind == 3) {
                v1 = true;
                let v15 = v10.linear_cursor;
                if (v15 >= 0x1::vector::length<LinearSegment>(&v10.linear_segments)) {
                    return false
                };
                while (v15 < 0x1::vector::length<LinearSegment>(&v10.linear_segments)) {
                    let (v16, v17) = linear_marginal_fraction(0x1::vector::borrow<LinearSegment>(&v10.linear_segments, v15));
                    v11 = 0x1::u256::min(v11, v16 / v17);
                    v12 = 0x1::u256::max(v12, div_ceil(v16, v17));
                    v15 = v15 + 1;
                };
            } else if (v10.kind == 1) {
                if (v10.liquidity == 0 || v10.boundary_cursor >= 0x1::vector::length<TickBoundary>(&v10.boundaries)) {
                    return false
                };
                v12 = cap_upper_v3(v10.sqrt_price_x64, v10.zero_for_one);
                let v18 = (0x1::u256::min(v8, (v10.policy.input_capacity as u256)) as u128);
                let v19 = if (v18 < f9(v10)) {
                    next_sqrt_price_partial(v10.sqrt_price_x64, v10.liquidity, v10.zero_for_one, effective_input(v18, v10.fee_rate, v10.fee_denominator), v10.policy.stop_at_zero_liquidity)
                } else {
                    0x1::vector::borrow<TickBoundary>(&v10.boundaries, 0x1::vector::length<TickBoundary>(&v10.boundaries) - 1).sqrt_price_x64
                };
                v11 = cap_marginal_v3(v19, v10.zero_for_one);
            } else if (v10.kind == 0) {
                let v20 = (v10.reserve_in as u256) + 0x1::u256::min(v8, (v10.policy.input_capacity as u256));
                if (v20 == 0) {
                    return false
                };
                v11 = mul_ratio_down_saturating((v10.reserve_out as u256) * q64() / v20, (v10.reserve_in as u256), v20);
                v12 = cap_upper_v2(v10.reserve_in, v10.reserve_out);
            } else {
                return false
            };
            v7 = mul_ratio_down_saturating(v7, mul_ratio_down_saturating(mul_ratio_down_saturating(v11, ((v10.fee_denominator - v10.fee_rate) as u256), (v10.fee_denominator as u256)), ((v10.output_fee_denominator - v10.output_fee_rate) as u256), (v10.output_fee_denominator as u256)), q64());
            let v21 = mul_ratio_up_saturating(v8, v12, q64());
            v8 = 0x1::u256::min(v21, (340282366920938463463374607431768211455 as u256));
            v9 = v9 + 1;
        };
        if (v0) {
            if (v1) {
                v7 > h1(arg0)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun l3(arg0: &mut vector<TickBoundary>, arg1: &vector<u128>, arg2: &vector<u128>, arg3: &vector<bool>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(arg1)) {
            0x1::vector::push_back<TickBoundary>(arg0, tick_boundary(*0x1::vector::borrow<u128>(arg1, v0), *0x1::vector::borrow<u128>(arg2, v0), *0x1::vector::borrow<bool>(arg3, v0)));
            v0 = v0 + 1;
        };
    }

    public fun l4(arg0: &vector<Hop>, arg1: &vector<V3PrefixCache>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            let v3 = if (v2.kind == 0) {
                1
            } else if (v2.kind == 2) {
                if (v2.orderbook_cursor > 0x1::vector::length<OrderbookSegment>(&v2.orderbook_segments)) {
                    return 0
                };
                ((0x1::vector::length<OrderbookSegment>(&v2.orderbook_segments) - v2.orderbook_cursor) as u128)
            } else if (v2.kind == 3) {
                if (v2.linear_cursor > 0x1::vector::length<LinearSegment>(&v2.linear_segments)) {
                    return 0
                };
                ((0x1::vector::length<LinearSegment>(&v2.linear_segments) - v2.linear_cursor) as u128)
            } else if (v2.kind == 1) {
                if (v1 >= 0x1::vector::length<V3PrefixCache>(arg1) || 0x1::vector::borrow<V3PrefixCache>(arg1, v1).boundary_cursor > 0x1::vector::length<TickBoundary>(&v2.boundaries)) {
                    return 0
                };
                2 * ((0x1::vector::length<TickBoundary>(&v2.boundaries) - 0x1::vector::borrow<V3PrefixCache>(arg1, v1).boundary_cursor) as u128) + 1
            } else {
                return 0
            };
            let v4 = v0 + v3;
            v0 = v4;
            if (v4 > 18446744073709551615) {
                return 0
            };
            v1 = v1 + 1;
        };
        (v0 as u64)
    }

    public fun linear_input_boundary(arg0: u64, arg1: &vector<LinearSegment>) : u128 {
        current_linear_segment(arg0, arg1).remaining_input
    }

    public fun linear_marginal_fraction(arg0: &LinearSegment) : (u256, u256) {
        if (!arg0.exact_dlmm) {
            return ((arg0.remaining_output as u256) * q64(), (arg0.remaining_input as u256))
        };
        if (arg0.forward) {
            ((arg0.price_x64 as u256) * ((arg0.fee_denominator - arg0.fee_rate) as u256) * q64(), (arg0.fee_denominator as u256) * (arg0.price_scale as u256))
        } else {
            (q64() * (arg0.price_scale as u256) * ((arg0.fee_denominator - arg0.fee_rate) as u256), (arg0.price_x64 as u256) * (arg0.fee_denominator as u256))
        }
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
            price_scale      : 18446744073709551616,
        }
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

    public fun m3(arg0: &mut Hop, arg1: vector<TickBoundary>, arg2: bool) {
        if (arg0.stable_amp > 0) {
            0x1::vector::pop_back<TickBoundary>(&mut arg0.boundaries);
            arg0.boundary_cursor = 0x1::u64::min(arg0.boundary_cursor, 0x1::vector::length<TickBoundary>(&arg0.boundaries) - 1);
        };
        0x1::vector::append<TickBoundary>(&mut arg0.boundaries, arg1);
        let v0 = if (arg2) {
            (0x1::vector::length<TickBoundary>(&arg0.boundaries) as u128)
        } else {
            0
        };
        arg0.stable_amp = v0;
        arg0.orderbook_cursor = arg0.boundary_cursor;
    }

    public fun m4(arg0: &Hop, arg1: &mut V3PrefixCache) {
        if (arg0.kind == 1 && arg0.stable_amp > 0) {
            let v0 = ((arg0.stable_amp - 1) as u64);
            arg1.real_boundary_limit = v0 - 0x1::u64::min(arg1.boundary_cursor, v0);
        };
    }

    public fun m6(arg0: &Hop, arg1: u128) : u128 {
        if (arg0.output_fee_rate == 0) {
            arg1
        } else {
            arg1 - mul_div_down(arg1, (arg0.output_fee_rate as u128), (arg0.output_fee_denominator as u128))
        }
    }

    public fun mul_fraction_ceil(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0 && arg1 <= arg2, 2);
        arg0 / arg2 * arg1 + div_ceil(arg0 % arg2 * arg1, arg2)
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

    public fun new_AftermathSigned(arg0: bool, arg1: u256) : AftermathSigned {
        AftermathSigned{
            negative  : arg0,
            magnitude : arg1,
        }
    }

    public fun new_ExecutionPolicy(arg0: vector<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>, arg1: bool, arg2: bool, arg3: bool, arg4: u128, arg5: u128, arg6: u128, arg7: bool, arg8: bool, arg9: u64, arg10: u64) : ExecutionPolicy {
        ExecutionPolicy{
            bolt                       : arg0,
            fractional_input_fee       : arg1,
            omm_update_flag            : arg2,
            linear_rate_inversion      : arg3,
            input_minimum              : arg4,
            input_capacity             : arg5,
            output_capacity            : arg6,
            stop_at_zero_liquidity     : arg7,
            momentum_fee_round_nearest : arg8,
            auxiliary_fee_rate         : arg9,
            auxiliary_fee_denominator  : arg10,
        }
    }

    public fun new_Hop(arg0: u8, arg1: ExecutionPolicy, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: bool, arg11: vector<TickBoundary>, arg12: u64, arg13: vector<OrderbookSegment>, arg14: u64, arg15: u128, arg16: u128, arg17: u128, arg18: bool, arg19: bool, arg20: vector<LinearSegment>, arg21: u64, arg22: bool, arg23: u128, arg24: u128, arg25: u128, arg26: u64, arg27: u64, arg28: u64, arg29: bool, arg30: u8) : Hop {
        Hop{
            kind                    : arg0,
            policy                  : arg1,
            fee_rate                : arg2,
            fee_denominator         : arg3,
            output_fee_rate         : arg4,
            output_fee_denominator  : arg5,
            reserve_in              : arg6,
            reserve_out             : arg7,
            sqrt_price_x64          : arg8,
            liquidity               : arg9,
            zero_for_one            : arg10,
            boundaries              : arg11,
            boundary_cursor         : arg12,
            orderbook_segments      : arg13,
            orderbook_cursor        : arg14,
            orderbook_lot_size      : arg15,
            orderbook_min_size      : arg16,
            orderbook_consumed_base : arg17,
            orderbook_base_to_quote : arg18,
            orderbook_has_more      : arg19,
            linear_segments         : arg20,
            linear_cursor           : arg21,
            linear_has_more         : arg22,
            stable_amp              : arg23,
            stable_scale_in         : arg24,
            stable_scale_out        : arg25,
            stable_admin_fee        : arg26,
            stable_lp_fee           : arg27,
            stable_th_fee           : arg28,
            stable_fee_on_input     : arg29,
            state_status            : arg30,
        }
    }

    public fun new_LinearPrefix(arg0: u128, arg1: u128) : LinearPrefix {
        LinearPrefix{
            spent  : arg0,
            output : arg1,
        }
    }

    public fun new_LinearSegment(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u128) : LinearSegment {
        LinearSegment{
            remaining_input  : arg0,
            remaining_output : arg1,
            price_x64        : arg2,
            fee_rate         : arg3,
            fee_denominator  : arg4,
            forward          : arg5,
            exact_dlmm       : arg6,
            price_scale      : arg7,
        }
    }

    public fun new_OrderbookPrefix(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : OrderbookPrefix {
        OrderbookPrefix{
            minimum_input : arg0,
            spent         : arg1,
            output        : arg2,
            base          : arg3,
        }
    }

    public fun new_OrderbookSegment(arg0: u128, arg1: u128) : OrderbookSegment {
        OrderbookSegment{
            price          : arg0,
            remaining_base : arg1,
        }
    }

    public fun new_OrderbookShortfall(arg0: vector<LinearPrefix>, arg1: vector<OrderbookPrefix>, arg2: u128, arg3: u64) : OrderbookShortfall {
        OrderbookShortfall{
            linear_prefixes : arg0,
            prefixes        : arg1,
            minimum_gross   : arg2,
            crossed         : arg3,
        }
    }

    public fun new_PreparedCpmm(arg0: bool, arg1: bool, arg2: u128, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256) : PreparedCpmm {
        PreparedCpmm{
            fractional         : arg0,
            reserves_valid     : arg1,
            reserve_in         : arg2,
            reserve_out        : arg3,
            scaled_reserve_in  : arg4,
            input_factor       : arg5,
            input_denominator  : arg6,
            output_factor      : arg7,
            output_denominator : arg8,
        }
    }

    public fun new_StagedHop(arg0: u8, arg1: u128, arg2: vector<TickBoundary>, arg3: vector<Hop>) : StagedHop {
        StagedHop{
            kind        : arg0,
            liquidity   : arg1,
            boundaries  : arg2,
            replacement : arg3,
        }
    }

    public fun new_TickBoundary(arg0: u128, arg1: u128, arg2: bool) : TickBoundary {
        TickBoundary{
            sqrt_price_x64    : arg0,
            liquidity_net_abs : arg1,
            negative          : arg2,
        }
    }

    public fun new_V3Prefix(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : V3Prefix {
        V3Prefix{
            cumulative_input   : arg0,
            crossing_input     : arg1,
            cumulative_output  : arg2,
            end_sqrt_price_x64 : arg3,
            liquidity_after    : arg4,
        }
    }

    public fun new_V3PrefixCache(arg0: vector<V3Prefix>, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: bool, arg9: bool, arg10: bool, arg11: u128, arg12: bool) : V3PrefixCache {
        V3PrefixCache{
            prefixes                      : arg0,
            real_boundary_limit           : arg1,
            status                        : arg2,
            boundary_cursor               : arg3,
            fee_denominator               : arg4,
            fee_rate                      : arg5,
            liquidity                     : arg6,
            policy_output_capacity        : arg7,
            policy_stop_at_zero_liquidity : arg8,
            reject_empty_endpoint         : arg9,
            momentum_fee_round_nearest    : arg10,
            sqrt_price_x64                : arg11,
            zero_for_one                  : arg12,
        }
    }

    public fun new_prefixCache(arg0: vector<V3Prefix>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: bool, arg10: bool) : V3PrefixCache {
        V3PrefixCache{
            prefixes                      : arg0,
            real_boundary_limit           : 18446744073709551615,
            status                        : arg1,
            boundary_cursor               : arg2,
            fee_denominator               : arg3,
            fee_rate                      : arg4,
            liquidity                     : arg5,
            policy_output_capacity        : arg6,
            policy_stop_at_zero_liquidity : arg7,
            reject_empty_endpoint         : false,
            momentum_fee_round_nearest    : arg10,
            sqrt_price_x64                : arg8,
            zero_for_one                  : arg9,
        }
    }

    public fun new_shortfall(arg0: vector<OrderbookPrefix>, arg1: u128, arg2: u64) : OrderbookShortfall {
        OrderbookShortfall{
            linear_prefixes : 0x1::vector::empty<LinearPrefix>(),
            prefixes        : arg0,
            minimum_gross   : arg1,
            crossed         : arg2,
        }
    }

    public fun nq(arg0: u128, arg1: u128) : u128 {
        to_u128((arg0 as u256) * (arg1 as u256) / 1000000000)
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
            nq(arg1.remaining_base, arg1.price)
        } else {
            arg1.remaining_base
        }
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

    public fun passes_bolt_coarse_gate(arg0: &vector<Hop>, arg1: u256, arg2: bool) : bool {
        let v0 = q64();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.state_status == 2) {
                return false
            };
            let v3 = if (v2.kind == 3) {
                true
            } else if (v2.kind == 0) {
                true
            } else if (v2.kind == 1) {
                true
            } else if (v2.kind == 4) {
                true
            } else if (v2.kind == 2) {
                true
            } else if (v2.kind == 18) {
                true
            } else if (v2.kind == 19) {
                true
            } else if (v2.kind == 12) {
                true
            } else {
                v2.kind == 13
            };
            let (v4, v5) = if (v3) {
                (true, e7(v2))
            } else {
                let (v6, v7, _) = c1(v2);
                (v6, v7)
            };
            if (!v4 || v5 == 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                return false
            };
            let v9 = v5;
            if (arg2 && v2.kind == 18) {
                v9 = mul_fraction_ceil(v5, (0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::current_fee_keep(0x1::vector::borrow<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(&v2.policy.bolt, 0)) as u256), 10000000);
            } else if (!arg2) {
                if (v2.fee_rate == v2.fee_denominator || v2.output_fee_rate == v2.output_fee_denominator) {
                    return false
                };
                let v10 = mul_ratio_up_saturating(mul_ratio_up_saturating(v5, (v2.fee_denominator as u256), ((v2.fee_denominator - v2.fee_rate) as u256)), (v2.output_fee_denominator as u256), ((v2.output_fee_denominator - v2.output_fee_rate) as u256));
                v9 = v10;
                if (v2.kind == 3 && !linear_terminal(v2.kind, v2.linear_cursor, v2.linear_has_more, &v2.linear_segments)) {
                    let v11 = 0x1::vector::borrow<LinearSegment>(&v2.linear_segments, v2.linear_cursor);
                    if (v11.exact_dlmm) {
                        if (v11.fee_rate == v11.fee_denominator) {
                            return false
                        };
                        v9 = mul_ratio_up_saturating(v10, (v11.fee_denominator as u256), ((v11.fee_denominator - v11.fee_rate) as u256));
                    };
                };
            };
            v0 = mul_q64_ceil(v0, v9);
            v1 = v1 + 1;
        };
        0x1::vector::length<Hop>(arg0) > 0 && v0 > saturating_add(arg1, h1(arg0) - q64())
    }

    public fun passes_bounded_profit_gate(arg0: &vector<Hop>, arg1: u128) : bool {
        let (v0, v1, v2, v3) = c2(arg0);
        if (!v3) {
            return false
        };
        if (!v0 || v1 > h1(arg0)) {
            return true
        };
        c3(arg0, v2, arg1)
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
            v0 = mul_q64_ceil(v0, e7(v2));
            v1 = v1 + 1;
        };
        v0 > saturating_add(arg1, h1(arg0) - q64())
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
        let v0 = *arg3;
        if (arg1 <= 8) {
            let v1 = 0;
            while (v1 < arg1) {
                if (v0 == 0) {
                    *arg3 = 0;
                    return (v1, 6)
                };
                v0 = v0 - 1;
                if (v1 >= 0x1::vector::length<V3Prefix>(arg0) || 0x1::vector::borrow<V3Prefix>(arg0, v1).crossing_input > arg2) {
                    break
                };
                v1 = v1 + 1;
            };
            *arg3 = v0;
            return (v1, 0)
        };
        let v2 = 0;
        while (v2 < arg1) {
            if (v0 == 0) {
                *arg3 = 0;
                return (v2, 6)
            };
            v0 = v0 - 1;
            let v3 = v2 + (arg1 - v2) / 2;
            if (v3 < 0x1::vector::length<V3Prefix>(arg0) && 0x1::vector::borrow<V3Prefix>(arg0, v3).crossing_input <= arg2) {
                v2 = v3 + 1;
                continue
            };
            arg1 = v3;
        };
        *arg3 = v0;
        (v2, 0)
    }

    public fun prepare_auxiliary_fees(arg0: &vector<Hop>) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = &0x1::vector::borrow<Hop>(arg0, v1).policy;
            if (v2.auxiliary_fee_rate > 0) {
                0x1::vector::push_back<u64>(&mut v0, v2.auxiliary_fee_rate);
                0x1::vector::push_back<u64>(&mut v0, v2.auxiliary_fee_denominator);
            };
            v1 = v1 + 1;
        };
        v0
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

    public fun prepared_auxiliary_fee(arg0: &vector<u64>, arg1: u128) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = saturating_add(v0, (arg1 as u256) * (*0x1::vector::borrow<u64>(arg0, v1) as u256) / (*0x1::vector::borrow<u64>(arg0, v1 + 1) as u256));
            v1 = v1 + 2;
        };
        v0
    }

    public fun q64() : u256 {
        (18446744073709551616 as u256)
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
                (0, 7)
            }
        } else {
            (v1, 0)
        };
        (v7, v8, v2, v0)
    }

    public fun quote_linear_segment_value(arg0: &LinearSegment, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 0
        };
        if (arg1 >= arg0.remaining_input) {
            arg0.remaining_output
        } else if (arg0.exact_dlmm) {
            let v1 = if (arg0.forward) {
                (effective_input(arg1, arg0.fee_rate, arg0.fee_denominator) as u256) * (arg0.price_x64 as u256) / (arg0.price_scale as u256)
            } else {
                (effective_input(arg1, arg0.fee_rate, arg0.fee_denominator) as u256) * (arg0.price_scale as u256) / (arg0.price_x64 as u256)
            };
            let v2 = if (v1 > (arg0.remaining_output as u256)) {
                (arg0.remaining_output as u256)
            } else {
                v1
            };
            to_u128(v2)
        } else if (arg0.price_x64 > 0) {
            let v3 = mul_div_down(arg1, arg0.price_x64, 18446744073709551616);
            let v4 = (arg0.fee_denominator as u128);
            let v5 = if (v3 > v4) {
                v3 - v4
            } else {
                0
            };
            0x1::u128::min(v5, arg0.remaining_output)
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
                7
            };
            return (0, v0, arg5.crossed)
        };
        let v1 = 0;
        let v2 = 0x1::u64::min(0x1::vector::length<LinearPrefix>(&arg5.linear_prefixes), *arg4);
        while (v1 < v2) {
            v2 = v1 + (v2 - v1) / 2;
            if (0x1::vector::borrow<LinearPrefix>(&arg5.linear_prefixes, v2).spent <= arg3) {
                v1 = v2 + 1;
                continue
            };
        };
        let v3 = if (v1 == 0) {
            0
        } else {
            0x1::vector::borrow<LinearPrefix>(&arg5.linear_prefixes, v1 - 1).spent
        };
        let v4 = if (v1 == 0) {
            0
        } else {
            0x1::vector::borrow<LinearPrefix>(&arg5.linear_prefixes, v1 - 1).output
        };
        *arg4 = *arg4 - v1;
        let v5 = 0x1::vector::length<LinearPrefix>(&arg5.linear_prefixes);
        let v6 = arg3 - v3;
        let v7 = 0;
        let v8 = v1;
        let v9 = arg0 + v1;
        let v10 = 0;
        let v11 = false;
        while (v6 > 0 && v9 < 0x1::vector::length<LinearSegment>(arg2)) {
            if (*arg4 == 0) {
                v10 = 6;
                break
            };
            *arg4 = *arg4 - 1;
            let v12 = 0x1::vector::borrow<LinearSegment>(arg2, v9);
            let v13 = v6 >= v12.remaining_input;
            let v14 = if (v13) {
                v12.remaining_input
            } else {
                v6
            };
            let v15 = if (v13) {
                v12.remaining_output
            } else {
                quote_linear_segment_value(v12, v14)
            };
            if (v7 > 340282366920938463463374607431768211455 - v15) {
                v10 = 5;
                break
            };
            let v16 = v7 + v15;
            v7 = v16;
            let v17 = v6 - v14;
            v6 = v17;
            if (!v13) {
                break
            };
            let v18 = v8 + 1;
            v8 = v18;
            v9 = v9 + 1;
            let v19 = if (0x1::vector::length<LinearSegment>(arg2) >= 8) {
                if (v18 > v5) {
                    !v11
                } else {
                    false
                }
            } else {
                false
            };
            if (v19) {
                if (v4 > 340282366920938463463374607431768211455 - v16) {
                    v11 = true;
                    continue
                };
                let v20 = LinearPrefix{
                    spent  : arg3 - v17,
                    output : v4 + v16,
                };
                0x1::vector::push_back<LinearPrefix>(&mut arg5.linear_prefixes, v20);
            };
        };
        if (v10 == 5) {
            while (0x1::vector::length<LinearPrefix>(&arg5.linear_prefixes) > v5) {
                0x1::vector::pop_back<LinearPrefix>(&mut arg5.linear_prefixes);
            };
        } else {
            if (v11) {
                return (0, 5, v8)
            };
            if (v6 > 0 && v10 == 0) {
                let v21 = if (arg1) {
                    3
                } else {
                    7
                };
                v10 = v21;
            };
        };
        if (v6 > 0 && (v10 == 3 || v10 == 7)) {
            arg5.minimum_gross = arg3 - v6 + 1;
            arg5.crossed = v8;
        };
        if (v10 == 0 && v4 > 340282366920938463463374607431768211455 - v7) {
            return (0, 5, v8)
        };
        let v22 = if (v10 == 0) {
            v4 + v7
        } else {
            0
        };
        (v22, v10, v8)
    }

    public fun quote_orderbook_hop_bounded(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<OrderbookSegment>, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        if (arg3 >= 0x1::vector::length<OrderbookSegment>(arg7)) {
            let v0 = if (arg4) {
                3
            } else {
                11
            };
            return (0, v0, 0)
        };
        let v1 = effective_input(arg8, arg1, arg0);
        let v2 = 0;
        let v3 = 0;
        let v4 = arg3;
        let v5 = 0;
        while (v1 > 0 && v4 < 0x1::vector::length<OrderbookSegment>(arg7)) {
            if (*arg9 == 0) {
                return (0, 6, v5)
            };
            *arg9 = *arg9 - 1;
            let v6 = 0x1::vector::borrow<OrderbookSegment>(arg7, v4);
            let v7 = if (arg2) {
                v1
            } else {
                mul_div_down(v1, 1000000000, v6.price)
            };
            let v8 = round_down_to_quantum(v7, arg5);
            let v9 = if (v8 < v6.remaining_base) {
                v8
            } else {
                v6.remaining_base
            };
            if (v9 == 0) {
                break
            };
            let v10 = nq(v9, v6.price);
            let v11 = if (arg2) {
                v9
            } else {
                v10
            };
            if (v11 > v1) {
                return (0, 5, v5)
            };
            v1 = v1 - v11;
            let v12 = if (arg2) {
                v10
            } else {
                v9
            };
            v2 = v2 + v12;
            v3 = v3 + v9;
            if (v9 < v6.remaining_base) {
                break
            };
            v5 = v5 + 1;
            v4 = v4 + 1;
        };
        if (v4 == 0x1::vector::length<OrderbookSegment>(arg7)) {
            if (v1 > 0 && arg4) {
                return (0, 3, v5)
            };
            if (v3 < arg6) {
                let v13 = if (arg4) {
                    3
                } else {
                    7
                };
                return (0, v13, v5)
            };
        };
        if (v3 < arg6 || v2 == 0) {
            return (0, 10, v5)
        };
        (v2, 0, v5)
    }

    public fun quote_orderbook_prefix(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<OrderbookSegment>, arg8: u128, arg9: &mut u64, arg10: &mut vector<OrderbookPrefix>) : (u128, u8, u64) {
        if (arg3 >= 0x1::vector::length<OrderbookSegment>(arg7)) {
            let v0 = if (arg4) {
                3
            } else {
                11
            };
            return (0, v0, 0)
        };
        let v1 = effective_input(arg8, arg1, arg0);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        let v5 = arg3;
        let v6 = 0;
        let v7 = 0;
        let v8 = if (0x1::vector::length<OrderbookPrefix>(arg10) < *arg9) {
            0x1::vector::length<OrderbookPrefix>(arg10)
        } else {
            *arg9
        };
        let v9 = v8;
        while (v7 < v9) {
            v9 = v7 + (v9 - v7) / 2;
            if (0x1::vector::borrow<OrderbookPrefix>(arg10, v9).minimum_input <= v1) {
                v7 = v9 + 1;
                continue
            };
        };
        if (v7 > 0) {
            let v10 = 0x1::vector::borrow<OrderbookPrefix>(arg10, v7 - 1);
            v2 = v1 - v10.spent;
            v3 = v10.output;
            v4 = v10.base;
            v5 = arg3 + v7;
            v6 = v7;
            *arg9 = *arg9 - v7;
        };
        while (v2 > 0 && v5 < 0x1::vector::length<OrderbookSegment>(arg7)) {
            if (*arg9 == 0) {
                return (0, 6, v6)
            };
            *arg9 = *arg9 - 1;
            let v11 = 0x1::vector::borrow<OrderbookSegment>(arg7, v5);
            let v12 = if (arg2) {
                v2
            } else {
                mul_div_down(v2, 1000000000, v11.price)
            };
            let v13 = round_down_to_quantum(v12, arg5);
            let v14 = if (v13 < v11.remaining_base) {
                v13
            } else {
                v11.remaining_base
            };
            if (v14 == 0) {
                break
            };
            let v15 = nq(v14, v11.price);
            let v16 = if (arg2) {
                v14
            } else {
                v15
            };
            if (v16 > v2) {
                return (0, 5, v6)
            };
            let v17 = v1 - v2;
            let v18 = v2 - v16;
            v2 = v18;
            let v19 = if (arg2) {
                v15
            } else {
                v14
            };
            let v20 = v3 + v19;
            v3 = v20;
            let v21 = v4 + v14;
            v4 = v21;
            if (v14 < v11.remaining_base) {
                break
            };
            let v22 = v6 + 1;
            v6 = v22;
            v5 = v5 + 1;
            if (v22 == 0x1::vector::length<OrderbookPrefix>(arg10) + 1) {
                let v23 = if (arg2) {
                    round_up_to_quantum(v11.remaining_base, arg5)
                } else {
                    mul_div_up(round_up_to_quantum(v11.remaining_base, arg5), v11.price, 1000000000)
                };
                if (v17 <= 340282366920938463463374607431768211455 - v23) {
                    let v24 = v17 + v23;
                    let v25 = if (v22 == 1) {
                        0
                    } else {
                        0x1::vector::borrow<OrderbookPrefix>(arg10, v22 - 2).minimum_input
                    };
                    let v26 = if (v24 > v25) {
                        v24
                    } else {
                        v25
                    };
                    let v27 = OrderbookPrefix{
                        minimum_input : v26,
                        spent         : v1 - v18,
                        output        : v20,
                        base          : v21,
                    };
                    0x1::vector::push_back<OrderbookPrefix>(arg10, v27);
                    continue
                } else {
                    continue
                };
            };
        };
        if (v5 == 0x1::vector::length<OrderbookSegment>(arg7)) {
            if (v2 > 0 && arg4) {
                return (0, 3, v6)
            };
            if (v4 < arg6) {
                let v28 = if (arg4) {
                    3
                } else {
                    7
                };
                return (0, v28, v6)
            };
        };
        if (v4 < arg6 || v3 == 0) {
            return (0, 10, v6)
        };
        (v3, 0, v6)
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
            (nq(v4, v0.price), v4)
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
        let v0 = if (!arg11 || 0x1::vector::length<OrderbookSegment>(arg7) < 8) {
            if (!arg4) {
                0x1::vector::is_empty<OrderbookPrefix>(&arg10.prefixes)
            } else {
                false
            }
        } else {
            false
        };
        let (v1, v2, v3) = if (v0) {
            quote_orderbook_hop_bounded(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
        } else {
            let v4 = &mut arg10.prefixes;
            quote_orderbook_prefix(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v4)
        };
        if (v2 == 3 && arg8 > 0) {
            arg10.minimum_gross = arg8;
            arg10.crossed = v3;
        };
        (v1, v2, v3)
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

    public fun quote_v3_cached(arg0: &vector<TickBoundary>, arg1: &mut V3PrefixCache, arg2: u128, arg3: &mut u64) : (u128, u8, u64) {
        if (arg1.status != 0) {
            if (arg1.status == 13) {
                arg1.status = 0;
                let (v0, v1, v2) = quote_v3_cached(arg0, arg1, arg2, arg3);
                if (arg1.status == 0) {
                    arg1.status = 13;
                };
                return (v0, v1, 0x1::u64::min(v2, arg1.real_boundary_limit))
            };
            return (0, arg1.status, 0)
        };
        if (arg2 == 0) {
            return (0, 0, 0)
        };
        let v3 = 0x1::vector::length<TickBoundary>(arg0) - arg1.boundary_cursor;
        if (v3 == 0) {
            return (0, 3, 0)
        };
        if (*arg3 == 0) {
            return (0, 6, 0)
        };
        extend_v3_prefix_cache(arg0, arg1, arg2, v3);
        if (arg1.status != 0) {
            return (0, arg1.status, 0)
        };
        let v4 = 0x1::vector::length<V3Prefix>(&arg1.prefixes);
        if (v4 == 0) {
            return (0, 3, 0)
        };
        let (v5, v6) = prefix_upper_bound_virtual(&arg1.prefixes, v3, arg2, arg3);
        if (v6 != 0) {
            return (0, v6, v5)
        };
        let (v7, v8, v9, v10) = if (v5 == 0) {
            (0, 0, arg1.sqrt_price_x64, arg1.liquidity)
        } else {
            let v11 = 0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v5 - 1);
            (v11.cumulative_input, v11.cumulative_output, v11.end_sqrt_price_x64, v11.liquidity_after)
        };
        let v12 = if (arg1.policy_stop_at_zero_liquidity || arg1.reject_empty_endpoint) {
            if (v5 > 0) {
                v10 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v12) {
            return (0, 7, v5)
        };
        if (arg2 == v7) {
            return (v8, 0, v5)
        };
        if (v8 > arg1.policy_output_capacity) {
            return (0, 7, v5)
        };
        if (v5 == v4 || v10 == 0) {
            return (0, 3, v5)
        };
        if (*arg3 == 0) {
            return (0, 6, v5)
        };
        *arg3 = *arg3 - 1;
        let (_, v14) = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::v3_partial_tail(v9, v10, arg1.zero_for_one, arg2 - v7, arg1.fee_rate, arg1.fee_denominator);
        let (v15, v16) = if (v8 > 340282366920938463463374607431768211455 - v14) {
            (0, 5)
        } else {
            (v8 + v14, 0)
        };
        (v15, v16, v5)
    }

    public fun quote_v3_cached_with_slope(arg0: &vector<TickBoundary>, arg1: &mut V3PrefixCache, arg2: u128, arg3: &mut u64) : (u128, u256, u8, u64) {
        if (arg1.status != 0) {
            if (arg1.status == 13) {
                arg1.status = 0;
                let (v0, v1, v2, v3) = quote_v3_cached_with_slope(arg0, arg1, arg2, arg3);
                if (arg1.status == 0) {
                    arg1.status = 13;
                };
                return (v0, v1, v2, 0x1::u64::min(v3, arg1.real_boundary_limit))
            };
            return (0, 0, arg1.status, 0)
        };
        if (arg2 == 0) {
            return (0, h6(arg1.sqrt_price_x64, arg1.zero_for_one), 0, 0)
        };
        let v4 = 0x1::vector::length<TickBoundary>(arg0) - arg1.boundary_cursor;
        if (v4 == 0) {
            return (0, 0, 3, 0)
        };
        if (*arg3 == 0) {
            return (0, 0, 6, 0)
        };
        extend_v3_prefix_cache(arg0, arg1, arg2, v4);
        if (arg1.status != 0) {
            return (0, 0, arg1.status, 0)
        };
        let v5 = 0x1::vector::length<V3Prefix>(&arg1.prefixes);
        if (v5 == 0) {
            return (0, 0, 3, 0)
        };
        let (v6, v7) = prefix_upper_bound_virtual(&arg1.prefixes, v4, arg2, arg3);
        if (v7 != 0) {
            return (0, 0, v7, v6)
        };
        let (v8, v9, v10, v11) = if (v6 == 0) {
            (0, 0, arg1.sqrt_price_x64, arg1.liquidity)
        } else {
            let v12 = 0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v6 - 1);
            (v12.cumulative_input, v12.cumulative_output, v12.end_sqrt_price_x64, v12.liquidity_after)
        };
        let v13 = if (arg1.policy_stop_at_zero_liquidity || arg1.reject_empty_endpoint) {
            if (v6 > 0) {
                v11 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v13) {
            return (0, 0, 7, v6)
        };
        if (arg2 == v8) {
            return (v9, h6(v10, arg1.zero_for_one), 0, v6)
        };
        if (v9 > arg1.policy_output_capacity) {
            return (0, 0, 7, v6)
        };
        if (v6 == v5 || v11 == 0) {
            return (0, 0, 3, v6)
        };
        if (*arg3 == 0) {
            return (0, 0, 6, v6)
        };
        *arg3 = *arg3 - 1;
        let (v14, v15) = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::v3_partial_tail(v10, v11, arg1.zero_for_one, arg2 - v8, arg1.fee_rate, arg1.fee_denominator);
        let (v16, v17, v18) = if (v9 > 340282366920938463463374607431768211455 - v15) {
            (5, 0, 0)
        } else {
            (0, v9 + v15, h6(v14, arg1.zero_for_one))
        };
        (v17, v18, v16, v6)
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
                v1 = mul_q64_ceil(v1, e7(v3));
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
            let (v5, v6) = liquidity_after_boundary(v1, &v4, arg1.zero_for_one);
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

    public fun route_model(arg0: &vector<Hop>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            let v3 = if (v2.kind == 3) {
                if (v2.output_fee_denominator == 10000) {
                    v2.policy.linear_rate_inversion
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                return 1
            };
            if (v2.policy.linear_rate_inversion) {
                v0 = 2;
            } else {
                let v4 = if (v2.kind != 0) {
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
                if (v4) {
                    return 1
                };
            };
            v1 = v1 + 1;
        };
        v0
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

    // decompiled from Move bytecode v7
}

