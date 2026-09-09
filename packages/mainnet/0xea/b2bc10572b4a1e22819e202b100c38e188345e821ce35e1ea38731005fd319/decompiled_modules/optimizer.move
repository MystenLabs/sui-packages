module 0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer {
    struct TickBoundary has copy, drop, store {
        sqrt_price_x64: u128,
        liquidity_net_abs: u128,
        negative: bool,
    }

    struct OrderbookSegment has copy, drop, store {
        price: u128,
        remaining_base: u128,
    }

    struct LinearSegment has copy, drop, store {
        remaining_input: u128,
        remaining_output: u128,
    }

    struct Hop has drop, store {
        kind: u8,
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
    }

    struct StagedHop has drop, store {
        kind: u8,
        liquidity: u128,
        boundaries: vector<TickBoundary>,
        replacement: vector<Hop>,
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
    }

    struct OptimizeState has drop {
        route: vector<Hop>,
        max_amount_in: u128,
        max_segments: u64,
        cursor: u128,
        cursor_output: u128,
        result: OptimizeResult,
        finished: bool,
    }

    fun advance_hop_probe(arg0: &mut Hop, arg1: u128, arg2: u64) : (u128, bool, u64, u64, u64) {
        if (arg1 == 0) {
            return (0, true, 0, 0, 0)
        };
        if (arg0.kind == 0) {
            let v0 = effective_input(arg1, arg0.fee_rate, arg0.fee_denominator);
            let v1 = mul_div_down(v0, arg0.reserve_out, arg0.reserve_in + v0);
            arg0.reserve_in = arg0.reserve_in + v0;
            arg0.reserve_out = arg0.reserve_out - v1;
            return (effective_output(v1, arg0.output_fee_rate, arg0.output_fee_denominator), true, 0, 0, 0)
        };
        let v2 = arg1;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v2 > 0) {
            if (arg0.kind == 1) {
                if (arg0.boundary_cursor >= 0x1::vector::length<TickBoundary>(&arg0.boundaries) || v6 >= arg2) {
                    return (0, false, v4, v5, v6)
                };
                let v7 = *current_boundary(arg0);
                let v8 = input_to_current_boundary(arg0);
                if (v8 == 0) {
                    arg0.sqrt_price_x64 = v7.sqrt_price_x64;
                    apply_liquidity_net(arg0, v7);
                    arg0.boundary_cursor = arg0.boundary_cursor + 1;
                    v4 = v4 + 1;
                    v6 = v6 + 1;
                    continue
                };
                let v9 = if (v2 < v8) {
                    v2
                } else {
                    v8
                };
                let v10 = effective_input(v9, arg0.fee_rate, arg0.fee_denominator);
                if (v10 == 0) {
                    v2 = v2 - v9;
                    continue
                };
                let v11 = next_sqrt_price(arg0, v10, v7.sqrt_price_x64);
                let v12 = if (arg0.zero_for_one) {
                    mul_div_down(arg0.liquidity, arg0.sqrt_price_x64 - v11, 18446744073709551616)
                } else {
                    amount0_delta_down(arg0.sqrt_price_x64, v11, arg0.liquidity)
                };
                arg0.sqrt_price_x64 = v11;
                v3 = v3 + v12;
                v2 = v2 - v9;
                if (v11 == v7.sqrt_price_x64) {
                    apply_liquidity_net(arg0, v7);
                    arg0.boundary_cursor = arg0.boundary_cursor + 1;
                    v4 = v4 + 1;
                    v6 = v6 + 1;
                    continue
                } else {
                    continue
                };
            };
            if (arg0.kind == 2) {
                if (arg0.orderbook_cursor >= 0x1::vector::length<OrderbookSegment>(&arg0.orderbook_segments) || v6 >= arg2) {
                    return (0, false, v4, v5, v6)
                };
                let v13 = input_to_current_boundary(arg0);
                if (v13 == 0) {
                    arg0.orderbook_cursor = arg0.orderbook_cursor + 1;
                    v5 = v5 + 1;
                    v6 = v6 + 1;
                    continue
                };
                let v14 = if (v2 < v13) {
                    v2
                } else {
                    v13
                };
                let (v15, v16) = quote_orderbook_segment_and_consumed_base(arg0, effective_input(v14, arg0.fee_rate, arg0.fee_denominator));
                let v17 = 0x1::vector::borrow_mut<OrderbookSegment>(&mut arg0.orderbook_segments, arg0.orderbook_cursor);
                v17.remaining_base = v17.remaining_base - v16;
                arg0.orderbook_consumed_base = arg0.orderbook_consumed_base + v16;
                v3 = v3 + v15;
                v2 = v2 - v14;
                if (v17.remaining_base == 0) {
                    arg0.orderbook_cursor = arg0.orderbook_cursor + 1;
                    v5 = v5 + 1;
                    v6 = v6 + 1;
                    continue
                } else {
                    continue
                };
            };
            assert!(arg0.kind == 3, 1);
            if (arg0.linear_cursor >= 0x1::vector::length<LinearSegment>(&arg0.linear_segments) || v6 >= arg2) {
                return (0, false, v4, v5, v6)
            };
            let v18 = input_to_current_boundary(arg0);
            let v19 = if (v2 < v18) {
                v2
            } else {
                v18
            };
            let v20 = quote_linear_segment(arg0, v19);
            let v21 = 0x1::vector::borrow_mut<LinearSegment>(&mut arg0.linear_segments, arg0.linear_cursor);
            v21.remaining_input = v21.remaining_input - v19;
            v21.remaining_output = v21.remaining_output - v20;
            v3 = v3 + v20;
            v2 = v2 - v19;
            if (v21.remaining_input == 0) {
                assert!(v21.remaining_output == 0, 3);
                arg0.linear_cursor = arg0.linear_cursor + 1;
                v6 = v6 + 1;
                continue
            };
        };
        (v3, true, v4, v5, v6)
    }

    fun advance_probe_target(arg0: &mut OptimizeState, arg1: u128) : bool {
        assert!(arg1 > arg0.cursor && arg1 <= arg0.max_amount_in, 6);
        let v0 = arg0.max_segments - arg0.result.segments;
        if (v0 == 0) {
            arg0.result.complete = false;
            arg0.finished = true;
            return true
        };
        let v1 = &mut arg0.route;
        let (v2, v3, v4, v5, v6, v7) = advance_route_probe(v1, arg1 - arg0.cursor, v0);
        arg0.result.segments = arg0.result.segments + v6;
        arg0.result.crossed_ticks = arg0.result.crossed_ticks + v4;
        arg0.result.crossed_orders = arg0.result.crossed_orders + v5;
        if (!v3) {
            arg0.result.complete = false;
            arg0.result.needs_more_hop = v7;
            arg0.finished = true;
            return true
        };
        arg0.cursor = arg1;
        arg0.cursor_output = arg0.cursor_output + v2;
        if (orderbook_minimums_satisfied(&arg0.route)) {
            let v8 = &mut arg0.result;
            record_candidate(arg0.cursor, arg0.cursor_output, v8);
            let v9 = if (arg0.result.found) {
                if (arg0.result.gross_profit == arg0.result.gross_profit) {
                    route_marginal_x64(&arg0.route) <= q64()
                } else {
                    false
                }
            } else {
                false
            };
            if (v9) {
                arg0.finished = true;
                return true
            };
        };
        false
    }

    fun advance_route(arg0: &mut vector<Hop>, arg1: u128) : (u128, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            let v4 = 0x1::vector::borrow_mut<Hop>(arg0, v3);
            let v5 = effective_input(v0, v4.fee_rate, v4.fee_denominator);
            if (v4.kind == 0) {
                let v6 = mul_div_down(v5, v4.reserve_out, v4.reserve_in + v5);
                v4.reserve_in = v4.reserve_in + v5;
                v4.reserve_out = v4.reserve_out - v6;
                v0 = effective_output(v6, v4.output_fee_rate, v4.output_fee_denominator);
            } else if (v4.kind == 1) {
                let v7 = *current_boundary(v4);
                let (v8, v9) = if (v5 == 0) {
                    (v4.sqrt_price_x64, 0)
                } else {
                    let v10 = next_sqrt_price(v4, v5, v7.sqrt_price_x64);
                    let v11 = if (v4.zero_for_one) {
                        mul_div_down(v4.liquidity, v4.sqrt_price_x64 - v10, 18446744073709551616)
                    } else {
                        amount0_delta_down(v4.sqrt_price_x64, v10, v4.liquidity)
                    };
                    (v10, v11)
                };
                v4.sqrt_price_x64 = v8;
                if (v8 == v7.sqrt_price_x64) {
                    apply_liquidity_net(v4, v7);
                    v4.boundary_cursor = v4.boundary_cursor + 1;
                    v1 = v1 + 1;
                };
                v0 = v9;
            } else if (v4.kind == 2) {
                assert!(!orderbook_terminal(v4), 3);
                let (v12, v13) = quote_orderbook_segment_and_consumed_base(v4, v5);
                let v14 = 0x1::vector::borrow_mut<OrderbookSegment>(&mut v4.orderbook_segments, v4.orderbook_cursor);
                v14.remaining_base = v14.remaining_base - v13;
                v4.orderbook_consumed_base = v4.orderbook_consumed_base + v13;
                if (v14.remaining_base == 0) {
                    v4.orderbook_cursor = v4.orderbook_cursor + 1;
                    v2 = v2 + 1;
                };
                v0 = v12;
            } else {
                assert!(v4.kind == 3, 1);
                assert!(!linear_terminal(v4), 3);
                let v15 = quote_linear_segment(v4, v5);
                let v16 = 0x1::vector::borrow_mut<LinearSegment>(&mut v4.linear_segments, v4.linear_cursor);
                assert!(v5 <= v16.remaining_input, 3);
                v16.remaining_input = v16.remaining_input - v5;
                v16.remaining_output = v16.remaining_output - v15;
                if (v16.remaining_input == 0) {
                    assert!(v16.remaining_output == 0, 3);
                    v4.linear_cursor = v4.linear_cursor + 1;
                };
                v0 = v15;
            };
            v3 = v3 + 1;
        };
        (v0, v1, v2)
    }

    fun advance_route_probe(arg0: &mut vector<Hop>, arg1: u128, arg2: u64) : (u128, bool, u64, u64, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<Hop>(arg0)) {
            if (v0 == 0) {
                return (0, true, v1, v2, v3, 18446744073709551615)
            };
            let v5 = 0x1::vector::borrow_mut<Hop>(arg0, v4);
            let (v6, v7, v8, v9, v10) = advance_hop_probe(v5, v0, arg2 - v3);
            let v11 = v1 + v8;
            v1 = v11;
            let v12 = v2 + v9;
            v2 = v12;
            let v13 = v3 + v10;
            v3 = v13;
            if (!v7) {
                return (0, false, v11, v12, v13, v4)
            };
            v0 = v6;
            v4 = v4 + 1;
        };
        (v0, true, v1, v2, v3, 18446744073709551615)
    }

    fun amount0_delta_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg1 >= arg0 && arg0 > 0, 3);
        if (arg1 == arg0) {
            return 0
        };
        let v0 = (arg2 as u256) << 64;
        let v1 = v0 / (arg0 as u256);
        let v2 = div_up_u256(v0, (arg1 as u256));
        if (v1 <= v2) {
            0
        } else {
            to_u128(v1 - v2)
        }
    }

    fun amount0_delta_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg0 > arg1 && arg1 > 0, 3);
        let v0 = (arg2 as u256) << 64;
        to_u128(div_up_u256(v0, (arg1 as u256)) - v0 / (arg0 as u256))
    }

    public fun amount_in(arg0: &OptimizeResult) : u128 {
        arg0.amount_in
    }

    public fun amount_out(arg0: &OptimizeResult) : u128 {
        arg0.amount_out
    }

    fun apply_liquidity_net(arg0: &mut Hop, arg1: TickBoundary) {
        if (arg0.zero_for_one && !arg1.negative || arg1.negative) {
            assert!(arg0.liquidity >= arg1.liquidity_net_abs, 3);
            arg0.liquidity = arg0.liquidity - arg1.liquidity_net_abs;
        } else {
            arg0.liquidity = arg0.liquidity + arg1.liquidity_net_abs;
        };
        assert!(arg0.liquidity > 0, 3);
    }

    fun bounded_geometric_first_target(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : u128 {
        let v0 = arg0;
        let v1 = arg3 - 1;
        while (v1 > 0 && v0 > 1) {
            let v2 = div_up_u256((v0 as u256) * (arg2 as u256), (arg1 as u256));
            v0 = to_u128(v2);
            v1 = v1 - 1;
        };
        v0
    }

    fun candidate_satisfies_orderbook_minimums(arg0: &vector<Hop>, arg1: u128) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (v1.kind == 2 && v1.orderbook_consumed_base + orderbook_segment_base_consumed(v1, effective_input(arg1, v1.fee_rate, v1.fee_denominator)) < v1.orderbook_min_size) {
                return false
            };
            arg1 = quote_hop(v1, arg1);
            v0 = v0 + 1;
        };
        true
    }

    fun closed_form_root(arg0: u128, arg1: u128, arg2: u256) : (u128, bool) {
        if (arg2 <= q64()) {
            return (0, true)
        };
        let v0 = arg2 * (arg0 as u256);
        let v1 = (arg1 as u256) * q64();
        if (v0 <= v1 || arg1 == 0) {
            return (arg0, false)
        };
        let v2 = (sqrt_down(arg2 * q64()) - q64()) * (arg1 as u256) * q64() / (v0 - v1);
        if (v2 > q64()) {
            return (arg0, false)
        };
        (to_u128((arg0 as u256) * v2 / q64()), true)
    }

    public fun coarse_rejected(arg0: &OptimizeResult) : bool {
        arg0.coarse_rejected
    }

    public fun coarse_rejection() : OptimizeResult {
        let v0 = empty_result();
        v0.coarse_rejected = true;
        v0
    }

    fun coefficient_root(arg0: u256, arg1: u256, arg2: u128) : u128 {
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
        OptimizeState{
            route         : arg0,
            max_amount_in : arg1,
            max_segments  : arg2,
            cursor        : 0,
            cursor_output : 0,
            result        : empty_result(),
            finished      : false,
        }
    }

    public fun coefficient_state_staged(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: u128, arg3: u64) : OptimizeState {
        coefficient_state(join_staged_route(arg0, arg1), arg2, arg3)
    }

    public fun complete(arg0: &OptimizeResult) : bool {
        arg0.complete
    }

    public fun crossed_orders(arg0: &OptimizeResult) : u64 {
        arg0.crossed_orders
    }

    public fun crossed_ticks(arg0: &OptimizeResult) : u64 {
        arg0.crossed_ticks
    }

    fun current_boundary(arg0: &Hop) : &TickBoundary {
        0x1::vector::borrow<TickBoundary>(&arg0.boundaries, arg0.boundary_cursor)
    }

    fun current_linear_segment(arg0: &Hop) : &LinearSegment {
        0x1::vector::borrow<LinearSegment>(&arg0.linear_segments, arg0.linear_cursor)
    }

    fun current_orderbook_segment(arg0: &Hop) : &OrderbookSegment {
        0x1::vector::borrow<OrderbookSegment>(&arg0.orderbook_segments, arg0.orderbook_cursor)
    }

    fun div_ceil(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 3);
        if (arg0 % arg1 == 0) {
            arg0 / arg1
        } else {
            arg0 / arg1 + 1
        }
    }

    fun div_up_u256(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 3);
        let v0 = if (arg0 % arg1 == 0) {
            0
        } else {
            1
        };
        arg0 / arg1 + v0
    }

    fun effective_input(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_down(arg0, ((arg2 - arg1) as u128), (arg2 as u128))
    }

    fun effective_output(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_down(arg0, ((arg2 - arg1) as u128), (arg2 as u128))
    }

    fun empty_result() : OptimizeResult {
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
        }
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

    public fun found(arg0: &OptimizeResult) : bool {
        arg0.found
    }

    fun gross_from_effective(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_up(arg0, (arg2 as u128), ((arg2 - arg1) as u128))
    }

    public fun gross_profit(arg0: &OptimizeResult) : u128 {
        arg0.gross_profit
    }

    fun has_terminal_finite_hop(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            if (orderbook_terminal(v1) || linear_terminal(v1)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun hop_curvature_x64(arg0: &Hop) : u256 {
        if (arg0.kind == 0) {
            ((arg0.fee_denominator - arg0.fee_rate) as u256) * q64() / (arg0.fee_denominator as u256) / (arg0.reserve_in as u256)
        } else if (arg0.kind == 1) {
            if (arg0.zero_for_one) {
                ((arg0.fee_denominator - arg0.fee_rate) as u256) * q64() / (arg0.fee_denominator as u256) * (arg0.sqrt_price_x64 as u256) / q64() / (arg0.liquidity as u256)
            } else {
                ((arg0.fee_denominator - arg0.fee_rate) as u256) * q64() / (arg0.fee_denominator as u256) * q64() / (arg0.sqrt_price_x64 as u256) / (arg0.liquidity as u256)
            }
        } else if (arg0.kind == 2) {
            0
        } else {
            assert!(arg0.kind == 3, 1);
            0
        }
    }

    fun hop_endpoint_marginal_x64(arg0: &Hop, arg1: u128) : u256 {
        let v0 = effective_input(arg1, arg0.fee_rate, arg0.fee_denominator);
        let v1 = if (arg0.kind == 0) {
            ((arg0.reserve_out - mul_div_down(v0, arg0.reserve_out, arg0.reserve_in + v0)) as u256) * q64() / ((arg0.reserve_in + v0) as u256)
        } else if (arg0.kind == 1) {
            let v2 = if (v0 == 0) {
                (arg0.sqrt_price_x64 as u256)
            } else {
                (next_sqrt_price(arg0, v0, current_boundary(arg0).sqrt_price_x64) as u256)
            };
            if (arg0.zero_for_one) {
                v2 * v2 / q64()
            } else {
                q64() * q64() * q64() / v2 * v2
            }
        } else if (arg0.kind == 2) {
            if (orderbook_terminal(arg0)) {
                return 0
            };
            if (arg0.orderbook_base_to_quote) {
                (current_orderbook_segment(arg0).price as u256) * q64() / 1000000000
            } else {
                1000000000 * q64() / (current_orderbook_segment(arg0).price as u256)
            }
        } else {
            assert!(arg0.kind == 3, 1);
            if (linear_terminal(arg0)) {
                return 0
            };
            let v3 = current_linear_segment(arg0);
            (v3.remaining_output as u256) * q64() / (v3.remaining_input as u256)
        };
        v1 * ((arg0.fee_denominator - arg0.fee_rate) as u256) / (arg0.fee_denominator as u256) * ((arg0.output_fee_denominator - arg0.output_fee_rate) as u256) / (arg0.output_fee_denominator as u256)
    }

    fun hop_marginal_upper_x64(arg0: &Hop) : u256 {
        let v0 = if (arg0.kind == 0) {
            div_ceil((arg0.reserve_out as u256) * q64(), (arg0.reserve_in as u256))
        } else if (arg0.kind == 1 || arg0.kind == 4) {
            let v1 = (arg0.sqrt_price_x64 as u256);
            if (arg0.zero_for_one) {
                div_ceil(v1 * v1, q64())
            } else {
                div_ceil(q64() * q64() * q64(), v1 * v1)
            }
        } else if (arg0.kind == 2) {
            if (orderbook_terminal(arg0)) {
                return 0
            };
            if (arg0.orderbook_base_to_quote) {
                div_ceil((current_orderbook_segment(arg0).price as u256) * q64(), 1000000000)
            } else {
                div_ceil(1000000000 * q64(), (current_orderbook_segment(arg0).price as u256))
            }
        } else {
            assert!(arg0.kind == 3, 1);
            if (linear_terminal(arg0)) {
                return 0
            };
            let v2 = current_linear_segment(arg0);
            div_ceil((v2.remaining_output as u256) * q64(), (v2.remaining_input as u256))
        };
        mul_fraction_ceil(mul_fraction_ceil(v0, ((arg0.fee_denominator - arg0.fee_rate) as u256), (arg0.fee_denominator as u256)), ((arg0.output_fee_denominator - arg0.output_fee_rate) as u256), (arg0.output_fee_denominator as u256))
    }

    fun hop_marginal_x64(arg0: &Hop) : u256 {
        let v0 = if (arg0.kind == 0) {
            (arg0.reserve_out as u256) * q64() / (arg0.reserve_in as u256)
        } else if (arg0.kind == 1 || arg0.kind == 4) {
            let v1 = (arg0.sqrt_price_x64 as u256);
            if (arg0.zero_for_one) {
                v1 * v1 / q64()
            } else {
                q64() * q64() * q64() / v1 * v1
            }
        } else if (arg0.kind == 2) {
            if (orderbook_terminal(arg0)) {
                return 0
            };
            if (arg0.orderbook_base_to_quote) {
                (current_orderbook_segment(arg0).price as u256) * q64() / 1000000000
            } else {
                1000000000 * q64() / (current_orderbook_segment(arg0).price as u256)
            }
        } else {
            assert!(arg0.kind == 3, 1);
            if (linear_terminal(arg0)) {
                return 0
            };
            let v2 = current_linear_segment(arg0);
            (v2.remaining_output as u256) * q64() / (v2.remaining_input as u256)
        };
        v0 * ((arg0.fee_denominator - arg0.fee_rate) as u256) / (arg0.fee_denominator as u256) * ((arg0.output_fee_denominator - arg0.output_fee_rate) as u256) / (arg0.output_fee_denominator as u256)
    }

    fun input_to_current_boundary(arg0: &Hop) : u128 {
        if (arg0.kind == 2) {
            let v0 = current_orderbook_segment(arg0);
            let v1 = if (arg0.orderbook_base_to_quote) {
                v0.remaining_base
            } else {
                mul_div_up(v0.remaining_base, v0.price, 1000000000)
            };
            return gross_from_effective(v1, arg0.fee_rate, arg0.fee_denominator)
        };
        if (arg0.kind == 3) {
            return current_linear_segment(arg0).remaining_input
        };
        let v2 = if (arg0.zero_for_one) {
            amount0_delta_up(arg0.sqrt_price_x64, current_boundary(arg0).sqrt_price_x64, arg0.liquidity)
        } else {
            mul_div_up(arg0.liquidity, current_boundary(arg0).sqrt_price_x64 - arg0.sqrt_price_x64, 18446744073709551616)
        };
        gross_from_effective(v2, arg0.fee_rate, arg0.fee_denominator)
    }

    fun inverse_hop(arg0: &Hop, arg1: u128) : (u128, bool) {
        if (arg1 == 0) {
            return (0, true)
        };
        let v0 = if (arg0.kind == 0) {
            let v1 = gross_from_effective(arg1, arg0.output_fee_rate, arg0.output_fee_denominator);
            if (v1 >= arg0.reserve_out) {
                return (0, false)
            };
            mul_div_up(arg0.reserve_in, v1, arg0.reserve_out - v1)
        } else if (arg0.kind == 1) {
            let v2 = current_boundary(arg0).sqrt_price_x64;
            if (arg0.zero_for_one) {
                if (arg1 > mul_div_down(arg0.liquidity, arg0.sqrt_price_x64 - v2, 18446744073709551616)) {
                    return (0, false)
                };
                let v3 = mul_div_up(arg1, 18446744073709551616, arg0.liquidity);
                if (v3 >= arg0.sqrt_price_x64) {
                    return (0, false)
                };
                let v4 = arg0.sqrt_price_x64 - v3;
                if (v4 < v2) {
                    return (0, false)
                };
                amount0_delta_up(arg0.sqrt_price_x64, v4, arg0.liquidity)
            } else {
                if (arg1 > amount0_delta_down(arg0.sqrt_price_x64, v2, arg0.liquidity)) {
                    return (0, false)
                };
                let v5 = (arg0.liquidity as u256) << 64;
                let v6 = v5 / (arg0.sqrt_price_x64 as u256);
                if ((arg1 as u256) >= v6) {
                    return (0, false)
                };
                let v7 = to_u128(div_up_u256(v5, v6 - (arg1 as u256)));
                if (v7 > v2) {
                    return (0, false)
                };
                mul_div_up(arg0.liquidity, v7 - arg0.sqrt_price_x64, 18446744073709551616)
            }
        } else if (arg0.kind == 2) {
            let v8 = current_orderbook_segment(arg0);
            if (arg1 > orderbook_segment_output_capacity(arg0, v8)) {
                return (0, false)
            };
            if (arg0.orderbook_base_to_quote) {
                round_up_to_quantum(mul_div_up(arg1, 1000000000, v8.price), arg0.orderbook_lot_size)
            } else {
                mul_div_up(round_up_to_quantum(arg1, arg0.orderbook_lot_size), v8.price, 1000000000)
            }
        } else {
            assert!(arg0.kind == 3, 1);
            let v9 = current_linear_segment(arg0);
            if (arg1 > v9.remaining_output) {
                return (0, false)
            };
            mul_div_up(arg1, v9.remaining_input, v9.remaining_output)
        };
        (gross_from_effective(v0, arg0.fee_rate, arg0.fee_denominator), true)
    }

    fun join_staged_route(arg0: vector<Hop>, arg1: vector<StagedHop>) : vector<Hop> {
        let v0 = 0x1::vector::length<Hop>(&arg0);
        assert!(v0 > 0, 5);
        assert!(v0 == 0x1::vector::length<StagedHop>(&arg1), 3);
        let v1 = 0x1::vector::empty<Hop>();
        while (0x1::vector::length<Hop>(&arg0) > 0) {
            let v2 = 0x1::vector::pop_back<Hop>(&mut arg0);
            let StagedHop {
                kind        : v3,
                liquidity   : v4,
                boundaries  : v5,
                replacement : v6,
            } = 0x1::vector::pop_back<StagedHop>(&mut arg1);
            let v7 = v6;
            let v8 = v5;
            if (v3 == 0) {
                assert!(v2.kind == 0, 1);
                let v9 = if (v4 == 0) {
                    if (0x1::vector::length<TickBoundary>(&v8) == 0) {
                        0x1::vector::length<Hop>(&v7) == 0
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v9, 3);
                0x1::vector::push_back<Hop>(&mut v1, v2);
                continue
            };
            if (v3 == 1) {
                assert!(v2.kind == 4, 1);
                let v10 = if (v4 > 0) {
                    if (0x1::vector::length<TickBoundary>(&v2.boundaries) == 0) {
                        0x1::vector::length<Hop>(&v7) == 0
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v10, 3);
                v2.kind = 1;
                v2.liquidity = v4;
                0x1::vector::append<TickBoundary>(&mut v2.boundaries, v8);
                validate_boundaries(v2.sqrt_price_x64, v2.zero_for_one, &v2.boundaries);
                0x1::vector::push_back<Hop>(&mut v1, v2);
                continue
            };
            assert!(v3 == 2, 1);
            let v11 = if (v4 == 0) {
                if (0x1::vector::length<TickBoundary>(&v8) == 0) {
                    0x1::vector::length<Hop>(&v7) == 1
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v11, 3);
            let v12 = 0x1::vector::pop_back<Hop>(&mut v7);
            assert!(v2.kind == 2 && v12.kind == 2 || v2.kind == 3 && v12.kind == 3, 1);
            0x1::vector::push_back<Hop>(&mut v1, v12);
        };
        0x1::vector::reverse<Hop>(&mut v1);
        v1
    }

    public fun linear_hop(arg0: vector<LinearSegment>, arg1: bool) : Hop {
        validate_linear_segments(&arg0);
        Hop{
            kind                    : 3,
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
            linear_segments         : arg0,
            linear_cursor           : 0,
            linear_has_more         : arg1,
        }
    }

    public fun linear_hop_from_capacities(arg0: vector<u128>, arg1: vector<u128>, arg2: bool) : Hop {
        assert!(0x1::vector::length<u128>(&arg0) == 0x1::vector::length<u128>(&arg1), 3);
        let v0 = 0x1::vector::empty<LinearSegment>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0)) {
            0x1::vector::push_back<LinearSegment>(&mut v0, linear_segment(*0x1::vector::borrow<u128>(&arg0, v1), *0x1::vector::borrow<u128>(&arg1, v1)));
            v1 = v1 + 1;
        };
        linear_hop(v0, arg2)
    }

    public fun linear_rate_hop(arg0: u128) : Hop {
        let v0 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v0, 18446744073709551616);
        let v1 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v1, arg0);
        linear_hop_from_capacities(v0, v1, false)
    }

    public fun linear_segment(arg0: u128, arg1: u128) : LinearSegment {
        assert!(arg0 > 0 && arg1 > 0, 3);
        LinearSegment{
            remaining_input  : arg0,
            remaining_output : arg1,
        }
    }

    fun linear_terminal(arg0: &Hop) : bool {
        if (arg0.kind == 3) {
            if (arg0.linear_cursor >= 0x1::vector::length<LinearSegment>(&arg0.linear_segments)) {
                !arg0.linear_has_more
            } else {
                false
            }
        } else {
            false
        }
    }

    fun log2_down(arg0: u256) : u8 {
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

    public fun marginal_upper_x64(arg0: &vector<Hop>) : u256 {
        assert!(0x1::vector::length<Hop>(arg0) > 0, 5);
        route_marginal_upper_x64(arg0)
    }

    public fun marginal_x64(arg0: &vector<Hop>) : u256 {
        assert!(0x1::vector::length<Hop>(arg0) > 0, 5);
        route_marginal_x64(arg0)
    }

    fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 3);
        to_u128((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 3);
        to_u128(div_up_u256((arg0 as u256) * (arg1 as u256), (arg2 as u256)))
    }

    fun mul_fraction_ceil(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0 && arg1 <= arg2, 2);
        arg0 / arg2 * arg1 + div_ceil(arg0 % arg2 * arg1, arg2)
    }

    fun mul_q64_ceil(arg0: u256, arg1: u256) : u256 {
        let v0 = q64();
        let v1 = arg0 % v0;
        saturating_add(saturating_add(saturating_mul(arg0 / v0, arg1), v1 * arg1 / v0), div_ceil(v1 * arg1 % v0, v0))
    }

    public fun needs_more_hop(arg0: &OptimizeResult) : u64 {
        arg0.needs_more_hop
    }

    fun next_geometric_target(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : u128 {
        if (arg0 == 0) {
            return 1
        };
        let v0 = (arg0 as u256) * ((arg2 - arg3) as u256);
        if (v0 >= ((arg1 - arg0) as u256) * (arg3 as u256)) {
            return arg1
        };
        arg0 + to_u128(div_up_u256(v0, (arg3 as u256)))
    }

    fun next_route_boundary(arg0: &vector<Hop>, arg1: u128) : (u128, u64) {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            let v3 = if (v2.kind == 1) {
                true
            } else if (v2.kind == 2 && !orderbook_terminal(v2)) {
                true
            } else {
                v2.kind == 3 && !linear_terminal(v2)
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

    fun next_route_boundary_forward(arg0: &vector<Hop>, arg1: u128) : (u128, u64) {
        let v0 = 18446744073709551615;
        let v1 = q64();
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            let v4 = 0x1::vector::borrow<Hop>(arg0, v3);
            let v5 = if (v4.kind == 1) {
                true
            } else if (v4.kind == 2 && !orderbook_terminal(v4)) {
                true
            } else {
                v4.kind == 3 && !linear_terminal(v4)
            };
            if (v5) {
                let v6 = input_to_current_boundary(v4);
                let v7 = v2 * (v6 as u256);
                if (v1 > v7) {
                };
            };
            v2 = v2 + hop_curvature_x64(v4) * v1 / q64();
            let v8 = v1 * hop_marginal_x64(v4);
            v1 = v8 / q64();
            v3 = v3 + 1;
        };
        if (v0 == 18446744073709551615) {
            return (arg1, 18446744073709551615)
        };
        let (v9, v10) = source_input_to_boundary(arg0, v0);
        if (v10 && v9 < arg1) {
            (v9, v0)
        } else {
            (arg1, 18446744073709551615)
        }
    }

    fun next_sqrt_price(arg0: &Hop, arg1: u128, arg2: u128) : u128 {
        let v0 = if (arg0.zero_for_one) {
            amount0_delta_up(arg0.sqrt_price_x64, arg2, arg0.liquidity)
        } else {
            mul_div_up(arg0.liquidity, arg2 - arg0.sqrt_price_x64, 18446744073709551616)
        };
        if (arg1 >= v0) {
            return arg2
        };
        if (arg0.zero_for_one) {
            let v2 = (arg0.liquidity as u256) << 64;
            to_u128(div_up_u256(v2, v2 / (arg0.sqrt_price_x64 as u256) + (arg1 as u256)))
        } else {
            arg0.sqrt_price_x64 + mul_div_down(arg1, 18446744073709551616, arg0.liquidity)
        }
    }

    public fun no_hop() : u64 {
        18446744073709551615
    }

    public fun optimize(arg0: vector<Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        optimize_coefficients(arg0, arg1, arg2)
    }

    public fun optimize_baseline(arg0: vector<Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        optimize_impl(arg0, arg1, arg2, 0)
    }

    public fun optimize_coefficients(arg0: vector<Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        let v0 = coefficient_state(arg0, arg1, arg2);
        let v1 = &mut v0;
        resume_coefficients(v1);
        progress_result(&v0)
    }

    public fun optimize_forward_events(arg0: vector<Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        optimize_impl(arg0, arg1, arg2, 2)
    }

    public fun optimize_hybrid(arg0: vector<Hop>, arg1: vector<u128>, arg2: u64, arg3: u64) : OptimizeResult {
        let v0 = 0x1::vector::length<u128>(&arg1);
        let v1 = if (v0 > 0) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 6);
        let v2 = 0;
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<u128>(&arg1, v2) > 0, 6);
            v2 = v2 + 1;
        };
        let v3 = coefficient_state(arg0, *0x1::vector::borrow<u128>(&arg1, v0 - 1), arg3);
        let v4 = if (arg2 < arg3) {
            arg2
        } else {
            arg3
        };
        let v5 = &mut v3;
        resume_coefficients_until(v5, v4);
        if (v3.finished || !v3.result.complete) {
            return progress_result(&v3)
        };
        v2 = 0;
        while (v2 < v0) {
            let v6 = *0x1::vector::borrow<u128>(&arg1, v2);
            let v7 = if (v6 > v3.cursor) {
                let v8 = &mut v3;
                advance_probe_target(v8, v6)
            } else {
                false
            };
            if (v7) {
                return progress_result(&v3)
            };
            v2 = v2 + 1;
        };
        v3.finished = true;
        progress_result(&v3)
    }

    public fun optimize_hybrid_geometric(arg0: vector<Hop>, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : OptimizeResult {
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                if (arg3 > 0) {
                    if (arg5 > 0) {
                        arg4 > arg5
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
        let v1 = coefficient_state(arg0, arg1, arg3);
        let v2 = if (arg2 < arg3) {
            arg2
        } else {
            arg3
        };
        let v3 = &mut v1;
        resume_coefficients_until(v3, v2);
        if (v1.finished || !v1.result.complete) {
            return progress_result(&v1)
        };
        while (v1.cursor < arg1) {
            let v4 = &mut v1;
            if (advance_probe_target(v4, next_geometric_target(v1.cursor, arg1, arg4, arg5))) {
                return progress_result(&v1)
            };
        };
        v1.finished = true;
        progress_result(&v1)
    }

    public fun optimize_hybrid_geometric_bounded(arg0: vector<Hop>, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : OptimizeResult {
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                if (arg3 > 0) {
                    if (arg5 > 0) {
                        if (arg4 > arg5) {
                            arg6 > 0
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
        let v1 = coefficient_state(arg0, arg1, arg3);
        let v2 = if (arg2 < arg3) {
            arg2
        } else {
            arg3
        };
        let v3 = &mut v1;
        resume_coefficients_until(v3, v2);
        if (v1.finished || !v1.result.complete) {
            return progress_result(&v1)
        };
        let v4 = bounded_geometric_first_target(arg1, arg4, arg5, arg6);
        let v5 = 0;
        while (v1.cursor < arg1 && v5 < arg6) {
            let v6 = next_geometric_target(v1.cursor, arg1, arg4, arg5);
            let v7 = v6;
            if (v6 < v4) {
                v7 = v4;
            };
            v5 = v5 + 1;
            let v8 = &mut v1;
            if (advance_probe_target(v8, v7)) {
                return progress_result(&v1)
            };
        };
        if (v1.cursor < arg1) {
            v1.result.complete = false;
        };
        v1.finished = true;
        progress_result(&v1)
    }

    public fun optimize_hybrid_geometric_bounded_staged_if(arg0: bool, arg1: vector<Hop>, arg2: vector<StagedHop>, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : OptimizeResult {
        if (!arg0) {
            coarse_rejection()
        } else {
            optimize_hybrid_geometric_bounded(join_staged_route(arg1, arg2), arg3, arg4, arg5, arg6, arg7, arg8)
        }
    }

    public fun optimize_hybrid_geometric_staged_if(arg0: bool, arg1: vector<Hop>, arg2: vector<StagedHop>, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : OptimizeResult {
        if (!arg0) {
            coarse_rejection()
        } else {
            optimize_hybrid_geometric(join_staged_route(arg1, arg2), arg3, arg4, arg5, arg6, arg7)
        }
    }

    public fun optimize_hybrid_staged_if(arg0: bool, arg1: vector<Hop>, arg2: vector<StagedHop>, arg3: vector<u128>, arg4: u64, arg5: u64) : OptimizeResult {
        if (!arg0) {
            coarse_rejection()
        } else {
            optimize_hybrid(join_staged_route(arg1, arg2), arg3, arg4, arg5)
        }
    }

    public fun optimize_if(arg0: bool, arg1: vector<Hop>, arg2: u128, arg3: u64) : OptimizeResult {
        if (!arg0) {
            coarse_rejection()
        } else {
            optimize_coefficients(arg1, arg2, arg3)
        }
    }

    fun optimize_impl(arg0: vector<Hop>, arg1: u128, arg2: u64, arg3: u8) : OptimizeResult {
        assert!(0x1::vector::length<Hop>(&arg0) > 0, 5);
        assert!(arg1 > 0 && arg2 > 0, 6);
        let v0 = empty_result();
        let v1 = 0;
        let v2 = 0;
        while (v1 < arg1 && v0.segments < arg2) {
            let v3 = first_missing_orderbook_segment(&arg0);
            if (v3 != 18446744073709551615) {
                v0.complete = false;
                v0.needs_more_hop = v3;
                break
            };
            let v4 = first_missing_linear_segment(&arg0);
            if (v4 != 18446744073709551615) {
                v0.complete = false;
                v0.needs_more_hop = v4;
                break
            };
            if (!orderbook_minimums_reachable(&arg0)) {
                break
            };
            let v5 = orderbook_minimums_satisfied(&arg0);
            let v6 = route_marginal_x64(&arg0);
            if (v6 <= q64()) {
                if (v1 == 0) {
                    v0.coarse_rejected = true;
                    break
                };
                if (v5) {
                    break
                };
            };
            let v7 = first_missing_boundary(&arg0);
            if (v7 != 18446744073709551615) {
                v0.complete = false;
                v0.needs_more_hop = v7;
                break
            };
            let v8 = arg1 - v1;
            let v9 = if (arg3 == 2) {
                let (v10, _) = next_route_boundary_forward(&arg0, v8);
                v10
            } else {
                let (v12, _) = next_route_boundary(&arg0, v8);
                v12
            };
            assert!(v9 > 0, 3);
            let (v14, v15) = if (arg3 == 0) {
                (quote_route(&arg0, v9), 0)
            } else {
                quote_route_and_endpoint_marginal(&arg0, v9)
            };
            v0.segments = v0.segments + 1;
            let (v16, v17) = if (arg3 != 0 && v15 > q64()) {
                (v9, false)
            } else {
                closed_form_root(v9, v14, v6)
            };
            if (v17) {
                let v18 = &mut v0;
                record_nearby_candidates(&arg0, v1, v2, v16, v9, v18);
                if (v5 || candidate_satisfies_orderbook_minimums(&arg0, v9)) {
                    return v0
                };
            };
            if (v9 == v8) {
                let v19 = &mut v0;
                record_candidate_if_valid(&arg0, v9, v1 + v9, v2 + v14, v19);
                return v0
            };
            let v20 = &mut arg0;
            let (v21, v22, v23) = advance_route(v20, v9);
            let v24 = v1 + v9;
            v1 = v24;
            let v25 = v2 + v21;
            v2 = v25;
            v0.crossed_ticks = v0.crossed_ticks + v22;
            v0.crossed_orders = v0.crossed_orders + v23;
            let v26 = &mut v0;
            record_candidate_if_valid(&arg0, 0, v24, v25, v26);
        };
        if (v1 < arg1 && v0.segments == arg2) {
            v0.complete = false;
        };
        v0
    }

    public fun optimize_lazy_sqrt(arg0: vector<Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        optimize_impl(arg0, arg1, arg2, 1)
    }

    public fun optimize_probe_amounts(arg0: vector<Hop>, arg1: vector<u128>, arg2: u64) : OptimizeResult {
        assert!(0x1::vector::length<Hop>(&arg0) > 0, 5);
        assert!(0x1::vector::length<u128>(&arg1) > 0 && arg2 > 0, 6);
        let v0 = empty_result();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(&arg1)) {
            let v4 = *0x1::vector::borrow<u128>(&arg1, v3);
            assert!(v4 > v1, 6);
            let v5 = arg2 - v0.segments;
            if (v5 == 0) {
                v0.complete = false;
                return v0
            };
            let v6 = &mut arg0;
            let (v7, v8, v9, v10, v11, v12) = advance_route_probe(v6, v4 - v1, v5);
            v0.segments = v0.segments + v11;
            v0.crossed_ticks = v0.crossed_ticks + v9;
            v0.crossed_orders = v0.crossed_orders + v10;
            if (!v8) {
                v0.complete = false;
                v0.needs_more_hop = v12;
                return v0
            };
            v2 = v2 + v7;
            if (orderbook_minimums_satisfied(&arg0)) {
                let v13 = &mut v0;
                record_candidate(v4, v2, v13);
                let v14 = if (v0.found) {
                    if (v0.gross_profit == v0.gross_profit) {
                        route_marginal_x64(&arg0) <= q64()
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v14) {
                    return v0
                };
            };
            v3 = v3 + 1;
        };
        v0
    }

    public fun optimize_probe_amounts_staged_if(arg0: bool, arg1: vector<Hop>, arg2: vector<StagedHop>, arg3: vector<u128>, arg4: u64) : OptimizeResult {
        if (!arg0) {
            coarse_rejection()
        } else {
            optimize_probe_amounts(join_staged_route(arg1, arg2), arg3, arg4)
        }
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

    public fun orderbook_hop(arg0: vector<OrderbookSegment>, arg1: u64, arg2: u64, arg3: bool, arg4: bool) : Hop {
        assert!(arg1 > 0 && arg2 > 0, 3);
        validate_orderbook_segments(&arg0, arg3);
        Hop{
            kind                    : 2,
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
            orderbook_segments      : arg0,
            orderbook_cursor        : 0,
            orderbook_lot_size      : (arg1 as u128),
            orderbook_min_size      : (arg2 as u128),
            orderbook_consumed_base : 0,
            orderbook_base_to_quote : arg3,
            orderbook_has_more      : arg4,
            linear_segments         : 0x1::vector::empty<LinearSegment>(),
            linear_cursor           : 0,
            linear_has_more         : false,
        }
    }

    public fun orderbook_hop_from_vectors(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : Hop {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 3);
        let v0 = 0x1::vector::empty<OrderbookSegment>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<OrderbookSegment>(&mut v0, orderbook_segment(*0x1::vector::borrow<u64>(&arg0, v1), *0x1::vector::borrow<u64>(&arg1, v1)));
            v1 = v1 + 1;
        };
        orderbook_hop(v0, arg2, arg3, arg4, arg5)
    }

    public fun orderbook_hop_from_vectors_with_input_fee(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64) : Hop {
        assert!(arg7 > arg6, 2);
        let v0 = orderbook_hop_from_vectors(arg0, arg1, arg2, arg3, arg4, arg5);
        v0.fee_rate = arg6;
        v0.fee_denominator = arg7;
        v0
    }

    fun orderbook_minimums_reachable(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<Hop>(arg0, v0);
            let v2 = if (v1.kind == 2) {
                if (v1.orderbook_consumed_base < v1.orderbook_min_size) {
                    orderbook_terminal(v1)
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
        assert!(arg0 > 0 && arg1 > 0, 3);
        OrderbookSegment{
            price          : (arg0 as u128),
            remaining_base : (arg1 as u128),
        }
    }

    fun orderbook_segment_base_consumed(arg0: &Hop, arg1: u128) : u128 {
        if (arg1 == 0 || orderbook_terminal(arg0)) {
            return 0
        };
        let v0 = current_orderbook_segment(arg0);
        if (arg0.orderbook_base_to_quote) {
            let v2 = round_down_to_quantum(arg1, arg0.orderbook_lot_size);
            if (v2 < v0.remaining_base) {
                v2
            } else {
                v0.remaining_base
            }
        } else {
            let v3 = round_down_to_quantum(mul_div_down(arg1, 1000000000, v0.price), arg0.orderbook_lot_size);
            if (v3 < v0.remaining_base) {
                v3
            } else {
                v0.remaining_base
            }
        }
    }

    fun orderbook_segment_output_capacity(arg0: &Hop, arg1: &OrderbookSegment) : u128 {
        if (arg0.orderbook_base_to_quote) {
            mul_div_down(arg1.remaining_base, arg1.price, 1000000000)
        } else {
            arg1.remaining_base
        }
    }

    public fun orderbook_stage_from_vectors_with_input_fee_if(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: bool) : StagedHop {
        if (!arg8) {
            return reuse_current_stage()
        };
        replacement_stage(orderbook_hop_from_vectors_with_input_fee(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    fun orderbook_terminal(arg0: &Hop) : bool {
        if (arg0.kind == 2) {
            if (arg0.orderbook_cursor >= 0x1::vector::length<OrderbookSegment>(&arg0.orderbook_segments)) {
                !arg0.orderbook_has_more
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun passes_marginal_gate(arg0: &vector<Hop>, arg1: u256) : bool {
        assert!(0x1::vector::length<Hop>(arg0) > 0, 5);
        route_marginal_upper_x64(arg0) > arg1
    }

    public fun progress_append_boundaries(arg0: &mut OptimizeState, arg1: u64, arg2: vector<TickBoundary>) {
        assert!(!arg0.finished, 3);
        assert!(!arg0.result.complete, 3);
        assert!(arg0.result.needs_more_hop == arg1, 3);
        assert!(0x1::vector::length<TickBoundary>(&arg2) > 0, 3);
        let v0 = 0x1::vector::borrow_mut<Hop>(&mut arg0.route, arg1);
        assert!(v0.kind == 1, 1);
        assert!(v0.boundary_cursor == 0x1::vector::length<TickBoundary>(&v0.boundaries), 3);
        let v1 = if (0x1::vector::length<TickBoundary>(&v0.boundaries) == 0) {
            v0.sqrt_price_x64
        } else {
            0x1::vector::borrow<TickBoundary>(&v0.boundaries, 0x1::vector::length<TickBoundary>(&v0.boundaries) - 1).sqrt_price_x64
        };
        let v2 = v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<TickBoundary>(&arg2)) {
            let v4 = *0x1::vector::borrow<TickBoundary>(&arg2, v3);
            if (v0.zero_for_one) {
                assert!(v4.sqrt_price_x64 < v2, 3);
            } else {
                assert!(v4.sqrt_price_x64 > v2, 3);
            };
            v2 = v4.sqrt_price_x64;
            0x1::vector::push_back<TickBoundary>(&mut v0.boundaries, v4);
            v3 = v3 + 1;
        };
        arg0.result.complete = true;
        arg0.result.needs_more_hop = 18446744073709551615;
    }

    public fun progress_append_linear_segments(arg0: &mut OptimizeState, arg1: u64, arg2: vector<LinearSegment>, arg3: bool) {
        assert!(!arg0.finished, 3);
        assert!(!arg0.result.complete, 3);
        assert!(arg0.result.needs_more_hop == arg1, 3);
        assert!(0x1::vector::length<LinearSegment>(&arg2) > 0, 3);
        let v0 = 0x1::vector::borrow_mut<Hop>(&mut arg0.route, arg1);
        assert!(v0.kind == 3, 1);
        assert!(v0.linear_cursor == 0x1::vector::length<LinearSegment>(&v0.linear_segments), 3);
        validate_linear_segments(&arg2);
        0x1::vector::append<LinearSegment>(&mut v0.linear_segments, arg2);
        v0.linear_has_more = arg3;
        arg0.result.complete = true;
        arg0.result.needs_more_hop = 18446744073709551615;
    }

    public fun progress_needs_boundary(arg0: &OptimizeState) : bool {
        !arg0.finished && !arg0.result.complete
    }

    public fun progress_result(arg0: &OptimizeState) : OptimizeResult {
        arg0.result
    }

    fun q64() : u256 {
        (18446744073709551616 as u256)
    }

    public fun q64_value() : u256 {
        q64()
    }

    fun quote_hop(arg0: &Hop, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = effective_input(arg1, arg0.fee_rate, arg0.fee_denominator);
        if (v0 == 0) {
            return 0
        };
        if (arg0.kind == 0) {
            effective_output(mul_div_down(v0, arg0.reserve_out, arg0.reserve_in + v0), arg0.output_fee_rate, arg0.output_fee_denominator)
        } else if (arg0.kind == 1) {
            if (arg0.zero_for_one) {
                mul_div_down(arg0.liquidity, arg0.sqrt_price_x64 - next_sqrt_price(arg0, v0, current_boundary(arg0).sqrt_price_x64), 18446744073709551616)
            } else {
                amount0_delta_down(arg0.sqrt_price_x64, next_sqrt_price(arg0, v0, current_boundary(arg0).sqrt_price_x64), arg0.liquidity)
            }
        } else if (arg0.kind == 2) {
            quote_orderbook_segment(arg0, v0)
        } else {
            assert!(arg0.kind == 3, 1);
            quote_linear_segment(arg0, v0)
        }
    }

    fun quote_linear_segment(arg0: &Hop, arg1: u128) : u128 {
        if (arg1 == 0 || linear_terminal(arg0)) {
            return 0
        };
        let v0 = current_linear_segment(arg0);
        if (arg1 >= v0.remaining_input) {
            v0.remaining_output
        } else {
            mul_div_down(arg1, v0.remaining_output, v0.remaining_input)
        }
    }

    fun quote_orderbook_segment(arg0: &Hop, arg1: u128) : u128 {
        let (v0, _) = quote_orderbook_segment_and_consumed_base(arg0, arg1);
        v0
    }

    fun quote_orderbook_segment_and_consumed_base(arg0: &Hop, arg1: u128) : (u128, u128) {
        if (arg1 == 0 || orderbook_terminal(arg0)) {
            return (0, 0)
        };
        let v0 = current_orderbook_segment(arg0);
        if (arg0.orderbook_base_to_quote) {
            let v3 = round_down_to_quantum(arg1, arg0.orderbook_lot_size);
            let v4 = if (v3 < v0.remaining_base) {
                v3
            } else {
                v0.remaining_base
            };
            (mul_div_down(v4, v0.price, 1000000000), v4)
        } else {
            let v5 = round_down_to_quantum(mul_div_down(arg1, 1000000000, v0.price), arg0.orderbook_lot_size);
            let v6 = if (v5 < v0.remaining_base) {
                v5
            } else {
                v0.remaining_base
            };
            (v6, v6)
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

    fun quote_route_and_endpoint_marginal(arg0: &vector<Hop>, arg1: u128) : (u128, u256) {
        let v0 = arg1;
        let v1 = q64();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Hop>(arg0)) {
            let v3 = 0x1::vector::borrow<Hop>(arg0, v2);
            let v4 = hop_endpoint_marginal_x64(v3, v0);
            v0 = quote_hop(v3, v0);
            let v5 = v1 * v4;
            v1 = v5 / q64();
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun quote_staged_window(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: u128) : (u128, bool, u64, u64) {
        quote_window(join_staged_route(arg0, arg1), arg2)
    }

    public fun quote_window(arg0: vector<Hop>, arg1: u128) : (u128, bool, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        while (arg1 > 0) {
            let v2 = first_missing_boundary(&arg0);
            if (v2 != 18446744073709551615) {
                return (v0, false, v1, v2)
            };
            if (has_terminal_finite_hop(&arg0)) {
                break
            };
            let (v3, _) = next_route_boundary(&arg0, arg1);
            let v5 = &mut arg0;
            let (v6, v7, _) = advance_route(v5, v3);
            arg1 = arg1 - v3;
            v0 = v0 + v6;
            v1 = v1 + v7;
        };
        if (!orderbook_minimums_satisfied(&arg0)) {
            return (0, true, v1, 18446744073709551615)
        };
        (v0, true, v1, 18446744073709551615)
    }

    fun record_candidate(arg0: u128, arg1: u128, arg2: &mut OptimizeResult) {
        if (arg1 <= arg0) {
            return
        };
        let v0 = arg1 - arg0;
        if (!arg2.found || v0 > arg2.gross_profit) {
            arg2.found = true;
            arg2.amount_in = arg0;
            arg2.amount_out = arg1;
            arg2.gross_profit = v0;
        };
    }

    fun record_candidate_if_valid(arg0: &vector<Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: &mut OptimizeResult) {
        if (!candidate_satisfies_orderbook_minimums(arg0, arg1)) {
            return
        };
        record_candidate(arg2, arg3, arg4);
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
            if (v1.kind == 2 && !orderbook_terminal(v1)) {
                let v2 = current_orderbook_segment(v1);
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

    public fun resume_coefficients(arg0: &mut OptimizeState) {
        let v0 = arg0.max_segments;
        resume_coefficients_until(arg0, v0);
        let v1 = if (!arg0.finished) {
            if (arg0.cursor < arg0.max_amount_in) {
                arg0.result.segments == arg0.max_segments
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            arg0.result.complete = false;
            arg0.finished = true;
        };
    }

    fun resume_coefficients_until(arg0: &mut OptimizeState, arg1: u64) {
        if (arg0.finished) {
            return
        };
        assert!(arg1 <= arg0.max_segments, 6);
        arg0.result.complete = true;
        arg0.result.needs_more_hop = 18446744073709551615;
        while (arg0.cursor < arg0.max_amount_in && arg0.result.segments < arg1) {
            let v0 = first_missing_orderbook_segment(&arg0.route);
            if (v0 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v0;
                return
            };
            let v1 = first_missing_linear_segment(&arg0.route);
            if (v1 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v1;
                return
            };
            if (!orderbook_minimums_reachable(&arg0.route)) {
                arg0.finished = true;
                return
            };
            let v2 = orderbook_minimums_satisfied(&arg0.route);
            let (v3, v4) = route_coefficients_x64(&arg0.route);
            if (v3 <= q64()) {
                if (arg0.cursor == 0) {
                    arg0.result.coarse_rejected = true;
                    arg0.finished = true;
                    return
                };
                if (v2) {
                    arg0.finished = true;
                    return
                };
            };
            let v5 = first_missing_boundary(&arg0.route);
            if (v5 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v5;
                return
            };
            let v6 = arg0.max_amount_in - arg0.cursor;
            let (v7, _) = next_route_boundary(&arg0.route, v6);
            assert!(v7 > 0, 3);
            arg0.result.segments = arg0.result.segments + 1;
            let v9 = q64() + v4 * (v7 as u256);
            if (v3 * q64() <= v9 * v9) {
                let v10 = &mut arg0.result;
                record_nearby_candidates(&arg0.route, arg0.cursor, arg0.cursor_output, coefficient_root(v3, v4, v7), v7, v10);
                if (v2 || candidate_satisfies_orderbook_minimums(&arg0.route, v7)) {
                    arg0.finished = true;
                    return
                };
            };
            if (v7 == v6) {
                let v11 = &mut arg0.result;
                record_candidate_if_valid(&arg0.route, v7, arg0.cursor + v7, arg0.cursor_output + quote_route(&arg0.route, v7), v11);
                arg0.finished = true;
                return
            };
            let v12 = &mut arg0.route;
            let (v13, v14, v15) = advance_route(v12, v7);
            arg0.cursor = arg0.cursor + v7;
            arg0.cursor_output = arg0.cursor_output + v13;
            arg0.result.crossed_ticks = arg0.result.crossed_ticks + v14;
            arg0.result.crossed_orders = arg0.result.crossed_orders + v15;
            let v16 = &mut arg0.result;
            record_candidate_if_valid(&arg0.route, 0, arg0.cursor, arg0.cursor_output, v16);
        };
        if (arg0.cursor >= arg0.max_amount_in) {
            arg0.finished = true;
        };
    }

    public fun reuse_current_stage() : StagedHop {
        StagedHop{
            kind        : 0,
            liquidity   : 0,
            boundaries  : 0x1::vector::empty<TickBoundary>(),
            replacement : 0x1::vector::empty<Hop>(),
        }
    }

    fun round_down_to_quantum(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 > 0, 3);
        arg0 - arg0 % arg1
    }

    fun round_up_to_quantum(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 > 0, 3);
        if (arg0 == 0) {
            0
        } else {
            arg0 + (arg1 - arg0 % arg1) % arg1
        }
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

    fun route_marginal_x64(arg0: &vector<Hop>) : u256 {
        let v0 = q64();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = v0 * hop_marginal_x64(0x1::vector::borrow<Hop>(arg0, v1));
            v0 = v2 / q64();
            v1 = v1 + 1;
        };
        v0
    }

    fun saturating_add(arg0: u256, arg1: u256) : u256 {
        if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 + arg1
        }
    }

    fun saturating_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 * arg1
        }
    }

    public fun segments(arg0: &OptimizeResult) : u64 {
        arg0.segments
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

    fun sqrt_down(arg0: u256) : u256 {
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

    public fun tick_boundary(arg0: u128, arg1: u128, arg2: bool) : TickBoundary {
        TickBoundary{
            sqrt_price_x64    : arg0,
            liquidity_net_abs : arg1,
            negative          : arg2,
        }
    }

    fun to_u128(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 4);
        (arg0 as u128)
    }

    public fun v2_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : Hop {
        assert!(arg0 > 0 && arg1 > 0, 3);
        assert!(arg3 > arg2, 2);
        Hop{
            kind                    : 0,
            fee_rate                : arg2,
            fee_denominator         : arg3,
            output_fee_rate         : 0,
            output_fee_denominator  : 1,
            reserve_in              : arg0,
            reserve_out             : arg1,
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
        }
    }

    public fun v2_hop_split_fee(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : Hop {
        assert!(arg0 > 0 && arg1 > 0, 3);
        assert!(arg3 > arg2, 2);
        assert!(arg5 > arg4, 2);
        Hop{
            kind                    : 0,
            fee_rate                : arg2,
            fee_denominator         : arg3,
            output_fee_rate         : arg4,
            output_fee_denominator  : arg5,
            reserve_in              : arg0,
            reserve_out             : arg1,
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
        }
    }

    public fun v3_current_hop(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : Hop {
        assert!(arg0 > 0, 3);
        assert!(arg2 > arg1, 2);
        Hop{
            kind                    : 4,
            fee_rate                : arg1,
            fee_denominator         : arg2,
            output_fee_rate         : 0,
            output_fee_denominator  : 1,
            reserve_in              : 0,
            reserve_out             : 0,
            sqrt_price_x64          : arg0,
            liquidity               : 0,
            zero_for_one            : arg3,
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
        }
    }

    public fun v3_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool, arg5: vector<TickBoundary>) : Hop {
        assert!(arg0 > 0 && arg1 > 0, 3);
        assert!(arg3 > arg2, 2);
        validate_boundaries(arg0, arg4, &arg5);
        Hop{
            kind                    : 1,
            fee_rate                : arg2,
            fee_denominator         : arg3,
            output_fee_rate         : 0,
            output_fee_denominator  : 1,
            reserve_in              : 0,
            reserve_out             : 0,
            sqrt_price_x64          : arg0,
            liquidity               : arg1,
            zero_for_one            : arg4,
            boundaries              : arg5,
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
        }
    }

    public fun v3_window_stage(arg0: u128, arg1: vector<TickBoundary>) : StagedHop {
        assert!(arg0 > 0, 3);
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

    fun validate_boundaries(arg0: u128, arg1: bool, arg2: &vector<TickBoundary>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TickBoundary>(arg2)) {
            let v1 = 0x1::vector::borrow<TickBoundary>(arg2, v0);
            if (arg1) {
                assert!(v1.sqrt_price_x64 < arg0, 3);
            } else {
                assert!(v1.sqrt_price_x64 > arg0, 3);
            };
            arg0 = v1.sqrt_price_x64;
            v0 = v0 + 1;
        };
    }

    fun validate_linear_segments(arg0: &vector<LinearSegment>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<LinearSegment>(arg0)) {
            let v3 = 0x1::vector::borrow<LinearSegment>(arg0, v2);
            assert!(v3.remaining_input > 0 && v3.remaining_output > 0, 3);
            if (v2 > 0) {
                assert!((v3.remaining_output as u256) * (v0 as u256) <= (v1 as u256) * (v3.remaining_input as u256), 3);
            };
            v0 = v3.remaining_input;
            v1 = v3.remaining_output;
            v2 = v2 + 1;
        };
    }

    fun validate_orderbook_segments(arg0: &vector<OrderbookSegment>, arg1: bool) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<OrderbookSegment>(arg0)) {
            let v2 = 0x1::vector::borrow<OrderbookSegment>(arg0, v1);
            assert!(v2.price > 0 && v2.remaining_base > 0, 3);
            if (v1 > 0) {
                if (arg1) {
                    assert!(v2.price <= v0, 3);
                } else {
                    assert!(v2.price >= v0, 3);
                };
            };
            v0 = v2.price;
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

