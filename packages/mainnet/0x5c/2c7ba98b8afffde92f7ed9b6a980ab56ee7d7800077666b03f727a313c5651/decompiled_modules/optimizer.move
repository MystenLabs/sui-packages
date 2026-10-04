module 0x5c2c7ba98b8afffde92f7ed9b6a980ab56ee7d7800077666b03f727a313c5651::optimizer {
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

    struct OptimizeState has drop {
        route: vector<Hop>,
        validation_route: vector<Hop>,
        max_amount_in: u128,
        max_segments: u64,
        cursor: u128,
        cursor_output: u128,
        result: OptimizeResult,
        finished: bool,
        work: u64,
        tolerance_bps: u64,
        small_gains: u64,
        gain_cursor: u128,
        gain_profit: u128,
        monotone: bool,
        approximate_stop: bool,
        auxiliary_cost: u256,
        bounded_domain: bool,
        capacity_slack: bool,
        has_book: bool,
        has_linear: bool,
        linear_prefix_length: u64,
    }

    struct BoltFixedHop has drop {
        is_bolt: bool,
        bolt: vector<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>,
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

    struct AdaptiveSearch has drop {
        route: vector<Hop>,
        caches: vector<V3PrefixCache>,
        shortfalls: vector<OrderbookShortfall>,
        mk: vector<OptimizeState>,
        result: OptimizeResult,
        points: vector<u128>,
        samples: vector<ProgressiveSample>,
        maximum: u128,
        minimum: u128,
        quantum: u128,
        evaluations: u64,
        refinements: u64,
        work: u64,
        phase: u8,
        amount: u128,
        upper: u128,
        low: u128,
        high: u128,
        previous: ProgressiveSample,
        best: ProgressiveSample,
        left: ProgressiveSample,
        declines: u64,
        refinement: u64,
        has_book: bool,
        bolt: bool,
        schedule: ReversalSchedule,
        pending: bool,
        resume_hop: u64,
        resume_input: u128,
        blocked: u64,
        readers: ReadBudget,
    }

    struct ReadBudget has drop {
        physical: u64,
        effective: u64,
        max_physical: u64,
        max_effective: u64,
        terminals: vector<bool>,
        synthetic: vector<bool>,
        hop_physical: vector<u64>,
        hop_effective: vector<u64>,
        max_batch_effective: u64,
        max_batch_physical: u64,
    }

    struct ReversalSchedule has drop {
        events: vector<u128>,
        remote_left: u64,
        mapped: bool,
        exploration: u64,
        boundaries: vector<u128>,
        boundary_index: u64,
        remote_done: bool,
        points: vector<u128>,
        point_index: u64,
        count: u128,
        outward: bool,
        exploration_limit: u64,
        valid_seen: bool,
        local_refined: bool,
        converged: bool,
        cached: vector<BoltFixedHop>,
        initialized: bool,
        tolerance_bps: u64,
        small_gains: u64,
    }

    public fun adaptive_append_book_if(arg0: &mut AdaptiveSearch, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: bool) {
        if (!arg8) {
            return
        };
        assert!(arg0.blocked == arg1, 3);
        adaptive_note_reads(arg0, arg1, arg5, arg6, arg7, false);
        if (arg5 == 0 && arg6 == 0) {
            let v0 = if (arg7) {
                7
            } else {
                3
            };
            adaptive_finish(arg0, v0, false);
            return
        };
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            let v1 = 0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(&arg2)) {
                let v3 = orderbook_segment(*0x1::vector::borrow<u64>(&arg2, v2), *0x1::vector::borrow<u64>(&arg3, v2));
                0x1::vector::push_back<OrderbookSegment>(&mut 0x1::vector::borrow_mut<Hop>(&mut v1.route, arg1).orderbook_segments, v3);
                0x1::vector::push_back<OrderbookSegment>(&mut 0x1::vector::borrow_mut<Hop>(&mut v1.validation_route, arg1).orderbook_segments, v3);
                v2 = v2 + 1;
            };
            0x1::vector::borrow_mut<Hop>(&mut v1.route, arg1).orderbook_has_more = arg4;
            0x1::vector::borrow_mut<Hop>(&mut v1.validation_route, arg1).orderbook_has_more = arg4;
            v1.result.needs_more_hop = 18446744073709551615;
            arg0.blocked = 18446744073709551615;
            return
        };
        let v4 = 0x1::vector::borrow_mut<Hop>(&mut arg0.route, arg1);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg2)) {
            0x1::vector::push_back<OrderbookSegment>(&mut v4.orderbook_segments, orderbook_segment(*0x1::vector::borrow<u64>(&arg2, v5), *0x1::vector::borrow<u64>(&arg3, v5)));
            v5 = v5 + 1;
        };
        v4.orderbook_has_more = arg4;
        0x1::vector::borrow_mut<OrderbookShortfall>(&mut arg0.shortfalls, arg1).minimum_gross = 0;
        let v6 = if (arg0.result.found) {
            0
        } else {
            1
        };
        arg0.result.status = v6;
        arg0.blocked = 18446744073709551615;
    }

    public fun adaptive_append_dlmm_if(arg0: &mut AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u64>, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: bool, arg12: bool) {
        if (!arg12) {
            return
        };
        assert!(arg0.blocked == arg1, 3);
        adaptive_note_reads(arg0, arg1, arg9, arg10, arg11, false);
        if (arg9 == 0 && arg10 == 0) {
            let v0 = if (arg11) {
                7
            } else {
                3
            };
            adaptive_finish(arg0, v0, false);
            return
        };
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            let v1 = 0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<u128>(&arg2)) {
                let v3 = dlmm_segment(*0x1::vector::borrow<u128>(&arg2, v2), *0x1::vector::borrow<u128>(&arg3, v2), *0x1::vector::borrow<u128>(&arg4, v2), *0x1::vector::borrow<u64>(&arg5, v2), arg6);
                0x1::vector::push_back<LinearSegment>(&mut 0x1::vector::borrow_mut<Hop>(&mut v1.route, arg1).linear_segments, v3);
                0x1::vector::push_back<LinearSegment>(&mut 0x1::vector::borrow_mut<Hop>(&mut v1.validation_route, arg1).linear_segments, v3);
                v2 = v2 + 1;
            };
            0x1::vector::borrow_mut<Hop>(&mut v1.route, arg1).linear_has_more = arg7;
            0x1::vector::borrow_mut<Hop>(&mut v1.validation_route, arg1).linear_has_more = arg7;
            let v4 = 0x1::vector::borrow<Hop>(&v1.route, arg1).policy.linear_rate_inversion || arg8;
            0x1::vector::borrow_mut<Hop>(&mut v1.route, arg1).policy.linear_rate_inversion = v4;
            if (arg8 || arg7) {
                v1.monotone = false;
            };
            v1.result.needs_more_hop = 18446744073709551615;
            arg0.blocked = 18446744073709551615;
            return
        };
        let v5 = 0x1::vector::borrow_mut<Hop>(&mut arg0.route, arg1);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u128>(&arg2)) {
            0x1::vector::push_back<LinearSegment>(&mut v5.linear_segments, dlmm_segment(*0x1::vector::borrow<u128>(&arg2, v6), *0x1::vector::borrow<u128>(&arg3, v6), *0x1::vector::borrow<u128>(&arg4, v6), *0x1::vector::borrow<u64>(&arg5, v6), arg6));
            v6 = v6 + 1;
        };
        v5.linear_has_more = arg7;
        let v7 = v5.policy.linear_rate_inversion || arg8;
        v5.policy.linear_rate_inversion = v7;
        0x1::vector::borrow_mut<OrderbookShortfall>(&mut arg0.shortfalls, arg1).minimum_gross = 0;
        let v8 = if (arg0.result.found) {
            0
        } else {
            1
        };
        arg0.result.status = v8;
        arg0.blocked = 18446744073709551615;
    }

    public fun adaptive_append_v3_if(arg0: &mut AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<bool>, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool) {
        if (!arg9) {
            return
        };
        assert!(arg0.blocked == arg1, 3);
        adaptive_note_reads(arg0, arg1, arg5, arg6, arg7, arg8);
        if (arg5 == 0 && 0x1::vector::is_empty<u128>(&arg2)) {
            let v0 = if (arg7) {
                7
            } else {
                3
            };
            if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
                0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).finished = true;
                0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).result.complete = false;
                0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).result.status = v0;
            };
            adaptive_finish(arg0, v0, false);
            return
        };
        let v1 = 0x1::vector::empty<TickBoundary>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg2)) {
            0x1::vector::push_back<TickBoundary>(&mut v1, tick_boundary(*0x1::vector::borrow<u128>(&arg2, v2), *0x1::vector::borrow<u128>(&arg3, v2), *0x1::vector::borrow<bool>(&arg4, v2)));
            v2 = v2 + 1;
        };
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            let v3 = 0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0);
            if (!0x1::vector::is_empty<Hop>(&v3.validation_route)) {
                0x1::vector::append<TickBoundary>(&mut 0x1::vector::borrow_mut<Hop>(&mut v3.validation_route, arg1).boundaries, v1);
            };
            0x1::vector::append<TickBoundary>(&mut 0x1::vector::borrow_mut<Hop>(&mut v3.route, arg1).boundaries, v1);
            v3.result.needs_more_hop = 18446744073709551615;
            v3.result.complete = true;
            let v4 = 0x1::vector::borrow_mut<Hop>(&mut v3.route, arg1);
            v3.result.crossed_ticks = v3.result.crossed_ticks + skip_empty_v3_boundaries(v4);
        } else {
            0x1::vector::append<TickBoundary>(&mut 0x1::vector::borrow_mut<Hop>(&mut arg0.route, arg1).boundaries, v1);
            0x1::vector::borrow_mut<V3PrefixCache>(&mut arg0.caches, arg1).status = 0;
            let v5 = if (arg0.result.found) {
                0
            } else {
                1
            };
            arg0.result.status = v5;
        };
        arg0.blocked = 18446744073709551615;
    }

    fun adaptive_bolt_initialize(arg0: &mut AdaptiveSearch) {
        arg0.schedule.initialized = true;
        arg0.minimum = aligned_in_range(arg0.minimum, arg0.minimum, arg0.maximum, arg0.quantum);
        arg0.maximum = arg0.maximum - arg0.maximum % arg0.quantum;
        if (arg0.minimum == 0 || arg0.maximum < arg0.minimum) {
            arg0.phase = 3;
            return
        };
        if (bolt_fixed_route(&arg0.route)) {
            let (v0, v1) = bolt_fixed_cache(&arg0.route);
            arg0.schedule.cached = v0;
            if (v1 != 0) {
                arg0.result.status = v1;
                arg0.phase = 3;
                return
            };
        };
        arg0.schedule.count = (arg0.maximum - arg0.minimum) / arg0.quantum + 1;
        let (v2, v3) = if (arg0.schedule.count <= (arg0.evaluations as u128)) {
            (vector[], arg0.maximum)
        } else {
            let v4 = 0x1::vector::empty<u128>();
            0x1::vector::push_back<u128>(&mut v4, arg0.amount);
            let v5 = &mut arg0.work;
            bolt_candidate_points(&arg0.route, v4, arg0.minimum, arg0.maximum, arg0.quantum, arg0.refinements, arg0.evaluations, v5)
        };
        let v6 = v2;
        if (arg0.schedule.count <= (arg0.evaluations as u128)) {
            let v7 = arg0.minimum;
            loop {
                0x1::vector::push_back<u128>(&mut v6, v7);
                if (arg0.maximum - v7 < arg0.quantum) {
                    break
                };
                v7 = v7 + arg0.quantum;
            };
        };
        let v8 = if (arg0.pending) {
            0x1::vector::length<u128>(&v6)
        } else {
            0
        };
        arg0.schedule.point_index = v8;
        arg0.schedule.points = v6;
        arg0.upper = v3;
        let v9 = if (0x1::vector::is_empty<u128>(&arg0.schedule.events)) {
            5
        } else {
            2
        };
        arg0.schedule.exploration_limit = 0x1::u64::min(arg0.evaluations, v9);
    }

    fun adaptive_bolt_run(arg0: &mut AdaptiveSearch) {
        while ((arg0.pending || arg0.result.evaluations < arg0.evaluations) && arg0.work > 0) {
            let v0 = if (arg0.result.found) {
                amount_lower_bound(&arg0.points, arg0.result.amount_in)
            } else {
                0
            };
            let v1 = if (arg0.result.found) {
                if (arg0.schedule.local_refined) {
                    if (!arg0.schedule.outward) {
                        if (arg0.schedule.remote_done || arg0.schedule.remote_left == 0) {
                            0x1::vector::is_empty<u128>(&arg0.schedule.events)
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
            if (v1) {
                let v2 = if (v0 > 0) {
                    *0x1::vector::borrow<u128>(&arg0.points, v0 - 1)
                } else {
                    arg0.minimum
                };
                let v3 = if (v0 + 1 < 0x1::vector::length<u128>(&arg0.points)) {
                    *0x1::vector::borrow<u128>(&arg0.points, v0 + 1)
                } else {
                    arg0.upper
                };
                if (v3 - v2 <= 0x1::u128::max(arg0.result.amount_in / 100, arg0.quantum * 2)) {
                    arg0.schedule.converged = true;
                    break
                };
            };
            let v4 = if (arg0.pending) {
                arg0.amount
            } else if (arg0.schedule.point_index < 0x1::vector::length<u128>(&arg0.schedule.points)) {
                arg0.schedule.point_index = arg0.schedule.point_index + 1;
                aligned_in_range(*0x1::vector::borrow<u128>(&arg0.schedule.points, arg0.schedule.point_index), arg0.minimum, arg0.maximum, arg0.quantum)
            } else {
                let v5 = if (arg0.schedule.count > (arg0.evaluations as u128)) {
                    if (arg0.schedule.outward) {
                        if (arg0.upper < arg0.maximum) {
                            if (arg0.result.evaluations < arg0.schedule.exploration_limit) {
                                true
                            } else if (arg0.result.found) {
                                if (arg0.result.amount_in >= arg0.upper) {
                                    0x1::vector::is_empty<u128>(&arg0.schedule.events)
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
                if (v5) {
                    arg0.upper = bolt_growth_point(arg0.upper, arg0.minimum, arg0.maximum, arg0.quantum, arg0.result.evaluations == 1);
                    arg0.upper
                } else if (!arg0.schedule.remote_done && arg0.schedule.remote_left > 0) {
                    let v6 = 0;
                    if (arg0.schedule.mapped) {
                        while (arg0.schedule.boundary_index < 0x1::vector::length<u128>(&arg0.schedule.boundaries) && *0x1::vector::borrow<u128>(&arg0.schedule.boundaries, arg0.schedule.boundary_index) <= arg0.upper) {
                            arg0.schedule.boundary_index = arg0.schedule.boundary_index + 1;
                        };
                        if (arg0.schedule.boundary_index < 0x1::vector::length<u128>(&arg0.schedule.boundaries)) {
                            v6 = *0x1::vector::borrow<u128>(&arg0.schedule.boundaries, arg0.schedule.boundary_index);
                        };
                    } else if (arg0.upper < arg0.maximum) {
                        let v7 = if (arg0.upper > arg0.maximum / 10) {
                            arg0.maximum
                        } else {
                            arg0.upper * 10
                        };
                        v6 = aligned_in_range(v7, arg0.minimum, arg0.maximum, arg0.quantum);
                    };
                    arg0.schedule.remote_left = arg0.schedule.remote_left - 1;
                    if (v6 == 0) {
                        arg0.schedule.remote_done = true;
                        continue
                    };
                    if (arg0.schedule.mapped) {
                        let v8 = if (arg0.schedule.boundary_index + 1 < 0x1::vector::length<u128>(&arg0.schedule.boundaries)) {
                            *0x1::vector::borrow<u128>(&arg0.schedule.boundaries, arg0.schedule.boundary_index + 1)
                        } else {
                            0
                        };
                        arg0.schedule.boundary_index = arg0.schedule.boundary_index + 1;
                        let v9 = if (v8 > v6) {
                            (v8 - v6) / 4 * 3
                        } else {
                            0x1::u128::min(0x1::u128::max(v6 / 10, arg0.quantum), arg0.maximum - v6)
                        };
                        let v10 = v6 + v9;
                        v6 = aligned_in_range(v10, arg0.minimum, arg0.maximum, arg0.quantum);
                    };
                    arg0.upper = 0x1::u128::max(arg0.upper, v6);
                    arg0.schedule.outward = false;
                    v6
                } else {
                    let v11 = if (!arg0.schedule.local_refined) {
                        if (arg0.result.found) {
                            if (v0 > 0) {
                                (arg0.result.amount_in - *0x1::vector::borrow<u128>(&arg0.points, v0 - 1)) / arg0.quantum > 1
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v11) {
                        arg0.schedule.local_refined = true;
                        aligned_in_range(midpoint(*0x1::vector::borrow<u128>(&arg0.points, v0 - 1), arg0.result.amount_in), arg0.minimum, arg0.upper, arg0.quantum)
                    } else {
                        let v12 = 0;
                        while (!0x1::vector::is_empty<u128>(&arg0.schedule.events) && v12 == 0) {
                            let v13 = 0x1::vector::pop_back<u128>(&mut arg0.schedule.events);
                            if (v13 <= arg0.upper && !contains_amount(&arg0.points, v13)) {
                                v12 = v13;
                            };
                        };
                        if (v12 > 0) {
                            v12
                        } else {
                            let v14 = refinement_point(&arg0.result, &arg0.points, arg0.minimum, arg0.upper, arg0.quantum, 0);
                            if (!contains_amount(&arg0.points, v14)) {
                                v14
                            } else {
                                largest_gap_midpoint(&arg0.points, arg0.minimum, arg0.upper, arg0.quantum)
                            }
                        }
                    }
                }
            };
            if (v4 == 0 || (0x1::vector::length<u128>(&arg0.points) as u128) >= arg0.schedule.count) {
                break
            };
            let v15 = amount_lower_bound(&arg0.points, v4);
            let v16 = if (!arg0.pending) {
                if (v15 < 0x1::vector::length<u128>(&arg0.points)) {
                    *0x1::vector::borrow<u128>(&arg0.points, v15) == v4
                } else {
                    false
                }
            } else {
                false
            };
            if (v16) {
                if (arg0.schedule.point_index >= 0x1::vector::length<u128>(&arg0.schedule.points)) {
                    break
                } else {
                    continue
                };
            };
            arg0.amount = v4;
            let v17 = adaptive_probe_at(arg0, v4, v15);
            let v18 = v17.status;
            if (arg0.blocked != 18446744073709551615) {
                return
            };
            if (v18 == 0) {
                arg0.schedule.valid_seen = true;
            };
            let v19 = if (v18 == 10) {
                if (!arg0.schedule.valid_seen) {
                    arg0.schedule.outward
                } else {
                    false
                }
            } else {
                false
            };
            if (v19) {
                let v20 = if (v4 > arg0.maximum / 10) {
                    arg0.maximum
                } else {
                    v4 * 10
                };
                let v21 = aligned_in_range(v20, arg0.minimum, arg0.maximum, arg0.quantum);
                if (v21 > v4 && !contains_amount(&arg0.points, v21)) {
                    0x1::vector::push_back<u128>(&mut arg0.schedule.points, v21);
                    arg0.upper = 0x1::u128::max(arg0.upper, v21);
                } else {
                    arg0.result.status = 10;
                    break
                };
            };
            if (v18 == 10 && arg0.schedule.valid_seen) {
                arg0.schedule.outward = false;
                arg0.schedule.remote_done = true;
                arg0.upper = v4;
            };
            let v22 = if (v18 == 2) {
                true
            } else if (v18 == 6) {
                true
            } else {
                v18 == 11
            };
            if (v22) {
                arg0.result.status = v18;
                break
            };
            if (v18 == 3 || v18 == 7) {
                arg0.result.status = v18;
                if (!arg0.schedule.valid_seen) {
                    arg0.result.complete = false;
                    arg0.phase = 3;
                    return
                };
                arg0.schedule.remote_done = true;
                arg0.schedule.outward = false;
                arg0.upper = v4;
            };
            let v23 = if (v18 == 7) {
                true
            } else if (v18 == 12) {
                true
            } else {
                v18 == 5 && arg0.result.found
            };
            if (v23) {
                arg0.schedule.outward = false;
            };
            if (v18 == 5) {
                arg0.result.status = 1;
            };
        };
        let v24 = arg0.schedule.converged || (0x1::vector::length<u128>(&arg0.points) as u128) == arg0.schedule.count;
        arg0.result.complete = v24;
        if (arg0.schedule.valid_seen && arg0.result.status == 10) {
            let v25 = if (arg0.result.found) {
                0
            } else {
                1
            };
            arg0.result.status = v25;
        };
        if (!arg0.result.complete && (arg0.result.status == 0 || arg0.result.status == 1)) {
            let v26 = if (arg0.work == 0) {
                6
            } else {
                9
            };
            arg0.result.status = v26;
        };
        arg0.phase = 3;
    }

    fun adaptive_bracket(arg0: &mut AdaptiveSearch) {
        arg0.low = arg0.minimum;
        arg0.high = arg0.upper;
        if (arg0.best.amount > 0) {
            let v0 = amount_lower_bound(&arg0.points, arg0.best.amount);
            if (v0 > 0 && 0x1::vector::borrow<ProgressiveSample>(&arg0.samples, v0 - 1).amount > 0) {
                arg0.low = *0x1::vector::borrow<u128>(&arg0.points, v0 - 1);
            };
            if (v0 + 1 < 0x1::vector::length<u128>(&arg0.points)) {
                arg0.high = *0x1::vector::borrow<u128>(&arg0.points, v0 + 1);
            };
        };
    }

    fun adaptive_finish(arg0: &mut AdaptiveSearch, arg1: u8, arg2: bool) {
        arg0.phase = 3;
        arg0.blocked = 18446744073709551615;
        arg0.result.complete = arg2;
        let v0 = if (arg0.result.status == 0) {
            true
        } else if (arg0.result.status == 1) {
            true
        } else {
            arg1 != 9
        };
        if (v0) {
            let v1 = if (arg1 == 0 && !arg0.result.found) {
                1
            } else {
                arg1
            };
            arg0.result.status = v1;
        };
    }

    public fun adaptive_note_reads(arg0: &mut AdaptiveSearch, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool) {
        if (arg0.phase == 3 && 0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            return
        };
        arg0.readers.physical = arg0.readers.physical + arg2;
        arg0.readers.effective = arg0.readers.effective + arg3;
        *0x1::vector::borrow_mut<u64>(&mut arg0.readers.hop_physical, arg1) = *0x1::vector::borrow<u64>(&arg0.readers.hop_physical, arg1) + arg2;
        *0x1::vector::borrow_mut<u64>(&mut arg0.readers.hop_effective, arg1) = *0x1::vector::borrow<u64>(&arg0.readers.hop_effective, arg1) + arg3;
        assert!(arg0.readers.physical <= arg0.readers.max_physical && arg0.readers.effective <= arg0.readers.max_effective, 6);
        *0x1::vector::borrow_mut<bool>(&mut arg0.readers.terminals, arg1) = arg4;
        *0x1::vector::borrow_mut<bool>(&mut arg0.readers.synthetic, arg1) = arg5;
    }

    fun adaptive_probe(arg0: &mut AdaptiveSearch, arg1: u128) : ProgressiveSample {
        let v0 = amount_lower_bound(&arg0.points, arg1);
        adaptive_probe_at(arg0, arg1, v0)
    }

    fun adaptive_probe_at(arg0: &mut AdaptiveSearch, arg1: u128, arg2: u64) : ProgressiveSample {
        let v0 = if (!arg0.pending) {
            if (arg2 < 0x1::vector::length<u128>(&arg0.points)) {
                *0x1::vector::borrow<u128>(&arg0.points, arg2) == arg1
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return *0x1::vector::borrow<ProgressiveSample>(&arg0.samples, arg2)
        };
        if (!arg0.pending) {
            if (arg0.result.evaluations >= arg0.evaluations) {
                let v1 = empty_progressive_sample();
                v1.status = 9;
                return v1
            };
            arg0.result.evaluations = arg0.result.evaluations + 1;
            arg0.resume_hop = 0;
            arg0.resume_input = arg1;
        };
        let (v2, v3, v4, v5, v6, v7) = if (!0x1::vector::is_empty<BoltFixedHop>(&arg0.schedule.cached)) {
            let v8 = &mut arg0.work;
            let (v9, v10) = bolt_cached_quote(&arg0.schedule.cached, arg1, v8);
            (v10, 0, 0, 18446744073709551615, 0, v9)
        } else {
            let v11 = &mut arg0.caches;
            let v12 = &mut arg0.work;
            let v13 = &mut arg0.shortfalls;
            let v14 = arg0.result.found || arg0.pending;
            let (v15, v16, v17, v18, v19, v20) = quote_route_from(&arg0.route, v11, arg0.resume_input, arg0.resume_hop, v12, v13, v14);
            (v16, v17, v18, v19, v20, v15)
        };
        let v21 = if (v2 == 3 && *0x1::vector::borrow<bool>(&arg0.readers.terminals, v5)) {
            7
        } else {
            v2
        };
        arg0.result.crossed_ticks = arg0.result.crossed_ticks + v3;
        arg0.result.crossed_orders = arg0.result.crossed_orders + v4;
        let v22 = empty_progressive_sample();
        v22.status = v21;
        v22.output = v7;
        v22.work = arg0.work - arg0.work;
        if (v21 == 3) {
            arg0.blocked = v5;
            arg0.resume_hop = v5;
            arg0.resume_input = v6;
            arg0.pending = true;
            arg0.result.status = v21;
            return v22
        };
        arg0.pending = false;
        arg0.blocked = 18446744073709551615;
        if (!0x1::vector::is_empty<BoltFixedHop>(&arg0.schedule.cached)) {
            let v23 = if (v21 != 0) {
                if (v21 != 1) {
                    v21 != 7
                } else {
                    false
                }
            } else {
                false
            };
            if (v23) {
                arg0.result.status = v21;
            };
        } else {
            let v24 = if (v21 != 0) {
                if (v21 != 1) {
                    if (v21 != 7) {
                        v21 != 10
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
                arg0.result.complete = false;
                if (arg0.result.status == 0 || arg0.result.status == 1) {
                    arg0.result.status = v21;
                };
            };
        };
        if (v21 == 0 && v7 > 0) {
            let v25 = route_auxiliary_fee(&arg0.route, arg1);
            let v26 = &mut arg0.result;
            record_candidate_with_fee(arg1, v7, v25, v26);
            let v27 = saturating_add((arg1 as u256), v25);
            v22.amount = arg1;
            v22.fee = v25;
            v22.negative = v27 > (v7 as u256);
            let v28 = if (v22.negative) {
                v27 - (v7 as u256)
            } else {
                (v7 as u256) - v27
            };
            v22.magnitude = v28;
        };
        0x1::vector::insert<u128>(&mut arg0.points, arg1, arg2);
        0x1::vector::insert<ProgressiveSample>(&mut arg0.samples, v22, arg2);
        v22
    }

    public fun adaptive_request(arg0: &mut AdaptiveSearch, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64) : (u64, u64, bool) {
        if (arg0.blocked != arg1) {
            return (0, 0, false)
        };
        let v0 = 0x1::u64::min(arg0.readers.max_effective - arg0.readers.effective, arg4 - 0x1::u64::min(*0x1::vector::borrow<u64>(&arg0.readers.hop_effective, arg1), arg4));
        let v1 = 0x1::u64::min(arg0.readers.max_physical - arg0.readers.physical, arg5 - 0x1::u64::min(*0x1::vector::borrow<u64>(&arg0.readers.hop_physical, arg1), arg5));
        let v2 = arg0.readers.max_batch_effective > 0;
        let v3 = if (v2) {
            let v4 = if (v0 % arg7 > 0) {
                1
            } else {
                0
            };
            0x1::u64::min(0x1::u64::max(v0 / arg7 + v4, arg2), arg0.readers.max_batch_effective)
        } else {
            arg2
        };
        let v5 = if (v2) {
            let v6 = if (v1 % arg7 > 0) {
                1
            } else {
                0
            };
            0x1::u64::min(0x1::u64::max(v1 / arg7 + v6, arg3), arg0.readers.max_batch_physical)
        } else {
            arg3
        };
        let v7 = 0x1::u64::min(v3, v0);
        let v8 = 0x1::u64::min(v5, v1);
        let v9 = if (!*0x1::vector::borrow<bool>(&arg0.readers.terminals, arg1)) {
            if (v7 > 0) {
                if (v8 > 0 || arg6) {
                    arg0.work > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        (v7, v8, v9)
    }

    public fun adaptive_result(arg0: AdaptiveSearch) : OptimizeResult {
        let AdaptiveSearch {
            route        : _,
            caches       : _,
            shortfalls   : _,
            mk           : v3,
            result       : v4,
            points       : _,
            samples      : _,
            maximum      : _,
            minimum      : _,
            quantum      : _,
            evaluations  : v10,
            refinements  : _,
            work         : v12,
            phase        : _,
            amount       : _,
            upper        : _,
            low          : _,
            high         : _,
            previous     : _,
            best         : _,
            left         : _,
            declines     : _,
            refinement   : _,
            has_book     : _,
            bolt         : _,
            schedule     : _,
            pending      : _,
            resume_hop   : _,
            resume_input : _,
            blocked      : _,
            readers      : _,
        } = arg0;
        let v31 = v3;
        if (0x1::vector::is_empty<OptimizeState>(&v31)) {
            v4
        } else {
            let v33 = 0x1::vector::pop_back<OptimizeState>(&mut v31);
            progress_result_bounded(&v33, 0x1::u64::min(v33.work, v12), v10 - 0x1::u64::min(v33.result.evaluations, v10), true)
        }
    }

    fun adaptive_route_start(arg0: vector<Hop>, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u128, arg11: u128) : AdaptiveSearch {
        let v0 = if (arg1 > 0) {
            if (arg5 > 0) {
                if (arg5 <= 64) {
                    if (arg4 <= 60) {
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
        };
        assert!(v0, 6);
        let v1 = if (arg9) {
            if (!0x1::vector::is_empty<Hop>(&arg0)) {
                route_model(&arg0) != 1
            } else {
                false
            }
        } else {
            false
        };
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<Hop>(&arg0)) {
            0x1::vector::push_back<bool>(&mut v2, false);
            0x1::vector::push_back<bool>(&mut v3, false);
            0x1::vector::push_back<u64>(&mut v4, 0);
            0x1::vector::push_back<u64>(&mut v5, 0);
            v6 = v6 + 1;
        };
        let v7 = if (0x1::vector::is_empty<Hop>(&arg0)) {
            arg2
        } else {
            0x1::u128::min(arg2, 0x1::vector::borrow<Hop>(&arg0, 0).policy.input_capacity)
        };
        let v8 = contains_bolt(&arg0);
        let v9 = if (v1) {
            true
        } else if (0x1::vector::is_empty<Hop>(&arg0)) {
            true
        } else {
            v8 && bolt_fixed_route(&arg0)
        };
        let (v10, v11, v12) = if (v9) {
            (0x1::vector::empty<V3PrefixCache>(), 0, 0)
        } else {
            prepare_v3_prefix_caches(&arg0, arg6)
        };
        let (v13, v14) = if (v1) {
            (false, 0x1::vector::empty<OrderbookShortfall>())
        } else {
            let (v15, v16) = orderbook_shortfall_memos(&arg0);
            (v16, v15)
        };
        let v17 = v8 && numeric_bolt_prefix_supported(&arg0);
        let v18 = arg6 - v12;
        let v19 = if (v17) {
            if (v7 >= arg10) {
                if (v7 > 0) {
                    (v7 - arg10) / arg11 + 1 > (arg5 as u128)
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
            let v21 = &mut v18;
            numeric_bolt_events(&arg0, arg10, v7, arg11, v21)
        } else {
            vector[]
        };
        let v22 = v20;
        let v23 = vector[];
        let v24 = 0;
        while (v24 < 0x1::vector::length<u128>(&v22)) {
            let v25 = *0x1::vector::borrow<u128>(&v22, v24);
            let v26 = if (v25 >= arg10 + arg11) {
                if (v7 - v25 >= arg11) {
                    let v27 = v25 - arg11;
                    if (0x1::vector::contains<u128>(&v22, &v27)) {
                        let v28 = v25 + arg11;
                        0x1::vector::contains<u128>(&v22, &v28)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v26) {
                0x1::vector::push_back<u128>(&mut v23, v25);
            };
            v24 = v24 + 1;
        };
        let v29 = if (!0x1::vector::is_empty<Hop>(&arg0)) {
            if (0x1::vector::borrow<Hop>(&arg0, 0).kind == 2) {
                if (0x1::vector::borrow<Hop>(&arg0, 0).orderbook_base_to_quote) {
                    if (0x1::vector::borrow<Hop>(&arg0, 0).fee_rate == 0) {
                        0x1::vector::borrow<Hop>(&arg0, 0).orderbook_lot_size % arg11 == 0
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
        let v30 = if (v29) {
            0x1::vector::borrow<Hop>(&arg0, 0).orderbook_lot_size
        } else {
            arg11
        };
        let v31 = if (0x1::vector::is_empty<Hop>(&arg0)) {
            0
        } else {
            aligned_in_range(first_probe_estimate(0x1::vector::borrow<Hop>(&arg0, 0), 0x1::u128::min(arg1, v7)), arg10, v7, v30)
        };
        let v32 = if (0x1::vector::is_empty<Hop>(&arg0)) {
            coarse_rejection()
        } else {
            empty_result()
        };
        let v33 = v32;
        v33.complete = false;
        if (v11 != 0) {
            v33.status = v11;
        };
        let v34 = 0x1::vector::empty<OptimizeState>();
        let v35 = if (v1) {
            let v36 = coefficient_state(arg0, v7, arg3);
            v36.work = arg6;
            0x1::vector::push_back<OptimizeState>(&mut v34, v36);
            0x1::vector::empty<Hop>()
        } else {
            arg0
        };
        let v37 = if (v11 != 0 || v31 == 0) {
            3
        } else {
            0
        };
        let v38 = if (v17) {
            3
        } else {
            1
        };
        let v39 = ReversalSchedule{
            events            : v22,
            remote_left       : v38,
            mapped            : v17,
            exploration       : 0,
            boundaries        : v23,
            boundary_index    : 0,
            remote_done       : false,
            points            : vector[],
            point_index       : 0,
            count             : 0,
            outward           : true,
            exploration_limit : 0,
            valid_seen        : false,
            local_refined     : false,
            converged         : false,
            cached            : 0x1::vector::empty<BoltFixedHop>(),
            initialized       : false,
            tolerance_bps     : 0,
            small_gains       : 0,
        };
        let v40 = ReadBudget{
            physical            : 0,
            effective           : 0,
            max_physical        : arg7,
            max_effective       : arg8,
            terminals           : v2,
            synthetic           : v3,
            hop_physical        : v4,
            hop_effective       : v5,
            max_batch_effective : 0,
            max_batch_physical  : 0,
        };
        let v41 = AdaptiveSearch{
            route        : v35,
            caches       : v10,
            shortfalls   : v14,
            mk           : v34,
            result       : v33,
            points       : vector[],
            samples      : 0x1::vector::empty<ProgressiveSample>(),
            maximum      : v7,
            minimum      : arg10,
            quantum      : v30,
            evaluations  : arg5,
            refinements  : arg4,
            work         : v18,
            phase        : v37,
            amount       : v31,
            upper        : v31,
            low          : arg10,
            high         : v31,
            previous     : empty_progressive_sample(),
            best         : empty_progressive_sample(),
            left         : empty_progressive_sample(),
            declines     : 0,
            refinement   : 0,
            has_book     : v13,
            bolt         : v8,
            schedule     : v39,
            pending      : false,
            resume_hop   : 0,
            resume_input : 0,
            blocked      : 18446744073709551615,
            readers      : v40,
        };
        if (v8 && v41.phase != 3) {
            let v42 = &mut v41;
            adaptive_bolt_initialize(v42);
        };
        v41
    }

    public fun adaptive_run(arg0: &mut AdaptiveSearch) {
        if (arg0.blocked != 18446744073709551615) {
            return
        };
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            let v0 = 0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0);
            resume_coefficients(v0);
            let v1 = if (0x1::vector::borrow<OptimizeState>(&arg0.mk, 0).finished) {
                18446744073709551615
            } else {
                0x1::vector::borrow<OptimizeState>(&arg0.mk, 0).result.needs_more_hop
            };
            arg0.blocked = v1;
            if (arg0.blocked != 18446744073709551615) {
                if (*0x1::vector::borrow<bool>(&arg0.readers.terminals, arg0.blocked)) {
                    0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).finished = true;
                    0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).result.status = 7;
                    arg0.blocked = 18446744073709551615;
                } else {
                    0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).result.status = 3;
                };
            } else if (0x1::vector::borrow<OptimizeState>(&arg0.mk, 0).result.status == 3) {
                let v2 = if (0x1::vector::borrow<OptimizeState>(&arg0.mk, 0).result.found) {
                    0
                } else {
                    1
                };
                0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).result.status = v2;
            };
            return
        };
        if (arg0.blocked != 18446744073709551615 || arg0.phase == 3) {
            return
        };
        if (arg0.bolt) {
            if (!arg0.schedule.initialized) {
                adaptive_bolt_initialize(arg0);
            };
            adaptive_bolt_run(arg0);
            return
        };
        loop {
            let v3 = if (arg0.phase != 3) {
                if (arg0.work > 0) {
                    arg0.pending || arg0.result.evaluations < arg0.evaluations
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                if (arg0.phase == 0) {
                    arg0.upper = arg0.amount;
                    let v4 = arg0.amount;
                    let v5 = adaptive_probe(arg0, v4);
                    if (arg0.blocked != 18446744073709551615) {
                        return
                    };
                    if (v5.status == 10 && arg0.previous.amount == 0) {
                        let v6 = if (arg0.amount > arg0.maximum / 10) {
                            arg0.maximum
                        } else {
                            arg0.amount * 10
                        };
                        let v7 = aligned_in_range(v6, arg0.minimum, arg0.maximum, arg0.quantum);
                        if (v7 <= arg0.amount) {
                            adaptive_finish(arg0, v5.status, false);
                            return
                        };
                        arg0.amount = v7;
                        continue
                    };
                    if (v5.amount == 0) {
                        if (v5.status == 7 && arg0.best.amount > 0) {
                            arg0.phase = 1;
                            adaptive_bracket(arg0);
                            continue
                        };
                        adaptive_finish(arg0, v5.status, false);
                        return
                    };
                    if (arg0.best.amount == 0 || progressive_better(&v5, &arg0.best)) {
                        arg0.best = v5;
                    };
                    if (arg0.previous.amount > 0 && progressive_better(&arg0.previous, &v5)) {
                        arg0.declines = arg0.declines + 1;
                    } else {
                        arg0.declines = 0;
                    };
                    let v8 = if (arg0.schedule.tolerance_bps > 0) {
                        if (arg0.previous.amount > 0) {
                            if (!v5.negative) {
                                if (!arg0.previous.negative) {
                                    v5.amount - arg0.previous.amount >= 0x1::u128::max(arg0.previous.amount / 10, 1)
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
                    if (v8) {
                        let v9 = if (v5.magnitude > arg0.previous.magnitude) {
                            v5.magnitude - arg0.previous.magnitude
                        } else {
                            0
                        };
                        let v10 = if (v9 * 10000 <= arg0.previous.magnitude * (0x1::u64::min(arg0.schedule.tolerance_bps, 100) as u256)) {
                            arg0.schedule.small_gains + 1
                        } else {
                            0
                        };
                        arg0.schedule.small_gains = v10;
                    };
                    arg0.schedule.exploration = arg0.schedule.exploration + 1;
                    let v11 = if (arg0.bolt) {
                        let v12 = if (0x1::vector::is_empty<u128>(&arg0.schedule.events)) {
                            5
                        } else {
                            2
                        };
                        0x1::u64::min(arg0.evaluations, v12)
                    } else {
                        arg0.evaluations - 0x1::u64::min(arg0.evaluations / 3, arg0.refinements)
                    };
                    let v13 = if (arg0.amount == arg0.maximum) {
                        true
                    } else if (arg0.result.evaluations >= v11) {
                        true
                    } else if (arg0.schedule.small_gains >= 2) {
                        true
                    } else if (arg0.bolt && arg0.schedule.remote_done) {
                        true
                    } else if (!arg0.bolt) {
                        let v14 = if (arg0.previous.amount == 0) {
                            if (v5.negative) {
                                !arg0.has_book
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v14) {
                            true
                        } else {
                            let v15 = if (arg0.has_book) {
                                3
                            } else {
                                1
                            };
                            arg0.declines >= v15
                        }
                    } else {
                        false
                    };
                    arg0.previous = v5;
                    if (!v13) {
                        let v16 = if (arg0.bolt && arg0.schedule.exploration > 1) {
                            8
                        } else {
                            4
                        };
                        let v17 = if (arg0.amount > arg0.maximum / v16) {
                            arg0.maximum
                        } else {
                            arg0.amount * v16
                        };
                        let v18 = if (0x1::vector::borrow<Hop>(&arg0.route, 0).kind == 2) {
                            first_probe_estimate(0x1::vector::borrow<Hop>(&arg0.route, 0), v17)
                        } else {
                            v17
                        };
                        let v19 = aligned_in_range(v18, arg0.minimum, arg0.maximum, arg0.quantum);
                        if (v19 > arg0.amount) {
                            arg0.amount = v19;
                            continue
                        };
                    };
                    arg0.phase = 1;
                    adaptive_bracket(arg0);
                    continue
                };
                let v20 = if (arg0.high <= arg0.low) {
                    true
                } else if ((arg0.high - arg0.low) / arg0.quantum <= 2) {
                    true
                } else {
                    arg0.refinement >= arg0.refinements
                };
                if (v20) {
                    let v21 = (arg0.high - arg0.low) / arg0.quantum <= 2;
                    let v22 = if (v21) {
                        0
                    } else {
                        9
                    };
                    adaptive_finish(arg0, v22, v21);
                    return
                };
                let v23 = (arg0.high - arg0.low) / 3;
                let v24 = if (arg0.phase == 1) {
                    arg0.low + v23
                } else {
                    arg0.high - v23
                };
                let v25 = aligned_in_range(v24, arg0.minimum, arg0.high, arg0.quantum);
                let v26 = adaptive_probe(arg0, v25);
                if (arg0.blocked != 18446744073709551615) {
                    return
                };
                if (arg0.phase == 1) {
                    arg0.left = v26;
                    arg0.phase = 2;
                    continue
                };
                arg0.refinement = arg0.refinement + 2;
                arg0.phase = 1;
                if (arg0.left.status == 10) {
                    arg0.low = aligned_in_range(arg0.low + v23, arg0.minimum, arg0.high, arg0.quantum);
                    continue
                };
                if (v26.status == 7) {
                    arg0.high = v25;
                    continue
                };
                if (arg0.left.amount > 0 && v26.amount > 0) {
                    if (progressive_better(&arg0.left, &v26)) {
                        arg0.high = v25;
                        continue
                    };
                    arg0.low = aligned_in_range(arg0.low + v23, arg0.minimum, arg0.high, arg0.quantum);
                    continue
                };
                if (v26.status == 10) {
                    arg0.low = v25;
                    continue
                };
                adaptive_finish(arg0, v26.status, false);
                return
            } else {
                break
            };
        };
        if (arg0.phase != 3) {
            let v27 = if (arg0.work == 0) {
                6
            } else {
                9
            };
            adaptive_finish(arg0, v27, false);
        };
    }

    public fun adaptive_start_if(arg0: bool, arg1: vector<Hop>, arg2: vector<StagedHop>, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) : AdaptiveSearch {
        let v0 = if (arg0 && arg4 > 0) {
            join_staged_route(arg1, arg2)
        } else {
            0x1::vector::empty<Hop>()
        };
        let v1 = adaptive_route_start(v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, true, 1, 1);
        let v2 = &mut v1;
        adaptive_tolerance(v2, arg11);
        v1.readers.max_batch_effective = arg12;
        v1.readers.max_batch_physical = arg13;
        v1
    }

    fun adaptive_tolerance(arg0: &mut AdaptiveSearch, arg1: u64) {
        arg0.schedule.tolerance_bps = arg1;
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).tolerance_bps = arg1;
            0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).approximate_stop = true;
        };
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
                let (v20, v21) = advance_segment_linear(v4.linear_cursor, v19, effective_input(v0, v4.fee_rate, v4.fee_denominator));
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

    fun advance_segment_linear(arg0: u64, arg1: &mut vector<LinearSegment>, arg2: u128) : (u128, u64) {
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

    fun balances_cover_domain(arg0: &vector<Hop>, arg1: u128) : bool {
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
            v0 = mul_ratio_up_saturating(v0, hop_marginal_upper_x64(v2), q64());
            if (v0 > (v2.policy.output_capacity as u256)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun bias_passes(arg0: &vector<Hop>, arg1: u256, arg2: u128) : bool {
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

    fun bolt_cached_quote(arg0: &vector<BoltFixedHop>, arg1: u128, arg2: &mut u64) : (u128, u8) {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<BoltFixedHop>(arg0)) {
            if (v0 == 0) {
                return (0, 10)
            };
            let v2 = 0x1::vector::borrow<BoltFixedHop>(arg0, v1);
            if (v0 > v2.input_capacity) {
                return (0, 7)
            };
            if (v0 < v2.input_minimum) {
                return (0, 10)
            };
            if (*arg2 == 0) {
                return (0, 6)
            };
            *arg2 = *arg2 - 1;
            if (v2.is_bolt) {
                if (v0 > 18446744073709551615) {
                    return (0, 5)
                };
                let (v3, _, _, v6) = 0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::evaluate(0x1::vector::borrow<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(&v2.bolt, 0), (v0 as u64));
                if (v6 != 0) {
                    return (0, bolt_quote_status(v6))
                };
                v0 = (v3 as u128);
            } else {
                v0 = quote_prepared_cpmm(&v2.cpmm, v0);
            };
            if (v0 == 0) {
                return (0, 10)
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
        let v0 = 0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::decode(arg0);
        let v1 = lst_ratio_hop(1, 1, 0, 0, false, true);
        v1.kind = 18;
        v1.policy.input_capacity = 18446744073709551615;
        let v2 = if (0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::ready(&v0)) {
            0
        } else {
            2
        };
        v1.state_status = v2;
        0x1::vector::push_back<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(&mut v1.policy.bolt, v0);
        v1
    }

    fun bolt_quote_status(arg0: u8) : u8 {
        if (arg0 == 1) {
            10
        } else if (arg0 == 5) {
            12
        } else {
            arg0
        }
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
        if (bolt_fixed_route(&arg0) && (v4 - v3) / arg4 + 1 <= (arg6 as u128)) {
            let (v5, v6) = bolt_fixed_cache(&arg0);
            let v7 = v5;
            if (v6 != 0) {
                let v8 = empty_result();
                v8.complete = false;
                v8.status = v6;
                return (v8, vector[])
            };
            return bolt_grid_search(&v7, v3, v4, arg4, arg7)
        };
        let v9 = if (0x1::vector::is_empty<u128>(&arg1)) {
            v3
        } else {
            *0x1::vector::borrow<u128>(&arg1, 0)
        };
        let v10 = adaptive_route_start(arg0, v9, v4, 1, arg5, arg6, arg7, 0, 0, false, v3, arg4);
        if (v10.schedule.count > (arg6 as u128)) {
            let v11 = &mut v10.work;
            let (v12, v13) = bolt_candidate_points(&v10.route, arg1, v3, v4, arg4, arg5, arg6, v11);
            v10.schedule.points = v12;
            v10.upper = v13;
        };
        let v14 = &mut v10;
        adaptive_run(v14);
        (v10.result, v10.points)
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

    fun coarse_upper(arg0: &vector<Hop>, arg1: u8) : (bool, u256, u256, bool) {
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
                let (v5, v6, v7) = if (v4.kind == 18 && arg1 > 0) {
                    if (arg1 == 2) {
                        (true, mul_fraction_ceil(hop_marginal_upper_x64(v4), (0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::current_fee_keep(0x1::vector::borrow<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(&v4.policy.bolt, 0)) as u256), 10000000), 0)
                    } else {
                        (true, hop_marginal_upper_x64(v4), 0)
                    }
                } else {
                    hop_affine_upper(v4)
                };
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
        let (v10, v11, v12, v13) = if (v0) {
            (v1, v2, true, true)
        } else {
            (115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935, true, false)
        };
        (v13, v10, v11, v12)
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
        let v0 = has_execution_bounds(&arg0);
        let v1 = if (v0 || contains_finite_model(&arg0)) {
            arg0
        } else {
            0x1::vector::empty<Hop>()
        };
        let v2 = route_model(&arg0) == 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hop>(&arg0)) {
            let v4 = if (0x1::vector::borrow<Hop>(&arg0, v3).kind == 3) {
                if (0x1::vector::borrow<Hop>(&arg0, v3).linear_has_more) {
                    0x1::vector::is_empty<LinearSegment>(&0x1::vector::borrow<Hop>(&arg0, v3).linear_segments) || 0x1::vector::borrow<LinearSegment>(&0x1::vector::borrow<Hop>(&arg0, v3).linear_segments, 0).exact_dlmm
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                v2 = false;
            };
            v3 = v3 + 1;
        };
        let v5 = false;
        let v6 = false;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<Hop>(&arg0)) {
            let v9 = v5 || 0x1::vector::borrow<Hop>(&arg0, v8).kind == 2;
            v5 = v9;
            let v10 = v6 || 0x1::vector::borrow<Hop>(&arg0, v8).kind == 3;
            v6 = v10;
            if (0x1::vector::borrow<Hop>(&arg0, v8).kind == 3) {
                v7 = v8 + 1;
            };
            v8 = v8 + 1;
        };
        OptimizeState{
            route                : arg0,
            validation_route     : v1,
            max_amount_in        : arg1,
            max_segments         : arg2,
            cursor               : 0,
            cursor_output        : 0,
            result               : empty_result(),
            finished             : false,
            work                 : (18446744073709551615 as u64),
            tolerance_bps        : 0,
            small_gains          : 0,
            gain_cursor          : 0,
            gain_profit          : 0,
            monotone             : v2,
            approximate_stop     : false,
            auxiliary_cost       : auxiliary_cost_x64(&arg0),
            bounded_domain       : v0,
            capacity_slack       : balances_cover_domain(&arg0, arg1),
            has_book             : v5,
            has_linear           : v6,
            linear_prefix_length : v7,
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

    fun contains_finite_model(arg0: &vector<Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hop>(arg0)) {
            if (0x1::vector::borrow<Hop>(arg0, v0).kind == 2 || 0x1::vector::borrow<Hop>(arg0, v0).kind == 3) {
                return true
            };
            v0 = v0 + 1;
        };
        false
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

    fun first_probe_estimate(arg0: &Hop, arg1: u128) : u128 {
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

    fun hop_marginal_upper_x64(arg0: &Hop) : u256 {
        if (arg0.kind == 19) {
            return meta_upper_rate(arg0)
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
            reject_empty_endpoint         : false,
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

    fun next_boundary_and_coefficients(arg0: &vector<Hop>, arg1: u128) : (u128, u64, u256, u256) {
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
            return (arg1, 18446744073709551615, v1, v2)
        };
        let (v9, v10) = source_input_to_boundary(arg0, v0);
        let (v11, v12) = if (v10 && v9 < arg1) {
            (v9, v0)
        } else {
            (arg1, 18446744073709551615)
        };
        (v11, v12, v1, v2)
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
        let v0 = if (!0x1::vector::is_empty<TickBoundary>(&arg0.boundaries)) {
            let v1 = *0x1::vector::borrow<TickBoundary>(&arg0.boundaries, 0);
            v1.sqrt_price_x64 == arg0.sqrt_price_x64
        } else {
            false
        };
        if (v0) {
            let v2 = *0x1::vector::borrow<TickBoundary>(&arg0.boundaries, 0);
            apply_liquidity_net(arg0, v2);
            arg0.boundary_cursor = 1;
        };
        skip_empty_v3_boundaries(arg0);
    }

    fun numeric_bolt_events(arg0: &vector<Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: &mut u64) : vector<u128> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<Hop>(arg0, v1);
            if (v2.kind == 18) {
                let v3 = 0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::input_breakpoints(0x1::vector::borrow<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(&v2.policy.bolt, 0));
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

    fun numeric_search_route_impl(arg0: vector<Hop>, arg1: vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: bool) : (OptimizeResult, vector<u128>) {
        if (arg2 > 0 && arg3 < arg2) {
            return (coarse_rejection(), vector[])
        };
        let v0 = if (arg2 > 0) {
            if (arg2 <= arg3) {
                if (arg4 > 0) {
                    0x1::vector::length<u128>(&arg1) <= 2
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
        if (contains_bolt(&arg0)) {
            return bolt_search(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
        };
        let v1 = 0x1::u128::min(arg3, 0x1::vector::borrow<Hop>(&arg0, 0).policy.input_capacity);
        if (v1 < arg2) {
            return (coarse_rejection(), vector[])
        };
        let v2 = if (0x1::vector::is_empty<u128>(&arg1)) {
            arg2
        } else {
            0x1::u128::min(*0x1::vector::borrow<u128>(&arg1, 0), v1)
        };
        let v3 = adaptive_route_start(arg0, v2, v1, 1, arg5, arg6, arg7, 0, 0, false, arg2, arg4);
        let v4 = &mut v3;
        adaptive_run(v4);
        if (v3.blocked != 18446744073709551615 && v3.best.amount > 0) {
            let v5 = amount_lower_bound(&v3.points, v3.amount);
            let v6 = empty_progressive_sample();
            v6.status = 3;
            0x1::vector::insert<u128>(&mut v3.points, v3.amount, v5);
            0x1::vector::insert<ProgressiveSample>(&mut v3.samples, v6, v5);
            v3.pending = false;
            v3.blocked = 18446744073709551615;
            v3.phase = 1;
            let v7 = &mut v3;
            adaptive_bracket(v7);
            let v8 = &mut v3;
            adaptive_run(v8);
        };
        (v3.result, v3.points)
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

    public fun optimize_coefficients(arg0: vector<Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        let v0 = coefficient_state(arg0, arg1, arg2);
        let v1 = &mut v0;
        resume_coefficients(v1);
        progress_result(&v0)
    }

    public fun optimize_selected_staged_if(arg0: bool, arg1: vector<Hop>, arg2: vector<StagedHop>, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : OptimizeResult {
        if (!arg0 || arg4 == 0) {
            return coarse_rejection()
        };
        assert!(arg3 > 0, 6);
        let v0 = join_staged_route(arg1, arg2);
        if (route_model(&v0) != 1) {
            let v1 = adaptive_route_start(v0, arg3, arg4, arg5, arg7, arg8, arg9, 0, 0, true, 1, 1);
            let v2 = &mut v1;
            adaptive_tolerance(v2, arg6);
            let v3 = &mut v1;
            adaptive_run(v3);
            return adaptive_result(v1)
        };
        let v4 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v4, 0x1::u128::min(arg3, arg4));
        let (v5, _) = numeric_search_route_impl(v0, v4, 1, arg4, 1, arg7, arg8, arg9, 0, false);
        v5
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

    public fun passes_bolt_coarse_gate(arg0: &vector<Hop>, arg1: u256, arg2: bool) : bool {
        let v0 = if (arg2) {
            2
        } else {
            1
        };
        let (v1, v2, v3, v4) = coarse_upper(arg0, v0);
        if (!v4) {
            return false
        };
        if (!v1) {
            return !arg2
        };
        v2 > saturating_add(arg1, auxiliary_cost_x64(arg0) - q64()) || !arg2 && v3 > 0
    }

    public fun passes_bounded_profit_gate(arg0: &vector<Hop>, arg1: u128) : bool {
        let (v0, v1, v2, v3) = coarse_upper(arg0, 0);
        if (!v3) {
            return false
        };
        if (!v0 || v1 > auxiliary_cost_x64(arg0)) {
            return true
        };
        bias_passes(arg0, v2, arg1)
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
        progress_result_bounded(arg0, 16384, 13, false)
    }

    fun progress_result_bounded(arg0: &OptimizeState, arg1: u64, arg2: u64, arg3: bool) : OptimizeResult {
        if (0x1::vector::is_empty<Hop>(&arg0.validation_route) || !arg0.result.found) {
            return arg0.result
        };
        let v0 = &arg0.validation_route;
        let (v1, v2, v3) = prepare_v3_prefix_caches(v0, arg1);
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
        let v6 = arg1 - v3;
        if (arg3) {
            let v7 = 0;
            while (v7 < 0x1::vector::length<V3PrefixCache>(&v4)) {
                if (0x1::vector::borrow<Hop>(v0, v7).kind == 1) {
                    0x1::vector::borrow_mut<V3PrefixCache>(&mut v4, v7).reject_empty_endpoint = true;
                };
                v7 = v7 + 1;
            };
        };
        let v8 = 0;
        let v9 = arg0.result.amount_in;
        let v10 = v9;
        let v11 = 0;
        while (v11 < 0x1::u64::min(arg2, 13) && v6 > 0) {
            let v12 = &mut v4;
            let v13 = &mut v6;
            let (v14, v15, _, _) = quote_bounded_route(v0, v12, v9, v13);
            let v18 = v11 + 1;
            v11 = v18;
            v5.evaluations = v5.evaluations + 1;
            if (v15 == 0) {
                let v19 = &mut v5;
                record_route_candidate(v0, v9, v14, v19);
                if (v18 == 1 || arg0.tolerance_bps > 0) {
                    return v5
                };
                v8 = v9;
            } else if (v15 == 7 || v15 == 3) {
                v10 = v9;
                if (v15 == 3) {
                    v5.complete = false;
                    v5.status = v15;
                };
            } else if (v15 == 1) {
                v8 = v9;
            } else {
                v5.complete = false;
                v5.status = v15;
                return v5
            };
            if (v10 - v8 <= 1) {
                break
            };
            if (arg0.tolerance_bps > 0 && v18 == 1) {
                v9 = v10 - 0x1::u128::max(v10 / 10000, 1);
                continue
            };
            v9 = v8 + (v10 - v8) / 2;
        };
        v5
    }

    public fun progressive_better(arg0: &ProgressiveSample, arg1: &ProgressiveSample) : bool {
        if (arg0.negative != arg1.negative) {
            return !arg0.negative
        };
        arg0.negative && arg0.magnitude < arg1.magnitude || arg0.magnitude > arg1.magnitude
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
        let (v0, v1, v2, v3, _, _) = quote_route_from(arg0, arg1, arg2, 0, arg3, arg4, arg5);
        (v0, v1, v2, v3)
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
        if (v0 == 0) {
            return (0, 10, 0)
        };
        if (v0 > (18446744073709551615 as u256)) {
            return (0, 12, 0)
        };
        if (!arg6) {
            if (v0 < (arg4 as u256)) {
                return (0, 10, 0)
            };
            if (v0 > (arg3 as u256) || v0 > (arg5 as u256)) {
                return (0, 7, 0)
            };
        };
        let v1 = v0 * (arg1 as u256) / (arg0 as u256);
        if (v1 > v0) {
            return (0, 5, 0)
        };
        (((v0 - v1) as u128), 0, 0)
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
            let v2 = (18446744073709551615 as u64);
            let v3 = &mut v2;
            let (v4, _, _, _) = quote_linear_hop_bounded_impl(arg0.linear_cursor, arg0.linear_has_more, &arg0.linear_segments, v0, v3);
            v4
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
                7
            };
            return (0, v0, arg5.crossed)
        };
        let v1 = 0;
        let v2 = 0x1::u64::min(0x1::vector::length<OrderbookPrefix>(&arg5.prefixes), *arg4);
        while (v1 < v2) {
            v2 = v1 + (v2 - v1) / 2;
            if (0x1::vector::borrow<OrderbookPrefix>(&arg5.prefixes, v2).spent <= arg3) {
                v1 = v2 + 1;
                continue
            };
        };
        let v3 = if (v1 == 0) {
            0
        } else {
            0x1::vector::borrow<OrderbookPrefix>(&arg5.prefixes, v1 - 1).spent
        };
        let v4 = if (v1 == 0) {
            0
        } else {
            0x1::vector::borrow<OrderbookPrefix>(&arg5.prefixes, v1 - 1).output
        };
        *arg4 = *arg4 - v1;
        let (v5, v6, v7, v8) = quote_linear_hop_bounded_impl(arg0 + v1, arg1, arg2, arg3 - v3, arg4);
        let v9 = v7 + v1;
        if (0x1::vector::length<LinearSegment>(arg2) >= 8 && v6 != 5) {
            let v10 = 0x1::vector::length<OrderbookPrefix>(&arg5.prefixes);
            let v11 = if (v10 == 0) {
                0
            } else {
                0x1::vector::borrow<OrderbookPrefix>(&arg5.prefixes, v10 - 1).spent
            };
            let v12 = v11;
            let v13 = if (v10 == 0) {
                0
            } else {
                0x1::vector::borrow<OrderbookPrefix>(&arg5.prefixes, v10 - 1).output
            };
            let v14 = v13;
            while (v10 < v9) {
                let v15 = 0x1::vector::borrow<LinearSegment>(arg2, arg0 + v10);
                let v16 = v12 + v15.remaining_input;
                v12 = v16;
                if (v14 > 340282366920938463463374607431768211455 - v15.remaining_output) {
                    return (0, 5, v9)
                };
                let v17 = v14 + v15.remaining_output;
                v14 = v17;
                let v18 = OrderbookPrefix{
                    minimum_input : v16,
                    spent         : v16,
                    output        : v17,
                    base          : 0,
                };
                0x1::vector::push_back<OrderbookPrefix>(&mut arg5.prefixes, v18);
                v10 = v10 + 1;
            };
        };
        if (v8 > 0 && (v6 == 3 || v6 == 7)) {
            arg5.minimum_gross = arg3 - v8 + 1;
            arg5.crossed = v9;
        };
        if (v6 == 0 && v4 > 340282366920938463463374607431768211455 - v5) {
            return (0, 5, v9)
        };
        let v19 = if (v6 == 0) {
            v4 + v5
        } else {
            0
        };
        (v19, v6, v9)
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
            let v10 = mul_div_down(v9, v6.price, 1000000000);
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
            let v15 = mul_div_down(v14, v11.price, 1000000000);
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

    fun quote_route(arg0: &vector<Hop>, arg1: u128) : u128 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hop>(arg0)) {
            v0 = quote_hop(0x1::vector::borrow<Hop>(arg0, v1), v0);
            v1 = v1 + 1;
        };
        v0
    }

    fun quote_route_from(arg0: &vector<Hop>, arg1: &mut vector<V3PrefixCache>, arg2: u128, arg3: u64, arg4: &mut u64, arg5: &mut vector<OrderbookShortfall>, arg6: bool) : (u128, u8, u64, u64, u64, u128) {
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
            let (v4, v5, v6) = if (v3.kind == 0) {
                if (*arg4 == 0) {
                    return (0, 6, v1, v2, arg3, v0)
                };
                *arg4 = *arg4 - 1;
                let v4 = effective_output(v2_curve_output(v3.fee_denominator, v3.fee_rate, v3.policy.fractional_input_fee, v3.reserve_in, v3.reserve_out, v0), v3.output_fee_rate, v3.output_fee_denominator);
                (v4, 0, 0)
            } else if (v3.kind == 5) {
                while (0x1::vector::length<V3PrefixCache>(arg1) <= arg3) {
                    0x1::vector::push_back<V3PrefixCache>(arg1, new_prefixCache(0x1::vector::empty<V3Prefix>(), 0, 0, 1, 0, 0, 340282366920938463463374607431768211455, false, 0, false, false));
                };
                let v7 = &mut 0x1::vector::borrow_mut<V3PrefixCache>(arg1, arg3).liquidity;
                quote_stable_with_d(v3.reserve_in, v3.reserve_out, v3.stable_admin_fee, v3.stable_amp, v3.stable_fee_on_input, v3.stable_lp_fee, v3.stable_scale_in, v3.stable_scale_out, v3.stable_th_fee, v0, arg4, v7)
            } else if (v3.kind == 6) {
                quote_ve33_stable_hop(v3.fee_denominator, v3.fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_amp, v3.stable_scale_in, v3.stable_scale_out, v0, arg4)
            } else if (v3.kind == 7) {
                quote_virtual_cpmm_hop(v3.fee_denominator, v3.fee_rate, v3.reserve_in, v3.reserve_out, v3.sqrt_price_x64, v3.stable_amp, v3.stable_scale_in, v3.stable_scale_out, v3.zero_for_one, v0, arg4)
            } else if (v3.kind == 8) {
                quote_kriya_v2_hop(v3.fee_denominator, v3.fee_rate, v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_amp, v3.stable_fee_on_input, v3.stable_scale_in, v3.stable_scale_out, v0, arg4)
            } else if (v3.kind == 18) {
                if (*arg4 == 0) {
                    return (0, 6, v1, v2, arg3, v0)
                };
                *arg4 = *arg4 - 1;
                let (v8, _, _, v11) = 0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::evaluate(0x1::vector::borrow<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(&v3.policy.bolt, 0), (v0 as u64));
                let v12 = if (v11 == 0) {
                    0
                } else {
                    bolt_quote_status(v11)
                };
                ((v8 as u128), v12, 0)
            } else if (v3.kind == 17) {
                quote_capped_ratio_hop(v3.reserve_in, v3.reserve_out, v3.stable_scale_in, v0, arg4)
            } else if (v3.kind == 9) {
                quote_lst_ratio_hop(v3.fee_denominator, v3.fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_amp, v3.zero_for_one, v0, arg4)
            } else if (v3.kind == 10) {
                quote_hasui_ratio_hop(v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_amp, v3.stable_scale_in, v3.stable_scale_out, v3.zero_for_one, v0, arg4)
            } else if (v3.kind == 11) {
                quote_hawal_ratio_hop(v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_amp, v3.stable_scale_out, v3.zero_for_one, v0, arg4)
            } else if (v3.kind == 12) {
                quote_aftermath_with_exponent(v3.fee_rate, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.stable_admin_fee, (v3.liquidity as u256), v3.stable_scale_in, v3.stable_scale_out, v0, arg4)
            } else if (v3.kind == 13) {
                quote_bucket_psm_hop(v3.fee_denominator, v3.fee_rate, v3.reserve_in, v3.stable_scale_in, v3.stable_scale_out, v3.zero_for_one, v0, arg4)
            } else if (v3.kind == 19) {
                quote_metastable(v3, v0, arg4)
            } else if (v3.kind == 14) {
                quote_steamm_cpmm_hop(v3.liquidity, v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.sqrt_price_x64, v3.stable_amp, v3.stable_scale_in, v3.stable_scale_out, v0, arg4)
            } else if (v3.kind == 15) {
                quote_steamm_omm_hop(v3.liquidity, v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.sqrt_price_x64, v3.stable_admin_fee, v3.stable_amp, v3.stable_lp_fee, v3.stable_scale_in, v3.stable_scale_out, v0, arg4)
            } else if (v3.kind == 16) {
                while (0x1::vector::length<V3PrefixCache>(arg1) <= arg3) {
                    0x1::vector::push_back<V3PrefixCache>(arg1, new_prefixCache(0x1::vector::empty<V3Prefix>(), 0, 0, 1, 0, 0, 340282366920938463463374607431768211455, false, 0, false, false));
                };
                let v13 = 0x1::vector::borrow_mut<V3PrefixCache>(arg1, arg3);
                quote_steamm_omm_v2_prepared(v3.liquidity, v3.orderbook_lot_size, v3.output_fee_denominator, v3.output_fee_rate, v3.reserve_in, v3.reserve_out, v3.sqrt_price_x64, v3.stable_admin_fee, v3.stable_amp, v3.stable_lp_fee, v3.stable_scale_in, v3.stable_scale_out, v3.stable_th_fee, v3.zero_for_one, v3.policy.omm_update_flag, v0, arg4, v13)
            } else if (v3.kind == 2) {
                let (v14, v15, v16) = if (0x1::vector::is_empty<OrderbookShortfall>(arg5)) {
                    quote_orderbook_hop_bounded(v3.fee_denominator, v3.fee_rate, v3.orderbook_base_to_quote, v3.orderbook_cursor, v3.orderbook_has_more, v3.orderbook_lot_size, v3.orderbook_min_size, &v3.orderbook_segments, v0, arg4)
                } else {
                    let v17 = 0x1::vector::borrow_mut<OrderbookShortfall>(arg5, arg3);
                    quote_orderbook_with_shortfall(v3.fee_denominator, v3.fee_rate, v3.orderbook_base_to_quote, v3.orderbook_cursor, v3.orderbook_has_more, v3.orderbook_lot_size, v3.orderbook_min_size, &v3.orderbook_segments, v0, arg4, v17, arg6)
                };
                v2 = v2 + v16;
                (v14, v15, 0)
            } else if (v3.kind == 3) {
                if (0x1::vector::is_empty<LinearSegment>(&v3.linear_segments)) {
                    let v18 = if (v3.linear_has_more) {
                        3
                    } else {
                        11
                    };
                    return (0, v18, v1, v2, arg3, v0)
                };
                let (v19, v20, v21) = if (0x1::vector::is_empty<OrderbookShortfall>(arg5)) {
                    let (v22, v23, v24) = quote_linear_hop_bounded(v3, v0, arg4);
                    (v24, v22, v23)
                } else {
                    let v25 = 0x1::vector::borrow_mut<OrderbookShortfall>(arg5, arg3);
                    let (v26, v27, v28) = quote_linear_with_shortfall(v3.linear_cursor, v3.linear_has_more, &v3.linear_segments, v0, arg4, v25);
                    (v28, v26, v27)
                };
                (v20, v21, v19)
            } else if (v3.kind == 1) {
                if (arg3 >= 0x1::vector::length<V3PrefixCache>(arg1)) {
                    return (0, 5, v1, v2, arg3, v0)
                };
                let v29 = 0x1::vector::borrow_mut<V3PrefixCache>(arg1, arg3);
                quote_v3_cached(&v3.boundaries, v29, v0, arg4)
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
        if (v2 == 0) {
            return (0, 10, 0)
        };
        if (v2 > (18446744073709551615 as u256)) {
            return (0, 7, 0)
        };
        let v3 = (arg4 as u256) * v2 / ((arg3 as u256) + v2);
        if (v3 == 0) {
            return (0, 10, 0)
        };
        if (v3 > (arg0 as u256)) {
            return (0, 7, 0)
        };
        let v4 = div_ceil(v3 * (arg2 as u256), (arg1 as u256));
        if (v4 >= v3) {
            return (0, 0, 0)
        };
        let v5 = steamm_btoken_burn_amount(v3 - v4, v1);
        if (v5 == 0) {
            let v6 = if (v3 - v4 >= (v1 as u256) || v1 <= 1000) {
                7
            } else {
                10
            };
            return (0, v6, 0)
        };
        let v7 = v5 * (arg8 as u256) / (v1 as u256) * 1000000000000000000;
        if (v7 > (arg5 as u256) || v7 > (18446744073709551615 as u256)) {
            return (0, 7, 0)
        };
        ((v7 as u128), 0, 0)
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
        if (v2 == 0) {
            return (0, 10, 0)
        };
        if (v2 > ((18446744073709551615 - (v0 as u128)) as u256)) {
            return (0, 7, 0)
        };
        let v3 = ((arg9 as u256) + (arg11 as u256) * 1000000000000000000) / ((v0 as u256) + v2);
        let v4 = (arg10 as u256) / (v1 as u256);
        if (v3 == 0 || v4 == 0) {
            return (0, 5, 0)
        };
        let (v5, v6) = steamm_decimal_mul(v2 * 1000000000000000000, v3);
        if (!v6) {
            return (0, 5, 0)
        };
        let (v7, v8) = steamm_decimal_mul(v5, (arg3 as u256));
        if (!v8) {
            return (0, 5, 0)
        };
        let (v9, v10) = steamm_decimal_div(v7, (arg0 as u256));
        if (!v10) {
            return (0, 5, 0)
        };
        let (v11, v12) = steamm_decimal_div(v9, v4);
        let v13 = v11;
        if (!v12) {
            return (0, 5, 0)
        };
        let v14 = (arg6 as u8);
        let v15 = (arg8 as u8);
        let v16 = if (v14 >= v15) {
            v14 - v15
        } else {
            v15 - v14
        };
        let v17 = 1;
        let v18 = 0;
        while (v18 < v16) {
            v17 = v17 * 10;
            v18 = v18 + 1;
        };
        if (v14 > v15) {
            v13 = v11 / v17;
        } else if (v15 > v14) {
            if (v11 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v17) {
                return (0, 5, 0)
            };
            v13 = v11 * v17;
        };
        let v19 = v13 / 1000000000000000000;
        if (v19 == 0) {
            return (0, 10, 0)
        };
        if (v19 >= (arg4 as u256) || v19 > (18446744073709551615 as u256)) {
            return (0, 7, 0)
        };
        let v20 = div_ceil(v19 * (arg2 as u256), (arg1 as u256));
        if (v20 >= v19) {
            return (0, 0, 0)
        };
        let v21 = steamm_btoken_burn_amount(v19 - v20, v1);
        if (v21 == 0) {
            let v22 = if (v19 - v20 >= (v1 as u256) || v1 <= 1000) {
                7
            } else {
                10
            };
            return (0, v22, 0)
        };
        let v23 = v21 * (arg10 as u256) / (v1 as u256) * 1000000000000000000;
        if (v23 > (arg5 as u256) || v23 > (18446744073709551615 as u256)) {
            return (0, 7, 0)
        };
        ((v23 as u128), 0, 0)
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
        let v9 = if (arg1.policy_stop_at_zero_liquidity || arg1.reject_empty_endpoint) {
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
            (0, 5)
        } else {
            (v5 + v12, 0)
        };
        (v13, v14, v2)
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
        if (!arg0.found || arg5 % 4 == 3) {
            return largest_gap_midpoint(arg1, arg2, arg3, arg4)
        };
        let v0 = arg0.amount_in;
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
        let v0 = arg0.auxiliary_cost;
        let v1 = arg0.bounded_domain;
        while (arg0.cursor < arg0.max_amount_in && arg0.result.segments < arg0.max_segments) {
            if ((arg0.has_book || arg0.has_linear) && has_terminal_finite_hop(&arg0.route)) {
                arg0.finished = true;
                return
            };
            let v2 = 0x1::vector::length<Hop>(&arg0.route) * (2 * 0x1::vector::length<Hop>(&arg0.route) + 4);
            if (arg0.work != (18446744073709551615 as u64)) {
                if (arg0.work <= v2 + 0x1::vector::length<Hop>(&arg0.route) * 4) {
                    arg0.finished = true;
                    arg0.result.complete = false;
                    arg0.result.status = 6;
                    return
                };
                arg0.work = arg0.work - v2;
            };
            let v3 = if (arg0.has_book) {
                first_missing_orderbook_segment(&arg0.route)
            } else {
                18446744073709551615
            };
            if (v3 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v3;
                return
            };
            let v4 = if (arg0.has_linear) {
                first_missing_linear_segment(&arg0.route)
            } else {
                18446744073709551615
            };
            if (v4 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v4;
                return
            };
            if (arg0.has_book && !orderbook_minimums_reachable(&arg0.route)) {
                arg0.finished = true;
                return
            };
            let v5 = first_missing_boundary(&arg0.route);
            if (v5 != 18446744073709551615) {
                while (v5 < 0x1::vector::length<Hop>(&arg0.route)) {
                    if (0x1::vector::borrow<Hop>(&arg0.route, v5).kind == 1 && 0x1::vector::borrow<Hop>(&arg0.route, v5).liquidity == 0) {
                        arg0.result.complete = false;
                        arg0.result.needs_more_hop = v5;
                        return
                    };
                    v5 = v5 + 1;
                };
            };
            let v6 = !arg0.has_book || orderbook_minimums_satisfied(&arg0.route);
            let v7 = arg0.max_amount_in - arg0.cursor;
            let v8 = arg0.work != (18446744073709551615 as u64);
            let (v9, v10, v11) = if (v8 && v5 == 18446744073709551615) {
                let (v12, v13, v14, v15) = next_boundary_and_coefficients(&arg0.route, v7);
                let _ = v13;
                (v12, v14, v15)
            } else {
                let (v17, v18) = route_coefficients_x64(&arg0.route);
                let _ = 18446744073709551615;
                (0, v17, v18)
            };
            let v19 = if (v0 == q64()) {
                v10
            } else {
                mul_ratio_down_saturating(v10, q64(), v0)
            };
            if (v19 <= q64() && (arg0.monotone || arg0.approximate_stop)) {
                if (arg0.cursor == 0 && v6) {
                    arg0.result.coarse_rejected = true;
                    arg0.finished = true;
                    return
                };
                if (v6) {
                    if (!arg0.monotone) {
                        arg0.result.complete = false;
                    };
                    arg0.finished = true;
                    return
                };
            };
            if (v5 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v5;
                return
            };
            let v20 = if (v8) {
                v9
            } else {
                let (v21, _) = next_route_boundary(&arg0.route, v7);
                v21
            };
            let v23 = v20;
            assert!(v20 > 0, 3);
            let v24 = 0;
            let v25 = false;
            if (arg0.has_linear) {
                let v26 = v20;
                let v27 = 0;
                let v28 = 0;
                while (v27 < 0x1::vector::length<Hop>(&arg0.route)) {
                    let v29 = if (v8) {
                        if (v27 >= arg0.linear_prefix_length) {
                            if (v23 != v7) {
                                !v25
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v29) {
                        break
                    };
                    let v30 = 0x1::vector::borrow<Hop>(&arg0.route, v27);
                    if (v30.kind == 3) {
                        let v31 = effective_input(v26, v30.fee_rate, v30.fee_denominator);
                        let v32 = &v30.linear_segments;
                        let v33 = &mut arg0.work;
                        let (v34, v35, _, v37) = quote_linear_hop_bounded_impl(v30.linear_cursor, v30.linear_has_more, v32, v31, v33);
                        if (v35 == 3) {
                            arg0.result.complete = false;
                            arg0.result.needs_more_hop = v27;
                            return
                        };
                        if (v35 == 7) {
                            let (v38, v39) = source_input_for_local(&arg0.route, v27, gross_from_effective(v31 - v37, v30.fee_rate, v30.fee_denominator));
                            let v40 = if (v39) {
                                0x1::u128::min(0x1::u128::min(v23, v38), v23 - 1)
                            } else {
                                v23 / 2
                            };
                            v23 = v40;
                            v25 = true;
                            v28 = v28 + 1;
                            if (v40 == 0 || v28 > 0x1::vector::length<Hop>(&arg0.route) + 1) {
                                arg0.finished = true;
                                return
                            };
                            v26 = v40;
                            v27 = 0;
                            continue
                        };
                        if (v35 != 0) {
                            arg0.result.complete = false;
                            arg0.result.status = v35;
                            arg0.finished = true;
                            return
                        };
                        v26 = v34;
                    } else {
                        v26 = quote_hop(v30, v26);
                    };
                    v27 = v27 + 1;
                };
                v24 = v26;
            };
            arg0.result.segments = arg0.result.segments + 1;
            let v41 = q64() + v11 * (v23 as u256);
            if (v19 * q64() <= v41 * v41) {
                let v42 = if (v1) {
                    segment_minimum_input(&arg0.route, coefficient_root(v19, v11, v23), v23)
                } else {
                    coefficient_root(v19, v11, v23)
                };
                let (v43, v44) = if (v1 && !arg0.capacity_slack) {
                    limited_segment_input(&arg0.route, v42)
                } else {
                    (v42, false)
                };
                if (v8) {
                    let v45 = 0x1::u128::min(0x1::u128::max(v43, 1), v23);
                    let v46 = &mut arg0.result;
                    record_candidate_if_valid(&arg0.route, v45, arg0.cursor + v45, arg0.cursor_output + quote_route(&arg0.route, v45), v46);
                    let v47 = &mut arg0.result;
                    record_orderbook_quantized_candidates(&arg0.route, arg0.cursor, arg0.cursor_output, v45, v23, v47);
                } else {
                    let v48 = &mut arg0.result;
                    record_nearby_candidates(&arg0.route, arg0.cursor, arg0.cursor_output, v43, v23, v48);
                };
                if (v44 || (arg0.monotone || arg0.approximate_stop) && (v6 || candidate_satisfies_orderbook_minimums(&arg0.route, v23))) {
                    if (!arg0.monotone) {
                        arg0.result.complete = false;
                    };
                    arg0.finished = true;
                    return
                };
            };
            if (v1 && !arg0.capacity_slack) {
                let (v49, v50) = limited_segment_input(&arg0.route, v23);
                if (v50) {
                    if (v49 > 0) {
                        let v51 = &mut arg0.result;
                        record_nearby_candidates(&arg0.route, arg0.cursor, arg0.cursor_output, v49, v49, v51);
                    };
                    arg0.finished = true;
                    return
                };
            };
            if (v23 == v7 || v25) {
                let v52 = if (arg0.has_linear) {
                    v24
                } else {
                    quote_route(&arg0.route, v23)
                };
                let v53 = &mut arg0.result;
                record_candidate_if_valid(&arg0.route, v23, arg0.cursor + v23, arg0.cursor_output + v52, v53);
                if (arg0.cursor == 0) {
                    let v54 = &mut arg0.result;
                    record_v2_plateau_candidate(&arg0.route, v23, v52, v54);
                };
                arg0.finished = true;
                return
            };
            let v55 = &mut arg0.route;
            let (v56, v57, v58) = advance_route(v55, v23);
            arg0.cursor = arg0.cursor + v23;
            arg0.cursor_output = arg0.cursor_output + v56;
            arg0.result.crossed_ticks = arg0.result.crossed_ticks + v57;
            arg0.result.crossed_orders = arg0.result.crossed_orders + v58;
            if (v8) {
                if (!arg0.has_book || orderbook_minimums_satisfied(&arg0.route)) {
                    let v59 = if (v0 == q64()) {
                        0
                    } else {
                        mul_ratio_down_saturating((arg0.cursor as u256), v0 - q64(), q64())
                    };
                    let v60 = &mut arg0.result;
                    record_candidate_with_fee(arg0.cursor, arg0.cursor_output, v59, v60);
                };
            } else {
                let v61 = &mut arg0.result;
                record_candidate_if_valid(&arg0.route, 0, arg0.cursor, arg0.cursor_output, v61);
            };
            if (arg0.tolerance_bps > 0 && arg0.result.found) {
                if (arg0.gain_profit == 0) {
                    arg0.gain_cursor = arg0.cursor;
                    arg0.gain_profit = arg0.result.gross_profit;
                    continue
                };
                if (arg0.cursor - arg0.gain_cursor >= 0x1::u128::max(arg0.gain_cursor / 10, 1)) {
                    let v62 = if (((arg0.result.gross_profit - arg0.gain_profit) as u256) * 10000 <= (arg0.gain_profit as u256) * (0x1::u64::min(arg0.tolerance_bps, 100) as u256)) {
                        arg0.small_gains + 1
                    } else {
                        0
                    };
                    arg0.small_gains = v62;
                    arg0.gain_cursor = arg0.cursor;
                    arg0.gain_profit = arg0.result.gross_profit;
                    if (arg0.small_gains >= 2) {
                        arg0.finished = true;
                        arg0.result.complete = false;
                        return
                    };
                };
            };
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
        assert!(v0 > 0, 3);
        assert!(0x1::vector::length<u128>(&arg2) == v0 && 0x1::vector::length<bool>(&arg3) == v0, 3);
        let v1 = 0x1::vector::empty<TickBoundary>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<TickBoundary>(&mut v1, tick_boundary(*0x1::vector::borrow<u128>(&arg1, v2), *0x1::vector::borrow<u128>(&arg2, v2), *0x1::vector::borrow<bool>(&arg3, v2)));
            v2 = v2 + 1;
        };
        v3_window_stage(arg0, v1)
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

