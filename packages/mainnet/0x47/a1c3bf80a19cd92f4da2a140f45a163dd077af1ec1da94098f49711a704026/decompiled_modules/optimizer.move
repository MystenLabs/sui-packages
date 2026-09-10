module 0x47a1c3bf80a19cd92f4da2a140f45a163dd077af1ec1da94098f49711a704026::optimizer {
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
        price_x64: u128,
        fee_rate: u64,
        fee_denominator: u64,
        forward: bool,
        exact_dlmm: bool,
    }

    struct V3Prefix has copy, drop, store {
        cumulative_input: u128,
        cumulative_output: u128,
        end_sqrt_price_x64: u128,
        liquidity_after: u128,
    }

    struct V3PrefixCache has drop {
        prefixes: vector<V3Prefix>,
        status: u8,
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
        stable_amp: u128,
        stable_scale_in: u128,
        stable_scale_out: u128,
        stable_admin_fee: u64,
        stable_lp_fee: u64,
        stable_th_fee: u64,
        stable_fee_on_input: bool,
        state_status: u8,
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
        status: u8,
        evaluations: u64,
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

    struct AftermathSigned has copy, drop {
        negative: bool,
        magnitude: u256,
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

    fun aftermath_a20(arg0: u64) : u256 {
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

    fun aftermath_exp(arg0: AftermathSigned) : u256 {
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

    fun aftermath_fixed_div_down(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 3);
        arg0 * 1000000000000000000 / arg1
    }

    fun aftermath_fixed_div_up(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 3);
        if (arg0 == 0) {
            0
        } else {
            (arg0 * 1000000000000000000 - 1) / arg1 + 1
        }
    }

    fun aftermath_fixed_mul_down(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000
    }

    fun aftermath_fixed_mul_up(arg0: u256, arg1: u256) : u256 {
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
        Hop{
            kind                    : 12,
            fee_rate                : arg4,
            fee_denominator         : (1000000000000000000 as u64),
            output_fee_rate         : arg5,
            output_fee_denominator  : (1000000000000000000 as u64),
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
            stable_amp              : (arg2 as u128) << 64 | (arg3 as u128),
            stable_scale_in         : arg6,
            stable_scale_out        : arg7,
            stable_admin_fee        : arg8,
            stable_lp_fee           : 0,
            stable_th_fee           : 0,
            stable_fee_on_input     : false,
            state_status            : v1,
        }
    }

    fun aftermath_ln(arg0: u256) : AftermathSigned {
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

    fun aftermath_ln_36(arg0: u256) : AftermathSigned {
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

    fun aftermath_log_exp_pow(arg0: u256, arg1: u256) : (u256, bool) {
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

    fun aftermath_pow_up(arg0: u256, arg1: u256) : (u256, bool) {
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

    fun aftermath_signed(arg0: u256, arg1: bool) : AftermathSigned {
        let v0 = arg1 && arg0 != 0;
        AftermathSigned{
            negative  : v0,
            magnitude : arg0,
        }
    }

    fun aftermath_signed_add(arg0: AftermathSigned, arg1: AftermathSigned) : AftermathSigned {
        if (arg0.negative == arg1.negative) {
            aftermath_signed(arg0.magnitude + arg1.magnitude, arg0.negative)
        } else if (arg0.magnitude >= arg1.magnitude) {
            aftermath_signed(arg0.magnitude - arg1.magnitude, arg0.negative)
        } else {
            aftermath_signed(arg1.magnitude - arg0.magnitude, arg1.negative)
        }
    }

    fun aftermath_signed_div_u(arg0: AftermathSigned, arg1: u256) : AftermathSigned {
        assert!(arg1 > 0, 3);
        aftermath_signed(arg0.magnitude / arg1, arg0.negative)
    }

    fun aftermath_signed_mul_u(arg0: AftermathSigned, arg1: u256) : AftermathSigned {
        aftermath_signed(arg0.magnitude * arg1, arg0.negative)
    }

    fun aftermath_signed_neg(arg0: AftermathSigned) : AftermathSigned {
        aftermath_signed(arg0.magnitude, !arg0.negative)
    }

    fun aftermath_signed_rem_u(arg0: AftermathSigned, arg1: u256) : AftermathSigned {
        assert!(arg1 > 0, 3);
        aftermath_signed(arg0.magnitude % arg1, arg0.negative)
    }

    fun aftermath_weights(arg0: &Hop) : (u64, u64) {
        (((arg0.stable_amp >> 64) as u64), ((arg0.stable_amp & (18446744073709551615 as u128)) as u64))
    }

    fun aftermath_x20(arg0: u64) : u256 {
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

    fun aligned_in_range(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
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

    public fun bounded_search_staged(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: vector<u128>, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64) : OptimizeResult {
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
        let (v2, v3, v4) = build_v3_prefix_caches(&v1, arg8);
        let v5 = v2;
        let v6 = empty_result();
        if (v3 != 0) {
            v6.complete = false;
            v6.status = v3;
            return v6
        };
        let v7 = arg8 - v4;
        let v8 = vector[];
        let v9 = 0;
        while (v9 < 0x1::vector::length<u128>(&arg2) && v6.evaluations < arg7) {
            let v10 = &mut v8;
            let v11 = &mut v7;
            let v12 = &mut v6;
            evaluate_bounded_probe(&v1, &v5, aligned_in_range(*0x1::vector::borrow<u128>(&arg2, v9), arg3, arg4, arg5), v10, v11, v12);
            v9 = v9 + 1;
        };
        let v13 = 0;
        loop {
            let v14 = if (v13 < arg6) {
                if (v6.evaluations < arg7) {
                    v7 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v14) {
                let v15 = &mut v8;
                let v16 = &mut v7;
                let v17 = &mut v6;
                evaluate_bounded_probe(&v1, &v5, refinement_point(&v6, &v8, arg3, arg4, arg5, v13), v15, v16, v17);
                v13 = v13 + 1;
            } else {
                break
            };
        };
        if (v9 < 0x1::vector::length<u128>(&arg2) || v13 < arg6) {
            v6.complete = false;
            if (v6.status == 0 || v6.status == 1) {
                v6.status = 6;
            };
        };
        v6
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
        let v4 = if (arg0 >= arg1) {
            v1
        } else {
            1
        };
        let v5 = if (arg0 >= arg1) {
            1
        } else {
            v1
        };
        let v6 = if (!v0) {
            5
        } else if (!arg5) {
            2
        } else {
            0
        };
        Hop{
            kind                    : 13,
            fee_rate                : arg2,
            fee_denominator         : 1000000000,
            output_fee_rate         : 0,
            output_fee_denominator  : 1,
            reserve_in              : (arg3 as u128),
            reserve_out             : 0,
            sqrt_price_x64          : 0,
            liquidity               : 0,
            zero_for_one            : arg0 >= arg1,
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
            stable_scale_in         : v4,
            stable_scale_out        : v5,
            stable_admin_fee        : 0,
            stable_lp_fee           : 0,
            stable_th_fee           : 0,
            stable_fee_on_input     : false,
            state_status            : v6,
        }
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
            let v5 = V3PrefixCache{
                prefixes : 0x1::vector::empty<V3Prefix>(),
                status   : 0,
            };
            if (v4.kind == 1 && v2 == 0) {
                let v6 = v4.sqrt_price_x64;
                let v7 = v4.liquidity;
                let v8 = 0;
                let v9 = 0;
                let v10 = v4.boundary_cursor;
                while (v10 < 0x1::vector::length<TickBoundary>(&v4.boundaries)) {
                    if (v1 >= arg1) {
                        v5.status = 6;
                        v2 = 6;
                        break
                    };
                    v1 = v1 + 1;
                    let v11 = *0x1::vector::borrow<TickBoundary>(&v4.boundaries, v10);
                    let v12 = if (v7 == 0) {
                        0
                    } else if (v4.zero_for_one) {
                        amount0_delta_up(v6, v11.sqrt_price_x64, v7)
                    } else {
                        mul_div_up(v7, v11.sqrt_price_x64 - v6, 18446744073709551616)
                    };
                    let v13 = gross_from_effective(v12, v4.fee_rate, v4.fee_denominator);
                    let v14 = if (v7 == 0) {
                        0
                    } else if (v4.zero_for_one) {
                        mul_div_down(v7, v6 - v11.sqrt_price_x64, 18446744073709551616)
                    } else {
                        amount0_delta_down(v6, v11.sqrt_price_x64, v7)
                    };
                    if (v8 > 340282366920938463463374607431768211455 - v13 || v9 > 340282366920938463463374607431768211455 - v14) {
                        v5.status = 5;
                        v2 = 5;
                        break
                    };
                    let v15 = v8 + v13;
                    v8 = v15;
                    let v16 = v9 + v14;
                    v9 = v16;
                    let (v17, v18) = liquidity_after_boundary(v7, v11, v4.zero_for_one);
                    if (!v18) {
                        v5.status = 5;
                        v2 = 5;
                        break
                    };
                    v7 = v17;
                    v6 = v11.sqrt_price_x64;
                    let v19 = V3Prefix{
                        cumulative_input   : v15,
                        cumulative_output  : v16,
                        end_sqrt_price_x64 : v6,
                        liquidity_after    : v17,
                    };
                    0x1::vector::push_back<V3Prefix>(&mut v5.prefixes, v19);
                    v10 = v10 + 1;
                };
            };
            0x1::vector::push_back<V3PrefixCache>(&mut v0, v5);
            v3 = v3 + 1;
        };
        (v0, v2, v1)
    }

    fun cached_quote_and_marginal(arg0: &vector<Hop>, arg1: &vector<V3PrefixCache>, arg2: u128, arg3: &mut u64) : (u128, u256, u8, u64) {
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
            let v5 = if (v4.kind == 0) {
                let v6 = effective_input(v0, v4.fee_rate, v4.fee_denominator);
                let v7 = v4.reserve_in + v6;
                v0 = effective_output(mul_div_down(v6, v4.reserve_out, v7), v4.output_fee_rate, v4.output_fee_denominator);
                mul_ratio_down_saturating(mul_ratio_down_saturating((v4.reserve_out as u256) * q64() / (v7 as u256), (v4.reserve_in as u256), (v7 as u256)), ((v4.output_fee_denominator - v4.output_fee_rate) as u256), (v4.output_fee_denominator as u256))
            } else if (v4.kind == 1) {
                let v8 = 0x1::vector::borrow<V3PrefixCache>(arg1, v3);
                let (v9, v10, v11) = quote_v3_cached(v4, v8, v0, arg3);
                if (v10 != 0) {
                    return (0, 0, v10, v2 + v11)
                };
                let (v12, v13, v14) = if (v11 == 0) {
                    (0, v4.sqrt_price_x64, v4.liquidity)
                } else {
                    let v15 = 0x1::vector::borrow<V3Prefix>(&v8.prefixes, v11 - 1);
                    (v15.cumulative_input, v15.end_sqrt_price_x64, v15.liquidity_after)
                };
                let v16 = if (v0 == v12) {
                    v13
                } else {
                    next_sqrt_price_scalar(v13, v14, v4.zero_for_one, effective_input(v0 - v12, v4.fee_rate, v4.fee_denominator), 0x1::vector::borrow<V3Prefix>(&v8.prefixes, v11).end_sqrt_price_x64)
                };
                let v17 = if (v4.zero_for_one) {
                    (v16 as u256) * (v16 as u256) / q64()
                } else {
                    q64() * q64() / (v16 as u256) * q64() / (v16 as u256)
                };
                v0 = v9;
                v2 = v2 + v11;
                v17
            } else {
                return (0, 0, 5, v2)
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

    fun contains_amount(arg0: &vector<u128>, arg1: u128) : bool {
        if (arg1 == 0) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(arg0)) {
            if (*0x1::vector::borrow<u128>(arg0, v0) == arg1) {
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

    public fun dlmm_hop_from_bins(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool) : Hop {
        let v0 = 0x1::vector::length<u128>(&arg0);
        let v1 = if (v0 == 0x1::vector::length<u128>(&arg1)) {
            if (v0 == 0x1::vector::length<u128>(&arg2)) {
                v0 == 0x1::vector::length<u64>(&arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        let v2 = 0x1::vector::empty<LinearSegment>();
        let v3 = 0;
        while (v3 < v0) {
            0x1::vector::push_back<LinearSegment>(&mut v2, dlmm_segment(*0x1::vector::borrow<u128>(&arg0, v3), *0x1::vector::borrow<u128>(&arg1, v3), *0x1::vector::borrow<u128>(&arg2, v3), *0x1::vector::borrow<u64>(&arg3, v3), arg4));
            v3 = v3 + 1;
        };
        linear_hop(v2, arg5)
    }

    public fun dlmm_segment(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: bool) : LinearSegment {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                if (arg2 > 0) {
                    arg3 < 1000000000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
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
            status          : 1,
            evaluations     : 0,
        }
    }

    fun evaluate_bounded_probe(arg0: &vector<Hop>, arg1: &vector<V3PrefixCache>, arg2: u128, arg3: &mut vector<u128>, arg4: &mut u64, arg5: &mut OptimizeResult) {
        if (contains_amount(arg3, arg2)) {
            return
        };
        0x1::vector::push_back<u128>(arg3, arg2);
        arg5.evaluations = arg5.evaluations + 1;
        let (v0, v1, v2, v3) = quote_bounded_route(arg0, arg1, arg2, arg4);
        arg5.crossed_ticks = arg5.crossed_ticks + v2;
        arg5.crossed_orders = arg5.crossed_orders + v3;
        if (v1 == 0) {
            record_candidate(arg2, v0, arg5);
        } else {
            arg5.complete = false;
            if (arg5.status == 0 || arg5.status == 1) {
                arg5.status = v1;
            };
        };
    }

    public fun evaluations(arg0: &OptimizeResult) : u64 {
        arg0.evaluations
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
        let v4 = if (arg6) {
            0
        } else {
            arg2
        };
        let v5 = if (arg6) {
            1000000000
        } else {
            1
        };
        let v6 = if (arg6) {
            0
        } else {
            1000000000
        };
        let v7 = if (arg6) {
            0
        } else {
            (arg3 as u128)
        };
        Hop{
            kind                    : 10,
            fee_rate                : 0,
            fee_denominator         : 1,
            output_fee_rate         : v4,
            output_fee_denominator  : 10000000,
            reserve_in              : (v1 as u128),
            reserve_out             : (v2 as u128),
            sqrt_price_x64          : 0,
            liquidity               : 0,
            zero_for_one            : arg6,
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
            stable_amp              : v5,
            stable_scale_in         : v6,
            stable_scale_out        : v7,
            stable_admin_fee        : 0,
            stable_lp_fee           : 0,
            stable_th_fee           : 0,
            stable_fee_on_input     : false,
            state_status            : v3,
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
        let v5 = if (arg8) {
            0
        } else {
            arg2
        };
        Hop{
            kind                    : 11,
            fee_rate                : 0,
            fee_denominator         : 1,
            output_fee_rate         : v5,
            output_fee_denominator  : 10000000,
            reserve_in              : (v1 as u128),
            reserve_out             : (v2 as u128),
            sqrt_price_x64          : 0,
            liquidity               : 0,
            zero_for_one            : arg8,
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
            stable_amp              : 1000000000,
            stable_scale_in         : 1,
            stable_scale_out        : (arg3 as u128),
            stable_admin_fee        : 0,
            stable_lp_fee           : 0,
            stable_th_fee           : 0,
            stable_fee_on_input     : false,
            state_status            : v4,
        }
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
        } else if (arg0.kind == 3) {
            if (linear_terminal(arg0)) {
                return 0
            };
            let v2 = current_linear_segment(arg0);
            div_ceil((v2.remaining_output as u256) * q64(), (v2.remaining_input as u256))
        } else if (arg0.kind == 12) {
            let (v3, v4) = aftermath_weights(arg0);
            mul_ratio_up_saturating(mul_ratio_up_saturating(mul_ratio_up_saturating(div_ceil((arg0.reserve_out as u256) * q64(), (arg0.reserve_in as u256)), (v3 as u256), (v4 as u256)), (arg0.stable_scale_in as u256), (arg0.stable_scale_out as u256)), 1000000000000000000 - (arg0.stable_admin_fee as u256), 1000000000000000000)
        } else {
            assert!(arg0.kind == 13, 1);
            if (arg0.zero_for_one) {
                div_ceil(q64(), (arg0.stable_scale_in as u256))
            } else {
                q64() * (arg0.stable_scale_out as u256)
            }
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
        } else if (arg0.kind == 3) {
            if (linear_terminal(arg0)) {
                return 0
            };
            let v2 = current_linear_segment(arg0);
            (v2.remaining_output as u256) * q64() / (v2.remaining_input as u256)
        } else if (arg0.kind == 12) {
            let (v3, v4) = aftermath_weights(arg0);
            mul_ratio_down_saturating(mul_ratio_down_saturating(mul_ratio_down_saturating((arg0.reserve_out as u256) * q64() / (arg0.reserve_in as u256), (v3 as u256), (v4 as u256)), (arg0.stable_scale_in as u256), (arg0.stable_scale_out as u256)), 1000000000000000000 - (arg0.stable_admin_fee as u256), 1000000000000000000)
        } else {
            assert!(arg0.kind == 13, 1);
            if (arg0.zero_for_one) {
                q64() / (arg0.stable_scale_in as u256)
            } else {
                q64() * (arg0.stable_scale_out as u256)
            }
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
                let v9 = if (v2.kind == 0) {
                    true
                } else if (v2.kind == 5) {
                    true
                } else if (v2.kind == 6) {
                    true
                } else if (v2.kind == 7) {
                    true
                } else if (v2.kind == 8) {
                    true
                } else if (v2.kind == 9) {
                    true
                } else if (v2.kind == 10) {
                    true
                } else if (v2.kind == 11) {
                    true
                } else if (v2.kind == 12) {
                    true
                } else if (v2.kind == 13) {
                    true
                } else if (v2.kind == 14) {
                    true
                } else if (v2.kind == 15) {
                    true
                } else {
                    v2.kind == 16
                };
                assert!(v9, 1);
                let v10 = if (v4 == 0) {
                    if (0x1::vector::length<TickBoundary>(&v8) == 0) {
                        0x1::vector::length<Hop>(&v7) == 0
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v10, 3);
                0x1::vector::push_back<Hop>(&mut v1, v2);
                continue
            };
            if (v3 == 1) {
                assert!(v2.kind == 4, 1);
                let v11 = if (v4 > 0) {
                    if (0x1::vector::length<TickBoundary>(&v2.boundaries) == 0) {
                        0x1::vector::length<Hop>(&v7) == 0
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v11, 3);
                v2.kind = 1;
                v2.liquidity = v4;
                0x1::vector::append<TickBoundary>(&mut v2.boundaries, v8);
                validate_boundaries(v2.sqrt_price_x64, v2.zero_for_one, &v2.boundaries);
                0x1::vector::push_back<Hop>(&mut v1, v2);
                continue
            };
            assert!(v3 == 2, 1);
            let v12 = if (v4 == 0) {
                if (0x1::vector::length<TickBoundary>(&v8) == 0) {
                    0x1::vector::length<Hop>(&v7) == 1
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v12, 3);
            let v13 = 0x1::vector::pop_back<Hop>(&mut v7);
            assert!(v2.kind == 2 && v13.kind == 2 || v2.kind == 3 && v13.kind == 3, 1);
            0x1::vector::push_back<Hop>(&mut v1, v13);
        };
        0x1::vector::reverse<Hop>(&mut v1);
        v1
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
        Hop{
            kind                    : 8,
            fee_rate                : arg3,
            fee_denominator         : 1000000,
            output_fee_rate         : arg2,
            output_fee_denominator  : 1000000,
            reserve_in              : (v0 as u128),
            reserve_out             : (v1 as u128),
            sqrt_price_x64          : 0,
            liquidity               : 0,
            zero_for_one            : arg8,
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
            stable_amp              : 100000000,
            stable_scale_in         : (v2 as u128),
            stable_scale_out        : (v3 as u128),
            stable_admin_fee        : 0,
            stable_lp_fee           : 0,
            stable_th_fee           : 0,
            stable_fee_on_input     : arg4,
            state_status            : v6,
        }
    }

    fun kriya_ve33_get_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        let v0 = 0;
        while (v0 < 255) {
            if (*arg3 == 0) {
                return (0, 6)
            };
            *arg3 = *arg3 - 1;
            if (arg0 > 10000000000000000000 || arg2 > 10000000000000000000) {
                return (0, 5)
            };
            let v1 = ve33_value(arg0, arg2);
            let v2 = ve33_derivative(arg0, arg2);
            if (v2 == 0) {
                return (0, 5)
            };
            let v3 = if (v1 < arg1) {
                let v4 = (arg1 - v1) / v2 + 1;
                if (v4 > 10000000000000000000 - arg2) {
                    return (0, 5)
                };
                arg2 = arg2 + v4;
                v4
            } else {
                let v5 = (v1 - arg1) / v2 + 1;
                if (v5 > arg2) {
                    return (0, 5)
                };
                arg2 = arg2 - v5;
                v5
            };
            if (v3 <= 1) {
                return (arg2, 0)
            };
            v0 = v0 + 1;
        };
        (0, 4)
    }

    fun largest_gap_midpoint(arg0: &vector<u128>, arg1: u128, arg2: u128, arg3: u128) : u128 {
        let v0 = arg2;
        let v1 = 0;
        while (arg1 < arg2) {
            let v2 = arg2;
            let v3 = 0;
            while (v3 < 0x1::vector::length<u128>(arg0)) {
                let v4 = *0x1::vector::borrow<u128>(arg0, v3);
                if (v4 > arg1 && v4 < arg2) {
                    v2 = v4;
                };
                v3 = v3 + 1;
            };
            if (v2 - arg1 > v1) {
                v1 = v2 - arg1;
                v0 = v2;
            };
            if (v2 == arg2) {
                break
            };
            arg1 = v2;
        };
        aligned_in_range(midpoint(arg1, v0), arg1, arg2, arg3)
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

    fun liquidity_after_boundary(arg0: u128, arg1: TickBoundary, arg2: bool) : (u128, bool) {
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
        Hop{
            kind                    : 9,
            fee_rate                : v2,
            fee_denominator         : 10000,
            output_fee_rate         : 0,
            output_fee_denominator  : 1,
            reserve_in              : (v0 as u128),
            reserve_out             : (v1 as u128),
            sqrt_price_x64          : 0,
            liquidity               : 0,
            zero_for_one            : arg5,
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
            stable_amp              : (arg6 as u128),
            stable_scale_in         : 1,
            stable_scale_out        : 1,
            stable_admin_fee        : 0,
            stable_lp_fee           : 0,
            stable_th_fee           : 0,
            stable_fee_on_input     : arg5,
            state_status            : v3,
        }
    }

    public fun marginal_upper_x64(arg0: &vector<Hop>) : u256 {
        assert!(0x1::vector::length<Hop>(arg0) > 0, 5);
        route_marginal_upper_x64(arg0)
    }

    public fun marginal_x64(arg0: &vector<Hop>) : u256 {
        assert!(0x1::vector::length<Hop>(arg0) > 0, 5);
        route_marginal_x64(arg0)
    }

    fun midpoint(arg0: u128, arg1: u128) : u128 {
        arg0 + (arg1 - arg0) / 2
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

    fun mul_ratio_down_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0, 3);
        if (arg0 == 0 || arg1 == 0) {
            0
        } else if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 * arg1 / arg2
        }
    }

    fun mul_ratio_up_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0, 3);
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

    fun next_sqrt_price_scalar(arg0: u128, arg1: u128, arg2: bool, arg3: u128, arg4: u128) : u128 {
        let v0 = if (arg2) {
            amount0_delta_up(arg0, arg4, arg1)
        } else {
            mul_div_up(arg1, arg4 - arg0, 18446744073709551616)
        };
        if (arg3 >= v0) {
            return arg4
        };
        if (arg2) {
            let v2 = (arg1 as u256) << 64;
            to_u128(div_up_u256(v2, v2 / (arg0 as u256) + (arg3 as u256)))
        } else {
            arg0 + mul_div_down(arg3, 18446744073709551616, arg1)
        }
    }

    public fun no_hop() : u64 {
        18446744073709551615
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

    public fun optimize_baseline(arg0: vector<Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        optimize_impl(arg0, arg1, arg2, 0)
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
            let v10 = &mut v6;
            let (v11, v12, v13, v14) = cached_quote_and_marginal(&arg0, &v5, arg1, v10);
            v1.evaluations = v1.evaluations + 1;
            if (v13 == 0) {
                let v15 = &mut v1;
                record_candidate(arg1, v11, v15);
                if (v1.amount_in == arg1) {
                    v1.crossed_ticks = v14;
                };
                if (v12 > q64()) {
                    v7 = arg1;
                } else {
                    v8 = arg1;
                };
            } else if (v13 == 3) {
                v8 = arg1;
                v9 = true;
            } else {
                v1.complete = false;
                v1.status = v13;
                return v1
            };
            let v16 = if (v9 && arg2 > 25) {
                25
            } else {
                arg2
            };
            let v17 = mul_div_down(v7, (v16 as u128), 10000);
            let v18 = if (v17 > 1) {
                v17
            } else {
                1
            };
            if (v8 - v7 <= v18) {
                v1.complete = !v9;
                if (v9) {
                    v1.status = 3;
                };
                return v1
            };
            arg1 = v7 + (v8 - v7) / 2;
        };
        v1.complete = false;
        v1.status = 6;
        v1
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
            0x1::vector::push_back<Hop>(&mut v0, v4);
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

    fun prefix_upper_bound(arg0: &vector<V3Prefix>, arg1: u128, arg2: &mut u64) : (u64, u8) {
        let v0 = 0x1::vector::length<V3Prefix>(arg0);
        if (v0 <= 8) {
            let v1 = 0;
            while (v1 < v0) {
                if (*arg2 == 0) {
                    return (v1, 6)
                };
                *arg2 = *arg2 - 1;
                if (0x1::vector::borrow<V3Prefix>(arg0, v1).cumulative_input > arg1) {
                    break
                };
                v1 = v1 + 1;
            };
            return (v1, 0)
        };
        let v2 = 0;
        while (v2 < v0) {
            if (*arg2 == 0) {
                return (v2, 6)
            };
            *arg2 = *arg2 - 1;
            let v3 = v2 + (v0 - v2) / 2;
            if (0x1::vector::borrow<V3Prefix>(arg0, v3).cumulative_input <= arg1) {
                v2 = v3 + 1;
                continue
            };
            v0 = v3;
        };
        (v2, 0)
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

    fun quote_aftermath_geometric_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (arg1 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg2 < 40) {
            return (0, 6, 0)
        };
        *arg2 = *arg2 - 40;
        let v0 = (effective_input(arg1, arg0.stable_admin_fee, (1000000000000000000 as u64)) as u256) * (arg0.stable_scale_in as u256);
        if (v0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / 1000000000000000000) {
            return (0, 5, 0)
        };
        let v1 = aftermath_fixed_mul_down(v0, 1000000000000000000 - (arg0.fee_rate as u256));
        let v2 = (arg0.reserve_in as u256);
        if (v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v2) {
            return (0, 5, 0)
        };
        let (v3, v4) = aftermath_weights(arg0);
        let (v5, v6) = aftermath_pow_up(aftermath_fixed_div_up(v2, v2 + v1), aftermath_fixed_div_down((v3 as u256), (v4 as u256)));
        if (!v6) {
            return (0, 5, 0)
        };
        let v7 = if (v5 < 1000000000000000000) {
            1000000000000000000 - v5
        } else {
            0
        };
        let v8 = aftermath_fixed_mul_down(aftermath_fixed_mul_down((arg0.reserve_out as u256), v7), 1000000000000000000 - (arg0.output_fee_rate as u256)) / (arg0.stable_scale_out as u256);
        if (v8 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v8 as u128), 0, 0)
    }

    fun quote_bounded_route(arg0: &vector<Hop>, arg1: &vector<V3PrefixCache>, arg2: u128, arg3: &mut u64) : (u128, u8, u64, u64) {
        if (0x1::vector::length<Hop>(arg0) != 0x1::vector::length<V3PrefixCache>(arg1)) {
            return (0, 5, 0, 0)
        };
        let v0 = arg2;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(arg0)) {
            let v4 = 0x1::vector::borrow<Hop>(arg0, v3);
            if (v4.state_status != 0) {
                return (0, v4.state_status, v1, v2)
            };
            let (v5, v6, v7) = if (v4.kind == 0) {
                if (*arg3 == 0) {
                    return (0, 6, v1, v2)
                };
                *arg3 = *arg3 - 1;
                let v8 = effective_input(v0, v4.fee_rate, v4.fee_denominator);
                let v9 = if (v8 == 0) {
                    0
                } else {
                    mul_div_down(v8, v4.reserve_out, v4.reserve_in + v8)
                };
                (effective_output(v9, v4.output_fee_rate, v4.output_fee_denominator), 0, 0)
            } else if (v4.kind == 5) {
                quote_stable_hop(v4, v0, arg3)
            } else if (v4.kind == 6) {
                quote_ve33_stable_hop(v4, v0, arg3)
            } else if (v4.kind == 7) {
                quote_virtual_cpmm_hop(v4, v0, arg3)
            } else if (v4.kind == 8) {
                quote_kriya_v2_hop(v4, v0, arg3)
            } else if (v4.kind == 9) {
                quote_lst_ratio_hop(v4, v0, arg3)
            } else if (v4.kind == 10) {
                quote_hasui_ratio_hop(v4, v0, arg3)
            } else if (v4.kind == 11) {
                quote_hawal_ratio_hop(v4, v0, arg3)
            } else if (v4.kind == 12) {
                quote_aftermath_geometric_hop(v4, v0, arg3)
            } else if (v4.kind == 13) {
                quote_bucket_psm_hop(v4, v0, arg3)
            } else if (v4.kind == 14) {
                quote_steamm_cpmm_hop(v4, v0, arg3)
            } else if (v4.kind == 15) {
                quote_steamm_omm_hop(v4, v0, arg3)
            } else if (v4.kind == 16) {
                quote_steamm_omm_v2_legacy_hop(v4, v0, arg3)
            } else {
                let (v10, v11, v12) = if (v4.kind == 2) {
                    let (v13, v14, v15) = quote_orderbook_hop_bounded(v4, v0, arg3);
                    v2 = v2 + v15;
                    (0, v13, v14)
                } else {
                    let (v16, v17, v18) = if (v4.kind == 3) {
                        quote_linear_hop_bounded(v4, v0, arg3)
                    } else if (v4.kind == 1) {
                        quote_v3_cached(v4, 0x1::vector::borrow<V3PrefixCache>(arg1, v3), v0, arg3)
                    } else {
                        (0, 5, 0)
                    };
                    (v18, v16, v17)
                };
                (v11, v12, v10)
            };
            if (v6 != 0) {
                return (0, v6, v1 + v7, v2)
            };
            v0 = v5;
            v1 = v1 + v7;
            v3 = v3 + 1;
        };
        (v0, 0, v1, v2)
    }

    fun quote_bucket_psm_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (*arg2 == 0) {
            return (0, 6, 0)
        };
        *arg2 = *arg2 - 1;
        if (arg1 > arg0.reserve_in) {
            return (0, 0, 0)
        };
        let v0 = if (arg0.zero_for_one) {
            arg1 / arg0.stable_scale_in
        } else {
            if (arg1 > 340282366920938463463374607431768211455 / arg0.stable_scale_out) {
                return (0, 5, 0)
            };
            arg1 * arg0.stable_scale_out
        };
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = div_ceil((v0 as u256) * (arg0.fee_rate as u256), (arg0.fee_denominator as u256));
        if (v1 > (v0 as u256)) {
            return (0, 0, 0)
        };
        ((((v0 as u256) - v1) as u128), 0, 0)
    }

    fun quote_hasui_ratio_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (arg1 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg2 == 0) {
            return (0, 6, 0)
        };
        *arg2 = *arg2 - 1;
        if (arg1 < arg0.stable_amp) {
            return (0, 0, 0)
        };
        let v0 = (arg1 as u256) * (arg0.reserve_out as u256) / (arg0.reserve_in as u256);
        if (v0 == 0 || v0 > (18446744073709551615 as u256)) {
            return (0, 0, 0)
        };
        if (!arg0.zero_for_one) {
            if (v0 < (arg0.stable_scale_in as u256) || v0 > (arg0.stable_scale_out as u256)) {
                return (0, 0, 0)
            };
        };
        let v1 = v0 * (arg0.output_fee_rate as u256) / (arg0.output_fee_denominator as u256);
        if (v1 > v0) {
            return (0, 5, 0)
        };
        (((v0 - v1) as u128), 0, 0)
    }

    fun quote_hawal_ratio_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (arg1 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg2 == 0) {
            return (0, 6, 0)
        };
        *arg2 = *arg2 - 1;
        if (arg0.zero_for_one && arg1 < arg0.stable_amp) {
            return (0, 0, 0)
        };
        let v0 = (arg1 as u256) * (arg0.reserve_out as u256) / (arg0.reserve_in as u256);
        if (v0 == 0 || v0 > (18446744073709551615 as u256)) {
            return (0, 0, 0)
        };
        let v1 = if (!arg0.zero_for_one) {
            if (v0 < (arg0.stable_amp as u256)) {
                true
            } else if (v0 > (arg0.reserve_out as u256)) {
                true
            } else {
                v0 > (arg0.stable_scale_out as u256)
            }
        } else {
            false
        };
        if (v1) {
            return (0, 0, 0)
        };
        let v2 = v0 * (arg0.output_fee_rate as u256) / (arg0.output_fee_denominator as u256);
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

    fun quote_kriya_v2_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (arg1 > 18446744073709551615) {
            return (0, 5, 0)
        };
        let v0 = arg1 - arg1 * (arg0.fee_rate as u128) / (arg0.fee_denominator as u128);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        if (!arg0.stable_fee_on_input) {
            if (*arg2 == 0) {
                return (0, 6, 0)
            };
            *arg2 = *arg2 - 1;
            let v1 = (v0 as u256) * ((arg0.output_fee_denominator - arg0.output_fee_rate) as u256);
            let v2 = (arg0.reserve_in as u256) * (arg0.output_fee_denominator as u256) + v1;
            if (v2 == 0) {
                return (0, 5, 0)
            };
            let v3 = v1 * (arg0.reserve_out as u256) / v2;
            if (v3 > (18446744073709551615 as u256)) {
                return (0, 5, 0)
            };
            return ((v3 as u128), 0, 0)
        };
        let v4 = (arg0.stable_amp as u256);
        let v5 = (arg0.stable_scale_in as u256);
        let v6 = (arg0.stable_scale_out as u256);
        let v7 = (arg0.reserve_in as u256) * v4 / v5;
        let v8 = (arg0.reserve_out as u256) * v4 / v6;
        let v9 = (v0 as u256) * v4 / v5 * ((arg0.output_fee_denominator - arg0.output_fee_rate) as u256) / (arg0.output_fee_denominator as u256);
        if (v9 > 10000000000000000000 || v7 > 10000000000000000000 - v9) {
            return (0, 5, 0)
        };
        let (v10, v11) = kriya_ve33_get_y(v7 + v9, ve33_invariant(v7, v8), v8, arg2);
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
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        let v0 = arg1;
        let v1 = 0;
        let v2 = arg0.linear_cursor;
        let v3 = 0;
        while (v0 > 0 && v2 < 0x1::vector::length<LinearSegment>(&arg0.linear_segments)) {
            if (*arg2 == 0) {
                return (0, 6, v3)
            };
            *arg2 = *arg2 - 1;
            let v4 = 0x1::vector::borrow<LinearSegment>(&arg0.linear_segments, v2);
            let v5 = if (v0 < v4.remaining_input) {
                v0
            } else {
                v4.remaining_input
            };
            let v6 = quote_linear_segment_value(v4, v5);
            if (v1 > 340282366920938463463374607431768211455 - v6) {
                return (0, 5, v3)
            };
            v1 = v1 + v6;
            v0 = v0 - v5;
            if (v5 == v4.remaining_input) {
                v3 = v3 + 1;
                v2 = v2 + 1;
            } else {
                break
            };
        };
        let (v7, v8) = if (v0 > 0) {
            if (arg0.linear_has_more) {
                (0, 3)
            } else {
                (0, 0)
            }
        } else {
            (v1, 0)
        };
        (v7, v8, v3)
    }

    fun quote_linear_segment(arg0: &Hop, arg1: u128) : u128 {
        if (arg1 == 0 || linear_terminal(arg0)) {
            return 0
        };
        quote_linear_segment_value(current_linear_segment(arg0), arg1)
    }

    fun quote_linear_segment_value(arg0: &LinearSegment, arg1: u128) : u128 {
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

    fun quote_lst_ratio_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (arg1 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg2 == 0) {
            return (0, 6, 0)
        };
        *arg2 = *arg2 - 1;
        if (arg1 < arg0.stable_amp) {
            return (0, 0, 0)
        };
        let v0 = (arg0.fee_denominator as u256);
        let v1 = div_ceil((arg1 as u256) * (arg0.fee_rate as u256), v0);
        let v2 = if (arg0.zero_for_one) {
            if (v1 > (arg1 as u256)) {
                return (0, 5, 0)
            };
            ((arg1 as u256) - v1) * (arg0.reserve_out as u256) / (arg0.reserve_in as u256)
        } else {
            let v3 = (arg1 as u256) * (arg0.reserve_out as u256) / (arg0.reserve_in as u256);
            let v4 = div_ceil(v3 * (arg0.fee_rate as u256), v0);
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

    fun quote_orderbook_hop_bounded(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        let v0 = effective_input(arg1, arg0.fee_rate, arg0.fee_denominator);
        let v1 = 0;
        let v2 = 0;
        let v3 = arg0.orderbook_cursor;
        let v4 = 0;
        while (v0 > 0 && v3 < 0x1::vector::length<OrderbookSegment>(&arg0.orderbook_segments)) {
            if (*arg2 == 0) {
                return (0, 6, v4)
            };
            *arg2 = *arg2 - 1;
            let v5 = 0x1::vector::borrow<OrderbookSegment>(&arg0.orderbook_segments, v3);
            let v6 = if (arg0.orderbook_base_to_quote) {
                v0
            } else {
                mul_div_down(v0, 1000000000, v5.price)
            };
            let v7 = round_down_to_quantum(v6, arg0.orderbook_lot_size);
            let v8 = if (v7 < v5.remaining_base) {
                v7
            } else {
                v5.remaining_base
            };
            if (v8 == 0) {
                break
            };
            let v9 = mul_div_down(v8, v5.price, 1000000000);
            let v10 = if (arg0.orderbook_base_to_quote) {
                v8
            } else {
                v9
            };
            if (v10 > v0) {
                return (0, 5, v4)
            };
            v0 = v0 - v10;
            let v11 = if (arg0.orderbook_base_to_quote) {
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
        if (v2 < arg0.orderbook_min_size) {
            return (0, 1, v4)
        };
        let v12 = if (v0 > 0) {
            if (v3 == 0x1::vector::length<OrderbookSegment>(&arg0.orderbook_segments)) {
                arg0.orderbook_has_more
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

    fun quote_stable_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (arg1 > 18446744073709551615) {
            return (0, 5, 0)
        };
        let v0 = arg1;
        if (arg0.stable_fee_on_input) {
            v0 = stable_fee_remainder(stable_fee_remainder(arg1, arg0.stable_admin_fee), arg0.stable_th_fee);
        };
        let v1 = stable_fee_remainder(v0, arg0.stable_lp_fee);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let v2 = (arg0.reserve_in as u256) * (arg0.stable_scale_in as u256);
        let v3 = (arg0.reserve_out as u256) * (arg0.stable_scale_out as u256);
        let v4 = (v1 as u256) * (arg0.stable_scale_in as u256);
        if (v2 + v4 > 1267650600228229401496703205376) {
            return (0, 5, 0)
        };
        let (v5, v6) = stable_compute_d(v2, v3, (arg0.stable_amp as u256), arg2);
        if (v6 != 0) {
            return (0, v6, 0)
        };
        let (v7, v8) = stable_compute_y(v2 + v4, v5, (arg0.stable_amp as u256), arg2);
        if (v8 != 0) {
            return (0, v8, 0)
        };
        if (v3 <= v7 + 1) {
            return (0, 0, 0)
        };
        let v9 = v3 - v7 - 1;
        let (v10, v11) = stable_compute_d(v2 + v4, v3 + v9, (arg0.stable_amp as u256), arg2);
        if (v11 != 0) {
            return (0, v11, 0)
        };
        if (v10 < v5) {
            return (0, 5, 0)
        };
        let v12 = v9 / (arg0.stable_scale_out as u256);
        if (v12 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        let v13 = (v12 as u128);
        let v14 = v13;
        if (!arg0.stable_fee_on_input) {
            v14 = stable_fee_remainder(stable_fee_remainder(v13, arg0.stable_admin_fee), arg0.stable_th_fee);
        };
        (v14, 0, 0)
    }

    public fun quote_staged_window(arg0: vector<Hop>, arg1: vector<StagedHop>, arg2: u128) : (u128, bool, u64, u64) {
        quote_window(join_staged_route(arg0, arg1), arg2)
    }

    fun quote_steamm_cpmm_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (arg1 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg2 == 0) {
            return (0, 6, 0)
        };
        *arg2 = *arg2 - 1;
        let (v0, v1) = steamm_btoken_supplies(arg0);
        let v2 = (arg1 as u256) * (v0 as u256) * 1000000000000000000 / (arg0.stable_scale_in as u256);
        if (v2 == 0 || v2 > (18446744073709551615 as u256)) {
            return (0, 0, 0)
        };
        let v3 = (arg0.reserve_out as u256) * v2 / ((arg0.reserve_in as u256) + v2);
        if (v3 == 0 || v3 > (arg0.liquidity as u256)) {
            return (0, 0, 0)
        };
        let v4 = div_ceil(v3 * (arg0.output_fee_rate as u256), (arg0.output_fee_denominator as u256));
        if (v4 >= v3) {
            return (0, 0, 0)
        };
        let v5 = steamm_btoken_burn_amount(v3 - v4, v1);
        if (v5 == 0) {
            return (0, 0, 0)
        };
        let v6 = v5 * (arg0.stable_scale_out as u256) / (v1 as u256) * 1000000000000000000;
        if (v6 > (arg0.sqrt_price_x64 as u256) || v6 > (18446744073709551615 as u256)) {
            return (0, 0, 0)
        };
        ((v6 as u128), 0, 0)
    }

    fun quote_steamm_omm_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (arg1 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg2 == 0) {
            return (0, 6, 0)
        };
        *arg2 = *arg2 - 1;
        let (v0, v1) = steamm_btoken_supplies(arg0);
        let v2 = (arg1 as u256) * (v0 as u256) * 1000000000000000000 / (arg0.stable_scale_in as u256);
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
        let v4 = ((arg0.stable_scale_in as u256) + (arg1 as u256) * 1000000000000000000) / ((v0 as u256) + v2);
        let v5 = (arg0.stable_scale_out as u256) / (v1 as u256);
        if (v4 == 0 || v5 == 0) {
            return (0, 5, 0)
        };
        let (v6, v7) = steamm_decimal_mul(v2 * 1000000000000000000, v4);
        if (!v7) {
            return (0, 5, 0)
        };
        let (v8, v9) = steamm_decimal_mul(v6, (arg0.reserve_in as u256));
        if (!v9) {
            return (0, 5, 0)
        };
        let (v10, v11) = steamm_decimal_div(v8, (arg0.liquidity as u256));
        if (!v11) {
            return (0, 5, 0)
        };
        let (v12, v13) = steamm_decimal_div(v10, v5);
        let v14 = v12;
        if (!v13) {
            return (0, 5, 0)
        };
        let v15 = 1;
        let v16 = (arg0.stable_admin_fee as u8);
        let v17 = (arg0.stable_lp_fee as u8);
        let v18 = if (v16 >= v17) {
            v16 - v17
        } else {
            v17 - v16
        };
        let v19 = 0;
        while (v19 < v18) {
            v15 = v15 * 10;
            v19 = v19 + 1;
        };
        if (v16 > v17) {
            v14 = v12 / v15;
        } else if (v17 > v16) {
            if (v12 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v15) {
                return (0, 5, 0)
            };
            v14 = v12 * v15;
        };
        let v20 = v14 / 1000000000000000000;
        let v21 = if (v20 == 0) {
            true
        } else if (v20 >= (arg0.reserve_out as u256)) {
            true
        } else {
            v20 > (18446744073709551615 as u256)
        };
        if (v21) {
            return (0, 0, 0)
        };
        let v22 = div_ceil(v20 * (arg0.output_fee_rate as u256), (arg0.output_fee_denominator as u256));
        if (v22 >= v20) {
            return (0, 0, 0)
        };
        let v23 = steamm_btoken_burn_amount(v20 - v22, v1);
        if (v23 == 0) {
            return (0, 0, 0)
        };
        let v24 = v23 * (arg0.stable_scale_out as u256) / (v1 as u256) * 1000000000000000000;
        if (v24 > (arg0.sqrt_price_x64 as u256) || v24 > (18446744073709551615 as u256)) {
            return (0, 0, 0)
        };
        ((v24 as u128), 0, 0)
    }

    fun quote_steamm_omm_v2_legacy_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (arg1 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg2 == 0) {
            return (0, 6, 0)
        };
        *arg2 = *arg2 - 1;
        let (v0, v1) = steamm_btoken_supplies(arg0);
        let v2 = (arg1 as u256) * (v0 as u256) * 1000000000000000000 / (arg0.stable_scale_in as u256);
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
        let v4 = ((arg0.stable_scale_in as u256) + (arg1 as u256) * 1000000000000000000) / ((v0 as u256) + v2);
        let v5 = (arg0.stable_scale_out as u256) / (v1 as u256);
        if (v4 == 0 || v5 == 0) {
            return (0, 5, 0)
        };
        let v6 = if (arg0.zero_for_one) {
            v4
        } else {
            v5
        };
        let v7 = if (arg0.zero_for_one) {
            v5
        } else {
            v4
        };
        let (v8, v9) = steamm_q_from_decimal((arg0.reserve_in as u256) * v6);
        let (v10, v11) = steamm_q_from_decimal((arg0.reserve_out as u256) * v7);
        let (v12, v13) = steamm_q_from_decimal(v2 * v4);
        let (v14, v15) = steamm_q_from_decimal((arg0.liquidity as u256));
        let (v16, v17) = steamm_q_from_decimal((arg0.orderbook_lot_size as u256));
        let (v18, v19) = steamm_q_from_integer((arg0.stable_th_fee as u128));
        let v20 = if (!v9) {
            true
        } else if (!v11) {
            true
        } else if (!v13) {
            true
        } else if (!v15) {
            true
        } else if (!v17) {
            true
        } else {
            !v19
        };
        if (v20) {
            return (0, 5, 0)
        };
        let v21 = (arg0.stable_admin_fee as u8);
        let v22 = (arg0.stable_lp_fee as u8);
        let v23 = if (v21 >= v22) {
            v21 - v22
        } else {
            v22 - v21
        };
        let v24 = 1;
        let v25 = 0;
        while (v25 < v23) {
            v24 = v24 * 10;
            v25 = v25 + 1;
        };
        let (v26, v27) = steamm_q_from_integer(v24);
        if (!v27) {
            return (0, 5, 0)
        };
        let v28 = if (v21 >= v22) {
            v26
        } else {
            let (v29, v30) = steamm_q_div(18446744073709551616, v26);
            if (!v30) {
                return (0, 5, 0)
            };
            v29
        };
        let (v31, v32) = if (arg0.zero_for_one) {
            let v33 = 0x1::vector::empty<u128>();
            let v34 = &mut v33;
            0x1::vector::push_back<u128>(v34, v12);
            0x1::vector::push_back<u128>(v34, v14);
            let v35 = 0x1::vector::empty<u128>();
            let v36 = &mut v35;
            0x1::vector::push_back<u128>(v36, v10);
            0x1::vector::push_back<u128>(v36, v16);
            0x1::vector::push_back<u128>(v36, v28);
            steamm_q_multiply_divide(v33, v35)
        } else {
            let v37 = 0x1::vector::empty<u128>();
            let v38 = &mut v37;
            0x1::vector::push_back<u128>(v38, v12);
            0x1::vector::push_back<u128>(v38, v28);
            0x1::vector::push_back<u128>(v38, v16);
            let v39 = 0x1::vector::empty<u128>();
            let v40 = &mut v39;
            0x1::vector::push_back<u128>(v40, v8);
            0x1::vector::push_back<u128>(v40, v14);
            steamm_q_multiply_divide(v37, v39)
        };
        if (!v32) {
            return (0, 5, 0)
        };
        let (v41, v42) = steamm_q_newton(v31, v18);
        if (!v42) {
            return (0, 5, 0)
        };
        let v43 = if (arg0.zero_for_one) {
            v10
        } else {
            v8
        };
        let (v44, v45) = steamm_q_mul(v41, v43);
        if (!v45) {
            return (0, 5, 0)
        };
        let v46 = ((v44 >> 64) as u256) * 1000000000000000000 / v5;
        let v47 = if (arg0.zero_for_one) {
            arg0.reserve_out
        } else {
            arg0.reserve_in
        };
        if (v46 == 0 || v46 >= (v47 as u256)) {
            return (0, 0, 0)
        };
        let (v48, v49) = steamm_omm_v2_linear_btoken_output(arg0, v2, v4, v5);
        if (!v49 || v46 >= v48) {
            return (0, 0, 0)
        };
        let v50 = div_ceil(v46 * (arg0.output_fee_rate as u256), (arg0.output_fee_denominator as u256));
        if (v50 >= v46) {
            return (0, 0, 0)
        };
        let v51 = steamm_btoken_burn_amount(v46 - v50, v1);
        if (v51 == 0) {
            return (0, 0, 0)
        };
        let v52 = v51 * (arg0.stable_scale_out as u256) / (v1 as u256) * 1000000000000000000;
        if (v52 > (arg0.sqrt_price_x64 as u256) || v52 > (18446744073709551615 as u256)) {
            return (0, 0, 0)
        };
        ((v52 as u128), 0, 0)
    }

    fun quote_v3_cached(arg0: &Hop, arg1: &V3PrefixCache, arg2: u128, arg3: &mut u64) : (u128, u8, u64) {
        if (arg1.status != 0) {
            return (0, arg1.status, 0)
        };
        if (arg2 == 0) {
            return (0, 0, 0)
        };
        let v0 = 0x1::vector::length<V3Prefix>(&arg1.prefixes);
        if (v0 == 0) {
            return (0, 3, 0)
        };
        let (v1, v2) = prefix_upper_bound(&arg1.prefixes, arg2, arg3);
        if (v2 != 0) {
            return (0, v2, v1)
        };
        let (v3, v4, v5, v6) = if (v1 == 0) {
            (0, 0, arg0.sqrt_price_x64, arg0.liquidity)
        } else {
            let v7 = 0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v1 - 1);
            (v7.cumulative_input, v7.cumulative_output, v7.end_sqrt_price_x64, v7.liquidity_after)
        };
        if (arg2 == v3) {
            return (v4, 0, v1)
        };
        if (v1 == v0 || v6 == 0) {
            return (0, 3, v1)
        };
        if (*arg3 == 0) {
            return (0, 6, v1)
        };
        *arg3 = *arg3 - 1;
        let v8 = effective_input(arg2 - v3, arg0.fee_rate, arg0.fee_denominator);
        let v9 = if (v8 == 0) {
            v5
        } else {
            next_sqrt_price_scalar(v5, v6, arg0.zero_for_one, v8, 0x1::vector::borrow<V3Prefix>(&arg1.prefixes, v1).end_sqrt_price_x64)
        };
        let v10 = if (arg0.zero_for_one) {
            mul_div_down(v6, v5 - v9, 18446744073709551616)
        } else {
            amount0_delta_down(v5, v9, v6)
        };
        let (v11, v12) = if (v4 > 340282366920938463463374607431768211455 - v10) {
            (0, 5)
        } else {
            (v4 + v10, 0)
        };
        (v11, v12, v1)
    }

    fun quote_ve33_stable_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (arg1 > 18446744073709551615) {
            return (0, 5, 0)
        };
        let v0 = arg1 - arg1 * (arg0.fee_rate as u128) / (arg0.fee_denominator as u128);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = (arg0.stable_amp as u256);
        let v2 = (arg0.reserve_in as u256) * v1 / (arg0.stable_scale_in as u256);
        let v3 = (arg0.reserve_out as u256) * v1 / (arg0.stable_scale_out as u256);
        let v4 = (v0 as u256) * v1 / (arg0.stable_scale_in as u256);
        if (v4 > 10000000000000000000 || v2 > 10000000000000000000 - v4) {
            return (0, 5, 0)
        };
        let (v5, v6) = ve33_get_y(v2 + v4, ve33_invariant(v2, v3), v3, arg2);
        if (v6 != 0) {
            return (0, v6, 0)
        };
        if (v5 > v3) {
            return (0, 5, 0)
        };
        let v7 = (v3 - v5) * (arg0.stable_scale_out as u256) / v1;
        if (v7 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v7 as u128), 0, 0)
    }

    fun quote_virtual_cpmm_hop(arg0: &Hop, arg1: u128, arg2: &mut u64) : (u128, u8, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        if (*arg2 == 0) {
            return (0, 6, 0)
        };
        *arg2 = *arg2 - 1;
        let v0 = if (arg0.zero_for_one) {
            arg0.reserve_in
        } else {
            arg0.reserve_out
        };
        let v1 = if (arg0.zero_for_one) {
            arg0.reserve_out
        } else {
            arg0.reserve_in
        };
        let v2 = (arg0.sqrt_price_x64 as u256) * (arg0.stable_amp as u256);
        let v3 = v2 * v2 * (arg0.stable_scale_in as u256) / (arg0.stable_scale_out as u256);
        let v4 = v2 + (v0 as u256) - (arg0.sqrt_price_x64 as u256);
        if (v4 == 0 || v3 == 0) {
            return (0, 5, 0)
        };
        let v5 = (arg1 as u256);
        let v6 = if (arg0.zero_for_one) {
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
        let v9 = if (arg0.zero_for_one) {
            v1
        } else {
            v0
        };
        if (v6 >= (v9 as u256)) {
            return (0, 0, 0)
        };
        let v10 = v6 - v6 * (arg0.fee_rate as u256) / (arg0.fee_denominator as u256);
        if (v10 > (340282366920938463463374607431768211455 as u256)) {
            return (0, 5, 0)
        };
        ((v10 as u128), 0, 0)
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
            arg2.status = 0;
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

    fun refinement_point(arg0: &OptimizeResult, arg1: &vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64) : u128 {
        let v0 = if (arg0.found) {
            arg0.amount_in
        } else {
            midpoint(arg2, arg3)
        };
        let v1 = arg2;
        let v2 = arg3;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(arg1)) {
            let v4 = *0x1::vector::borrow<u128>(arg1, v3);
            if (v4 < v0 && v4 > arg2) {
                v1 = v4;
            };
            if (v4 > v0 && v4 < arg3) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        if (!arg0.found || arg5 % 4 == 3) {
            return largest_gap_midpoint(arg1, arg2, arg3, arg4)
        };
        let v5 = if (v0 - v1 >= v2 - v0) {
            midpoint(v1, v0)
        } else {
            midpoint(v0, v2)
        };
        let v6 = aligned_in_range(v5, arg2, arg3, arg4);
        if (!contains_amount(arg1, v6)) {
            v6
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

    public fun resume_coefficients(arg0: &mut OptimizeState) {
        if (arg0.finished) {
            return
        };
        arg0.result.complete = true;
        arg0.result.needs_more_hop = 18446744073709551615;
        while (arg0.cursor < arg0.max_amount_in && arg0.result.segments < arg0.max_segments) {
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

    public fun search_budget_exhausted_status() : u8 {
        6
    }

    public fun search_evaluations(arg0: &OptimizeResult) : u64 {
        arg0.evaluations
    }

    public fun search_need_more_data_status() : u8 {
        3
    }

    public fun search_no_profit_status() : u8 {
        1
    }

    public fun search_not_converged_status() : u8 {
        4
    }

    public fun search_not_ready_status() : u8 {
        2
    }

    public fun search_status(arg0: &OptimizeResult) : u8 {
        arg0.status
    }

    public fun search_unsupported_status() : u8 {
        5
    }

    public fun search_valid_status() : u8 {
        0
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

    fun stable_abs_diff(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg1 - arg0
        } else {
            arg0 - arg1
        }
    }

    fun stable_compute_d(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        stable_compute_d_with_limit(arg0, arg1, arg2, arg3, 256)
    }

    fun stable_compute_d_with_limit(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64, arg4: u64) : (u256, u8) {
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

    fun stable_compute_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
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

    fun stable_fee_remainder(arg0: u128, arg1: u64) : u128 {
        arg0 - arg0 * (arg1 as u128) / 10000
    }

    public fun status(arg0: &OptimizeResult) : u8 {
        arg0.status
    }

    fun steamm_btoken_burn_amount(arg0: u256, arg1: u64) : u256 {
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

    fun steamm_btoken_supplies(arg0: &Hop) : (u64, u64) {
        (((arg0.stable_amp >> 64) as u64), ((arg0.stable_amp & 18446744073709551615) as u64))
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
        let v5 = if (v4) {
            0
        } else {
            5
        };
        Hop{
            kind                    : 14,
            fee_rate                : 0,
            fee_denominator         : 1,
            output_fee_rate         : arg3,
            output_fee_denominator  : 10000,
            reserve_in              : v1,
            reserve_out             : v3,
            sqrt_price_x64          : (arg9 as u128),
            liquidity               : (arg1 as u128),
            zero_for_one            : arg10,
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
            stable_amp              : (arg5 as u128) << 64 | (arg8 as u128),
            stable_scale_in         : arg4,
            stable_scale_out        : arg7,
            stable_admin_fee        : 0,
            stable_lp_fee           : arg6,
            stable_th_fee           : 0,
            stable_fee_on_input     : false,
            state_status            : v5,
        }
    }

    fun steamm_decimal_div(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg1 == 0 || arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / 1000000000000000000) {
            return (0, false)
        };
        (arg0 * 1000000000000000000 / arg1, true)
    }

    fun steamm_decimal_mul(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg1 != 0 && arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            return (0, false)
        };
        (arg0 * arg1 / 1000000000000000000, true)
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
        let v1 = if (v0) {
            0
        } else {
            5
        };
        Hop{
            kind                    : 15,
            fee_rate                : 0,
            fee_denominator         : 1,
            output_fee_rate         : arg1,
            output_fee_denominator  : 10000,
            reserve_in              : arg7,
            reserve_out             : (arg0 as u128),
            sqrt_price_x64          : (arg6 as u128),
            liquidity               : arg8,
            zero_for_one            : arg9 >= arg10,
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
            stable_amp              : (arg3 as u128) << 64 | (arg5 as u128),
            stable_scale_in         : arg2,
            stable_scale_out        : arg4,
            stable_admin_fee        : (arg9 as u64),
            stable_lp_fee           : (arg10 as u64),
            stable_th_fee           : 0,
            stable_fee_on_input     : false,
            state_status            : v1,
        }
    }

    public fun steamm_omm_v2_legacy_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: bool, arg15: bool) : Hop {
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
                                                            arg12 == 50 || arg12 == 100
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
        let v2 = if (v1) {
            0
        } else {
            5
        };
        Hop{
            kind                    : 16,
            fee_rate                : 0,
            fee_denominator         : 1,
            output_fee_rate         : v0,
            output_fee_denominator  : 10000,
            reserve_in              : (arg0 as u128),
            reserve_out             : (arg1 as u128),
            sqrt_price_x64          : (arg7 as u128),
            liquidity               : arg8,
            zero_for_one            : arg14,
            boundaries              : 0x1::vector::empty<TickBoundary>(),
            boundary_cursor         : 0,
            orderbook_segments      : 0x1::vector::empty<OrderbookSegment>(),
            orderbook_cursor        : 0,
            orderbook_lot_size      : arg9,
            orderbook_min_size      : 1,
            orderbook_consumed_base : 0,
            orderbook_base_to_quote : false,
            orderbook_has_more      : false,
            linear_segments         : 0x1::vector::empty<LinearSegment>(),
            linear_cursor           : 0,
            linear_has_more         : false,
            stable_amp              : (arg4 as u128) << 64 | (arg6 as u128),
            stable_scale_in         : arg3,
            stable_scale_out        : arg5,
            stable_admin_fee        : (arg10 as u64),
            stable_lp_fee           : (arg11 as u64),
            stable_th_fee           : arg12,
            stable_fee_on_input     : false,
            state_status            : v2,
        }
    }

    fun steamm_omm_v2_linear_btoken_output(arg0: &Hop, arg1: u256, arg2: u256, arg3: u256) : (u256, bool) {
        let v0 = if (arg0.zero_for_one) {
            (arg0.liquidity as u256)
        } else {
            (arg0.orderbook_lot_size as u256)
        };
        let v1 = if (arg0.zero_for_one) {
            (arg0.orderbook_lot_size as u256)
        } else {
            (arg0.liquidity as u256)
        };
        let v2 = if (arg0.zero_for_one) {
            (arg0.stable_admin_fee as u8)
        } else {
            (arg0.stable_lp_fee as u8)
        };
        let v3 = if (arg0.zero_for_one) {
            (arg0.stable_lp_fee as u8)
        } else {
            (arg0.stable_admin_fee as u8)
        };
        let (v4, v5) = steamm_decimal_mul(arg1 * 1000000000000000000, arg2);
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
        let (v10, v11) = steamm_decimal_div(v8, arg3);
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

    fun steamm_q_compute_f(arg0: u128, arg1: u128, arg2: u128) : (u128, bool, bool) {
        let (v0, v1) = steamm_q_div(18446744073709551616, arg1);
        let v2 = if (!v1) {
            true
        } else if (v0 > 18446744073709551616) {
            true
        } else {
            arg0 > 18446744073709551616
        };
        if (v2) {
            return (0, false, false)
        };
        let (v3, v4) = steamm_q_mul(arg0, 18446744073709551616 - v0);
        if (!v4) {
            return (0, false, false)
        };
        let (v5, v6) = steamm_q_ln_plus_64ln2(18446744073709551616 - arg0);
        if (!v6) {
            return (0, false, false)
        };
        let v7 = 818323753292969962240;
        if (v5 > v7) {
            return (0, false, false)
        };
        let (v8, v9) = steamm_q_mul(v0, v7 - v5);
        if (!v9 || v3 > 340282366920938463463374607431768211455 - v8) {
            return (0, false, false)
        };
        let v10 = v3 + v8;
        if (v10 >= arg2) {
            (v10 - arg2, true, true)
        } else {
            (arg2 - v10, false, true)
        }
    }

    fun steamm_q_compute_f_prime(arg0: u128, arg1: u128) : (u128, bool) {
        let (v0, v1) = steamm_q_div(18446744073709551616, arg1);
        let v2 = if (!v1) {
            true
        } else if (v0 > 18446744073709551616) {
            true
        } else {
            arg0 >= 18446744073709551616
        };
        if (v2) {
            return (0, false)
        };
        let (v3, v4) = steamm_q_mul(arg1, 18446744073709551616 - arg0);
        if (!v4) {
            return (0, false)
        };
        let (v5, v6) = steamm_q_div(18446744073709551616, v3);
        if (!v6 || 18446744073709551616 - v0 > 340282366920938463463374607431768211455 - v5) {
            return (0, false)
        };
        (18446744073709551616 - v0 + v5, true)
    }

    fun steamm_q_div(arg0: u128, arg1: u128) : (u128, bool) {
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

    fun steamm_q_floor_log2(arg0: u128) : u8 {
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

    fun steamm_q_from_decimal(arg0: u256) : (u128, bool) {
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

    fun steamm_q_from_integer(arg0: u128) : (u128, bool) {
        if (arg0 > 340282366920938463463374607431768211455 >> 64) {
            (0, false)
        } else {
            (arg0 << 64, true)
        }
    }

    fun steamm_q_ln_plus_64ln2(arg0: u128) : (u128, bool) {
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
        let v4 = 9223372036854775808;
        while (v4 != 0) {
            v2 = (((v2 as u256) * (v2 as u256) >> 63) as u128);
            if (v2 >= 18446744073709551616) {
                v3 = v3 + v4;
                v2 = v2 >> 1;
            };
            v4 = v4 >> 1;
        };
        let v5 = ((((v0 as u128) << 64) + v3) as u256) * 12786308645202655660 >> 64;
        if (v5 > (340282366920938463463374607431768211455 as u256)) {
            (0, false)
        } else {
            ((v5 as u128), true)
        }
    }

    fun steamm_q_mul(arg0: u128, arg1: u128) : (u128, bool) {
        let v0 = (arg0 as u256) * (arg1 as u256) >> 64;
        if (v0 > (340282366920938463463374607431768211455 as u256)) {
            (0, false)
        } else {
            ((v0 as u128), true)
        }
    }

    fun steamm_q_multiply_divide(arg0: vector<u128>, arg1: vector<u128>) : (u128, bool) {
        if (0x1::vector::is_empty<u128>(&arg0)) {
            return (0, false)
        };
        let v0 = &mut arg0;
        steamm_q_sort_desc(v0);
        let v1 = &mut arg1;
        steamm_q_sort_desc(v1);
        let v2 = 18446744073709551616;
        while (!0x1::vector::is_empty<u128>(&arg0)) {
            let (v3, v4) = steamm_q_mul(v2, *0x1::vector::borrow<u128>(&arg0, 0x1::vector::length<u128>(&arg0) - 1));
            if (v4) {
                v2 = v3;
                0x1::vector::pop_back<u128>(&mut arg0);
                continue
            };
            if (0x1::vector::is_empty<u128>(&arg1)) {
                return (0, false)
            };
            let (v5, v6) = steamm_q_div(v2, 0x1::vector::pop_back<u128>(&mut arg1));
            if (!v6) {
                return (0, false)
            };
            v2 = v5;
        };
        while (!0x1::vector::is_empty<u128>(&arg1)) {
            let (v7, v8) = steamm_q_div(v2, 0x1::vector::pop_back<u128>(&mut arg1));
            if (!v8) {
                return (0, false)
            };
            v2 = v7;
        };
        (v2, true)
    }

    fun steamm_q_newton(arg0: u128, arg1: u128) : (u128, bool) {
        let v0 = 18446744073709551616 / 100000;
        let v1 = 18446744073709551597;
        let v2 = 18446744073709551616 / 100000000000000;
        let v3 = 18446744071864877208;
        let v4 = if (arg0 > v3) {
            v3
        } else {
            arg0
        };
        let v5 = v4;
        let v6 = 0;
        while (v6 < 20) {
            let (v7, v8, v9) = steamm_q_compute_f(v5, arg1, arg0);
            if (!v9) {
                return (0, false)
            };
            if (v7 < v2) {
                return (v5, true)
            };
            let (v10, v11) = steamm_q_compute_f_prime(v5, arg1);
            if (!v11 || v10 < 18446744073709551616 / 10000000000) {
                return (0, false)
            };
            let (v12, v13) = steamm_q_div(v7, v10);
            if (!v13) {
                return (0, false)
            };
            let v14 = if (v12 >= 18446744073709551616) {
                v12 / 2
            } else {
                v12
            };
            let v15 = v8 && v5 > v14 || v5 <= 340282366920938463463374607431768211455 - v14;
            let v16 = if (!v15) {
                0
            } else if (v8) {
                v5 - v14
            } else {
                v5 + v14
            };
            let v17 = v16;
            let v18 = if (!v15) {
                true
            } else if (v16 == 0) {
                true
            } else {
                v16 >= 18446744073709551616
            };
            if (v18) {
                let v19 = v12 / 2;
                let v20 = v8 && v4 > v19 || v4 <= 340282366920938463463374607431768211455 - v19;
                if (!v20) {
                    return (0, false)
                };
                let v21 = if (v8) {
                    v4 - v19
                } else {
                    v4 + v19
                };
                v17 = v21;
                if (v21 < v0) {
                    v17 = v0;
                } else if (v21 > v1) {
                    v17 = v1;
                };
            };
            let v22 = if (v17 >= v4) {
                v17 - v4
            } else {
                v4 - v17
            };
            if (v22 < v2) {
                return (v4, true)
            };
            v5 = v17;
            v6 = v6 + 1;
        };
        (v5, true)
    }

    fun steamm_q_sort_desc(arg0: &mut vector<u128>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<u128>(arg0)) {
            while (v0 > 0 && *0x1::vector::borrow<u128>(arg0, v0 - 1) < *0x1::vector::borrow<u128>(arg0, v0)) {
                0x1::vector::swap<u128>(arg0, v0 - 1, v0);
                v0 = v0 - 1;
            };
            v0 = v0 + 1;
        };
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
        Hop{
            kind                    : 5,
            fee_rate                : 0,
            fee_denominator         : 1,
            output_fee_rate         : 0,
            output_fee_denominator  : 1,
            reserve_in              : (arg0 as u128),
            reserve_out             : (arg1 as u128),
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
            stable_amp              : (arg4 as u128),
            stable_scale_in         : (arg2 as u128),
            stable_scale_out        : (arg3 as u128),
            stable_admin_fee        : arg5,
            stable_lp_fee           : arg6,
            stable_th_fee           : arg7,
            stable_fee_on_input     : arg9 == v2,
            state_status            : v0,
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
        v2_hop_with_gate(arg0, arg1, arg2, arg3, true)
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
            stable_amp              : 0,
            stable_scale_in         : 0,
            stable_scale_out        : 0,
            stable_admin_fee        : 0,
            stable_lp_fee           : 0,
            stable_th_fee           : 0,
            stable_fee_on_input     : false,
            state_status            : v0,
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
            if (v3.exact_dlmm) {
                assert!(v3.price_x64 > 0 && v3.fee_denominator > v3.fee_rate, 3);
            } else {
                let v4 = if (v3.price_x64 == 0) {
                    if (v3.fee_rate == 0) {
                        v3.fee_denominator == 1
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v4, 3);
            };
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

    fun ve33_derivative(arg0: u256, arg1: u256) : u256 {
        3 * arg0 * arg1 * arg1 + arg0 * arg0 * arg0
    }

    fun ve33_get_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        let v0 = 0;
        while (v0 < 255) {
            if (*arg3 == 0) {
                return (0, 6)
            };
            *arg3 = *arg3 - 1;
            if (arg0 > 10000000000000000000 || arg2 > 10000000000000000000) {
                return (0, 5)
            };
            let v1 = ve33_value(arg0, arg2);
            let v2 = ve33_derivative(arg0, arg2);
            if (v2 == 0) {
                return (0, 5)
            };
            let v3 = if (v1 < arg1) {
                let v4 = (arg1 - v1) / v2 + 1;
                if (v4 > 10000000000000000000 - arg2) {
                    return (0, 5)
                };
                arg2 = arg2 + v4;
                v4
            } else {
                let v5 = (v1 - arg1) / v2;
                if (v5 > arg2) {
                    return (0, 5)
                };
                arg2 = arg2 - v5;
                v5
            };
            if (v3 <= 1) {
                return (arg2, 0)
            };
            v0 = v0 + 1;
        };
        (0, 4)
    }

    fun ve33_invariant(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * (arg0 * arg0 + arg1 * arg1)
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
        Hop{
            kind                    : 6,
            fee_rate                : arg5,
            fee_denominator         : arg6,
            output_fee_rate         : 0,
            output_fee_denominator  : 1,
            reserve_in              : (arg0 as u128),
            reserve_out             : (arg1 as u128),
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
            stable_amp              : (arg4 as u128),
            stable_scale_in         : (arg2 as u128),
            stable_scale_out        : (arg3 as u128),
            stable_admin_fee        : 0,
            stable_lp_fee           : 0,
            stable_th_fee           : 0,
            stable_fee_on_input     : true,
            state_status            : v2,
        }
    }

    fun ve33_value(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * arg1 * arg1 + arg0 * arg0 * arg0 * arg1
    }

    public fun virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: u64) : Hop {
        let v0 = if (arg8) {
            (arg0 as u128)
        } else {
            (arg1 as u128)
        };
        let v1 = if (arg8) {
            (arg1 as u128)
        } else {
            (arg0 as u128)
        };
        Hop{
            kind                    : 7,
            fee_rate                : arg7,
            fee_denominator         : 1000000,
            output_fee_rate         : 0,
            output_fee_denominator  : 1,
            reserve_in              : v0,
            reserve_out             : v1,
            sqrt_price_x64          : (arg4 as u128),
            liquidity               : (arg5 as u128),
            zero_for_one            : arg8,
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
            stable_amp              : (arg6 as u128),
            stable_scale_in         : (arg2 as u128),
            stable_scale_out        : (arg3 as u128),
            stable_admin_fee        : 0,
            stable_lp_fee           : 0,
            stable_th_fee           : 0,
            stable_fee_on_input     : false,
            state_status            : virtual_cpmm_state_status(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11, arg12),
        }
    }

    fun virtual_cpmm_state_status(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64) : u8 {
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

    // decompiled from Move bytecode v7
}

