module 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows {
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

    struct V3ReadDemand has copy, drop {
        exact: bool,
        remaining_gross: u128,
        sqrt_price_x64: u128,
        liquidity: u128,
        fee_rate: u64,
        fee_denominator: u64,
        reject_empty_endpoint: bool,
    }

    struct V3PrefixCache has drop {
        prefixes: vector<V3Prefix>,
        numeric: vector<u256>,
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
        lot_input: u128,
        lot_left: u128,
        lot_next: u128,
        capture_lots: bool,
    }

    struct BookReadDemand has copy, drop {
        exact: bool,
        remaining_effective: u128,
    }

    public fun cap_inverse_v3(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: &TickBoundary, arg6: u128) : (u128, bool) {
        0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::cap_inverse_v3(arg0, arg1, arg2, arg3, arg4, arg5.sqrt_price_x64, arg6)
    }

    public fun clmm_input_boundary(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: &TickBoundary) : u128 {
        0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::clmm_input_boundary(arg0, arg1, arg2, arg3, arg4, arg5.sqrt_price_x64)
    }

    public fun liquidity_after_boundary(arg0: u128, arg1: &TickBoundary, arg2: bool) : (u128, bool) {
        0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::liquidity_after_boundary(arg0, arg1.negative, arg1.liquidity_net_abs, arg2)
    }

    public fun a1(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: bool) : LinearSegment {
        if (arg3 >= 9223372036854775808) {
            let v0 = arg3 - 9223372036854775808;
            return LinearSegment{
                remaining_input  : arg0,
                remaining_output : arg1,
                price_x64        : arg2,
                fee_rate         : v0 & 255 | (v0 >> 8 & 65535) << 8,
                fee_denominator  : v0 >> 24,
                forward          : arg4,
                exact_dlmm       : false,
                price_scale      : 18446744073709551616,
            }
        };
        dlmm_segment(arg0, arg1, arg2, arg3, arg4)
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
        let (v2, v3) = quote_orderbook_segment_and_consumed_base(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
        let v4 = 0x1::vector::borrow_mut<OrderbookSegment>(arg6, arg3);
        v4.remaining_base = v4.remaining_base - v3;
        if (v4.remaining_base == 0) {
            arg3 = arg3 + 1;
            v1 = v0 + 1;
        };
        (v2, arg2 + v3, arg3, v1)
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
        (true, 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::saturating_add((v0.remaining_output as u256), 2), 0)
    }

    public fun apply_boundary_liquidity(arg0: &mut u128, arg1: bool, arg2: TickBoundary) {
        if (arg1 && !arg2.negative || arg2.negative) {
            *arg0 = *arg0 - arg2.liquidity_net_abs;
        } else {
            *arg0 = *arg0 + arg2.liquidity_net_abs;
        };
    }

    public fun book_buy_segments(arg0: u128, arg1: u128, arg2: u128, arg3: &vector<OrderbookSegment>, arg4: u64, arg5: u128, arg6: u128, arg7: &vector<u128>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (arg4 < 0x1::vector::length<OrderbookSegment>(arg3)) {
            let v2 = 0x1::vector::borrow<OrderbookSegment>(arg3, arg4);
            let v3 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_down(arg0, 1000000000, v2.price) / arg1 * arg1;
            if (v3 < v2.remaining_base) {
                let v4 = if (v3 == 0) {
                    true
                } else if (0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::book_buy_add_base(v1, v3) < arg2) {
                    true
                } else {
                    (v2.price as u256) * (arg1 as u256) % 1000000000 != 0
                };
                if (v4) {
                    return arg0
                };
                let v5 = v0 + 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_up(v3, v2.price, 1000000000);
                if (v5 < arg5 || v5 % arg6 != 0) {
                    return arg0
                };
                let v6 = 0;
                let v7 = 0x1::vector::length<u128>(arg7);
                while (v6 < v7) {
                    v7 = v6 + (v7 - v6) / 2;
                    if (*0x1::vector::borrow<u128>(arg7, v7) < v5) {
                        v6 = v7 + 1;
                        continue
                    };
                };
                return if (v6 < 0x1::vector::length<u128>(arg7) && *0x1::vector::borrow<u128>(arg7, v6) == v5) {
                    arg0
                } else {
                    v5
                }
            };
            let v9 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_down(v2.remaining_base, v2.price, 1000000000);
            arg0 = arg0 - v9;
            v0 = v0 + v9;
            v1 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::book_buy_add_base(v1, v2.remaining_base);
            arg4 = arg4 + 1;
        };
        arg0
    }

    public fun book_lot_bounds(arg0: &OrderbookShortfall, arg1: u64, arg2: u64) : (u128, u128, u128) {
        if (arg1 == 0) {
            (arg0.lot_input, arg0.lot_left, arg0.lot_next)
        } else {
            (arg0.lot_input, 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::gross_from_effective(arg0.lot_left, arg1, arg2), 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::gross_from_effective(arg0.lot_next, arg1, arg2))
        }
    }

    public fun book_lot_input(arg0: &OrderbookShortfall) : u128 {
        arg0.lot_input
    }

    public fun book_read_demand_from_shortfall(arg0: &OrderbookShortfall, arg1: u128, arg2: u64, arg3: u64) : BookReadDemand {
        let v0 = if (arg2 == 0) {
            arg1
        } else {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::model_effective_input(arg1, arg2, arg3)
        };
        let v1 = if (0x1::vector::is_empty<OrderbookPrefix>(&arg0.prefixes)) {
            0
        } else {
            0x1::vector::borrow<OrderbookPrefix>(&arg0.prefixes, 0x1::vector::length<OrderbookPrefix>(&arg0.prefixes) - 1).spent
        };
        BookReadDemand{
            exact               : true,
            remaining_effective : v0 - v1,
        }
    }

    public fun book_read_demand_is_covered(arg0: &BookReadDemand) : bool {
        arg0.exact && arg0.remaining_effective == 0
    }

    public fun book_read_demand_step(arg0: &mut BookReadDemand, arg1: bool, arg2: u128, arg3: u128, arg4: u128) : bool {
        if (!arg0.exact || arg0.remaining_effective == 0) {
            return true
        };
        let v0 = if (arg1) {
            arg0.remaining_effective
        } else {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::mul_div_down(arg0.remaining_effective, 1000000000, arg2)
        };
        let v1 = 0x1::u128::min(0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_down_to_quantum(v0, arg4), arg3);
        let v2 = if (arg1) {
            v1
        } else {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::model_nq(v1, arg2)
        };
        arg0.remaining_effective = arg0.remaining_effective - v2;
        v1 < arg3 || arg0.remaining_effective == 0
    }

    public fun borrow_LinearPrefix_output(arg0: &LinearPrefix) : &u128 {
        &arg0.output
    }

    public fun borrow_LinearPrefix_spent(arg0: &LinearPrefix) : &u128 {
        &arg0.spent
    }

    public fun borrow_LinearSegment_exact_dlmm(arg0: &LinearSegment) : &bool {
        &arg0.exact_dlmm
    }

    public fun borrow_LinearSegment_fee_denominator(arg0: &LinearSegment) : &u64 {
        &arg0.fee_denominator
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

    public fun borrow_LinearSegment_remaining_output(arg0: &LinearSegment) : &u128 {
        &arg0.remaining_output
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

    public fun borrow_OrderbookShortfall_linear_prefixes(arg0: &OrderbookShortfall) : &vector<LinearPrefix> {
        &arg0.linear_prefixes
    }

    public fun borrow_OrderbookShortfall_minimum_gross(arg0: &OrderbookShortfall) : &u128 {
        &arg0.minimum_gross
    }

    public fun borrow_TickBoundary_sqrt_price_x64(arg0: &TickBoundary) : &u128 {
        &arg0.sqrt_price_x64
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

    public fun borrow_mut_LinearSegment_price_scale(arg0: &mut LinearSegment) : &mut u128 {
        &mut arg0.price_scale
    }

    public fun borrow_mut_OrderbookShortfall_crossed(arg0: &mut OrderbookShortfall) : &mut u64 {
        &mut arg0.crossed
    }

    public fun borrow_mut_OrderbookShortfall_minimum_gross(arg0: &mut OrderbookShortfall) : &mut u128 {
        &mut arg0.minimum_gross
    }

    public fun borrow_mut_V3PrefixCache_liquidity(arg0: &mut V3PrefixCache) : &mut u128 {
        &mut arg0.liquidity
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

    public fun cap_inverse_linear(arg0: u64, arg1: u64, arg2: u64, arg3: &vector<LinearSegment>, arg4: u128) : (u128, bool) {
        let v0 = current_linear_segment(arg2, arg3);
        if (arg4 > v0.remaining_output) {
            return (0, false)
        };
        (0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::gross_from_effective(0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_up(arg4, v0.remaining_input, v0.remaining_output), arg1, arg0), true)
    }

    public fun cap_inverse_orderbook(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u128, arg5: &vector<OrderbookSegment>, arg6: u128) : (u128, bool) {
        let v0 = current_orderbook_segment(arg3, arg5);
        if (arg6 > orderbook_segment_output_capacity(arg2, v0)) {
            return (0, false)
        };
        let v1 = if (arg2) {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_up_to_quantum(0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_up(arg6, 1000000000, v0.price), arg4)
        } else {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_up(0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_up_to_quantum(arg6, arg4), v0.price, 1000000000)
        };
        (0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::gross_from_effective(v1, arg1, arg0), true)
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
            (current_orderbook_segment(arg2, arg4).price as u256) * 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::q64() / 1000000000
        } else {
            1000000000 * 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::q64() / (current_orderbook_segment(arg2, arg4).price as u256)
        }
    }

    public fun cap_segment_quote_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<OrderbookSegment>, arg6: u128) : u128 {
        quote_orderbook_segment(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
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
        0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::div_ceil(v1, v2)
    }

    public fun cap_upper_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: &vector<OrderbookSegment>) : u256 {
        if (orderbook_terminal(arg0, arg2, arg3, arg4)) {
            return 0
        };
        if (arg1) {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::div_ceil((current_orderbook_segment(arg2, arg4).price as u256) * 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::q64(), 1000000000)
        } else {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::div_ceil(1000000000 * 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::q64(), (current_orderbook_segment(arg2, arg4).price as u256))
        }
    }

    public fun current_linear_segment(arg0: u64, arg1: &vector<LinearSegment>) : &LinearSegment {
        0x1::vector::borrow<LinearSegment>(arg1, arg0)
    }

    public fun current_orderbook_segment(arg0: u64, arg1: &vector<OrderbookSegment>) : &OrderbookSegment {
        0x1::vector::borrow<OrderbookSegment>(arg1, arg0)
    }

    public fun d7(arg0: &LinearSegment) : u256 {
        0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::div_ceil((arg0.price_x64 as u256) * ((10000 + (arg0.fee_rate >> 8 & 65535)) as u256), 10000)
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
                (v7.remaining_output as u256) * 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::q64() / (v7.remaining_input as u256)
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
                let v14 = (v11.remaining_output as u256) * 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::q64() / (v11.remaining_input as u256);
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

    public fun l3(arg0: &mut vector<TickBoundary>, arg1: &vector<u128>, arg2: &vector<u128>, arg3: &vector<bool>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(arg1)) {
            0x1::vector::push_back<TickBoundary>(arg0, tick_boundary(*0x1::vector::borrow<u128>(arg1, v0), *0x1::vector::borrow<u128>(arg2, v0), *0x1::vector::borrow<bool>(arg3, v0)));
            v0 = v0 + 1;
        };
    }

    public fun linear_input_boundary(arg0: u64, arg1: &vector<LinearSegment>) : u128 {
        current_linear_segment(arg0, arg1).remaining_input
    }

    public fun linear_marginal_fraction(arg0: &LinearSegment) : (u256, u256) {
        if (!arg0.exact_dlmm) {
            return ((arg0.remaining_output as u256) * 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::q64(), (arg0.remaining_input as u256))
        };
        if (arg0.forward) {
            ((arg0.price_x64 as u256) * ((arg0.fee_denominator - arg0.fee_rate) as u256) * 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::q64(), (arg0.fee_denominator as u256) * (arg0.price_scale as u256))
        } else {
            (0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::q64() * (arg0.price_scale as u256) * ((arg0.fee_denominator - arg0.fee_rate) as u256), (arg0.price_x64 as u256) * (arg0.fee_denominator as u256))
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

    public fun model_advance_segment_v3(arg0: &vector<TickBoundary>, arg1: u64, arg2: u128, arg3: bool, arg4: u128, arg5: bool, arg6: u128) : (u128, u128, u128, u64, u64) {
        let v0 = 0;
        let v1 = v0;
        let v2 = *0x1::vector::borrow<TickBoundary>(arg0, arg1);
        let (v3, v4) = if (arg6 == 0) {
            let v3 = arg4;
            (v3, 0)
        } else {
            let v5 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::next_sqrt_price(arg2, arg3, arg4, arg5, arg6, v2.sqrt_price_x64);
            let v6 = if (arg5) {
                0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::mul_div_down(arg2, arg4 - v5, 18446744073709551616)
            } else {
                0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::amount0_delta_down(arg4, v5, arg2)
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

    public fun model_cap_segment_quote_v3(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: &TickBoundary, arg5: u128) : u128 {
        0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::cap_segment_quote_v3(arg0, arg1, arg2, arg3, arg4.sqrt_price_x64, arg5)
    }

    public fun model_extend_v3_prefix_cache(arg0: &vector<TickBoundary>, arg1: &mut V3PrefixCache, arg2: u128, arg3: u64, arg4: &mut u64) : (u64, u8) {
        let v0 = 0x1::vector::length<V3Prefix>(&arg1.prefixes);
        if (v0 == arg3) {
            return (0, 0)
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
        let v10 = if (v0 > 0) {
            if (0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v0 - 1).crossing_input > arg2) {
                true
            } else if (0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v0 - 1).cumulative_input == arg2 && (!arg1.reject_empty_endpoint || v4 > 0)) {
                true
            } else {
                arg1.policy_stop_at_zero_liquidity && v4 == 0
            }
        } else {
            false
        };
        if (v10) {
            return (0, 0)
        };
        let v11 = arg1.boundary_cursor + v0;
        let v12 = v11;
        while (v12 < arg1.boundary_cursor + arg3) {
            if (*arg4 == 0) {
                return (v12 - v11, 6)
            };
            *arg4 = *arg4 - 1;
            let v13 = *0x1::vector::borrow<TickBoundary>(arg0, v12);
            let v14 = if (v6 == 0) {
                0
            } else if (arg1.zero_for_one) {
                0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::amount0_delta_up(v7, v13.sqrt_price_x64, v6)
            } else {
                0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_up(v6, v13.sqrt_price_x64 - v7, 18446744073709551616)
            };
            let (v15, v16) = v3_fee_input(v14, arg1.fee_rate, arg1.fee_denominator, arg1.momentum_fee_round_nearest);
            let v17 = if (v6 == 0) {
                0
            } else if (arg1.zero_for_one) {
                0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::mul_div_down(v6, v7 - v13.sqrt_price_x64, 18446744073709551616)
            } else {
                0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::amount0_delta_down(v7, v13.sqrt_price_x64, v6)
            };
            if (v9 > 340282366920938463463374607431768211455 - v15 || v8 > 340282366920938463463374607431768211455 - v17) {
                arg1.status = 5;
                return (v12 - v11 + 1, arg1.status)
            };
            let v18 = v9 + v15;
            let v19 = v9 + v16;
            v9 = v19;
            let v20 = v8 + v17;
            v8 = v20;
            let v21 = if (arg1.zero_for_one != v13.negative) {
                v6 - v13.liquidity_net_abs
            } else {
                v6 + v13.liquidity_net_abs
            };
            v6 = v21;
            let v22 = v13.sqrt_price_x64;
            v7 = v22;
            let v23 = V3Prefix{
                cumulative_input   : v19,
                crossing_input     : v18,
                cumulative_output  : v20,
                end_sqrt_price_x64 : v22,
                liquidity_after    : v21,
            };
            0x1::vector::push_back<V3Prefix>(&mut arg1.prefixes, v23);
            v12 = v12 + 1;
            let v24 = if (v18 > arg2) {
                true
            } else if (v19 == arg2 && (!arg1.reject_empty_endpoint || v21 > 0)) {
                true
            } else {
                arg1.policy_stop_at_zero_liquidity && v21 == 0
            };
            if (v24) {
                break
            };
        };
        (v12 - v11, 0)
    }

    public fun model_i4(arg0: u64, arg1: &mut vector<LinearSegment>, arg2: u128) : (u128, u64) {
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

    public fun model_quote_orderbook_hop_bounded(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<OrderbookSegment>, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        if (arg3 >= 0x1::vector::length<OrderbookSegment>(arg7)) {
            let v0 = if (arg4) {
                3
            } else {
                11
            };
            return (0, v0, 0)
        };
        let v1 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::model_effective_input(arg8, arg1, arg0);
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
                0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::mul_div_down(v1, 1000000000, v6.price)
            };
            let v8 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_down_to_quantum(v7, arg5);
            let v9 = if (v8 < v6.remaining_base) {
                v8
            } else {
                v6.remaining_base
            };
            if (v9 == 0) {
                break
            };
            let v10 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::model_nq(v9, v6.price);
            let v11 = if (arg2) {
                v9
            } else {
                v10
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
                    10
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

    public fun model_quote_orderbook_prefix(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<OrderbookSegment>, arg8: u128, arg9: &mut u64, arg10: &mut vector<OrderbookPrefix>) : (u128, u8, u64) {
        let (v0, v1, v2, _, _) = quote_orderbook_lot_prefix(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, true, false);
        (v0, v1, v2)
    }

    public fun model_quote_steamm_omm_v2_prepared(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u128, arg9: u64, arg10: u128, arg11: u128, arg12: u64, arg13: bool, arg14: bool, arg15: u128, arg16: &mut u64, arg17: &mut V3PrefixCache) : (u128, u8, u64) {
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
        let (v0, v1) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_btoken_supplies(arg8);
        let v2 = (arg15 as u256) * (v0 as u256) * 1000000000000000000 / (arg10 as u256);
        if (v2 == 0) {
            return (0, 10, 0)
        };
        if (v2 > ((18446744073709551615 - (v0 as u128)) as u256)) {
            return (0, 12, 0)
        };
        let v3 = ((arg10 as u256) + (arg15 as u256) * 1000000000000000000) / ((v0 as u256) + v2);
        if (0x1::vector::is_empty<u256>(&arg17.numeric)) {
            let v4 = (arg11 as u256) / (v1 as u256);
            let v5 = if (arg13) {
                arg5
            } else {
                arg4
            };
            let (v6, v7) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_q_from_decimal((v5 as u256) * v4);
            if (!v7) {
                return (0, 5, 0)
            };
            let (v8, v9) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_q_from_decimal((arg0 as u256));
            let (v10, v11) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_q_from_decimal((arg1 as u256));
            if (!v9 || !v11) {
                return (0, 5, 0)
            };
            let v12 = (arg7 as u8);
            let v13 = (arg9 as u8);
            let v14 = if (v12 >= v13) {
                v12 - v13
            } else {
                v13 - v12
            };
            let v15 = 1;
            let v16 = 0;
            while (v16 < v14) {
                v15 = v15 * 10;
                v16 = v16 + 1;
            };
            let (v17, v18) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_q_from_integer(v15);
            if (!v18) {
                return (0, 5, 0)
            };
            let v19 = if (v12 >= v13) {
                v17
            } else {
                let (v20, v21) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_q_div(18446744073709551616, v17);
                if (!v21) {
                    return (0, 5, 0)
                };
                v20
            };
            arg17.liquidity = v8;
            arg17.sqrt_price_x64 = v10;
            arg17.policy_output_capacity = v19;
            let v22 = 0x1::vector::empty<u256>();
            let v23 = &mut v22;
            0x1::vector::push_back<u256>(v23, (v6 as u256));
            0x1::vector::push_back<u256>(v23, (v15 as u256));
            0x1::vector::push_back<u256>(v23, v4);
            arg17.numeric = v22;
        };
        let v24 = *0x1::vector::borrow<u256>(&arg17.numeric, 2);
        if (v3 == 0 || v24 == 0) {
            return (0, 5, 0)
        };
        let v25 = (*0x1::vector::borrow<u256>(&arg17.numeric, 0) as u128);
        let (v26, v27) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_q_from_decimal(v2 * v3);
        if (!v27) {
            return (0, 5, 0)
        };
        let v28 = if (arg12 == 50) {
            true
        } else if (arg12 == 100) {
            true
        } else {
            arg14
        };
        let v29 = if (v28) {
            arg12
        } else {
            let v30 = if (arg13) {
                v3
            } else {
                v24
            };
            let v31 = if (arg13) {
                v24
            } else {
                v3
            };
            let (v32, v33) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_effective_amp(arg12, false, (arg4 as u256) * v30, (arg5 as u256) * v31, arg0, arg1, (arg7 as u8), (arg9 as u8));
            if (!v33) {
                return (0, 12, 0)
            };
            v32
        };
        let (v34, v35) = if (arg13) {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_q_multiply_divide(v26, arg17.liquidity, v25, arg17.sqrt_price_x64, arg17.policy_output_capacity, false)
        } else {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_q_multiply_divide(v26, arg17.policy_output_capacity, arg17.sqrt_price_x64, v25, arg17.liquidity, true)
        };
        if (!v35) {
            return (0, 5, 0)
        };
        let (v36, v37) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_q_newton(v34, (v29 as u128) << 64);
        if (!v37) {
            return (0, 5, 0)
        };
        let (v38, v39) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_q_mul(v36, v25);
        if (!v39) {
            return (0, 5, 0)
        };
        let v40 = ((v38 >> 64) as u256) * 1000000000000000000 / v24;
        let v41 = if (arg13) {
            arg5
        } else {
            arg4
        };
        if (v40 == 0) {
            return (0, 10, 0)
        };
        if (v40 >= (v41 as u256)) {
            return (0, 7, 0)
        };
        let v42 = if (arg13) {
            (arg0 as u256)
        } else {
            (arg1 as u256)
        };
        let v43 = if (arg13) {
            (arg1 as u256)
        } else {
            (arg0 as u256)
        };
        let v44 = arg13 && arg7 > arg9 || arg9 > arg7;
        let (v45, v46) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_omm_v2_linear_with_scale(v42, v43, v44, *0x1::vector::borrow<u256>(&arg17.numeric, 1), v2, v3, v24);
        if (!v46 || v40 > v45) {
            return (0, 12, 0)
        };
        if (v40 == v45) {
            return (0, 10, 0)
        };
        let v47 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::div_ceil(v40 * (arg3 as u256), (arg2 as u256));
        if (v47 >= v40) {
            return (0, 10, 0)
        };
        let v48 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::steamm_btoken_burn_amount(v40 - v47, v1);
        if (v48 == 0) {
            return (0, 10, 0)
        };
        let v49 = v48 * (arg11 as u256) / (v1 as u256) * 1000000000000000000;
        if (v49 > (18446744073709551615 as u256)) {
            return (0, 12, 0)
        };
        if (v49 > (arg6 as u256)) {
            return (0, 7, 0)
        };
        ((v49 as u128), 0, 0)
    }

    public fun model_quote_v3_cached(arg0: &vector<TickBoundary>, arg1: &mut V3PrefixCache, arg2: u128, arg3: &mut u64) : (u128, u8, u64) {
        if (arg1.status != 0) {
            if (arg1.status == 13) {
                arg1.status = 0;
                let (v0, v1, v2) = model_quote_v3_cached(arg0, arg1, arg2, arg3);
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
        let (_, v5) = model_extend_v3_prefix_cache(arg0, arg1, arg2, v3, arg3);
        if (v5 != 0) {
            return (0, v5, 0x1::vector::length<V3Prefix>(&arg1.prefixes))
        };
        let v6 = 0x1::vector::length<V3Prefix>(&arg1.prefixes);
        let (v7, v8) = prefix_upper_bound_materialized(&arg1.prefixes, v6, arg2, arg3);
        if (v8 != 0) {
            return (0, v8, v7)
        };
        let (v9, v10, v11, v12) = if (v7 == 0) {
            (0, 0, arg1.sqrt_price_x64, arg1.liquidity)
        } else {
            let v13 = 0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v7 - 1);
            (v13.cumulative_input, v13.cumulative_output, v13.end_sqrt_price_x64, v13.liquidity_after)
        };
        let v14 = if (arg1.policy_stop_at_zero_liquidity || arg1.reject_empty_endpoint) {
            if (v7 > 0) {
                v12 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v14) {
            return (0, 7, v7)
        };
        if (arg2 == v9) {
            return (v10, 0, v7)
        };
        if (v10 > arg1.policy_output_capacity) {
            return (0, 7, v7)
        };
        if (v7 == v6 || v12 == 0) {
            return (0, 3, v7)
        };
        if (*arg3 == 0) {
            return (0, 6, v7)
        };
        *arg3 = *arg3 - 1;
        let (_, v16) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::v3_partial_tail(v11, v12, arg1.zero_for_one, arg2 - v9, arg1.fee_rate, arg1.fee_denominator);
        let (v17, v18) = if (v10 > 340282366920938463463374607431768211455 - v16) {
            (0, 5)
        } else {
            (v10 + v16, 0)
        };
        (v17, v18, v7)
    }

    public fun new_OrderbookShortfall(arg0: vector<LinearPrefix>, arg1: vector<OrderbookPrefix>, arg2: u128, arg3: u64) : OrderbookShortfall {
        OrderbookShortfall{
            linear_prefixes : arg0,
            prefixes        : arg1,
            minimum_gross   : arg2,
            crossed         : arg3,
            lot_input       : 0,
            lot_left        : 0,
            lot_next        : 0,
            capture_lots    : false,
        }
    }

    public fun new_book_read_demand(arg0: bool, arg1: u128) : BookReadDemand {
        BookReadDemand{
            exact               : arg0,
            remaining_effective : arg1,
        }
    }

    public fun new_prefixCache(arg0: vector<V3Prefix>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: bool, arg10: bool) : V3PrefixCache {
        V3PrefixCache{
            prefixes                      : arg0,
            numeric                       : vector[],
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
            lot_input       : 0,
            lot_left        : 0,
            lot_next        : 0,
            capture_lots    : false,
        }
    }

    public fun new_v3_read_demand(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: bool) : V3ReadDemand {
        V3ReadDemand{
            exact                 : arg0,
            remaining_gross       : arg1,
            sqrt_price_x64        : arg2,
            liquidity             : arg3,
            fee_rate              : arg4,
            fee_denominator       : arg5,
            reject_empty_endpoint : arg6,
        }
    }

    public fun orderbook_input_boundary(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: &vector<OrderbookSegment>) : u128 {
        let v0 = current_orderbook_segment(arg3, arg4);
        let v1 = if (arg2) {
            v0.remaining_base
        } else {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_up(v0.remaining_base, v0.price, 1000000000)
        };
        0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::gross_from_effective(v1, arg1, arg0)
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
            let v2 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_down_to_quantum(arg6, arg4);
            if (v2 < v0.remaining_base) {
                v2
            } else {
                v0.remaining_base
            }
        } else {
            let v3 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_down_to_quantum(0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::mul_div_down(arg6, 1000000000, v0.price), arg4);
            if (v3 < v0.remaining_base) {
                v3
            } else {
                v0.remaining_base
            }
        }
    }

    public fun orderbook_segment_output_capacity(arg0: bool, arg1: &OrderbookSegment) : u128 {
        if (arg0) {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::model_nq(arg1.remaining_base, arg1.price)
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

    fun prefix_upper_bound_materialized(arg0: &vector<V3Prefix>, arg1: u64, arg2: u128, arg3: &mut u64) : (u64, u8) {
        let v0 = *arg3;
        if (arg1 <= 8) {
            let v1 = 0;
            while (v1 < arg1) {
                if (v0 == 0) {
                    *arg3 = 0;
                    return (v1, 6)
                };
                v0 = v0 - 1;
                if (0x1::vector::borrow<V3Prefix>(arg0, v1).crossing_input > arg2) {
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
            if (0x1::vector::borrow<V3Prefix>(arg0, v3).crossing_input <= arg2) {
                v2 = v3 + 1;
                continue
            };
            arg1 = v3;
        };
        *arg3 = v0;
        (v2, 0)
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

    public fun prepare_v3_window(arg0: &mut V3PrefixCache, arg1: u128) {
        if (arg1 > 0) {
            let v0 = ((arg1 - 1) as u64);
            arg0.real_boundary_limit = v0 - 0x1::u64::min(arg0.boundary_cursor, v0);
        };
        if (arg0.status == 0 && arg0.real_boundary_limit != 18446744073709551615) {
            arg0.status = 13;
        };
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
                (0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::model_effective_input(arg1, arg0.fee_rate, arg0.fee_denominator) as u256) * (arg0.price_x64 as u256) / (arg0.price_scale as u256)
            } else {
                (0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::model_effective_input(arg1, arg0.fee_rate, arg0.fee_denominator) as u256) * (arg0.price_scale as u256) / (arg0.price_x64 as u256)
            };
            let v2 = if (v1 > (arg0.remaining_output as u256)) {
                (arg0.remaining_output as u256)
            } else {
                v1
            };
            (v2 as u128)
        } else if (arg0.price_x64 > 0) {
            let v3 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::mul_div_down(arg1, arg0.price_x64, 18446744073709551616);
            let v4 = (arg0.fee_denominator as u128);
            let v5 = if (v3 > v4) {
                v3 - v4
            } else {
                0
            };
            0x1::u128::min(v5, arg0.remaining_output)
        } else {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::mul_div_down(arg1, arg0.remaining_output, arg0.remaining_input)
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

    fun quote_orderbook_lot_prefix(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<OrderbookSegment>, arg8: u128, arg9: &mut u64, arg10: &mut vector<OrderbookPrefix>, arg11: bool, arg12: bool) : (u128, u8, u64, u128, u128) {
        if (arg3 >= 0x1::vector::length<OrderbookSegment>(arg7)) {
            let v0 = if (arg4) {
                3
            } else {
                11
            };
            return (0, v0, 0, 0, 0)
        };
        let v1 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::model_effective_input(arg8, arg1, arg0);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        let v5 = arg3;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = if (0x1::vector::length<OrderbookPrefix>(arg10) < *arg9) {
            0x1::vector::length<OrderbookPrefix>(arg10)
        } else {
            *arg9
        };
        let v12 = v11;
        while (v10 < v12) {
            v12 = v10 + (v12 - v10) / 2;
            if (0x1::vector::borrow<OrderbookPrefix>(arg10, v12).minimum_input <= v1) {
                v10 = v12 + 1;
                continue
            };
        };
        if (v10 > 0) {
            let v13 = 0x1::vector::borrow<OrderbookPrefix>(arg10, v10 - 1);
            v2 = v1 - v13.spent;
            v3 = v13.output;
            v4 = v13.base;
            v5 = arg3 + v10;
            v6 = v10;
            v9 = v13.minimum_input;
            *arg9 = *arg9 - v10;
        };
        while (v2 > 0 && v5 < 0x1::vector::length<OrderbookSegment>(arg7)) {
            if (*arg9 == 0) {
                return (0, 6, v6, 0, 0)
            };
            *arg9 = *arg9 - 1;
            let v14 = 0x1::vector::borrow<OrderbookSegment>(arg7, v5);
            let v15 = if (arg2) {
                v2
            } else {
                0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::mul_div_down(v2, 1000000000, v14.price)
            };
            let v16 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_down_to_quantum(v15, arg5);
            let v17 = if (v16 < v14.remaining_base) {
                v16
            } else {
                v14.remaining_base
            };
            if (arg12 && v17 < v14.remaining_base) {
                let v18 = v1 - v2;
                let v19 = if (arg2) {
                    v17
                } else {
                    0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_up(v17, v14.price, 1000000000)
                };
                let v20 = if (arg2) {
                    v17 + arg5
                } else {
                    0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_up(v17 + arg5, v14.price, 1000000000)
                };
                v7 = 0x1::u128::max(v18 + v19, v9);
                v8 = 0x1::u128::max(v18 + v20, v9);
            };
            if (v17 == 0) {
                break
            };
            let v21 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::model_nq(v17, v14.price);
            let v22 = if (arg2) {
                v17
            } else {
                v21
            };
            let v23 = v1 - v2;
            let v24 = v2 - v22;
            v2 = v24;
            let v25 = if (arg2) {
                v21
            } else {
                v17
            };
            let v26 = v3 + v25;
            v3 = v26;
            let v27 = v4 + v17;
            v4 = v27;
            if (v17 < v14.remaining_base) {
                break
            };
            let v28 = v6 + 1;
            v6 = v28;
            v5 = v5 + 1;
            let v29 = arg11 && v28 == 0x1::vector::length<OrderbookPrefix>(arg10) + 1;
            if (arg12 || v29) {
                let v30 = if (arg2) {
                    0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_up_to_quantum(v14.remaining_base, arg5)
                } else {
                    0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_up(0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_up_to_quantum(v14.remaining_base, arg5), v14.price, 1000000000)
                };
                v9 = 0x1::u128::max(v23 + v30, v9);
            };
            if (v29) {
                let v31 = OrderbookPrefix{
                    minimum_input : v9,
                    spent         : v1 - v24,
                    output        : v26,
                    base          : v27,
                };
                0x1::vector::push_back<OrderbookPrefix>(arg10, v31);
            };
        };
        if (v5 == 0x1::vector::length<OrderbookSegment>(arg7)) {
            if (v2 > 0 && arg4) {
                return (0, 3, v6, 0, 0)
            };
            if (v4 < arg6) {
                let v32 = if (arg4) {
                    10
                } else {
                    7
                };
                return (0, v32, v6, 0, 0)
            };
        };
        if (v4 < arg6 || v3 == 0) {
            return (0, 10, v6, 0, 0)
        };
        (v3, 0, v6, v7, v8)
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
            let v3 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_down_to_quantum(arg6, arg4);
            let v4 = if (v3 < v0.remaining_base) {
                v3
            } else {
                v0.remaining_base
            };
            (0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::model_nq(v4, v0.price), v4)
        } else {
            let v5 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::round_down_to_quantum(0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::mul_div_down(arg6, 1000000000, v0.price), arg4);
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
        let v0 = if (arg11 && 0x1::vector::length<OrderbookSegment>(arg7) >= 8) {
            true
        } else if (arg4) {
            true
        } else {
            !0x1::vector::is_empty<OrderbookPrefix>(&arg10.prefixes)
        };
        let (v1, v2, v3, v4, v5) = if (!arg10.capture_lots && !v0) {
            let (v6, v7, v8) = model_quote_orderbook_hop_bounded(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
            (v6, v7, v8, 0, 0)
        } else {
            let v9 = &mut arg10.prefixes;
            quote_orderbook_lot_prefix(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v9, v0, arg10.capture_lots)
        };
        if (arg10.capture_lots) {
            arg10.lot_input = arg8;
            arg10.lot_left = v4;
            arg10.lot_next = v5;
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
            return (0, 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::h6(arg1.sqrt_price_x64, arg1.zero_for_one), 0, 0)
        };
        let v4 = 0x1::vector::length<TickBoundary>(arg0) - arg1.boundary_cursor;
        if (v4 == 0) {
            return (0, 0, 3, 0)
        };
        if (*arg3 == 0) {
            return (0, 0, 6, 0)
        };
        let (_, v6) = model_extend_v3_prefix_cache(arg0, arg1, arg2, v4, arg3);
        if (v6 != 0) {
            return (0, 0, v6, 0x1::vector::length<V3Prefix>(&arg1.prefixes))
        };
        let v7 = 0x1::vector::length<V3Prefix>(&arg1.prefixes);
        let (v8, v9) = prefix_upper_bound_materialized(&arg1.prefixes, v7, arg2, arg3);
        if (v9 != 0) {
            return (0, 0, v9, v8)
        };
        let (v10, v11, v12, v13) = if (v8 == 0) {
            (0, 0, arg1.sqrt_price_x64, arg1.liquidity)
        } else {
            let v14 = 0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v8 - 1);
            (v14.cumulative_input, v14.cumulative_output, v14.end_sqrt_price_x64, v14.liquidity_after)
        };
        let v15 = if (arg1.policy_stop_at_zero_liquidity || arg1.reject_empty_endpoint) {
            if (v8 > 0) {
                v13 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v15) {
            return (0, 0, 7, v8)
        };
        if (arg2 == v10) {
            return (v11, 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::h6(v12, arg1.zero_for_one), 0, v8)
        };
        if (v11 > arg1.policy_output_capacity) {
            return (0, 0, 7, v8)
        };
        if (v8 == v7 || v13 == 0) {
            return (0, 0, 3, v8)
        };
        if (*arg3 == 0) {
            return (0, 0, 6, v8)
        };
        *arg3 = *arg3 - 1;
        let (v16, v17) = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::v3_partial_tail(v12, v13, arg1.zero_for_one, arg2 - v10, arg1.fee_rate, arg1.fee_denominator);
        let (v18, v19, v20) = if (v11 > 340282366920938463463374607431768211455 - v17) {
            (5, 0, 0)
        } else {
            (0, v11 + v17, 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math::h6(v16, arg1.zero_for_one))
        };
        (v19, v20, v18, v8)
    }

    public fun quote_ve33_prepared(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: &mut u64, arg9: &mut V3PrefixCache) : (u128, u8, u64) {
        if (arg7 == 0) {
            return (0, 0, 0)
        };
        let v0 = arg7 - arg7 * (arg1 as u128) / (arg0 as u128);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        if (*arg8 == 0) {
            return (0, 6, 0)
        };
        if (0x1::vector::is_empty<u256>(&arg9.numeric)) {
            let v1 = (arg2 as u256) * (arg4 as u256) / (arg5 as u256);
            let v2 = (arg3 as u256) * (arg4 as u256) / (arg6 as u256);
            let v3 = 0x1::vector::empty<u256>();
            let v4 = &mut v3;
            0x1::vector::push_back<u256>(v4, v1);
            0x1::vector::push_back<u256>(v4, v2);
            0x1::vector::push_back<u256>(v4, 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::ve33_invariant(v1, v2));
            arg9.numeric = v3;
        };
        0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::quote_ve33_normalized(*0x1::vector::borrow<u256>(&arg9.numeric, 0), *0x1::vector::borrow<u256>(&arg9.numeric, 1), *0x1::vector::borrow<u256>(&arg9.numeric, 2), (arg4 as u256), arg5, arg6, v0, arg8)
    }

    public fun set_book_lot_capture(arg0: &mut OrderbookShortfall, arg1: bool) {
        arg0.capture_lots = arg1;
    }

    public fun tick_boundary(arg0: u128, arg1: u128, arg2: bool) : TickBoundary {
        TickBoundary{
            sqrt_price_x64    : arg0,
            liquidity_net_abs : arg1,
            negative          : arg2,
        }
    }

    fun v3_fee_input(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : (u128, u128) {
        if (arg0 == 0 || arg1 == 0) {
            return (arg0, arg0)
        };
        let v0 = ((arg2 - arg1) as u256);
        if (!arg3) {
            let v1 = ((((arg0 as u256) * (arg2 as u256) - 1) / v0 + 1) as u128);
            return (v1, v1)
        };
        let v2 = (arg0 as u256) * (arg1 as u256);
        let v3 = v2 / v0;
        let v4 = v2 - v3 * v0;
        let v5 = if (v4 == 0) {
            0
        } else {
            1
        };
        let v6 = if (v4 >= v0 - (v0 >> 1)) {
            1
        } else {
            0
        };
        (arg0 + ((v3 + v5) as u128), arg0 + ((v3 + v6) as u128))
    }

    public fun v3_read_demand_from_cache(arg0: &V3PrefixCache, arg1: u128) : V3ReadDemand {
        let v0 = 0x1::u64::min(0x1::vector::length<V3Prefix>(&arg0.prefixes), arg0.real_boundary_limit);
        let (v1, v2, v3) = if (v0 == 0) {
            (0, arg0.sqrt_price_x64, arg0.liquidity)
        } else {
            let v4 = 0x1::vector::borrow<V3Prefix>(&arg0.prefixes, v0 - 1);
            (v4.cumulative_input, v4.end_sqrt_price_x64, v4.liquidity_after)
        };
        V3ReadDemand{
            exact                 : true,
            remaining_gross       : arg1 - v1,
            sqrt_price_x64        : v2,
            liquidity             : v3,
            fee_rate              : arg0.fee_rate,
            fee_denominator       : arg0.fee_denominator,
            reject_empty_endpoint : arg0.reject_empty_endpoint,
        }
    }

    public fun v3_read_demand_is_exact(arg0: &V3ReadDemand) : bool {
        arg0.exact
    }

    public fun v3_read_demand_step(arg0: &mut V3ReadDemand, arg1: bool, arg2: u128, arg3: u128, arg4: bool, arg5: bool, arg6: bool, arg7: bool) : bool {
        let v0 = arg0.liquidity > 0 && arg2 != arg0.sqrt_price_x64;
        if (arg0.exact) {
            let v1 = if (arg0.liquidity == 0) {
                0
            } else if (arg1) {
                0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::amount0_delta_up(arg0.sqrt_price_x64, arg2, arg0.liquidity)
            } else {
                0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::mul_div_up(arg0.liquidity, arg2 - arg0.sqrt_price_x64, 18446744073709551616)
            };
            let (v2, v3) = v3_fee_input(v1, arg0.fee_rate, arg0.fee_denominator, arg5);
            if (v2 > arg0.remaining_gross) {
                return true
            };
            arg0.remaining_gross = arg0.remaining_gross - v3;
        };
        let v4 = if (arg1 != arg4) {
            arg0.liquidity - arg3
        } else {
            arg0.liquidity + arg3
        };
        arg0.liquidity = v4;
        arg0.sqrt_price_x64 = arg2;
        arg6 && v4 == 0 || arg0.exact && arg0.remaining_gross == 0 && (!arg0.reject_empty_endpoint || v4 > 0) || v0 && arg7
    }

    // decompiled from Move bytecode v7
}

