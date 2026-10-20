module 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::optimizer {
    struct OptimizeState has drop {
        route: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>,
        validation_route: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>,
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
        has_frontier: bool,
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
        cpmm: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::PreparedCpmm,
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
        route: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>,
        caches: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>,
        shortfalls: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>,
        auxiliary_fees: vector<u64>,
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
        selector: SelectorState,
        marginal: MarginalBracket,
        schedule: ReversalSchedule,
        pending: bool,
        resume_hop: u64,
        resume_input: u128,
        blocked: u64,
        readers: ReadBudget,
    }

    struct SelectorState has drop {
        has_book: bool,
        bolt: bool,
        groups: bool,
    }

    struct MarginalBracket has drop {
        low: u256,
        high: u256,
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

    fun a0(arg0: u8) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::a0(arg0)
    }

    fun a1(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::a1(arg0, arg1, arg2, arg3, arg4)
    }

    fun a2(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::a2(arg0)
    }

    fun a3(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>, arg1: bool, arg2: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = a0(3);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_segments(&mut v0) = arg0;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_has_more(&mut v0) = arg1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_linear_rate_inversion(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = arg2;
        v0
    }

    fun a4(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: bool) : (OptimizeResult, vector<u128>) {
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
        if (a2(&arg0)) {
            return b6(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
        };
        let v1 = 0x1::u128::min(arg3, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0))));
        if (v1 < arg2) {
            return (coarse_rejection(), vector[])
        };
        let v2 = if (0x1::vector::is_empty<u128>(&arg1)) {
            arg2
        } else {
            0x1::u128::min(*0x1::vector::borrow<u128>(&arg1, 0), v1)
        };
        let v3 = k5(arg0, v2, v1, 1, arg5, arg6, arg7, 0, 0, false, arg2, arg4);
        let v4 = &mut v3;
        adaptive_run(v4);
        if (v3.blocked != 18446744073709551615 && v3.best.amount > 0) {
            let v5 = empty_progressive_sample();
            v5.status = 3;
            let v6 = &mut v3.points;
            let v7 = &mut v3.samples;
            insert_paid_sample(v6, v7, v3.amount, v5, amount_lower_bound(&v3.points, v3.amount));
            v3.pending = false;
            v3.blocked = 18446744073709551615;
            v3.phase = 1;
            let v8 = &mut v3;
            k9(v8);
            let v9 = &mut v3;
            adaptive_run(v9);
        };
        (v3.result, v3.points)
    }

    fun a5(arg0: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop, arg1: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::a5(arg0, arg1)
    }

    fun a6(arg0: u8) : u8 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::a6(arg0)
    }

    fun a7(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::a7(arg0)
    }

    fun a9(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: &mut u64) : vector<u128> {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::a9(arg0, arg1, arg2, arg3, arg4)
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
            k8(arg0, v0, false);
            return
        };
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            let v1 = 0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(&arg2)) {
                let v3 = orderbook_segment(*0x1::vector::borrow<u64>(&arg2, v2), *0x1::vector::borrow<u64>(&arg3, v2));
                0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_segments(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.route, arg1)), v3);
                0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_segments(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.validation_route, arg1)), v3);
                v2 = v2 + 1;
            };
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_has_more(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.route, arg1)) = arg4;
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_has_more(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.validation_route, arg1)) = arg4;
            v1.result.needs_more_hop = 18446744073709551615;
            arg0.blocked = 18446744073709551615;
            return
        };
        let v4 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut arg0.route, arg1);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg2)) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_segments(v4), orderbook_segment(*0x1::vector::borrow<u64>(&arg2, v5), *0x1::vector::borrow<u64>(&arg3, v5)));
            v5 = v5 + 1;
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_has_more(v4) = arg4;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_OrderbookShortfall_minimum_gross(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&mut arg0.shortfalls, arg1)) = 0;
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
            k8(arg0, v0, false);
            return
        };
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            let v1 = 0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<u128>(&arg2)) {
                0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_segments(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.validation_route, arg1)), dlmm_segment(*0x1::vector::borrow<u128>(&arg2, v2), *0x1::vector::borrow<u128>(&arg3, v2), *0x1::vector::borrow<u128>(&arg4, v2), *0x1::vector::borrow<u64>(&arg5, v2), arg6));
                v2 = v2 + 1;
            };
            let v3 = if (0x1::vector::length<u128>(&arg2) > 1) {
                h7(&v1.validation_route)
            } else {
                0
            };
            let v4 = if (true) {
                h9(&v1.route, arg1)
            } else {
                0
            };
            0x1::vector::append<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_segments(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.route, arg1)), i3(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&v1.validation_route, arg1)), v3, true, v4, 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&v1.validation_route, arg1)))));
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_has_more(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.route, arg1)) = arg7;
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_has_more(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.validation_route, arg1)) = arg7;
            let v5 = *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_linear_rate_inversion(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&v1.route, arg1))) || arg8;
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_linear_rate_inversion(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.route, arg1))) = v5;
            if (arg8 || arg7) {
                v1.monotone = false;
            };
            v1.result.needs_more_hop = 18446744073709551615;
            arg0.blocked = 18446744073709551615;
            return
        };
        let v6 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut arg0.route, arg1);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u128>(&arg2)) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_segments(v6), dlmm_segment(*0x1::vector::borrow<u128>(&arg2, v7), *0x1::vector::borrow<u128>(&arg3, v7), *0x1::vector::borrow<u128>(&arg4, v7), *0x1::vector::borrow<u64>(&arg5, v7), arg6));
            v7 = v7 + 1;
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_has_more(v6) = arg7;
        let v8 = *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_linear_rate_inversion(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v6)) || arg8;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_linear_rate_inversion(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(v6)) = v8;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_OrderbookShortfall_minimum_gross(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&mut arg0.shortfalls, arg1)) = 0;
        let v9 = if (arg0.result.found) {
            0
        } else {
            1
        };
        arg0.result.status = v9;
        arg0.blocked = 18446744073709551615;
    }

    public fun adaptive_append_secant_dlmm_if(arg0: &mut AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u64>, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: bool, arg12: bool) {
        if (!arg12) {
            return
        };
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg5)) {
            if (*0x1::vector::borrow<u64>(&arg5, v1) >= 9223372036854775808) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        if (!v0) {
            adaptive_append_dlmm_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
            return
        };
        assert!(adaptive_cetus_secant_eligible(arg0, arg1), 3);
        assert!(arg0.blocked == arg1, 3);
        let v2 = if (0x1::vector::length<u128>(&arg2) == 0x1::vector::length<u128>(&arg3)) {
            if (0x1::vector::length<u128>(&arg2) == 0x1::vector::length<u128>(&arg4)) {
                0x1::vector::length<u128>(&arg2) == 0x1::vector::length<u64>(&arg5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
        adaptive_note_reads(arg0, arg1, arg9, arg10, arg11, false);
        if (arg9 == 0 && arg10 == 0) {
            let v3 = if (arg11) {
                7
            } else {
                3
            };
            k8(arg0, v3, false);
            return
        };
        let v4 = if (arg0.selector.has_book) {
            if (!arg0.selector.bolt) {
                if (arg1 == 1) {
                    if (arg0.schedule.exploration_limit == 0) {
                        !arg0.schedule.initialized
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
            if (arg0.marginal.low == 0) {
                *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_minimum_gross(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg0.shortfalls, arg1)) > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            arg0.marginal.low = ((*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_minimum_gross(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg0.shortfalls, arg1)) - 1) as u256);
        };
        arg0.selector.groups = true;
        let v6 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut arg0.route, arg1);
        v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg2)) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_segments(v6), a1(*0x1::vector::borrow<u128>(&arg2, v1), *0x1::vector::borrow<u128>(&arg3, v1), *0x1::vector::borrow<u128>(&arg4, v1), *0x1::vector::borrow<u64>(&arg5, v1), arg6));
            if (v4) {
                arg0.marginal.low = arg0.marginal.low + (*0x1::vector::borrow<u128>(&arg2, v1) as u256);
            };
            v1 = v1 + 1;
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_has_more(v6) = arg7;
        let v7 = *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_linear_rate_inversion(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v6)) || arg8;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_linear_rate_inversion(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(v6)) = v7;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_OrderbookShortfall_minimum_gross(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&mut arg0.shortfalls, arg1)) = 0;
        let v8 = if (arg0.result.found) {
            0
        } else {
            1
        };
        arg0.result.status = v8;
        arg0.blocked = 18446744073709551615;
    }

    public fun adaptive_append_v3_frontier_if(arg0: &mut AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<bool>, arg5: u64, arg6: u64, arg7: bool, arg8: u128, arg9: bool) {
        if (!arg9) {
            return
        };
        let v0 = 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg2)) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(&mut v0, tick_boundary(*0x1::vector::borrow<u128>(&arg2, v1), *0x1::vector::borrow<u128>(&arg3, v1), *0x1::vector::borrow<bool>(&arg4, v1)));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::is_empty<u128>(&arg2) || arg8 != *0x1::vector::borrow<u128>(&arg2, 0x1::vector::length<u128>(&arg2) - 1);
        if (v2) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(&mut v0, tick_boundary(arg8, 0, false));
        };
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            let v3 = 0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0);
            let v4 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&v3.route, arg1);
            let v5 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_stable_amp(v4) > 0) {
                if ((*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_cursor(v4) as u128) < *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_stable_amp(v4)) {
                    (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_boundary_cursor(v4) as u128) >= *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_stable_amp(v4)
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                v3.result.crossed_ticks = v3.result.crossed_ticks - 1;
            };
            let v6 = v3.has_frontier || v2;
            v3.has_frontier = v6;
            let v7 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v3.route, arg1);
            m3(v7, v0, v2);
            let v8 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v3.validation_route, arg1);
            m3(v8, v0, v2);
            v3.result.needs_more_hop = 18446744073709551615;
            v3.result.complete = true;
        } else {
            let v9 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut arg0.route, arg1);
            m3(v9, v0, v2);
            let v10 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&mut arg0.caches, arg1);
            let v11 = if (v2) {
                1
            } else {
                0
            };
            let v12 = 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_boundaries(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1))) - v11;
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_stable_amp(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)) > 0 && 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(v10)) > *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_real_boundary_limit(v10)) {
                0x1::vector::pop_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_V3PrefixCache_prefixes(v10));
            };
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_V3PrefixCache_real_boundary_limit(v10) = v12 - 0x1::u64::min(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_boundary_cursor(v10), v12);
            let v13 = if (v2) {
                13
            } else {
                0
            };
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_V3PrefixCache_status(v10) = v13;
        };
        adaptive_note_reads(arg0, arg1, arg5, arg6, arg7, false);
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
            k8(arg0, v0, false);
            return
        };
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            let v1 = 0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0);
            if (!0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&v1.validation_route)) {
                let v2 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_boundaries(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.validation_route, arg1));
                l3(v2, &arg2, &arg3, &arg4);
            };
            let v3 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_boundaries(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.route, arg1));
            l3(v3, &arg2, &arg3, &arg4);
            v1.result.needs_more_hop = 18446744073709551615;
            v1.result.complete = true;
            let v4 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v1.route, arg1);
            v1.result.crossed_ticks = v1.result.crossed_ticks + g5(v4);
        } else {
            let v5 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_boundaries(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut arg0.route, arg1));
            l3(v5, &arg2, &arg3, &arg4);
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_V3PrefixCache_status(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&mut arg0.caches, arg1)) = 0;
            let v6 = if (arg0.result.found) {
                0
            } else {
                1
            };
            arg0.result.status = v6;
        };
        arg0.blocked = 18446744073709551615;
    }

    public fun adaptive_cetus_read_demand(arg0: &AdaptiveSearch, arg1: u64, arg2: bool) : (u128, u128) {
        if (arg0.blocked != arg1) {
            return (0, 0)
        };
        let v0 = if (!arg2) {
            true
        } else if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            true
        } else if (!arg0.pending) {
            true
        } else if (arg0.resume_hop != arg1) {
            true
        } else if (arg1 >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
            true
        } else {
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)) != 3
        };
        if (v0) {
            return (adaptive_cetus_stop_rate(arg0, arg1), 0)
        };
        let v1 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v1))) {
            v2 = v2 + (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_LinearSegment_remaining_input(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v1), v3)) as u256);
            v3 = v3 + 1;
        };
        let v4 = (effective_input(arg0.resume_input, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(v1), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v1)) as u256);
        let v5 = if (v4 > v2) {
            to_u128(v4 - v2)
        } else {
            0
        };
        (adaptive_cetus_stop_rate(arg0, arg1), v5)
    }

    public fun adaptive_cetus_secant_eligible(arg0: &AdaptiveSearch, arg1: u64) : bool {
        let v0 = if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            true
        } else if (!arg0.selector.has_book) {
            true
        } else if (arg0.selector.bolt) {
            true
        } else if (arg1 >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
            true
        } else {
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)) != 3
        };
        if (v0) {
            return false
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
            let v2 = *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v1));
            let v3 = if (v2 != 0) {
                if (v2 != 1) {
                    if (v2 != 3) {
                        v2 != 2
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
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun adaptive_cetus_stop_rate(arg0: &AdaptiveSearch, arg1: u64) : u128 {
        let v0 = if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            &0x1::vector::borrow<OptimizeState>(&arg0.mk, 0).validation_route
        } else {
            &arg0.route
        };
        if (arg1 >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0) || *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1)) != 3) {
            return 0
        };
        let v1 = q64();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0)) {
            if (v2 != arg1) {
                let v3 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, v2);
                if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_state_status(v3) != 0) {
                    return 0
                };
                let v4 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v3) == 0 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_in(v3) > 0) {
                    cap_upper_v2(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_in(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_out(v3))
                } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v3) == 1 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_sqrt_price_x64(v3) > 0) {
                    cap_upper_v3(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_sqrt_price_x64(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_zero_for_one(v3))
                } else {
                    let v5 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v3) == 2) {
                        if (!0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v3))) {
                            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookSegment_price(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v3), 0)) > 0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v5) {
                        cap_upper_orderbook(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_base_to_quote(v3), 0, false, 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v3))
                    } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v3) == 3 && !0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v3))) {
                        let v6 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v3), 0);
                        let v7 = if (!*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_LinearSegment_exact_dlmm(v6)) {
                            true
                        } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_LinearSegment_price_x64(v6) == 0) {
                            true
                        } else {
                            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_LinearSegment_fee_rate(v6) >= 9223372036854775808
                        };
                        if (v7) {
                            return 0
                        };
                        if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_LinearSegment_forward(v6)) {
                            (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_LinearSegment_price_x64(v6) as u256)
                        } else {
                            div_ceil(q64() * q64(), (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_LinearSegment_price_x64(v6) as u256))
                        }
                    } else {
                        return 0
                    }
                };
                v1 = mul_ratio_up_saturating(v1, v4, q64());
            };
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            return 0
        };
        to_u128(0x1::u256::min(q64() * q64() / v1, (340282366920938463463374607431768211455 as u256)))
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

    public fun adaptive_request(arg0: &mut AdaptiveSearch, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64) : (u64, u64, bool) {
        if (arg0.blocked != arg1) {
            return (0, 0, false)
        };
        let v0 = if (arg0.schedule.tolerance_bps > 0) {
            if (arg0.declines > 0) {
                if (0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
                    arg0.selector.bolt || arg0.phase == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return (0, 0, false)
        };
        let v1 = arg0.readers.max_batch_effective > 0;
        let v2 = if (v1) {
            l2(arg0, arg1)
        } else {
            0
        };
        let v3 = arg4 - 0x1::u64::min(*0x1::vector::borrow<u64>(&arg0.readers.hop_effective, arg1), arg4);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            &0x1::vector::borrow<OptimizeState>(&arg0.mk, 0).route
        } else {
            &arg0.route
        };
        if (v2 > v3) {
            while (v6 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v7)) {
                let v8 = if (v6 != arg1) {
                    if (!*0x1::vector::borrow<bool>(&arg0.readers.terminals, v6)) {
                        if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v7, v6)) == 3) {
                            true
                        } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v7, v6)) == 2) {
                            true
                        } else {
                            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v7, v6)) == 1
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v8) {
                    v4 = v4 + arg2;
                    v5 = v5 + arg3;
                };
                v6 = v6 + 1;
            };
        };
        let v9 = arg0.readers.max_effective - arg0.readers.effective;
        let v10 = if (v2 > v3) {
            v9 - 0x1::u64::min(v4, v9 - 0x1::u64::min(v9, arg2))
        } else {
            v3
        };
        let v11 = 0x1::u64::min(v9, v10);
        let v12 = arg0.readers.max_physical - arg0.readers.physical;
        let v13 = 0x1::u64::min(v12 - 0x1::u64::min(v5, v12 - 0x1::u64::min(v12, arg3)), arg5 - 0x1::u64::min(*0x1::vector::borrow<u64>(&arg0.readers.hop_physical, arg1), arg5));
        let v14 = if (v1) {
            let v15 = if (v11 % arg7 > 0) {
                1
            } else {
                0
            };
            0x1::u64::min(0x1::u64::max(v11 / arg7 + v15, arg2), arg0.readers.max_batch_effective)
        } else {
            arg2
        };
        let v16 = if (v1) {
            let v17 = if (v13 % arg7 > 0) {
                1
            } else {
                0
            };
            0x1::u64::min(0x1::u64::max(v13 / arg7 + v17, arg3), arg0.readers.max_batch_physical)
        } else {
            arg3
        };
        let (v18, v19) = if (v1) {
            if (v2 > 0) {
                let v20 = 0x1::u64::min(0x1::u64::max(v2, arg2), v14);
                let v21 = *0x1::vector::borrow<u64>(&arg0.readers.hop_effective, arg1);
                let v22 = if (v21 > 0) {
                    (0x1::u256::min(div_ceil((v20 as u256) * (*0x1::vector::borrow<u64>(&arg0.readers.hop_physical, arg1) as u256), (v21 as u256)), (18446744073709551615 as u256)) as u64)
                } else {
                    arg3
                };
                (v20, 0x1::u64::min(0x1::u64::max(v22, arg3), v16))
            } else {
                (v14, v16)
            }
        } else {
            (v14, v16)
        };
        let v23 = 0x1::u64::min(v18, v11);
        let v24 = 0x1::u64::min(v19, v13);
        let v25 = if (!*0x1::vector::borrow<bool>(&arg0.readers.terminals, arg1)) {
            if (v23 > 0) {
                if (v24 > 0 || arg6) {
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
        (v23, v24, v25)
    }

    public fun adaptive_result(arg0: AdaptiveSearch) : OptimizeResult {
        l9(arg0, 0, false)
    }

    public fun adaptive_result_with_profit_floor(arg0: AdaptiveSearch, arg1: u128) : OptimizeResult {
        l9(arg0, arg1, true)
    }

    public fun adaptive_run(arg0: &mut AdaptiveSearch) {
        if (arg0.blocked != 18446744073709551615) {
            return
        };
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            let v0 = 0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0);
            b9(v0, arg0.evaluations);
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
            probe_loaded_mk_reversal(arg0);
            return
        };
        if (arg0.blocked != 18446744073709551615 || arg0.phase == 3) {
            return
        };
        if (arg0.selector.bolt) {
            if (!arg0.schedule.initialized) {
                b7(arg0);
            };
            b8(arg0);
            return
        };
        let v3 = if (arg0.selector.has_book) {
            l1(arg0)
        } else {
            false
        };
        if (v3) {
            return
        };
        let v4 = if (arg0.schedule.exploration_limit == 0) {
            if (!arg0.selector.bolt) {
                if (j4(&arg0.route)) {
                    !k1(&arg0.route)
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
            arg0.schedule.exploration_limit = 2;
            arg0.low = arg0.minimum;
            arg0.high = arg0.maximum;
            arg0.marginal.low = e4(&arg0.route);
            arg0.marginal.high = 0;
            arg0.phase = 0;
        };
        if (arg0.schedule.exploration_limit == 2) {
            j9(arg0);
            return
        };
        loop {
            let v5 = if (arg0.phase != 3) {
                if (arg0.work > 0) {
                    arg0.pending || arg0.result.evaluations < arg0.evaluations
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                if (arg0.phase == 0) {
                    if (arg0.selector.has_book && !arg0.pending) {
                        arg0.amount = k3(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, 0), arg0.amount, arg0.minimum, arg0.quantum, &arg0.points);
                    };
                    arg0.upper = arg0.amount;
                    let v6 = arg0.amount;
                    let v7 = k6(arg0, v6);
                    if (arg0.blocked != 18446744073709551615) {
                        return
                    };
                    if (v7.status == 10 && arg0.previous.amount == 0) {
                        let v8 = if (arg0.amount > arg0.maximum / 10) {
                            arg0.maximum
                        } else {
                            arg0.amount * 10
                        };
                        let v9 = aligned_in_range(v8, arg0.minimum, arg0.maximum, arg0.quantum);
                        if (v9 <= arg0.amount) {
                            k8(arg0, v7.status, false);
                            return
                        };
                        arg0.amount = v9;
                        continue
                    };
                    if (v7.amount == 0) {
                        let v10 = if (v7.status == 3) {
                            if (v7.output > 0) {
                                v7.output < v6
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v10) {
                            let v11 = aligned_in_range(v7.output, arg0.minimum, v6, arg0.quantum);
                            let v12 = amount_lower_bound(&arg0.points, v11);
                            if (v12 < 0x1::vector::length<u128>(&arg0.points) && *0x1::vector::borrow<u128>(&arg0.points, v12) == v11) {
                                k8(arg0, 3, false);
                                return
                            };
                            arg0.amount = v11;
                            continue
                        };
                        if (v7.status == 7 && (arg0.best.amount > 0 || k1(&arg0.route))) {
                            arg0.phase = 1;
                            k9(arg0);
                            continue
                        };
                        k8(arg0, v7.status, false);
                        return
                    };
                    if (arg0.best.amount == 0 || progressive_better(&v7, &arg0.best)) {
                        arg0.best = v7;
                    };
                    let v13 = if (arg0.schedule.tolerance_bps > 0) {
                        if (!arg0.selector.has_book) {
                            if (arg0.declines > 0) {
                                if (arg0.previous.negative) {
                                    arg0.best.negative
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
                    if (arg0.schedule.tolerance_bps > 0 && meaningful_growth_decline(&arg0.best, &v7, arg0.schedule.tolerance_bps, arg0.selector.has_book) || arg0.previous.amount > 0 && progressive_better(&arg0.previous, &v7)) {
                        arg0.declines = arg0.declines + 1;
                    } else {
                        arg0.declines = 0;
                    };
                    let v14 = if (arg0.previous.amount == 0) {
                        if (v7.negative) {
                            !arg0.selector.has_book
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    let v15 = if (arg0.schedule.tolerance_bps > 0) {
                        if (v14 || arg0.declines > 0) {
                            has_growth_reversal(&arg0.route)
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v14 && v15) {
                        arg0.declines = 1;
                    };
                    if (v13) {
                        arg0.declines = 2;
                    };
                    let v16 = if (arg0.schedule.tolerance_bps > 0) {
                        if (arg0.previous.amount > 0) {
                            if (!v7.negative) {
                                if (!arg0.previous.negative) {
                                    v7.amount - arg0.previous.amount >= 0x1::u128::max(arg0.previous.amount / 10, 1)
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
                    if (v16) {
                        let v17 = if (v7.magnitude > arg0.previous.magnitude) {
                            v7.magnitude - arg0.previous.magnitude
                        } else {
                            0
                        };
                        let v18 = if (v17 * 10000 <= arg0.previous.magnitude * (0x1::u64::min(arg0.schedule.tolerance_bps, 100) as u256)) {
                            arg0.schedule.small_gains + 1
                        } else {
                            0
                        };
                        arg0.schedule.small_gains = v18;
                    };
                    arg0.schedule.exploration = arg0.schedule.exploration + 1;
                    let v19 = if (arg0.selector.bolt) {
                        let v20 = if (0x1::vector::is_empty<u128>(&arg0.schedule.events)) {
                            5
                        } else {
                            2
                        };
                        0x1::u64::min(arg0.evaluations, v20)
                    } else {
                        arg0.evaluations - 0x1::u64::min(arg0.evaluations / 3, arg0.refinements)
                    };
                    let v21 = if (arg0.amount == arg0.maximum) {
                        true
                    } else if (arg0.result.evaluations >= v19) {
                        true
                    } else if (arg0.schedule.small_gains >= 2) {
                        true
                    } else if (arg0.selector.bolt && arg0.schedule.remote_done) {
                        true
                    } else if (!arg0.selector.bolt) {
                        if (v14 && !v15) {
                            true
                        } else if (arg0.declines > 0) {
                            let v22 = if (arg0.schedule.tolerance_bps > 0) {
                                if (v15) {
                                    2
                                } else {
                                    1
                                }
                            } else if (arg0.selector.has_book) {
                                3
                            } else {
                                1
                            };
                            arg0.declines >= v22
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    arg0.previous = v7;
                    if (!v21) {
                        let v23 = if (arg0.selector.bolt && arg0.schedule.exploration > 1) {
                            8
                        } else {
                            4
                        };
                        let v24 = if (arg0.schedule.exploration_limit > 0 && arg0.schedule.exploration >= arg0.schedule.exploration_limit || arg0.amount > arg0.maximum / v23) {
                            arg0.maximum
                        } else {
                            arg0.amount * v23
                        };
                        let v25 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, 0)) == 2) {
                            a5(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, 0), v24)
                        } else {
                            v24
                        };
                        let v26 = aligned_in_range(v25, arg0.minimum, arg0.maximum, arg0.quantum);
                        if (v26 > arg0.amount) {
                            arg0.amount = v26;
                            continue
                        };
                    };
                    arg0.phase = 1;
                    k9(arg0);
                    continue
                };
                let v27 = if (arg0.high <= arg0.low) {
                    true
                } else if ((arg0.high - arg0.low) / arg0.quantum <= 2) {
                    true
                } else {
                    arg0.refinement >= arg0.refinements
                };
                if (v27) {
                    let v28 = if ((arg0.high - arg0.low) / arg0.quantum <= 2) {
                        let v29 = arg0.schedule.tolerance_bps > 0 && arg0.declines > 0;
                        !v29
                    } else {
                        false
                    };
                    let v30 = if (v28) {
                        0
                    } else {
                        4
                    };
                    k8(arg0, v30, v28);
                    return
                };
                let v31 = (arg0.high - arg0.low) / 3;
                let v32 = if (arg0.phase == 1) {
                    arg0.low + v31
                } else {
                    arg0.high - v31
                };
                let v33 = aligned_in_range(v32, arg0.minimum, arg0.high, arg0.quantum);
                let v34 = k6(arg0, v33);
                if (arg0.blocked != 18446744073709551615) {
                    return
                };
                if (arg0.phase == 1) {
                    arg0.left = v34;
                    arg0.phase = 2;
                    continue
                };
                arg0.refinement = arg0.refinement + 2;
                arg0.phase = 1;
                if (arg0.left.status == 10) {
                    arg0.low = aligned_in_range(arg0.low + v31, arg0.minimum, arg0.high, arg0.quantum);
                    continue
                };
                if (v34.status == 7) {
                    arg0.high = v33;
                    continue
                };
                if (arg0.left.amount > 0 && v34.amount > 0) {
                    if (progressive_better(&arg0.left, &v34)) {
                        arg0.high = v33;
                        continue
                    };
                    arg0.low = aligned_in_range(arg0.low + v31, arg0.minimum, arg0.high, arg0.quantum);
                    continue
                };
                if (v34.status == 10) {
                    arg0.low = v33;
                    continue
                };
                k8(arg0, v34.status, false);
                return
            } else {
                break
            };
        };
        if (arg0.phase != 3) {
            let v35 = if (arg0.work == 0) {
                6
            } else {
                9
            };
            k8(arg0, v35, false);
        };
    }

    public fun adaptive_start_if(arg0: bool, arg1: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg2: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop>, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) : AdaptiveSearch {
        let v0 = if (arg0 && arg4 > 0) {
            join_staged_route(arg1, arg2)
        } else {
            0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>()
        };
        let v1 = k5(v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, true, 1, 1);
        let v2 = &mut v1;
        j2(v2, arg11);
        v1.readers.max_batch_effective = arg12;
        v1.readers.max_batch_physical = arg13;
        v1
    }

    public fun advance_empty_boundaries(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>, arg1: &mut u64, arg2: &mut u128, arg3: &mut u128, arg4: bool) : u64 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::advance_empty_boundaries(arg0, arg1, arg2, arg3, arg4)
    }

    public fun advance_segment_orderbook(arg0: u8, arg1: bool, arg2: u128, arg3: u64, arg4: bool, arg5: u128, arg6: &mut vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>, arg7: u128) : (u128, u128, u64, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::advance_segment_orderbook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun advance_segment_v2(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : (u128, u128, u128) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::advance_segment_v2(arg0, arg1, arg2, arg3, arg4)
    }

    public fun advance_segment_v3(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>, arg1: u64, arg2: u128, arg3: bool, arg4: u128, arg5: bool, arg6: u128) : (u128, u128, u128, u64, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::advance_segment_v3(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun affine_linear(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>) : (bool, u256, u256) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::affine_linear(arg0)
    }

    public fun affine_ratio(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u128, arg6: u128) : (bool, u256, u256) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::affine_ratio(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun affine_steamm_cpmm(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128) : (bool, u256, u256) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::affine_steamm_cpmm(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun affine_steamm_omm(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u128) : (bool, u256, u256) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::affine_steamm_omm(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun affine_virtual_cpmm(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool) : (bool, u256, u256) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::affine_virtual_cpmm(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun aftermath_a20(arg0: u64) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_a20(arg0)
    }

    public fun aftermath_exp(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::aftermath_exp(arg0)
    }

    public fun aftermath_fixed_div_up(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_fixed_div_up(arg0, arg1)
    }

    public fun aftermath_fixed_mul_down(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_fixed_mul_down(arg0, arg1)
    }

    public fun aftermath_fixed_mul_up(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_fixed_mul_up(arg0, arg1)
    }

    public fun aftermath_geometric_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
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
        let v2 = a0(12);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_rate(&mut v2) = arg4;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_denominator(&mut v2) = (1000000000000000000 as u64);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_rate(&mut v2) = arg5;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_denominator(&mut v2) = (1000000000000000000 as u64);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v2) = arg0;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v2) = arg1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v2) = (arg2 as u128) << 64 | (arg3 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v2) = arg6;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v2) = arg7;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_admin_fee(&mut v2) = arg8;
        let v3 = if (v1 == 0) {
            (arg2 as u128) * (1000000000000000000 as u128) / (arg3 as u128)
        } else {
            0
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_liquidity(&mut v2) = v3;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v2) = v1;
        v2
    }

    public fun aftermath_ln(arg0: u256) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::aftermath_ln(arg0)
    }

    public fun aftermath_ln_36(arg0: u256) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::aftermath_ln_36(arg0)
    }

    public fun aftermath_log_exp_pow(arg0: u256, arg1: u256) : (u256, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_log_exp_pow(arg0, arg1)
    }

    public fun aftermath_pow_up(arg0: u256, arg1: u256) : (u256, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_pow_up(arg0, arg1)
    }

    public fun aftermath_signed(arg0: u256, arg1: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::aftermath_signed(arg0, arg1)
    }

    public fun aftermath_signed_add(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned, arg1: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::aftermath_signed_add(arg0, arg1)
    }

    public fun aftermath_signed_div_u(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned, arg1: u256) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::aftermath_signed_div_u(arg0, arg1)
    }

    public fun aftermath_signed_mul_u(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned, arg1: u256) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::aftermath_signed_mul_u(arg0, arg1)
    }

    public fun aftermath_signed_neg(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::aftermath_signed_neg(arg0)
    }

    public fun aftermath_signed_rem_u(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned, arg1: u256) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::AftermathSigned {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::aftermath_signed_rem_u(arg0, arg1)
    }

    public fun aftermath_weights(arg0: u128) : (u64, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_weights(arg0)
    }

    public fun aftermath_x20(arg0: u64) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aftermath_x20(arg0)
    }

    public fun aligned_in_range(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::aligned_in_range(arg0, arg1, arg2, arg3)
    }

    public fun amount0_delta_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::amount0_delta_down(arg0, arg1, arg2)
    }

    public fun amount0_delta_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::amount0_delta_up(arg0, arg1, arg2)
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

    public fun apply_boundary_liquidity(arg0: &mut u128, arg1: bool, arg2: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::apply_boundary_liquidity(arg0, arg1, arg2);
    }

    public fun auxiliary_fee_estimate(arg0: &OptimizeResult) : u128 {
        if (arg0.found) {
            arg0.amount_out - arg0.amount_in - arg0.gross_profit
        } else {
            0
        }
    }

    fun b0(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::b0(arg0)
    }

    fun b1(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : (vector<BoltFixedHop>, u8) {
        let v0 = 0x1::vector::empty<BoltFixedHop>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0)) {
            let v2 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0, v1);
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_state_status(v2) != 0) {
                return (0x1::vector::empty<BoltFixedHop>(), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_state_status(v2))
            };
            let v3 = BoltFixedHop{
                is_bolt         : *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v2) == 18,
                bolt            : *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_bolt(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v2)),
                input_capacity  : *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v2)),
                input_minimum   : *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_input_minimum(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v2)),
                output_capacity : *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_output_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v2)),
                cpmm            : prepare_cpmm(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_in(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_out(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_output_fee_rate(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_output_fee_denominator(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_fractional_input_fee(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v2))),
            };
            0x1::vector::push_back<BoltFixedHop>(&mut v0, v3);
            v1 = v1 + 1;
        };
        (v0, 0)
    }

    fun b2(arg0: &vector<BoltFixedHop>, arg1: u128, arg2: &mut u64) : (u128, u8) {
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
                    return (0, a6(v6))
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

    fun b3(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: &mut u64) : (vector<u128>, u128) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::b3(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun b4(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : u8 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::b4(arg0)
    }

    fun b5(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: bool) : u128 {
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

    fun b6(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64) : (OptimizeResult, vector<u128>) {
        let v0 = b4(&arg0);
        if (v0 != 0) {
            let v1 = empty_result();
            v1.complete = false;
            v1.status = v0;
            return (v1, vector[])
        };
        let v2 = 0x1::u128::min(arg3, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0))));
        if (arg2 > v2) {
            return (empty_result(), vector[])
        };
        let v3 = aligned_in_range(arg2, arg2, v2, arg4);
        if (v3 == 0) {
            return (empty_result(), vector[])
        };
        let v4 = v2 - v2 % arg4;
        if (b0(&arg0) && (v4 - v3) / arg4 + 1 <= (arg6 as u128)) {
            let (v5, v6) = b1(&arg0);
            let v7 = v5;
            if (v6 != 0) {
                let v8 = empty_result();
                v8.complete = false;
                v8.status = v6;
                return (v8, vector[])
            };
            return i8(&v7, v3, v4, arg4, arg7)
        };
        let v9 = if (0x1::vector::is_empty<u128>(&arg1)) {
            v3
        } else {
            *0x1::vector::borrow<u128>(&arg1, 0)
        };
        let v10 = k5(arg0, v9, v4, 1, arg5, arg6, arg7, 0, 0, false, v3, arg4);
        if (v10.schedule.count > (arg6 as u128)) {
            let v11 = &mut v10.work;
            let (v12, v13) = b3(&v10.route, arg1, v3, v4, arg4, arg5, arg6, v11);
            v10.schedule.points = v12;
            v10.upper = v13;
        };
        let v14 = &mut v10;
        adaptive_run(v14);
        (v10.result, v10.points)
    }

    fun b7(arg0: &mut AdaptiveSearch) {
        arg0.schedule.initialized = true;
        arg0.minimum = aligned_in_range(arg0.minimum, arg0.minimum, arg0.maximum, arg0.quantum);
        arg0.maximum = arg0.maximum - arg0.maximum % arg0.quantum;
        if (arg0.minimum == 0 || arg0.maximum < arg0.minimum) {
            arg0.phase = 3;
            return
        };
        if (b0(&arg0.route)) {
            let (v0, v1) = b1(&arg0.route);
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
            b3(&arg0.route, v4, arg0.minimum, arg0.maximum, arg0.quantum, arg0.refinements, arg0.evaluations, v5)
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

    fun b8(arg0: &mut AdaptiveSearch) {
        while ((arg0.pending || arg0.result.evaluations < arg0.evaluations) && arg0.work > 0) {
            let v0 = if (arg0.declines > 0) {
                if (!arg0.schedule.outward) {
                    arg0.schedule.remote_done || arg0.schedule.remote_left == 0
                } else {
                    false
                }
            } else {
                false
            };
            let v1 = if (!arg0.pending) {
                if (v0) {
                    if (!arg0.result.found) {
                        arg0.refinement >= 0x1::u64::min(arg0.refinements, 2)
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
                break
            };
            let v2 = if (arg0.result.found) {
                amount_lower_bound(&arg0.points, arg0.result.amount_in)
            } else {
                0
            };
            let v3 = 18446744073709551615;
            let v4 = if (arg0.result.found) {
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
            if (v4) {
                let v5 = if (v2 > 0) {
                    *0x1::vector::borrow<u128>(&arg0.points, v2 - 1)
                } else {
                    arg0.minimum
                };
                let v6 = if (v2 + 1 < 0x1::vector::length<u128>(&arg0.points)) {
                    *0x1::vector::borrow<u128>(&arg0.points, v2 + 1)
                } else {
                    arg0.upper
                };
                if (v6 - v5 <= 0x1::u128::max(arg0.result.amount_in / 100, arg0.quantum * 2)) {
                    arg0.schedule.converged = true;
                    break
                };
            };
            let v7 = if (arg0.pending) {
                arg0.amount
            } else if (arg0.schedule.point_index < 0x1::vector::length<u128>(&arg0.schedule.points)) {
                arg0.schedule.point_index = arg0.schedule.point_index + 1;
                aligned_in_range(*0x1::vector::borrow<u128>(&arg0.schedule.points, arg0.schedule.point_index), arg0.minimum, arg0.maximum, arg0.quantum)
            } else {
                let v8 = if (arg0.schedule.count > (arg0.evaluations as u128)) {
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
                if (v8) {
                    arg0.upper = b5(arg0.upper, arg0.minimum, arg0.maximum, arg0.quantum, arg0.result.evaluations == 1);
                    arg0.upper
                } else if (!arg0.schedule.remote_done && arg0.schedule.remote_left > 0) {
                    let v9 = 0;
                    if (arg0.schedule.mapped) {
                        while (arg0.schedule.boundary_index < 0x1::vector::length<u128>(&arg0.schedule.boundaries) && *0x1::vector::borrow<u128>(&arg0.schedule.boundaries, arg0.schedule.boundary_index) <= arg0.upper) {
                            arg0.schedule.boundary_index = arg0.schedule.boundary_index + 1;
                        };
                        if (arg0.schedule.boundary_index < 0x1::vector::length<u128>(&arg0.schedule.boundaries)) {
                            v9 = *0x1::vector::borrow<u128>(&arg0.schedule.boundaries, arg0.schedule.boundary_index);
                        };
                    } else if (arg0.upper < arg0.maximum) {
                        let v10 = if (arg0.upper > arg0.maximum / 10) {
                            arg0.maximum
                        } else {
                            arg0.upper * 10
                        };
                        v9 = aligned_in_range(v10, arg0.minimum, arg0.maximum, arg0.quantum);
                    };
                    arg0.schedule.remote_left = arg0.schedule.remote_left - 1;
                    if (v9 == 0) {
                        arg0.schedule.remote_done = true;
                        continue
                    };
                    if (arg0.schedule.mapped) {
                        let v11 = if (arg0.schedule.boundary_index + 1 < 0x1::vector::length<u128>(&arg0.schedule.boundaries)) {
                            *0x1::vector::borrow<u128>(&arg0.schedule.boundaries, arg0.schedule.boundary_index + 1)
                        } else {
                            0
                        };
                        arg0.schedule.boundary_index = arg0.schedule.boundary_index + 1;
                        let v12 = if (v11 > v9) {
                            (v11 - v9) / 4 * 3
                        } else {
                            0x1::u128::min(0x1::u128::max(v9 / 10, arg0.quantum), arg0.maximum - v9)
                        };
                        let v13 = v9 + v12;
                        v9 = aligned_in_range(v13, arg0.minimum, arg0.maximum, arg0.quantum);
                    };
                    arg0.upper = 0x1::u128::max(arg0.upper, v9);
                    arg0.schedule.outward = false;
                    v9
                } else {
                    let v14 = if (!arg0.schedule.local_refined) {
                        if (arg0.result.found) {
                            if (v2 > 0) {
                                (arg0.result.amount_in - *0x1::vector::borrow<u128>(&arg0.points, v2 - 1)) / arg0.quantum > 1
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v14) {
                        arg0.schedule.local_refined = true;
                        aligned_in_range(midpoint(*0x1::vector::borrow<u128>(&arg0.points, v2 - 1), arg0.result.amount_in), arg0.minimum, arg0.upper, arg0.quantum)
                    } else {
                        let v15 = 0;
                        while (!0x1::vector::is_empty<u128>(&arg0.schedule.events) && v15 == 0) {
                            let v16 = 0x1::vector::pop_back<u128>(&mut arg0.schedule.events);
                            if (v16 <= arg0.upper && !contains_amount(&arg0.points, v16)) {
                                v15 = v16;
                            };
                        };
                        if (v15 > 0) {
                            v15
                        } else {
                            if (!arg0.result.found && arg0.schedule.exploration == 0) {
                                let v17 = vector[];
                                let v18 = 0;
                                while (v18 < 0x1::vector::length<ProgressiveSample>(&arg0.samples)) {
                                    let v19 = 0x1::vector::borrow<ProgressiveSample>(&arg0.samples, v18);
                                    let v20 = if (v19.status == 0 && v19.negative) {
                                        v19.magnitude
                                    } else {
                                        115792089237316195423570985008687907853269984665640564039457584007913129639935
                                    };
                                    0x1::vector::push_back<u256>(&mut v17, v20);
                                    v18 = v18 + 1;
                                };
                                arg0.schedule.exploration = 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::nv(&arg0.points, &v17, arg0.upper);
                            };
                            let v21 = if (!arg0.result.found) {
                                if (arg0.schedule.exploration != 18446744073709551615) {
                                    (arg0.schedule.exploration as u128) < arg0.upper
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            let (v22, v23) = if (arg0.result.found) {
                                0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::bs(arg0.result.amount_in, v2, &arg0.points, arg0.minimum, arg0.upper, arg0.quantum)
                            } else {
                                let v24 = if (v21) {
                                    (arg0.schedule.exploration as u128)
                                } else {
                                    arg0.result.amount_in
                                };
                                let v25 = if (v21) {
                                    arg0.result.evaluations
                                } else {
                                    0
                                };
                                0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::bq(v21, v24, &arg0.points, arg0.minimum, arg0.upper, arg0.quantum, v25)
                            };
                            v3 = v23;
                            v22
                        }
                    }
                }
            };
            if (v7 == 0 || (0x1::vector::length<u128>(&arg0.points) as u128) >= arg0.schedule.count) {
                break
            };
            let v26 = if (v3 == 18446744073709551615) {
                amount_lower_bound(&arg0.points, v7)
            } else {
                v3
            };
            let v27 = if (!arg0.pending) {
                if (v26 < 0x1::vector::length<u128>(&arg0.points)) {
                    *0x1::vector::borrow<u128>(&arg0.points, v26) == v7
                } else {
                    false
                }
            } else {
                false
            };
            if (v27) {
                if (arg0.schedule.point_index >= 0x1::vector::length<u128>(&arg0.schedule.points)) {
                    break
                } else {
                    continue
                };
            };
            arg0.amount = v7;
            if (v0 && !arg0.pending) {
                arg0.refinement = arg0.refinement + 1;
            };
            let v28 = k7(arg0, v7, v26);
            let v29 = v28.status;
            if (arg0.blocked != 18446744073709551615) {
                let v30 = if (arg0.schedule.tolerance_bps == 0) {
                    true
                } else if (arg0.declines == 0) {
                    true
                } else {
                    v0
                };
                if (v30) {
                    return
                };
                arg0.pending = false;
                arg0.blocked = 18446744073709551615;
                arg0.result.needs_more_hop = 18446744073709551615;
            };
            let v31 = if (arg0.schedule.tolerance_bps > 0) {
                if (arg0.schedule.count > (arg0.evaluations as u128)) {
                    if (arg0.schedule.outward) {
                        if (v29 == 0) {
                            v7 > arg0.previous.amount
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
            if (v31) {
                if (meaningful_growth_decline(&arg0.best, &v28, arg0.schedule.tolerance_bps, arg0.selector.has_book)) {
                    arg0.declines = 1;
                    arg0.schedule.outward = false;
                    arg0.schedule.remote_left = 0x1::u64::min(arg0.schedule.remote_left, 1);
                    arg0.schedule.point_index = 0x1::vector::length<u128>(&arg0.schedule.points);
                };
                if (arg0.best.amount == 0 || progressive_better(&v28, &arg0.best)) {
                    arg0.best = v28;
                };
                arg0.previous = v28;
            };
            if (v29 == 0) {
                arg0.schedule.valid_seen = true;
            };
            let v32 = if (v29 == 10) {
                if (!arg0.schedule.valid_seen) {
                    arg0.schedule.outward
                } else {
                    false
                }
            } else {
                false
            };
            if (v32) {
                let v33 = if (v7 > arg0.maximum / 10) {
                    arg0.maximum
                } else {
                    v7 * 10
                };
                let v34 = aligned_in_range(v33, arg0.minimum, arg0.maximum, arg0.quantum);
                if (v34 > v7 && !contains_amount(&arg0.points, v34)) {
                    0x1::vector::push_back<u128>(&mut arg0.schedule.points, v34);
                    arg0.upper = 0x1::u128::max(arg0.upper, v34);
                } else {
                    arg0.result.status = 10;
                    break
                };
            };
            if (v29 == 10 && arg0.schedule.valid_seen) {
                arg0.schedule.outward = false;
                arg0.schedule.remote_done = true;
                arg0.upper = v7;
            };
            let v35 = if (v29 == 2) {
                true
            } else if (v29 == 6) {
                true
            } else {
                v29 == 11
            };
            if (v35) {
                arg0.result.status = v29;
                break
            };
            if (v29 == 3 || v29 == 7) {
                arg0.result.status = v29;
                if (!arg0.schedule.valid_seen) {
                    arg0.result.complete = false;
                    arg0.phase = 3;
                    return
                };
                arg0.schedule.remote_done = true;
                arg0.schedule.outward = false;
                arg0.upper = v7;
            };
            let v36 = if (v29 == 7) {
                true
            } else if (v29 == 12) {
                true
            } else {
                v29 == 5 && arg0.result.found
            };
            if (v36) {
                arg0.schedule.outward = false;
            };
            if (v29 == 5) {
                arg0.result.status = 1;
            };
        };
        let v37 = arg0.schedule.converged && arg0.declines == 0 || (0x1::vector::length<u128>(&arg0.points) as u128) == arg0.schedule.count;
        arg0.result.complete = v37;
        if (arg0.schedule.valid_seen && arg0.result.status == 10) {
            let v38 = if (arg0.result.found) {
                0
            } else {
                1
            };
            arg0.result.status = v38;
        };
        if (!arg0.result.complete && (arg0.result.status == 0 || arg0.result.status == 1)) {
            let v39 = if (arg0.work == 0) {
                6
            } else if (arg0.result.evaluations >= arg0.evaluations) {
                9
            } else {
                4
            };
            arg0.result.status = v39;
        };
        arg0.phase = 3;
    }

    fun b9(arg0: &mut OptimizeState, arg1: u64) {
        if (arg0.finished) {
            return
        };
        arg0.result.complete = true;
        arg0.result.needs_more_hop = 18446744073709551615;
        let v0 = arg0.auxiliary_cost;
        let v1 = arg0.bounded_domain;
        while (arg0.cursor < arg0.max_amount_in && arg0.result.segments < arg0.max_segments) {
            if ((arg0.has_book || arg0.has_linear) && c9(&arg0.route)) {
                arg0.finished = true;
                return
            };
            let v2 = 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route) * (2 * 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route) + 4);
            if (arg0.work != (18446744073709551615 as u64)) {
                if (arg0.work <= v2 + 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route) * 4) {
                    arg0.finished = true;
                    arg0.result.complete = false;
                    arg0.result.status = 6;
                    return
                };
                arg0.work = arg0.work - v2;
            };
            let v3 = if (arg0.has_book) {
                c6(&arg0.route)
            } else {
                18446744073709551615
            };
            if (v3 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v3;
                return
            };
            let v4 = if (arg0.has_linear) {
                c7(&arg0.route)
            } else {
                18446744073709551615
            };
            if (v4 != 18446744073709551615) {
                arg0.result.complete = false;
                arg0.result.needs_more_hop = v4;
                return
            };
            if (arg0.has_book && !d1(&arg0.route)) {
                arg0.finished = true;
                return
            };
            let v5 = c5(&arg0.route);
            if (v5 != 18446744073709551615) {
                while (v5 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
                    if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v5)) == 1 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_liquidity(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v5)) == 0) {
                        arg0.result.complete = false;
                        arg0.result.needs_more_hop = v5;
                        return
                    };
                    v5 = v5 + 1;
                };
            };
            let v6 = if (!arg0.has_book) {
                true
            } else {
                d0(&arg0.route)
            };
            let v7 = arg0.max_amount_in - arg0.cursor;
            let v8 = arg0.work != (18446744073709551615 as u64);
            let (v9, v10, v11) = if (v8 && v5 == 18446744073709551615) {
                let (v12, v13, v14, v15) = f7(&arg0.route, v7);
                let _ = v13;
                (v12, v14, v15)
            } else {
                let (v17, v18) = e5(&arg0.route);
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
                let (v21, _) = f4(&arg0.route, v7);
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
                while (v27 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
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
                    let v30 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v27);
                    if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v30) == 3) {
                        let v31 = effective_input(v26, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(v30), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v30));
                        let v32 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v30);
                        let v33 = &mut arg0.work;
                        let (v34, v35, _, v37) = quote_linear_hop_bounded_impl(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_cursor(v30), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_has_more(v30), v32, v31, v33);
                        if (v35 == 3) {
                            let v38 = if (true) {
                                if (arg0.has_book) {
                                    if (v37 > 0) {
                                        v31 >= v37
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            if (v38) {
                                i0(arg0, v27, gross_from_effective(v31 - v37, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(v30), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v30)), v23, arg1);
                            };
                            arg0.result.complete = false;
                            arg0.result.needs_more_hop = v27;
                            return
                        };
                        if (v35 == 7) {
                            let (v39, v40) = f6(&arg0.route, v27, gross_from_effective(v31 - v37, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(v30), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v30)));
                            let v41 = if (v40) {
                                0x1::u128::min(0x1::u128::min(v23, v39), v23 - 1)
                            } else {
                                v23 / 2
                            };
                            v23 = v41;
                            v25 = true;
                            v28 = v28 + 1;
                            if (v41 == 0 || v28 > 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route) + 1) {
                                arg0.finished = true;
                                return
                            };
                            v26 = v41;
                            v27 = 0;
                            continue
                        };
                        if (v35 != 0) {
                            arg0.result.complete = false;
                            arg0.result.status = v35;
                            arg0.finished = true;
                            return
                        };
                        v26 = m6(v30, v34);
                    } else {
                        v26 = g2(v30, v26, false);
                    };
                    v27 = v27 + 1;
                };
                v24 = v26;
            };
            arg0.result.segments = arg0.result.segments + 1;
            let v42 = q64() + v11 * (v23 as u256);
            if (v19 * q64() <= v42 * v42) {
                let v43 = if (v1) {
                    f3(&arg0.route, coefficient_root(v19, v11, v23), v23)
                } else {
                    coefficient_root(v19, v11, v23)
                };
                let (v44, v45) = if (v1 && !arg0.capacity_slack) {
                    f2(&arg0.route, v43)
                } else {
                    (v43, false)
                };
                if (v8) {
                    let v46 = 0x1::u128::min(0x1::u128::max(v44, 1), v23);
                    let v47 = &mut arg0.result;
                    g9(&arg0.route, v46, arg0.cursor + v46, arg0.cursor_output + g1(&arg0.route, v46), v47);
                    let v48 = &mut arg0.result;
                    g7(&arg0.route, arg0.cursor, arg0.cursor_output, v46, v23, v48);
                } else {
                    let v49 = &mut arg0.result;
                    g6(&arg0.route, arg0.cursor, arg0.cursor_output, v44, v23, v49);
                };
                if (v45 || (arg0.monotone || arg0.approximate_stop) && (v6 || d2(&arg0.route, v23))) {
                    if (!arg0.monotone) {
                        arg0.result.complete = false;
                    };
                    arg0.finished = true;
                    return
                };
            };
            if (v1 && !arg0.capacity_slack) {
                let (v50, v51) = f2(&arg0.route, v23);
                if (v51) {
                    if (v50 > 0) {
                        let v52 = &mut arg0.result;
                        g6(&arg0.route, arg0.cursor, arg0.cursor_output, v50, v50, v52);
                    };
                    arg0.finished = true;
                    return
                };
            };
            if (v23 == v7 || v25) {
                let v53 = if (arg0.has_linear) {
                    v24
                } else {
                    g1(&arg0.route, v23)
                };
                let v54 = &mut arg0.result;
                g9(&arg0.route, v23, arg0.cursor + v23, arg0.cursor_output + v53, v54);
                if (arg0.cursor == 0) {
                    let v55 = &mut arg0.result;
                    h3(&arg0.route, v23, v53, v55);
                };
                arg0.finished = true;
                return
            };
            let v56 = &mut arg0.route;
            let (v57, v58, v59) = g3(v56, v23);
            arg0.cursor = arg0.cursor + v23;
            arg0.cursor_output = arg0.cursor_output + v57;
            arg0.result.crossed_ticks = arg0.result.crossed_ticks + v58;
            arg0.result.crossed_orders = arg0.result.crossed_orders + v59;
            if (v8) {
                if (!arg0.has_book || d0(&arg0.route)) {
                    let v60 = if (v0 == q64()) {
                        0
                    } else {
                        mul_ratio_down_saturating((arg0.cursor as u256), v0 - q64(), q64())
                    };
                    let v61 = &mut arg0.result;
                    record_candidate_with_fee(arg0.cursor, arg0.cursor_output, v60, v61);
                };
            } else {
                let v62 = &mut arg0.result;
                g9(&arg0.route, 0, arg0.cursor, arg0.cursor_output, v62);
            };
            if (arg0.tolerance_bps > 0 && arg0.result.found) {
                if (arg0.gain_profit == 0) {
                    arg0.gain_cursor = arg0.cursor;
                    arg0.gain_profit = arg0.result.gross_profit;
                    continue
                };
                if (arg0.cursor - arg0.gain_cursor >= 0x1::u128::max(arg0.gain_cursor / 10, 1)) {
                    let v63 = if (((arg0.result.gross_profit - arg0.gain_profit) as u256) * 10000 <= (arg0.gain_profit as u256) * (0x1::u64::min(arg0.tolerance_bps, 100) as u256)) {
                        arg0.small_gains + 1
                    } else {
                        0
                    };
                    arg0.small_gains = v63;
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

    public fun bolt_hop(arg0: vector<u128>) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = 0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::decode(arg0);
        let v1 = lst_ratio_hop(1, 1, 0, 0, false, true);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_kind(&mut v1) = 18;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v1)) = 18446744073709551615;
        let v2 = if (0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::ready(&v0)) {
            0
        } else {
            2
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v1) = v2;
        0x1::vector::push_back<0xa4ad7bb6bacc55d474caae079195c6201627d73f0fcdf4cd08a8d032c4cc6a5b::curve::State>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_bolt(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v1)), v0);
        v1
    }

    public fun bucket_psm_hop(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
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
        let v4 = a0(13);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_rate(&mut v4) = arg2;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_denominator(&mut v4) = 1000000000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v4) = (arg3 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v4) = arg0 >= arg1;
        let v5 = if (arg0 >= arg1) {
            v1
        } else {
            1
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v4) = v5;
        let v6 = if (arg0 >= arg1) {
            1
        } else {
            v1
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v4) = v6;
        let v7 = if (!v0) {
            5
        } else if (!arg5) {
            2
        } else {
            0
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v4) = v7;
        v4
    }

    fun c0(arg0: &OptimizeState, arg1: u64, arg2: u64, arg3: bool) : OptimizeResult {
        if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.validation_route) || !arg0.result.found) {
            return m5(arg0)
        };
        let v0 = &arg0.validation_route;
        let (v1, v2, v3) = d3(v0, arg1);
        let v4 = v1;
        let v5 = m5(arg0);
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
            while (v7 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&v4)) {
                if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, v7)) == 1) {
                    *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_V3PrefixCache_reject_empty_endpoint(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&mut v4, v7)) = true;
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
            let (v14, v15, _, _) = d5(v0, v12, v9, v13);
            let v18 = v11 + 1;
            v11 = v18;
            v5.evaluations = v5.evaluations + 1;
            if (v15 == 0) {
                let v19 = &mut v5;
                h2(v0, v9, v14, v19);
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

    fun c5(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : u64 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::c5(arg0)
    }

    fun c6(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : u64 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::c6(arg0)
    }

    fun c7(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : u64 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::c7(arg0)
    }

    fun c9(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::c9(arg0)
    }

    public fun cap_curvature_linear() : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_curvature_linear()
    }

    public fun cap_curvature_orderbook() : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_curvature_orderbook()
    }

    public fun cap_curvature_v2(arg0: u128, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_curvature_v2(arg0, arg1)
    }

    public fun cap_curvature_v3(arg0: u128, arg1: u128, arg2: bool, arg3: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_curvature_v3(arg0, arg1, arg2, arg3)
    }

    public fun cap_inverse_linear(arg0: u64, arg1: u64, arg2: u64, arg3: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>, arg4: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_inverse_linear(arg0, arg1, arg2, arg3, arg4)
    }

    public fun cap_inverse_orderbook(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u128, arg5: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>, arg6: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_inverse_orderbook(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_inverse_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_inverse_v2(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_inverse_v3(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary, arg6: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_inverse_v3(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_marginal_aftermath_geometric(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: u128, arg5: u128) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_marginal_aftermath_geometric(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun cap_marginal_bucket_psm(arg0: u128, arg1: u128, arg2: bool) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_marginal_bucket_psm(arg0, arg1, arg2)
    }

    public fun cap_marginal_linear(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_marginal_linear(arg0, arg1, arg2, arg3)
    }

    public fun cap_marginal_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_marginal_orderbook(arg0, arg1, arg2, arg3, arg4)
    }

    public fun cap_marginal_v2(arg0: u128, arg1: u128) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_marginal_v2(arg0, arg1)
    }

    public fun cap_marginal_v3(arg0: u128, arg1: bool) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_marginal_v3(arg0, arg1)
    }

    public fun cap_segment_quote_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>, arg6: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_segment_quote_orderbook(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_segment_quote_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_segment_quote_v2(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun cap_segment_quote_v3(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary, arg5: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_segment_quote_v3(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun cap_upper_bucket_psm(arg0: u128, arg1: u128, arg2: bool) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_upper_bucket_psm(arg0, arg1, arg2)
    }

    public fun cap_upper_linear(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_upper_linear(arg0, arg1, arg2, arg3)
    }

    public fun cap_upper_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_upper_orderbook(arg0, arg1, arg2, arg3, arg4)
    }

    public fun cap_upper_v2(arg0: u128, arg1: u128) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_upper_v2(arg0, arg1)
    }

    public fun cap_upper_v3(arg0: u128, arg1: bool) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::cap_upper_v3(arg0, arg1)
    }

    public fun capped_ratio_hop(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = lst_ratio_hop(1, 1, 0, 0, !arg3, true);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_kind(&mut v0) = 17;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v0) = arg1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v0) = arg0;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v0) = (arg2 as u128);
        let v1 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v1) {
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v0) = 2;
        };
        v0
    }

    public fun clmm_input_boundary(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::clmm_input_boundary(arg0, arg1, arg2, arg3, arg4, arg5)
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
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::coefficient_root(arg0, arg1, arg2)
    }

    public fun coefficient_state(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u64) : OptimizeState {
        assert!(0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0) > 0, 5);
        assert!(arg1 > 0 && arg2 > 0, 6);
        let v0 = e8(&arg0);
        let v1 = if (v0 || j3(&arg0)) {
            arg0
        } else {
            0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>()
        };
        let v2 = v1;
        let v3 = route_model(&arg0) == 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
            let v5 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v4)) == 3) {
                if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_has_more(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v4))) {
                    0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v4))) || *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_LinearSegment_exact_dlmm(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v4)), 0))
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                v3 = false;
            };
            v4 = v4 + 1;
        };
        let v6 = 0;
        let v7 = false;
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v8)) == 3 && 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v8))) > 1) {
                if (!v7) {
                    v6 = h7(&arg0);
                    v7 = true;
                };
                let v9 = if (true) {
                    h9(&v2, v8)
                } else {
                    0
                };
                *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_segments(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut arg0, v8)) = i2(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v8)), v6, v9);
            };
            v8 = v8 + 1;
        };
        let v10 = false;
        let v11 = false;
        let v12 = false;
        let v13 = 0;
        let v14 = 0;
        while (v14 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v14)) == 1 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_stable_amp(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v14)) > 0) {
                v10 = true;
            };
            let v15 = v11 || *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v14)) == 2;
            v11 = v15;
            let v16 = v12 || *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v14)) == 3;
            v12 = v16;
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v14)) == 3) {
                v13 = v14 + 1;
            };
            v14 = v14 + 1;
        };
        OptimizeState{
            route                : arg0,
            validation_route     : v2,
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
            monotone             : v3,
            approximate_stop     : false,
            auxiliary_cost       : h1(&arg0),
            bounded_domain       : v0,
            capacity_slack       : f0(&arg0, arg1),
            has_frontier         : v10,
            has_book             : v11,
            has_linear           : v12,
            linear_prefix_length : v13,
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

    public fun current_linear_segment(arg0: u64, arg1: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>) : &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::current_linear_segment(arg0, arg1)
    }

    public fun current_orderbook_segment(arg0: u64, arg1: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>) : &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::current_orderbook_segment(arg0, arg1)
    }

    fun d0(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::d0(arg0)
    }

    fun d1(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::d1(arg0)
    }

    fun d2(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::d2(arg0, arg1)
    }

    fun d3(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u64) : (vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::d3(arg0, arg1)
    }

    fun d5(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: &mut vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>, arg2: u128, arg3: &mut u64) : (u128, u8, u64, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::d5(arg0, arg1, arg2, arg3)
    }

    public fun div_ceil(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::div_ceil(arg0, arg1)
    }

    public fun div_up_u256(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::div_up_u256(arg0, arg1)
    }

    public fun dlmm_hop_from_bins_with_model(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool, arg6: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0)) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(&mut v0, dlmm_segment(*0x1::vector::borrow<u128>(&arg0, v1), *0x1::vector::borrow<u128>(&arg1, v1), *0x1::vector::borrow<u128>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1), arg4));
            v1 = v1 + 1;
        };
        a3(v0, arg5, arg6)
    }

    public fun dlmm_segment(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::dlmm_segment(arg0, arg1, arg2, arg3, arg4)
    }

    public fun dlmm_stage_from_bins_with_model_if(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool, arg6: bool, arg7: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop {
        if (!arg7) {
            return reuse_current_stage()
        };
        replacement_stage(dlmm_hop_from_bins_with_model(arg0, arg1, arg2, arg3, arg4, arg5, arg6))
    }

    fun e0(arg0: bool, arg1: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg2: &mut vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>, arg3: u128, arg4: u64, arg5: &mut u64, arg6: &mut vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>, arg7: bool) : (u128, u8, u64, u64, u64, u128) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::e0(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun e2(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : (vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::e2(arg0)
    }

    fun e4(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::e4(arg0)
    }

    fun e5(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : (u256, u256) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::e5(arg0)
    }

    fun e6(arg0: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::e6(arg0)
    }

    fun e8(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::e8(arg0)
    }

    public fun effective_input(arg0: u128, arg1: u64, arg2: u64) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::effective_input(arg0, arg1, arg2)
    }

    public fun effective_output(arg0: u128, arg1: u64, arg2: u64) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::effective_output(arg0, arg1, arg2)
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

    public fun extend_v3_prefix_cache(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>, arg1: &mut 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache, arg2: u128, arg3: u64) : u64 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::extend_v3_prefix_cache(arg0, arg1, arg2, arg3)
    }

    fun f0(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::f0(arg0, arg1)
    }

    fun f2(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::f2(arg0, arg1)
    }

    fun f3(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::f3(arg0, arg1, arg2)
    }

    fun f4(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : (u128, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::f4(arg0, arg1)
    }

    fun f6(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u64, arg2: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::f6(arg0, arg1, arg2)
    }

    fun f7(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : (u128, u64, u256, u256) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::f7(arg0, arg1)
    }

    fun f8(arg0: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::f8(arg0)
    }

    public fun flowx_v2_exact_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = v2_hop(arg0, arg1, arg2, arg3);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_fractional_input_fee(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = true;
        v0
    }

    public fun found(arg0: &OptimizeResult) : bool {
        arg0.found
    }

    fun g1(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::g1(arg0, arg1)
    }

    fun g2(arg0: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop, arg1: u128, arg2: bool) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::g2(arg0, arg1, arg2)
    }

    fun g3(arg0: &mut vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : (u128, u64, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::g3(arg0, arg1)
    }

    fun g5(arg0: &mut 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop) : u64 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::g5(arg0)
    }

    fun g6(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: &mut OptimizeResult) {
        let v0 = if (arg3 == 0) {
            1
        } else {
            arg3
        };
        if (v0 <= arg4) {
            g9(arg0, v0, arg1 + v0, arg2 + g1(arg0, v0), arg5);
        };
        if (v0 > 1) {
            let v1 = v0 - 1;
            g9(arg0, v1, arg1 + v1, arg2 + g1(arg0, v1), arg5);
        };
        if (v0 < arg4) {
            let v2 = v0 + 1;
            g9(arg0, v2, arg1 + v2, arg2 + g1(arg0, v2), arg5);
        };
        g7(arg0, arg1, arg2, v0, arg4, arg5);
    }

    fun g7(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: &mut OptimizeResult) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0)) {
            let v1 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0, v0);
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v1) == 2 && !orderbook_terminal(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v1), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_cursor(v1), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_has_more(v1), 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v1))) {
                let v2 = current_orderbook_segment(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_cursor(v1), 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v1));
                let (v3, v4) = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_base_to_quote(v1)) {
                    let v5 = round_down_to_quantum(arg3, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_lot_size(v1));
                    (v5, v5 + *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_lot_size(v1))
                } else {
                    let v6 = round_down_to_quantum(mul_div_down(arg3, 1000000000, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookSegment_price(v2)), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_lot_size(v1));
                    let v7 = if (v6 == 0) {
                        0
                    } else {
                        mul_div_up(v6, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookSegment_price(v2), 1000000000)
                    };
                    (v7, mul_div_up(v6 + *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_lot_size(v1), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookSegment_price(v2), 1000000000))
                };
                g8(arg0, v0, v3, arg1, arg2, arg4, arg5);
                g8(arg0, v0, v4, arg1, arg2, arg4, arg5);
                let v8 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_consumed_base(v1) >= *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_min_size(v1)) {
                    0
                } else {
                    round_up_to_quantum(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_min_size(v1) - *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_consumed_base(v1), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_lot_size(v1))
                };
                let v9 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_base_to_quote(v1)) {
                    v8
                } else {
                    mul_div_up(v8, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookSegment_price(v2), 1000000000)
                };
                g8(arg0, v0, v9, arg1, arg2, arg4, arg5);
            };
            arg3 = g2(v1, arg3, false);
            v0 = v0 + 1;
        };
    }

    fun g8(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: &mut OptimizeResult) {
        if (arg2 == 0) {
            return
        };
        let (v0, v1) = f6(arg0, arg1, arg2);
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
        g9(arg0, v0, arg3 + v0, arg4 + g1(arg0, v0), arg6);
        if (v0 > 1) {
            let v3 = v0 - 1;
            g9(arg0, v3, arg3 + v3, arg4 + g1(arg0, v3), arg6);
        };
        if (v0 < arg5) {
            let v4 = v0 + 1;
            g9(arg0, v4, arg3 + v4, arg4 + g1(arg0, v4), arg6);
        };
    }

    fun g9(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u128, arg3: u128, arg4: &mut OptimizeResult) {
        if (!d2(arg0, arg1)) {
            return
        };
        h2(arg0, arg2, arg3, arg4);
    }

    public fun gross_from_effective(arg0: u128, arg1: u64, arg2: u64) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::gross_from_effective(arg0, arg1, arg2)
    }

    public fun gross_profit(arg0: &OptimizeResult) : u128 {
        arg0.gross_profit
    }

    fun h0(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::h0(arg0, arg1)
    }

    fun h1(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::h1(arg0)
    }

    fun h2(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u128, arg3: &mut OptimizeResult) {
        if (arg2 <= arg1) {
            return
        };
        record_candidate_with_fee(arg1, arg2, h0(arg0, arg1), arg3);
    }

    fun h3(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u128, arg3: &mut OptimizeResult) {
        if (arg2 == 0) {
            return
        };
        let (v0, v1) = h4(arg0, arg2);
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
            h2(arg0, v0, g1(arg0, v0), arg3);
        };
    }

    fun h4(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::h4(arg0, arg1)
    }

    fun h7(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::h7(arg0)
    }

    fun h8(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u64) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::h8(arg0, arg1)
    }

    fun h9(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u64) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::h9(arg0, arg1)
    }

    fun has_growth_reversal(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0)) {
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_linear_rate_inversion(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0, v0)))) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun hasui_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
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
        let v4 = a0(10);
        let v5 = if (arg6) {
            0
        } else {
            arg2
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_rate(&mut v4) = v5;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_denominator(&mut v4) = 10000000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v4) = (v1 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v4) = (v2 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v4) = arg6;
        let v6 = if (arg6) {
            1000000000
        } else {
            1
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v4) = v6;
        let v7 = if (arg6) {
            0
        } else {
            1000000000
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v4) = v7;
        let v8 = if (arg6) {
            0
        } else {
            (arg3 as u128)
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v4) = v8;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v4) = v3;
        v4
    }

    public fun hawal_capacity_stage(arg0: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::new_StagedHop(3, (arg0 as u128), 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(), 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>())
    }

    public fun hawal_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: bool, arg8: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
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
        let v5 = a0(11);
        let v6 = if (arg8) {
            0
        } else {
            arg2
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_rate(&mut v5) = v6;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_denominator(&mut v5) = 10000000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v5) = (v1 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v5) = (v2 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v5) = arg8;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v5) = 1000000000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v5) = 1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v5) = (arg3 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v5) = v4;
        v5
    }

    fun i0(arg0: &mut OptimizeState, arg1: u64, arg2: u128, arg3: u128, arg4: u64) {
        if (arg0.result.evaluations >= arg4 || arg4 - arg0.result.evaluations <= 1) {
            return
        };
        if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.validation_route)) {
            return
        };
        let v0 = 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route) * 4;
        let v1 = i1(&arg0.validation_route);
        if (v1 == 0 || (arg0.work as u128) <= (v0 as u128) + 2 * v1) {
            return
        };
        let v2 = h8(&arg0.route, arg1);
        if (v2 == 0) {
            return
        };
        arg0.work = arg0.work - v0;
        let (v3, v4) = f6(&arg0.route, arg1, arg2);
        if (!v4) {
            return
        };
        let v5 = 0x1::u128::min(v3, arg3);
        if (v5 <= v2) {
            return
        };
        let v6 = v5 - v2;
        if (arg0.cursor > arg0.max_amount_in || v6 > arg0.max_amount_in - arg0.cursor) {
            return
        };
        let v7 = arg0.cursor + v6;
        if (v7 <= arg0.result.amount_in) {
            return
        };
        let (v8, v9, v10) = d3(&arg0.validation_route, arg0.work);
        let v11 = v8;
        arg0.work = arg0.work - v10;
        if (v9 != 0 || arg0.work == 0) {
            return
        };
        let v12 = 0;
        while (v12 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&v11)) {
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.validation_route, v12)) == 1) {
                *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_V3PrefixCache_reject_empty_endpoint(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&mut v11, v12)) = true;
            };
            v12 = v12 + 1;
        };
        let v13 = &mut v11;
        let v14 = &mut arg0.work;
        let (v15, v16, _, _) = d5(&arg0.validation_route, v13, v7, v14);
        arg0.result.evaluations = arg0.result.evaluations + 1;
        if (v16 == 0) {
            let v19 = &mut arg0.result;
            h2(&arg0.validation_route, v7, v15, v19);
        };
    }

    fun i1(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::i1(arg0)
    }

    fun i2(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>, arg1: u256, arg2: u128) : vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment> {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::i2(arg0, arg1, arg2)
    }

    fun i3(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>, arg1: u256, arg2: bool, arg3: u128, arg4: u64) : vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment> {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::i3(arg0, arg1, arg2, arg3, arg4)
    }

    fun i5(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: bool, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: u128, arg10: &mut u64, arg11: &mut u128) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_stable_with_d(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    fun i6(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64, arg4: u256) : (u256, u8) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::ve33_solve_y(arg0, arg1, arg2, arg3, arg4)
    }

    fun i7(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: bool) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_q_multiply_divide(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun i8(arg0: &vector<BoltFixedHop>, arg1: u128, arg2: u128, arg3: u128, arg4: u64) : (OptimizeResult, vector<u128>) {
        let v0 = empty_result();
        let v1 = vector[];
        while (arg4 > 0) {
            0x1::vector::push_back<u128>(&mut v1, arg1);
            v0.evaluations = v0.evaluations + 1;
            let v2 = &mut arg4;
            let (v3, v4) = b2(arg0, arg1, v2);
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

    fun i9(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : (u128, u8) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::meta_exchange(arg0, arg1, arg2, arg3, arg4)
    }

    fun insert_paid_sample(arg0: &mut vector<u128>, arg1: &mut vector<ProgressiveSample>, arg2: u128, arg3: ProgressiveSample, arg4: u64) {
        let v0 = 0x1::vector::length<u128>(arg0);
        assert!(0x1::vector::length<ProgressiveSample>(arg1) == v0 && arg4 <= v0, 3);
        0x1::vector::push_back<u128>(arg0, arg2);
        0x1::vector::push_back<ProgressiveSample>(arg1, arg3);
        while (arg4 < v0) {
            0x1::vector::swap<u128>(arg0, arg4, v0);
            0x1::vector::swap<ProgressiveSample>(arg1, arg4, v0);
            arg4 = arg4 + 1;
        };
    }

    fun j2(arg0: &mut AdaptiveSearch, arg1: u64) {
        arg0.schedule.tolerance_bps = arg1;
        if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).tolerance_bps = arg1;
            0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0).approximate_stop = true;
        };
    }

    fun j3(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::j3(arg0)
    }

    fun j4(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::j4(arg0)
    }

    fun j5(arg0: &mut AdaptiveSearch, arg1: u128) : (u128, u256, u8, u64, u128) {
        let v0 = arg1;
        let v1 = q64();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
            let v3 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v2);
            if (v0 == 0 || v0 < *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_input_minimum(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v3))) {
                return (0, 0, 10, v2, v0)
            };
            if (v0 > *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v3))) {
                return (0, 0, 7, v2, v0)
            };
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_state_status(v3) != 0) {
                return (0, 0, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_state_status(v3), v2, v0)
            };
            let (v4, v5, v6, v7) = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v3) == 0) {
                if (arg0.work == 0) {
                    return (0, 0, 6, v2, v0)
                };
                arg0.work = arg0.work - 1;
                let (v8, v9) = quote_cpmm_cached_with_slope(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_output_fee_denominator(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_output_fee_rate(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_in(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_out(v3), v0);
                (v8, v9, 0, 0)
            } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v3) == 1) {
                let v10 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&mut arg0.caches, v2);
                let v11 = &mut arg0.work;
                quote_v3_cached_with_slope(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_boundaries(v3), v10, v0, v11)
            } else {
                let v12 = effective_input(v0, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v3));
                let v13 = &mut arg0.work;
                let v14 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&mut arg0.shortfalls, v2);
                let (v15, v16, v17) = quote_linear_with_shortfall(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_cursor(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_has_more(v3), 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v3), v12, v13, v14);
                let (v18, v19) = linear_marginal_fraction(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v3), 0x1::u64::min(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_cursor(v3) + v17, 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v3)) - 1)));
                let (v20, v21, v22) = if (v15 > *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_output_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v3))) {
                    (0, 0, 7)
                } else {
                    (m6(v3, v15), v18 / v19, v16)
                };
                (v20, v21, v22, v17)
            };
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v3) == 1) {
                arg0.result.crossed_ticks = arg0.result.crossed_ticks + v7;
            };
            if (v6 != 0) {
                return (0, 0, v6, v2, arg1)
            };
            if (v4 > *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_output_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v3))) {
                return (0, 0, 7, v2, arg1)
            };
            let v23 = mul_ratio_down_saturating(v5, ((*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v3) - *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(v3)) as u256), (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v3) as u256));
            let v24 = v23;
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v3) != 0) {
                v24 = mul_ratio_down_saturating(v23, ((*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_output_fee_denominator(v3) - *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_output_fee_rate(v3)) as u256), (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_output_fee_denominator(v3) as u256));
            };
            v1 = mul_ratio_down_saturating(v1, v24, q64());
            v0 = v4;
            v2 = v2 + 1;
        };
        let v25 = if (v0 > 0) {
            0
        } else {
            10
        };
        (v0, v1, v25, 18446744073709551615, 0)
    }

    fun j6(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::j6(arg0)
    }

    fun j7(arg0: &AdaptiveSearch) : bool {
        if (!j6(&arg0.route)) {
            return false
        };
        let v0 = 0;
        while (v0 < 2) {
            let v1 = if (v0 == 0) {
                arg0.low
            } else {
                arg0.high
            };
            let v2 = amount_lower_bound(&arg0.points, v1);
            let v3 = if (v2 >= 0x1::vector::length<u128>(&arg0.points)) {
                true
            } else if (*0x1::vector::borrow<u128>(&arg0.points, v2) != v1) {
                true
            } else {
                0x1::vector::borrow<ProgressiveSample>(&arg0.samples, v2).status != 0
            };
            if (v3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun j8(arg0: &mut AdaptiveSearch, arg1: u128, arg2: u256, arg3: u256) {
        let v0 = if (!arg0.result.found) {
            true
        } else if (arg0.refinement >= arg0.refinements) {
            true
        } else if (arg0.result.evaluations >= arg0.evaluations) {
            true
        } else {
            arg0.work < 3
        };
        if (v0) {
            return
        };
        if (!j7(arg0)) {
            return
        };
        let v1 = l4(&arg0.route, &arg0.caches);
        if (v1 == 0 || (arg0.work as u128) <= 3 + 2 * (v1 as u128)) {
            return
        };
        arg0.work = arg0.work - 3;
        let (v2, v3) = 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::clmm_residual_proposal(arg0.low, arg0.high, arg0.marginal.low, arg0.marginal.high, arg3, arg1, arg2, arg0.minimum, arg0.maximum, arg0.quantum);
        if (!v3) {
            return
        };
        let v4 = amount_lower_bound(&arg0.points, v2);
        if (v4 < 0x1::vector::length<u128>(&arg0.points) && *0x1::vector::borrow<u128>(&arg0.points, v4) == v2) {
            return
        };
        let v5 = &mut arg0.caches;
        let v6 = &mut v1;
        let v7 = &mut arg0.shortfalls;
        let (v8, v9, v10, v11, _, _) = e0(arg0.selector.groups, &arg0.route, v5, v2, 0, v6, v7, arg0.result.found);
        arg0.work = arg0.work - v1 - v1;
        arg0.refinement = arg0.refinement + 1;
        arg0.result.evaluations = arg0.result.evaluations + 1;
        arg0.result.crossed_ticks = arg0.result.crossed_ticks + v10;
        arg0.result.crossed_orders = arg0.result.crossed_orders + v11;
        if (v9 == 0) {
            let v14 = &mut arg0.result;
            record_candidate_with_fee(v2, v8, 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::prepared_auxiliary_fee(&arg0.auxiliary_fees, v2), v14);
        };
    }

    fun j9(arg0: &mut AdaptiveSearch) {
        if (!j4(&arg0.route)) {
            arg0.schedule.exploration_limit = 0;
            arg0.phase = 0;
            arg0.pending = false;
            arg0.amount = aligned_in_range(0x1::u128::max(arg0.result.amount_in, arg0.amount), arg0.minimum, arg0.maximum, arg0.quantum);
            adaptive_run(arg0);
            return
        };
        let v0 = h1(&arg0.route);
        while (arg0.work > 0 && (arg0.pending || arg0.result.evaluations < arg0.evaluations)) {
            let v1 = arg0.amount;
            let v2 = v1;
            let v3 = amount_lower_bound(&arg0.points, v1);
            let v4 = if (!arg0.pending) {
                if (v3 < 0x1::vector::length<u128>(&arg0.points)) {
                    *0x1::vector::borrow<u128>(&arg0.points, v3) == v1
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                k8(arg0, 4, false);
                return
            };
            if (!arg0.pending) {
                arg0.result.evaluations = arg0.result.evaluations + 1;
            };
            let v5 = arg0.work;
            let (v6, v7, v8, v9, v10) = j5(arg0, v1);
            let v11 = v7;
            let v12 = v6;
            let v13 = if (v8 == 3 && *0x1::vector::borrow<bool>(&arg0.readers.terminals, v9)) {
                7
            } else {
                v8
            };
            let v14 = v13;
            let v15 = false;
            let v16 = if (v13 == 3) {
                if (!arg0.schedule.remote_done) {
                    arg0.phase == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v16) {
                let (v17, v18, v19, v20) = k0(arg0, v9, v1, v0);
                if (v17) {
                    v2 = v18;
                    v12 = v19;
                    v11 = v20;
                    v14 = 0;
                    v15 = true;
                };
            };
            let v21 = amount_lower_bound(&arg0.points, v2);
            if (v14 == 3 && !arg0.schedule.remote_done) {
                arg0.pending = true;
                arg0.blocked = v9;
                arg0.resume_hop = v9;
                arg0.resume_input = v10;
                arg0.result.complete = false;
                arg0.result.status = v14;
                return
            };
            arg0.pending = false;
            arg0.blocked = 18446744073709551615;
            let v22 = empty_progressive_sample();
            v22.status = v14;
            v22.work = v5 - arg0.work;
            v22.output = v12;
            if (v14 == 0) {
                let v23 = if (v0 == q64()) {
                    0
                } else {
                    0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::prepared_auxiliary_fee(&arg0.auxiliary_fees, v2)
                };
                let v24 = &mut arg0.result;
                record_candidate_with_fee(v2, v12, v23, v24);
                v22.amount = v2;
                v22.fee = v23;
                v22.negative = (v2 as u256) + v23 > (v12 as u256);
                let v25 = if (v22.negative) {
                    (v2 as u256) + v23 - (v12 as u256)
                } else {
                    (v12 as u256) - (v2 as u256) - v23
                };
                v22.magnitude = v25;
                if (v11 > v0) {
                    arg0.low = v2;
                    arg0.marginal.low = v11;
                } else {
                    arg0.high = v2;
                    arg0.marginal.high = v11;
                    arg0.phase = 1;
                };
                if (v2 == arg0.maximum && v11 > v0) {
                    if (!v15) {
                        let v26 = &mut arg0.points;
                        let v27 = &mut arg0.samples;
                        insert_paid_sample(v26, v27, v2, v22, v21);
                    };
                    k8(arg0, 0, false);
                    return
                };
                let v28 = if (arg0.phase == 1) {
                    if (arg0.result.found) {
                        arg0.high > arg0.low
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v28) {
                    let v29 = if (v11 > v0) {
                        v11 - v0
                    } else {
                        v0 - v11
                    };
                    if (mul_ratio_up_saturating(v29, ((arg0.high - arg0.low) as u256), q64()) * 10000 <= (arg0.result.gross_profit as u256) * (0x1::u64::min(arg0.schedule.tolerance_bps, 100) as u256)) {
                        if (j6(&arg0.route)) {
                            arg0.schedule.converged = true;
                            arg0.amount = v2;
                        };
                        if (!v15) {
                            let v30 = &mut arg0.points;
                            let v31 = &mut arg0.samples;
                            insert_paid_sample(v30, v31, v2, v22, v21);
                        };
                        k8(arg0, 0, false);
                        return
                    };
                };
            } else {
                let v32 = if (v14 == 7) {
                    true
                } else if (v14 == 11) {
                    true
                } else {
                    v14 == 3
                };
                if (v32) {
                    arg0.high = v2;
                    arg0.marginal.high = 0;
                    arg0.phase = 1;
                } else if (v14 == 10 && arg0.phase == 0) {
                    arg0.low = v2;
                } else {
                    if (!v15) {
                        let v33 = &mut arg0.points;
                        let v34 = &mut arg0.samples;
                        insert_paid_sample(v33, v34, v2, v22, v21);
                    };
                    k8(arg0, v14, false);
                    return
                };
            };
            if (!v15) {
                let v35 = &mut arg0.points;
                let v36 = &mut arg0.samples;
                insert_paid_sample(v35, v36, v2, v22, v21);
            };
            let v37 = if (arg0.high <= arg0.low) {
                true
            } else if ((arg0.high - arg0.low) / arg0.quantum <= 2) {
                true
            } else {
                arg0.phase == 1 && arg0.refinement >= arg0.refinements
            };
            if (v37) {
                k8(arg0, 4, false);
                return
            };
            let v38 = if (arg0.phase == 0) {
                if (v2 > arg0.maximum / 4) {
                    arg0.maximum
                } else {
                    v2 * 4
                }
            } else {
                arg0.refinement = arg0.refinement + 1;
                let v39 = arg0.high - arg0.low;
                let v40 = if (arg0.marginal.high > 0) {
                    if (arg0.marginal.low > v0) {
                        arg0.marginal.high < v0
                    } else {
                        false
                    }
                } else {
                    false
                };
                let v41 = if (v40) {
                    arg0.low + to_u128(mul_ratio_down_saturating((v39 as u256), arg0.marginal.low - v0, arg0.marginal.low - arg0.marginal.high))
                } else {
                    arg0.low + v39 / 2
                };
                let v42 = if (arg0.refinement == 1) {
                    if (arg0.work > 1) {
                        if (!v15) {
                            if (v0 == q64()) {
                                if (arg0.marginal.low > v0) {
                                    if (arg0.marginal.high > 0) {
                                        if (arg0.marginal.high < v0) {
                                            j6(&arg0.route)
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
                let v43 = if (v42) {
                    arg0.work = arg0.work - 1;
                    arg0.low + to_u128(mul_ratio_down_saturating(((v41 - arg0.low) as u256), v0 + arg0.marginal.high, 2 * v0))
                } else {
                    v41
                };
                let v44 = 0x1::u128::max(v39 / 16, arg0.quantum);
                if (v42) {
                    v43
                } else if (v41 <= arg0.low + v44 || v41 >= arg0.high - v44) {
                    arg0.low + v39 / 2
                } else {
                    v41
                }
            };
            let v45 = aligned_in_range(v38, arg0.minimum, arg0.maximum, arg0.quantum);
            let v46 = if (v45 <= arg0.low) {
                true
            } else if (arg0.phase == 1 && v45 >= arg0.high) {
                true
            } else {
                v45 == v2
            };
            if (v46) {
                k8(arg0, 4, false);
                return
            };
            arg0.amount = v45;
        };
        let v47 = if (arg0.work == 0) {
            6
        } else {
            9
        };
        k8(arg0, v47, false);
    }

    public fun join_staged_route(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop>) : vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop> {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::join_staged_route(arg0, arg1)
    }

    fun k0(arg0: &mut AdaptiveSearch, arg1: u64, arg2: u128, arg3: u256) : (bool, u128, u128, u256) {
        let v0 = if (arg1 >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
            true
        } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)) != 1) {
            true
        } else if (arg0.result.evaluations >= arg0.evaluations) {
            true
        } else {
            !j4(&arg0.route)
        };
        if (v0) {
            return (false, 0, 0, 0)
        };
        if (!j6(&arg0.route)) {
            return (false, 0, 0, 0)
        };
        if (arg1 >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg0.caches)) {
            return (false, 0, 0, 0)
        };
        let v1 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg0.caches, arg1);
        let v2 = 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_boundaries(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)));
        let v3 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_status(v1) != 0) {
            true
        } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_boundary_cursor(v1) > v2) {
            true
        } else if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(v1))) {
            true
        } else {
            0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(v1)) != v2 - *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_boundary_cursor(v1)
        };
        if (v3) {
            return (false, 0, 0, 0)
        };
        let v4 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(v1), 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(v1)) - 1);
        let v5 = 0x1::u128::min(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3Prefix_crossing_input(v4), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3Prefix_cumulative_input(v4));
        let v6 = 0x1::u128::max(arg0.quantum, 1);
        let v7 = l4(&arg0.route, &arg0.caches);
        let v8 = (0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route) as u128) * 4;
        let v9 = if (v5 <= 1) {
            true
        } else if (v6 == 0) {
            true
        } else if (v7 == 0) {
            true
        } else {
            (arg0.work as u128) <= v8 + 2 * (v7 as u128)
        };
        if (v9) {
            return (false, 0, 0, 0)
        };
        arg0.work = arg0.work - (v8 as u64);
        let (v10, v11) = f6(&arg0.route, arg1, v5);
        if (!v11 || v10 <= v6) {
            return (false, 0, 0, 0)
        };
        let v12 = aligned_in_range(0x1::u128::min(v10 - v6, arg0.maximum), arg0.minimum, arg0.maximum, arg0.quantum);
        let v13 = if (v12 <= arg0.low) {
            true
        } else if (v12 >= arg2) {
            true
        } else {
            v12 < arg0.minimum
        };
        if (v13) {
            return (false, 0, 0, 0)
        };
        let v14 = amount_lower_bound(&arg0.points, v12);
        if (v14 < 0x1::vector::length<u128>(&arg0.points) && *0x1::vector::borrow<u128>(&arg0.points, v14) == v12) {
            return (false, 0, 0, 0)
        };
        let v15 = arg0.work;
        arg0.result.evaluations = arg0.result.evaluations + 1;
        let (v16, v17, v18, _, _) = j5(arg0, v12);
        if (v18 != 0) {
            return (false, 0, 0, 0)
        };
        let v21 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::prepared_auxiliary_fee(&arg0.auxiliary_fees, v12);
        let v22 = &mut arg0.result;
        record_candidate_with_fee(v12, v16, v21, v22);
        let v23 = empty_progressive_sample();
        v23.amount = v12;
        v23.output = v16;
        v23.status = v18;
        v23.work = v15 - arg0.work;
        v23.fee = v21;
        v23.negative = (v12 as u256) + v21 > (v16 as u256);
        let v24 = if (v23.negative) {
            (v12 as u256) + v21 - (v16 as u256)
        } else {
            (v16 as u256) - (v12 as u256) - v21
        };
        v23.magnitude = v24;
        let v25 = &mut arg0.points;
        let v26 = &mut arg0.samples;
        insert_paid_sample(v25, v26, v12, v23, v14);
        let (v27, v28, v29, v30) = if (v17 <= arg3) {
            (v16, v17, true, v12)
        } else {
            (0, 0, false, 0)
        };
        (v29, v30, v27, v28)
    }

    fun k1(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::k1(arg0)
    }

    fun k2(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::k2(arg0, arg1)
    }

    fun k3(arg0: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop, arg1: u128, arg2: u128, arg3: u128, arg4: &vector<u128>) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::k3(arg0, arg1, arg2, arg3, arg4)
    }

    fun k4(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::k4(arg0, arg1)
    }

    fun k5(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u128, arg11: u128) : AdaptiveSearch {
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
            if (!0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
                k1(&arg0)
            } else {
                false
            }
        } else {
            false
        };
        let v2 = if (arg9) {
            if (!v1) {
                if (!0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
                    k4(&arg0, arg2)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v3 = if (arg9) {
            if (!v1) {
                if (!v2) {
                    j4(&arg0)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v4 = if (v1) {
            true
        } else if (v2) {
            true
        } else {
            v3
        };
        let v5 = if (arg9) {
            if (!v4) {
                if (!0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
                    route_model(&arg0) != 1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v6 = vector[];
        let v7 = vector[];
        let v8 = vector[];
        let v9 = vector[];
        let v10 = 0;
        while (v10 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
            0x1::vector::push_back<bool>(&mut v6, false);
            0x1::vector::push_back<bool>(&mut v7, false);
            0x1::vector::push_back<u64>(&mut v8, 0);
            0x1::vector::push_back<u64>(&mut v9, 0);
            v10 = v10 + 1;
        };
        let v11 = if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
            arg2
        } else {
            0x1::u128::min(arg2, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0))))
        };
        let v12 = a2(&arg0);
        let v13 = if (v5) {
            true
        } else if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
            true
        } else {
            v12 && b0(&arg0)
        };
        let (v14, v15, v16) = if (v13) {
            (0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(), 0, 0)
        } else {
            d3(&arg0, arg6)
        };
        let v17 = v14;
        if (v4) {
            let v18 = 0;
            while (v18 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&v17)) {
                if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, v18)) == 1) {
                    *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_V3PrefixCache_reject_empty_endpoint(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&mut v17, v18)) = true;
                };
                v18 = v18 + 1;
            };
        };
        let (v19, v20) = if (v5) {
            (0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(), false)
        } else {
            e2(&arg0)
        };
        let v21 = v12 && a7(&arg0);
        let v22 = arg6 - v16;
        let v23 = if (v21) {
            if (v11 >= arg10) {
                if (v11 > 0) {
                    (v11 - arg10) / arg11 + 1 > (arg5 as u128)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v24 = if (v23) {
            let v25 = &mut v22;
            a9(&arg0, arg10, v11, arg11, v25)
        } else {
            vector[]
        };
        let v26 = v24;
        let v27 = vector[];
        let v28 = 0;
        while (v28 < 0x1::vector::length<u128>(&v26)) {
            let v29 = *0x1::vector::borrow<u128>(&v26, v28);
            let v30 = if (v29 >= arg10 + arg11) {
                if (v11 - v29 >= arg11) {
                    let v31 = v29 - arg11;
                    if (0x1::vector::contains<u128>(&v26, &v31)) {
                        let v32 = v29 + arg11;
                        0x1::vector::contains<u128>(&v26, &v32)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v30) {
                0x1::vector::push_back<u128>(&mut v27, v29);
            };
            v28 = v28 + 1;
        };
        let v33 = if (!0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0)) == 2) {
                if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_base_to_quote(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0))) {
                    if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0)) == 0) {
                        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_lot_size(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0)) % arg11 == 0
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
        let v34 = if (v33) {
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_lot_size(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0))
        } else {
            arg11
        };
        let v35 = 0;
        let v36 = if (v4) {
            let (v37, v38) = e5(&arg0);
            let v39 = if (v20) {
                if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0)) == 2) {
                    if (!v12) {
                        v37 <= (340282366920938463463374607431768211455 as u256)
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
                v35 = (v37 as u128);
            };
            let v40 = coefficient_root(mul_ratio_down_saturating(v37, q64(), h1(&arg0)), v38, v11);
            let v41 = if (v40 > 0) {
                v40
            } else {
                0x1::u128::min(arg1, v11)
            };
            0x1::u128::min(v41, k2(&arg0, v11))
        } else {
            0x1::u128::min(arg1, v11)
        };
        let v42 = if (v2) {
            let v43 = vector[];
            k3(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0), v36, arg10, v34, &v43)
        } else {
            v36
        };
        let v44 = if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
            0
        } else {
            aligned_in_range(a5(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0, 0), v42), arg10, v11, v34)
        };
        let v45 = if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0)) {
            coarse_rejection()
        } else {
            empty_result()
        };
        let v46 = v45;
        v46.complete = false;
        if (v15 != 0) {
            v46.status = v15;
        };
        let v47 = 0x1::vector::empty<OptimizeState>();
        let v48 = if (v5) {
            let v49 = coefficient_state(arg0, v11, arg3);
            v49.work = arg6;
            0x1::vector::push_back<OptimizeState>(&mut v47, v49);
            0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>()
        } else {
            arg0
        };
        let v50 = v48;
        let v51 = if (v15 != 0 || v44 == 0) {
            3
        } else {
            0
        };
        let v52 = SelectorState{
            has_book : v20,
            bolt     : v12,
            groups   : false,
        };
        let v53 = if (v21) {
            3
        } else {
            1
        };
        let v54 = if (v3) {
            2
        } else if (v2) {
            1
        } else {
            0
        };
        let v55 = MarginalBracket{
            low  : 0,
            high : 0,
        };
        let v56 = ReversalSchedule{
            events            : v26,
            remote_left       : v53,
            mapped            : v21,
            exploration       : 0,
            boundaries        : v27,
            boundary_index    : 0,
            remote_done       : false,
            points            : vector[],
            point_index       : 0,
            count             : v35,
            outward           : true,
            exploration_limit : v54,
            valid_seen        : false,
            local_refined     : false,
            converged         : false,
            cached            : 0x1::vector::empty<BoltFixedHop>(),
            initialized       : false,
            tolerance_bps     : 0,
            small_gains       : 0,
        };
        let v57 = ReadBudget{
            physical            : 0,
            effective           : 0,
            max_physical        : arg7,
            max_effective       : arg8,
            terminals           : v6,
            synthetic           : v7,
            hop_physical        : v8,
            hop_effective       : v9,
            max_batch_effective : 0,
            max_batch_physical  : 0,
        };
        let v58 = AdaptiveSearch{
            route          : v50,
            caches         : v17,
            shortfalls     : v19,
            auxiliary_fees : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::prepare_auxiliary_fees(&v50),
            mk             : v47,
            result         : v46,
            points         : vector[],
            samples        : 0x1::vector::empty<ProgressiveSample>(),
            maximum        : v11,
            minimum        : arg10,
            quantum        : v34,
            evaluations    : arg5,
            refinements    : arg4,
            work           : v22,
            phase          : v51,
            amount         : v44,
            upper          : v44,
            low            : arg10,
            high           : v44,
            previous       : empty_progressive_sample(),
            best           : empty_progressive_sample(),
            left           : empty_progressive_sample(),
            declines       : 0,
            refinement     : 0,
            selector       : v52,
            marginal       : v55,
            schedule       : v56,
            pending        : false,
            resume_hop     : 0,
            resume_input   : 0,
            blocked        : 18446744073709551615,
            readers        : v57,
        };
        if (v3) {
            v58.low = arg10;
            v58.high = v11;
            v58.marginal.low = e4(&v58.route);
        };
        if (v12 && v58.phase != 3) {
            let v59 = &mut v58;
            b7(v59);
        };
        v58
    }

    fun k6(arg0: &mut AdaptiveSearch, arg1: u128) : ProgressiveSample {
        let v0 = amount_lower_bound(&arg0.points, arg1);
        k7(arg0, arg1, v0)
    }

    fun k7(arg0: &mut AdaptiveSearch, arg1: u128, arg2: u64) : ProgressiveSample {
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
        let v2 = arg0.work;
        let v3 = if (arg0.selector.groups) {
            let v4 = arg0.resume_input;
            let v5 = arg0.resume_hop;
            let v6 = m1(v4, v5, arg0);
            !v6
        } else {
            false
        };
        let (v7, v8, v9, v10, v11, v12) = if (!0x1::vector::is_empty<BoltFixedHop>(&arg0.schedule.cached)) {
            let v13 = &mut arg0.work;
            let (v14, v15) = b2(&arg0.schedule.cached, arg1, v13);
            (v14, v15, 0, 0, 18446744073709551615, 0)
        } else {
            let v16 = &mut arg0.caches;
            let v17 = &mut arg0.work;
            let v18 = &mut arg0.shortfalls;
            let v19 = arg0.result.found || arg0.pending;
            e0(v3, &arg0.route, v16, arg0.resume_input, arg0.resume_hop, v17, v18, v19)
        };
        let v20 = if (v3) {
            if (arg0.resume_hop == 0) {
                v8 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v20) {
            let v21 = arg0.resume_input;
            m0(v21, arg0);
        };
        let v22 = if (v8 == 3 && *0x1::vector::borrow<bool>(&arg0.readers.terminals, v11)) {
            7
        } else {
            v8
        };
        arg0.result.crossed_ticks = arg0.result.crossed_ticks + v9;
        arg0.result.crossed_orders = arg0.result.crossed_orders + v10;
        let v23 = empty_progressive_sample();
        v23.status = v22;
        v23.output = v7;
        v23.work = v2 - arg0.work;
        if (v22 == 3) {
            let v24 = if (arg0.readers.max_physical == 0) {
                if (arg0.readers.max_effective == 0) {
                    k1(&arg0.route)
                } else {
                    false
                }
            } else {
                false
            };
            if (v24) {
                let v25 = if (v11 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg0.shortfalls) && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_minimum_gross(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg0.shortfalls, v11)) > 0) {
                    *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_minimum_gross(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg0.shortfalls, v11)) - 1
                } else if (v11 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg0.caches) && !0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg0.caches, v11)))) {
                    *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3Prefix_cumulative_input(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg0.caches, v11)), 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg0.caches, v11))) - 1))
                } else {
                    0
                };
                let v26 = if (v12 > 0 && v25 > 0) {
                    0x1::u128::min(mul_div_down(arg1, v25, v12), arg1 - 1)
                } else {
                    arg1 / 2
                };
                v23.output = v26;
                arg0.pending = false;
                arg0.result.complete = false;
                arg0.result.status = 3;
                let v27 = &mut arg0.points;
                let v28 = &mut arg0.samples;
                insert_paid_sample(v27, v28, arg1, v23, arg2);
                return v23
            };
            arg0.blocked = v11;
            arg0.resume_hop = v11;
            arg0.resume_input = v12;
            arg0.pending = true;
            arg0.result.status = v22;
            return v23
        };
        arg0.pending = false;
        arg0.blocked = 18446744073709551615;
        if (!0x1::vector::is_empty<BoltFixedHop>(&arg0.schedule.cached)) {
            let v29 = if (v22 != 0) {
                if (v22 != 1) {
                    v22 != 7
                } else {
                    false
                }
            } else {
                false
            };
            if (v29) {
                arg0.result.status = v22;
            };
        } else {
            let v30 = if (v22 != 0) {
                if (v22 != 1) {
                    if (v22 != 7) {
                        v22 != 10
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v30) {
                arg0.result.complete = false;
                if (arg0.result.status == 0 || arg0.result.status == 1) {
                    arg0.result.status = v22;
                };
            };
        };
        if (v22 == 0 && v7 > 0) {
            let v31 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::prepared_auxiliary_fee(&arg0.auxiliary_fees, arg1);
            let v32 = &mut arg0.result;
            record_candidate_with_fee(arg1, v7, v31, v32);
            let v33 = saturating_add((arg1 as u256), v31);
            v23.amount = arg1;
            v23.fee = v31;
            v23.negative = v33 > (v7 as u256);
            let v34 = if (v23.negative) {
                v33 - (v7 as u256)
            } else {
                (v7 as u256) - v33
            };
            v23.magnitude = v34;
        };
        let v35 = &mut arg0.points;
        let v36 = &mut arg0.samples;
        insert_paid_sample(v35, v36, arg1, v23, arg2);
        v23
    }

    fun k8(arg0: &mut AdaptiveSearch, arg1: u8, arg2: bool) {
        arg0.phase = 3;
        arg0.blocked = 18446744073709551615;
        arg0.result.complete = arg2;
        let v0 = if (arg0.result.status == 0) {
            true
        } else if (arg0.result.status == 1) {
            true
        } else {
            arg1 != 9 && arg1 != 4
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

    fun k9(arg0: &mut AdaptiveSearch) {
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

    public fun kriya_v2_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
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
        let v8 = a0(8);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_rate(&mut v8) = arg3;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_denominator(&mut v8) = 1000000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_rate(&mut v8) = arg2;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_denominator(&mut v8) = 1000000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v8) = (v0 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v8) = (v1 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v8) = arg8;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v8) = 100000000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v8) = (v2 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v8) = (v3 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_fee_on_input(&mut v8) = arg4;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v8) = v6;
        v8
    }

    public fun kriya_ve33_get_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::ve33_solve_y(arg0, arg1, arg2, arg3, 1)
    }

    fun l0(arg0: &mut AdaptiveSearch, arg1: u128) : bool {
        arg0.schedule.initialized = true;
        let v0 = amount_lower_bound(&arg0.points, arg1);
        let v1 = v0 < 0x1::vector::length<u128>(&arg0.points) && *0x1::vector::borrow<u128>(&arg0.points, v0) == arg1;
        if (!v1 && arg0.result.evaluations < arg0.evaluations) {
            arg0.result.evaluations = arg0.result.evaluations + 1;
            let v2 = &mut arg0.caches;
            let v3 = &mut arg0.work;
            let v4 = &mut arg0.shortfalls;
            let (v5, v6, v7, v8, _, _) = e0(arg0.selector.groups, &arg0.route, v2, arg1, 0, v3, v4, arg0.result.found);
            arg0.result.crossed_ticks = arg0.result.crossed_ticks + v7;
            arg0.result.crossed_orders = arg0.result.crossed_orders + v8;
            if (v6 == 0 && v5 > 0) {
                let v11 = &mut arg0.result;
                record_candidate_with_fee(arg1, v5, 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::prepared_auxiliary_fee(&arg0.auxiliary_fees, arg1), v11);
                if (arg0.result.gross_profit > arg0.result.gross_profit) {
                    arg0.schedule.local_refined = true;
                    arg0.schedule.count = arg1;
                };
            };
        };
        arg0.refinement = arg0.refinement + 1;
        arg0.result.status = arg0.result.status;
        false
    }

    fun l1(arg0: &mut AdaptiveSearch) : bool {
        let v0 = if (arg0.schedule.initialized) {
            true
        } else if (!arg0.result.found) {
            true
        } else if (arg0.schedule.exploration_limit != 0) {
            true
        } else if (arg0.schedule.count == 0) {
            true
        } else if (arg0.marginal.low == 0) {
            true
        } else if (arg0.refinement + 1 > arg0.refinements) {
            true
        } else if (arg0.result.evaluations + 1 > arg0.evaluations) {
            true
        } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, 0)) != 0) {
            true
        } else if (arg0.best.status != 0) {
            true
        } else if (arg0.best.fee != 0) {
            true
        } else {
            arg0.work <= 3
        };
        if (v0) {
            return false
        };
        arg0.work = arg0.work - 3;
        let v1 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, 0);
        let v2 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v1), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_cursor(v1));
        let (v3, v4, v5, v6) = 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::book_anchor_projected_point(arg0.schedule.count, h1(&arg0.route), arg0.best.amount, arg0.best.output, arg0.minimum, arg0.maximum, arg0.quantum, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookSegment_price(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_lot_size(v1), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_min_size(v1), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookSegment_remaining_base(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_base_to_quote(v1), (arg0.marginal.low as u128));
        if (!v5) {
            if (v4 == 0) {
                arg0.schedule.initialized = true;
            };
            return false
        };
        if (v3 == arg0.result.amount_in) {
            return false
        };
        let v7 = l4(&arg0.route, &arg0.caches);
        if (v7 == 0 || arg0.work <= v7) {
            return false
        };
        if (v6) {
            return l0(arg0, v3)
        };
        arg0.schedule.initialized = true;
        arg0.pending = false;
        arg0.blocked = 18446744073709551615;
        let v8 = arg0.result.gross_profit;
        let v9 = k6(arg0, v3);
        arg0.refinement = arg0.refinement + 1;
        if (v9.status == 0 && arg0.result.gross_profit > v8) {
            arg0.schedule.local_refined = true;
            arg0.schedule.count = v3;
        };
        k8(arg0, 0, false);
        true
    }

    fun l2(arg0: &AdaptiveSearch, arg1: u64) : u64 {
        let v0 = if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            &0x1::vector::borrow<OptimizeState>(&arg0.mk, 0).validation_route
        } else {
            &arg0.route
        };
        if (arg1 >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0) || *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1)) != 3) {
            return 0
        };
        let v1 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1));
        if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(v1)) {
            return 0
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(v1)) {
            v2 = v2 + (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_LinearSegment_remaining_input(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(v1, v3)) as u256);
            v3 = v3 + 1;
        };
        if (v2 == 0) {
            return 0
        };
        let v4 = 0;
        if (0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            if (!arg0.pending || arg0.resume_hop != arg1) {
                return 0
            };
            let v5 = if (arg0.schedule.exploration_limit == 2) {
                if (arg0.phase == 0) {
                    arg0.marginal.low > h1(v0)
                } else {
                    false
                }
            } else {
                false
            };
            let v6 = if (v5) {
                (effective_input(arg0.resume_input, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1)), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1))) as u256) * 4
            } else {
                let v7 = if (arg0.selector.has_book) {
                    if (!arg0.selector.bolt) {
                        route_model(v0) != 1
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v7) {
                    let (v8, _) = e5(v0);
                    if (v8 > h1(v0)) {
                        (effective_input(arg0.resume_input, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1)), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1))) as u256) * 4
                    } else {
                        (effective_input(arg0.resume_input, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1)), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1))) as u256)
                    }
                } else {
                    (effective_input(arg0.resume_input, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1)), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(v0, arg1))) as u256)
                }
            };
            if (v6 > v2) {
                v4 = v6 - v2;
            };
        } else {
            let v10 = 0x1::vector::borrow<OptimizeState>(&arg0.mk, 0);
            let v11 = q64();
            let v12 = 0;
            let v13 = q64();
            let v14 = 0;
            while (v14 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&v10.route)) {
                let v15 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&v10.route, v14);
                if (v14 == arg1) {
                    v13 = v11;
                };
                let v16 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v15) == 3 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_cursor(v15) >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v15))) {
                    let v17 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&v10.validation_route, v14);
                    if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v17))) {
                        return 0
                    };
                    let (v18, v19) = linear_marginal_fraction(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v17), 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v17)) - 1));
                    v18 / v19 * ((*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v15) - *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(v15)) as u256) / (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(v15) as u256)
                } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v15) == 2 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_cursor(v15) >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v15))) {
                    let v20 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&v10.validation_route, v14);
                    if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v20))) {
                        return 0
                    };
                    cap_marginal_orderbook(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v15), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_base_to_quote(v15), 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v20)) - 1, true, 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v20))
                } else {
                    e6(v15)
                };
                if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v15) == 1 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_liquidity(v15) == 0) {
                    return 0
                };
                v12 = v12 + f8(v15) * v11 / q64();
                let v21 = v11 * v16;
                v11 = v21 / q64();
                v14 = v14 + 1;
            };
            let v22 = mul_ratio_down_saturating(v11, q64(), v10.auxiliary_cost);
            if (v22 <= q64()) {
                return 0
            };
            let v23 = coefficient_root(v22, v12, v10.max_amount_in - v10.cursor);
            v4 = (v23 as u256) * v13 / (q64() + 0 * (v23 as u256));
        };
        let v24 = if (v4 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / (0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(v1) as u256)) {
            (18446744073709551615 as u256)
        } else {
            div_ceil(v4 * (0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(v1) as u256), v2)
        };
        (0x1::u256::min(v24, (18446744073709551615 as u256)) as u64)
    }

    fun l3(arg0: &mut vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>, arg1: &vector<u128>, arg2: &vector<u128>, arg3: &vector<bool>) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::l3(arg0, arg1, arg2, arg3);
    }

    fun l4(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>) : u64 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::l4(arg0, arg1)
    }

    fun l5(arg0: &mut AdaptiveSearch) {
        if (!arg0.pending) {
            return
        };
        let v0 = arg0.blocked;
        l6(arg0, v0);
    }

    fun l6(arg0: &mut AdaptiveSearch, arg1: u64) {
        let v0 = if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            true
        } else if (arg1 == 18446744073709551615) {
            true
        } else if (arg1 >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
            true
        } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)) != 3 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)) != 1) {
            true
        } else if (arg0.result.evaluations >= arg0.evaluations) {
            true
        } else {
            arg0.work == 0
        };
        if (v0) {
            return
        };
        let v1 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)) == 3) {
            if (arg1 >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg0.shortfalls) || *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_minimum_gross(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg0.shortfalls, arg1)) <= 1) {
                return
            };
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_minimum_gross(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg0.shortfalls, arg1)) - 1
        } else {
            if (arg1 >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg0.caches)) {
                return
            };
            let v2 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg0.caches, arg1);
            let v3 = 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_boundaries(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)));
            let v4 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_status(v2) != 0) {
                true
            } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_boundary_cursor(v2) > v3) {
                true
            } else if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(v2))) {
                true
            } else {
                0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(v2)) != v3 - *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_boundary_cursor(v2)
            };
            if (v4) {
                return
            };
            let v5 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(v2), 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(v2)) - 1);
            0x1::u128::min(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3Prefix_crossing_input(v5), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3Prefix_cumulative_input(v5))
        };
        if (v1 <= 1) {
            return
        };
        let v6 = l4(&arg0.route, &arg0.caches);
        if (v6 == 0) {
            return
        };
        let v7 = (0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route) as u128) * 4;
        if ((arg0.work as u128) <= v7 + 2 * (v6 as u128)) {
            return
        };
        let v8 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)) == 1) {
            0x1::u128::max(arg0.quantum, 1)
        } else {
            h8(&arg0.route, arg1)
        };
        if (v8 == 0) {
            return
        };
        arg0.work = arg0.work - (v7 as u64);
        let (v9, v10) = f6(&arg0.route, arg1, v1);
        if (!v10 || v9 <= v8) {
            return
        };
        let v11 = 0x1::u128::min(v9 - v8, arg0.maximum);
        if (v11 <= arg0.result.amount_in || v11 < arg0.minimum) {
            return
        };
        let v12 = 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route);
        let v13 = if (v12 >= 2) {
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v12 - 2)) == 0) {
                if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v12 - 1)) == 1) {
                    mul_ratio_up_saturating((*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_out(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v12 - 2)) as u256), cap_upper_v3(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_sqrt_price_x64(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v12 - 1)), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_zero_for_one(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v12 - 1))), q64()) <= (v11 as u256)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v13) {
            return
        };
        let v14 = amount_lower_bound(&arg0.points, v11);
        if (v14 < 0x1::vector::length<u128>(&arg0.points) && *0x1::vector::borrow<u128>(&arg0.points, v14) == v11) {
            return
        };
        let v15 = 0;
        while (v15 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
            if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v15)) == 1) {
                *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_V3PrefixCache_reject_empty_endpoint(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&mut arg0.caches, v15)) = true;
            };
            v15 = v15 + 1;
        };
        let v16 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg1)) == 3) {
            arg1
        } else {
            arg0.result.needs_more_hop
        };
        let v17 = &mut arg0.caches;
        let v18 = &mut v6;
        let v19 = &mut arg0.shortfalls;
        let (v20, v21, v22, v23, _, _) = e0(arg0.selector.groups, &arg0.route, v17, v11, 0, v18, v19, arg0.result.found);
        arg0.work = arg0.work - v6 - v6;
        arg0.result.evaluations = arg0.result.evaluations + 1;
        arg0.result.crossed_ticks = arg0.result.crossed_ticks + v22;
        arg0.result.crossed_orders = arg0.result.crossed_orders + v23;
        if (v21 == 0) {
            let v26 = &mut arg0.result;
            record_candidate_with_fee(v11, v20, 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::prepared_auxiliary_fee(&arg0.auxiliary_fees, v11), v26);
        };
        arg0.result.complete = false;
        arg0.result.status = arg0.result.status;
        arg0.result.needs_more_hop = v16;
    }

    fun l7(arg0: &mut AdaptiveSearch) {
        if (arg0.schedule.exploration_limit != 2) {
            return
        };
        if (!j6(&arg0.route)) {
            return
        };
        let v0 = 0;
        loop {
            let v1 = if (v0 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
                if (arg0.result.evaluations < arg0.evaluations) {
                    arg0.work > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v1) {
                if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v0)) == 1) {
                    l6(arg0, v0);
                };
                v0 = v0 + 1;
            } else {
                break
            };
        };
    }

    fun l8(arg0: &mut AdaptiveSearch, arg1: u128) {
        let v0 = if (!0x1::vector::is_empty<OptimizeState>(&arg0.mk)) {
            true
        } else if (!arg0.selector.has_book) {
            true
        } else if (!arg0.result.found) {
            true
        } else if (arg0.result.evaluations >= arg0.evaluations) {
            true
        } else {
            arg0.work == 0
        };
        if (v0) {
            return
        };
        let v1 = arg0.selector.groups;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
            let v3 = v1 || *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v2)) == 3 && 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v2))) >= 16;
            v1 = v3;
            v2 = v2 + 1;
        };
        if (!v1) {
            return
        };
        let v4 = arg0.result;
        let v5 = 0x1::u128::max(mul_div_up(v4.gross_profit, 9000, 10000), arg1);
        if (v5 >= v4.gross_profit) {
            return
        };
        let v6 = 0;
        let v7 = 0;
        let v8 = v4.amount_in;
        let v9 = v4.gross_profit;
        let v10 = 0;
        while (v10 < 0x1::vector::length<ProgressiveSample>(&arg0.samples)) {
            let v11 = 0x1::vector::borrow<ProgressiveSample>(&arg0.samples, v10);
            let v12 = if (v11.status == 0) {
                if (v11.amount > 0) {
                    if (!v11.negative) {
                        if (v11.magnitude <= (340282366920938463463374607431768211455 as u256)) {
                            v11.amount < v4.amount_in
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
            if (v12) {
                let v13 = (v11.magnitude as u128);
                if (v13 >= v5) {
                    v8 = v11.amount;
                    v9 = v13;
                    break
                };
                v6 = v11.amount;
                v7 = v13;
            };
            v10 = v10 + 1;
        };
        let v14 = 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::profit_chord_left(v6, v7, v8, v9, v5);
        let v15 = 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route) * 4;
        if (arg0.work <= v15) {
            return
        };
        arg0.work = arg0.work - v15;
        let v16 = 0x1::u128::max(arg0.quantum, h8(&arg0.route, 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)));
        let v17 = (v16 - v14 % v16) % v16;
        if (v14 > 340282366920938463463374607431768211455 - v17) {
            return
        };
        let v18 = 0x1::u128::max(v14 + v17, arg0.minimum);
        if (v18 >= v4.amount_in || v18 > arg0.maximum) {
            return
        };
        let v19 = l4(&arg0.route, &arg0.caches);
        if (v19 == 0 || arg0.work < v19) {
            return
        };
        let v20 = if (arg0.selector.groups) {
            let v21 = m1(v18, 0, arg0);
            !v21
        } else {
            false
        };
        let v22 = &mut arg0.caches;
        let v23 = &mut arg0.work;
        let v24 = &mut arg0.shortfalls;
        let (v25, v26, v27, v28, _, _) = e0(v20, &arg0.route, v22, v18, 0, v23, v24, true);
        arg0.result.evaluations = arg0.result.evaluations + 1;
        arg0.result.crossed_ticks = arg0.result.crossed_ticks + v27;
        arg0.result.crossed_orders = arg0.result.crossed_orders + v28;
        let v31 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::prepared_auxiliary_fee(&arg0.auxiliary_fees, v18);
        let v32 = if (v26 == 0) {
            if (v25 > v18) {
                if (((v25 - v18) as u256) > v31) {
                    ((v25 - v18) as u256) - v31 >= (v5 as u256)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v32) {
            arg0.result.amount_in = v18;
            arg0.result.amount_out = v25;
            arg0.result.gross_profit = ((((v25 - v18) as u256) - v31) as u128);
        };
    }

    fun l9(arg0: AdaptiveSearch, arg1: u128, arg2: bool) : OptimizeResult {
        let v0 = if (arg0.schedule.exploration_limit == 2) {
            if (arg0.pending) {
                if (arg0.result.evaluations < arg0.evaluations) {
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
        if (v0) {
            arg0.high = arg0.amount;
            arg0.marginal.high = 0;
            arg0.phase = 1;
            arg0.low = 0x1::u128::min(0x1::u128::max(arg0.result.amount_in, arg0.minimum), arg0.high);
            arg0.amount = aligned_in_range(arg0.low + (arg0.high - arg0.low) / 2, arg0.minimum, arg0.maximum, arg0.quantum);
            arg0.pending = false;
            arg0.blocked = 18446744073709551615;
            arg0.schedule.remote_done = true;
            if (arg0.amount > arg0.low && arg0.amount < arg0.high) {
                let v1 = &mut arg0;
                j9(v1);
            };
            arg0.result.complete = false;
            arg0.result.status = arg0.result.status;
            arg0.result.needs_more_hop = arg0.blocked;
        };
        if (arg0.blocked >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route) || *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, arg0.blocked)) != 1) {
            let v2 = &mut arg0;
            l5(v2);
        };
        let v3 = &mut arg0;
        l7(v3);
        let v4 = if (arg0.schedule.exploration_limit == 2) {
            if (arg0.schedule.converged) {
                if (!arg0.pending) {
                    if (arg0.result.status == 0) {
                        0x1::vector::is_empty<OptimizeState>(&arg0.mk)
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
        if (v4) {
            let v5 = if (arg0.amount == arg0.low) {
                arg0.marginal.low
            } else if (arg0.amount == arg0.high) {
                arg0.marginal.high
            } else {
                0
            };
            if (v5 > 0) {
                let v6 = &mut arg0;
                j8(v6, arg0.amount, v5, h1(&arg0.route));
            };
        };
        let v7 = if (arg2) {
            let v8 = if (arg0.selector.has_book) {
                if (!arg0.selector.bolt) {
                    if (arg0.schedule.local_refined) {
                        arg0.schedule.count == arg0.result.amount_in
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            !v8
        } else {
            false
        };
        if (v7) {
            let v9 = &mut arg0;
            l8(v9, arg1);
        };
        if (arg0.selector.groups) {
            arg0.result.complete = false;
        };
        let AdaptiveSearch {
            route          : _,
            caches         : _,
            shortfalls     : _,
            auxiliary_fees : _,
            mk             : v14,
            result         : v15,
            points         : _,
            samples        : _,
            maximum        : _,
            minimum        : _,
            quantum        : _,
            evaluations    : v21,
            refinements    : _,
            work           : v23,
            phase          : _,
            amount         : _,
            upper          : _,
            low            : _,
            high           : _,
            previous       : _,
            best           : _,
            left           : _,
            declines       : _,
            refinement     : _,
            selector       : _,
            marginal       : _,
            schedule       : _,
            pending        : _,
            resume_hop     : _,
            resume_input   : _,
            blocked        : _,
            readers        : _,
        } = arg0;
        let v42 = v14;
        if (0x1::vector::is_empty<OptimizeState>(&v42)) {
            v15
        } else {
            let v44 = 0x1::vector::pop_back<OptimizeState>(&mut v42);
            c0(&v44, 0x1::u64::min(v44.work, v23), v21 - 0x1::u64::min(v44.result.evaluations, v21), true)
        }
    }

    public fun largest_gap_midpoint(arg0: &vector<u128>, arg1: u128, arg2: u128, arg3: u128) : u128 {
        let (v0, _) = 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::bg(arg0, arg1, arg2, arg3);
        v0
    }

    public fun linear_hop(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>, arg1: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        a3(arg0, arg1, false)
    }

    public fun linear_hop_from_capacities(arg0: vector<u128>, arg1: vector<u128>, arg2: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0)) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(&mut v0, linear_segment(*0x1::vector::borrow<u128>(&arg0, v1), *0x1::vector::borrow<u128>(&arg1, v1)));
            v1 = v1 + 1;
        };
        linear_hop(v0, arg2)
    }

    public fun linear_input_boundary(arg0: u64, arg1: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::linear_input_boundary(arg0, arg1)
    }

    public fun linear_marginal_fraction(arg0: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment) : (u256, u256) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::linear_marginal_fraction(arg0)
    }

    public fun linear_rate_hop(arg0: u128) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v0, 18446744073709551616);
        let v1 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v1, arg0);
        linear_hop_from_capacities(v0, v1, false)
    }

    public fun linear_segment(arg0: u128, arg1: u128) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::linear_segment(arg0, arg1)
    }

    public fun linear_terminal(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::linear_terminal(arg0, arg1, arg2, arg3)
    }

    public fun liquidity_after_boundary(arg0: u128, arg1: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary, arg2: bool) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::liquidity_after_boundary(arg0, arg1, arg2)
    }

    fun loaded_reversal_point(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u128, arg3: &mut u64) : u128 {
        let v0 = 0;
        let v1 = 0;
        loop {
            let v2 = if (v0 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0)) {
                if (*arg3 > 0) {
                    v1 < 8
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                *arg3 = *arg3 - 1;
                let v3 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0, v0);
                if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v3) == 3 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_linear_rate_inversion(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(v3))) {
                    let v4 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v3);
                    let v5 = *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_cursor(v3);
                    let v6 = 0;
                    loop {
                        let v7 = if (v5 + 1 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(v4)) {
                            if (v1 < 8) {
                                *arg3 > 0
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v7) {
                            *arg3 = *arg3 - 1;
                            v1 = v1 + 1;
                            let v8 = *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_LinearSegment_remaining_input(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(v4, v5));
                            if (v8 > 340282366920938463463374607431768211455 - v6) {
                                return 0
                            };
                            let v9 = v6 + v8;
                            v6 = v9;
                            let (v10, v11) = linear_marginal_fraction(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(v4, v5));
                            let (v12, v13) = linear_marginal_fraction(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(v4, v5 + 1));
                            let v14 = if (v11 > 0) {
                                if (v13 > 0) {
                                    v12 / v13 > v10 / v11
                                } else {
                                    false
                                }
                            } else {
                                false
                            };
                            if (v14) {
                                let v15 = 1;
                                let v16 = 0;
                                while (v16 < v0) {
                                    let v17 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0, v16);
                                    let v18 = *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v17);
                                    let v19 = if (v18 == 3 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_cursor(v17) >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(v17))) {
                                        true
                                    } else if (v18 == 2 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_cursor(v17) >= 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v17))) {
                                        true
                                    } else if (v18 == 1 && *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_liquidity(v17) == 0) {
                                        true
                                    } else if (v18 != 3) {
                                        if (v18 != 2) {
                                            if (v18 != 1) {
                                                v18 != 0
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    };
                                    if (v19) {
                                        return 0
                                    };
                                    let v20 = v15 + 1 + 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_linear_segments(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0, v16))) + 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0, v16)));
                                    v15 = v20 + 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_boundaries(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(arg0, v16)));
                                    v16 = v16 + 1;
                                };
                                if (*arg3 < v15) {
                                    return 0
                                };
                                *arg3 = *arg3 - v15;
                                let (v21, v22) = f6(arg0, v0, v9);
                                if (!v22 || v21 > arg2 - arg1) {
                                    return 0
                                };
                                let v23 = arg1 + v21;
                                return if (v23 > arg2 / 4) {
                                    arg2
                                } else {
                                    v23 * 4
                                }
                            };
                            v5 = v5 + 1;
                        } else {
                            break
                        };
                    };
                };
                v0 = v0 + 1;
            } else {
                break
            };
        };
        0
    }

    public fun log2_down(arg0: u256) : u8 {
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::log2_down(arg0)
    }

    public fun lst_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        lst_ratio_hop_with_minimum(arg0, arg1, arg2, arg3, arg4, arg5, 0)
    }

    public fun lst_ratio_hop_with_minimum(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
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
        let v5 = a0(9);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_rate(&mut v5) = v2;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_denominator(&mut v5) = 10000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v5) = (v0 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v5) = (v1 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v5) = arg5;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v5) = (arg6 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v5) = 1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v5) = 1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_fee_on_input(&mut v5) = arg5;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v5) = v3;
        v5
    }

    fun m0(arg0: u128, arg1: &mut AdaptiveSearch) {
        if (0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg1.route) != 4 || *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg1.route, 2)) != 1) {
            return
        };
        let v0 = 0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&mut arg1.shortfalls, 2);
        if (arg0 > *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_minimum_gross(v0)) {
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_OrderbookShortfall_minimum_gross(v0) = arg0;
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_OrderbookShortfall_crossed(v0) = 0;
        };
    }

    fun m1(arg0: u128, arg1: u64, arg2: &mut AdaptiveSearch) : bool {
        let v0 = if (arg1 != 0) {
            true
        } else if (0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg2.route) != 4) {
            true
        } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg2.route, 2)) != 1) {
            true
        } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_minimum_gross(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg2.shortfalls, 2)) == 0) {
            true
        } else if (arg0 > *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_minimum_gross(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg2.shortfalls, 2))) {
            true
        } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_status(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg2.caches, 2)) != 0) {
            true
        } else {
            0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg2.caches, 2))) != 1
        };
        if (v0) {
            return false
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_crossed(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg2.shortfalls, 2)) == 1 || m2(arg2)
    }

    fun m2(arg0: &mut AdaptiveSearch) : bool {
        let v0 = if (arg0.work == 0) {
            true
        } else if (arg0.schedule.exploration_limit != 0) {
            true
        } else if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, 0)) != 2) {
            true
        } else {
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, 3)) != 0
        };
        if (v0) {
            return false
        };
        let v1 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, 0);
        let v2 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache>(&arg0.caches, 2);
        if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_cursor(v1) != 0 || 0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v1))) {
            return false
        };
        let v3 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_segments(v1), 0);
        let v4 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_prefixes(v2), 0);
        if (!0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::book_coverage_cell(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookShortfall_minimum_gross(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&arg0.shortfalls, 2)), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(v1), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_base_to_quote(v1), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookSegment_remaining_base(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_OrderbookSegment_price(v3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_status(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_liquidity(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3Prefix_liquidity_after(v4), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3Prefix_crossing_input(v4), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_V3PrefixCache_policy_output_capacity(v2), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_output_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, 2))))) {
            return false
        };
        arg0.work = arg0.work - 1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_OrderbookShortfall_crossed(0x1::vector::borrow_mut<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall>(&mut arg0.shortfalls, 2)) = 1;
        true
    }

    fun m3(arg0: &mut 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop, arg1: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>, arg2: bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::m3(arg0, arg1, arg2);
    }

    fun m5(arg0: &OptimizeState) : OptimizeResult {
        let v0 = arg0.result;
        if (arg0.has_frontier) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route)) {
                let v2 = 0x1::vector::borrow<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&arg0.route, v1);
                let v3 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_kind(v2) == 1) {
                    if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_stable_amp(v2) > 0) {
                        if ((*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_orderbook_cursor(v2) as u128) < *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_stable_amp(v2)) {
                            (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_boundary_cursor(v2) as u128) >= *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_stable_amp(v2)
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
                    v0.crossed_ticks = v0.crossed_ticks - 1;
                };
                v1 = v1 + 1;
            };
        };
        v0
    }

    fun m6(arg0: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop, arg1: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::m6(arg0, arg1)
    }

    fun meaningful_growth_decline(arg0: &ProgressiveSample, arg1: &ProgressiveSample, arg2: u64, arg3: bool) : bool {
        let v0 = if (arg0.amount == 0) {
            true
        } else if (arg1.amount <= arg0.amount) {
            true
        } else if (arg1.status != 0) {
            true
        } else {
            !progressive_better(arg0, arg1)
        };
        if (v0) {
            return false
        };
        let v1 = (0x1::u64::min(arg2, 100) as u256);
        let v2 = if (arg3) {
            2
        } else {
            0
        };
        let v3 = 0x1::u256::max(arg0.magnitude / 10000 * v1 + arg0.magnitude % 10000 * v1 / 10000, v2);
        arg0.negative && arg1.magnitude - arg0.magnitude > v3 || !arg1.negative && arg0.magnitude - arg1.magnitude > v3 || arg0.magnitude > v3 || arg1.magnitude > v3 - arg0.magnitude
    }

    public fun metastable_hop(arg0: vector<u128>, arg1: u8, arg2: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = a0(19);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v0) = arg1;
        if (arg1 != 0) {
            return v0
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v0) = *0x1::vector::borrow<u128>(&arg0, 0);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v0) = *0x1::vector::borrow<u128>(&arg0, 1);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v0) = *0x1::vector::borrow<u128>(&arg0, 2);
        let v1 = if (*0x1::vector::borrow<u128>(&arg0, 10) == 1) {
            *0x1::vector::borrow<u128>(&arg0, 3)
        } else if (arg2) {
            0x1::u128::min(*0x1::vector::borrow<u128>(&arg0, 3), 1000000000000000000)
        } else {
            0x1::u128::max(*0x1::vector::borrow<u128>(&arg0, 3), 1000000000000000000)
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_liquidity(&mut v0) = v1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_admin_fee(&mut v0) = (*0x1::vector::borrow<u128>(&arg0, 4) as u64);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_lp_fee(&mut v0) = (*0x1::vector::borrow<u128>(&arg0, 5) as u64);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v0) = 0x1::u128::pow(10, (*0x1::vector::borrow<u128>(&arg0, 8) as u8));
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v0) = 0x1::u128::pow(10, (*0x1::vector::borrow<u128>(&arg0, 9) as u8));
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v0) = arg2;
        if (!arg2) {
            let v2 = (*0x1::vector::borrow<u128>(&arg0, 2) as u256) * (*0x1::vector::borrow<u128>(&arg0, 6) as u256) / (*0x1::vector::borrow<u128>(&arg0, 7) as u256);
            if (v2 > (18446744073709551615 as u256)) {
                *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v0) = 12;
                return v0
            };
            let (v3, v4) = i9((v2 as u128), 1000000000000000000, *0x1::vector::borrow<u128>(&arg0, 3), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_stable_scale_in(&v0), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_stable_scale_out(&v0));
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_sqrt_price_x64(&mut v0) = v3;
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v0) = v4;
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
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = v5;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_output_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = 18446744073709551615;
        v0
    }

    public fun midpoint(arg0: u128, arg1: u128) : u128 {
        arg0 + (arg1 - arg0) / 2
    }

    public fun momentum_v3_current_hop(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = v3_current_hop(arg0, arg1, arg2, arg3);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_momentum_fee_round_nearest(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = true;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_output_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = 18446744073709551615;
        v0
    }

    public fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::mul_div_down(arg0, arg1, arg2)
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::mul_div_up(arg0, arg1, arg2)
    }

    public fun mul_fraction_ceil(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::mul_fraction_ceil(arg0, arg1, arg2)
    }

    public fun mul_q64_ceil(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::mul_q64_ceil(arg0, arg1)
    }

    public fun mul_ratio_down_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::mul_ratio_down_saturating(arg0, arg1, arg2)
    }

    public fun mul_ratio_up_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::mul_ratio_up_saturating(arg0, arg1, arg2)
    }

    public fun new_prefixCache(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: bool, arg10: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::new_prefixCache(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun new_shortfall(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookPrefix>, arg1: u128, arg2: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::new_shortfall(arg0, arg1, arg2)
    }

    public fun next_sqrt_price(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: u128, arg5: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::next_sqrt_price(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun next_sqrt_price_partial(arg0: u128, arg1: u128, arg2: bool, arg3: u128, arg4: bool) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::next_sqrt_price_partial(arg0, arg1, arg2, arg3, arg4)
    }

    public fun obric_virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = virtual_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg8, 1, 1, 1);
        if (arg9) {
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v0) = 5;
        };
        v0
    }

    public fun optimize(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        optimize_coefficients(arg0, arg1, arg2)
    }

    public fun optimize_coefficients(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128, arg2: u64) : OptimizeResult {
        let v0 = coefficient_state(arg0, arg1, arg2);
        let v1 = &mut v0;
        resume_coefficients(v1);
        progress_result(&v0)
    }

    public fun optimize_selected_staged_if(arg0: bool, arg1: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg2: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop>, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : OptimizeResult {
        if (!arg0 || arg4 == 0) {
            return coarse_rejection()
        };
        assert!(arg3 > 0, 6);
        let v0 = join_staged_route(arg1, arg2);
        if (route_model(&v0) != 1) {
            let v1 = k5(v0, arg3, arg4, arg5, arg7, arg8, arg9, 0, 0, true, 1, 1);
            let v2 = &mut v1;
            j2(v2, arg6);
            let v3 = &mut v1;
            adaptive_run(v3);
            return adaptive_result(v1)
        };
        let v4 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v4, 0x1::u128::min(arg3, arg4));
        let (v5, _) = a4(v0, v4, 1, arg4, 1, arg7, arg8, arg9, 0, false);
        v5
    }

    public fun orderbook_hop(arg0: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>, arg1: u64, arg2: u64, arg3: bool, arg4: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = a0(2);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_segments(&mut v0) = arg0;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_lot_size(&mut v0) = (arg1 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_min_size(&mut v0) = (arg2 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_base_to_quote(&mut v0) = arg3;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_has_more(&mut v0) = arg4;
        v0
    }

    public fun orderbook_hop_from_vectors(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>(&mut v0, orderbook_segment(*0x1::vector::borrow<u64>(&arg0, v1), *0x1::vector::borrow<u64>(&arg1, v1)));
            v1 = v1 + 1;
        };
        orderbook_hop(v0, arg2, arg3, arg4, arg5)
    }

    public fun orderbook_hop_from_vectors_with_auxiliary_fee(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = orderbook_hop_from_vectors(arg0, arg1, arg2, arg3, arg4, arg5);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_auxiliary_fee_rate(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = arg6;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_auxiliary_fee_denominator(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = arg7;
        v0
    }

    public fun orderbook_hop_from_vectors_with_input_fee(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = orderbook_hop_from_vectors(arg0, arg1, arg2, arg3, arg4, arg5);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_rate(&mut v0) = arg6;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_denominator(&mut v0) = arg7;
        v0
    }

    public fun orderbook_input_boundary(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::orderbook_input_boundary(arg0, arg1, arg2, arg3, arg4)
    }

    public fun orderbook_rate_hop(arg0: u64, arg1: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = vector[];
        let v1 = vector[];
        if (arg0 > 0) {
            0x1::vector::push_back<u64>(&mut v0, arg0);
            0x1::vector::push_back<u64>(&mut v1, 1);
        };
        orderbook_hop_from_vectors(v0, v1, 1, 1, arg1, false)
    }

    public fun orderbook_rate_hop_with_auxiliary_fee(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = orderbook_rate_hop(arg0, arg1);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_auxiliary_fee_rate(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = arg2;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_auxiliary_fee_denominator(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = arg3;
        v0
    }

    public fun orderbook_rate_hop_with_input_fee(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = vector[];
        let v1 = vector[];
        if (arg0 > 0) {
            0x1::vector::push_back<u64>(&mut v0, arg0);
            0x1::vector::push_back<u64>(&mut v1, 1);
        };
        orderbook_hop_from_vectors_with_input_fee(v0, v1, 1, 1, arg1, false, arg2, arg3)
    }

    public fun orderbook_segment(arg0: u64, arg1: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::orderbook_segment(arg0, arg1)
    }

    public fun orderbook_segment_base_consumed(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>, arg6: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::orderbook_segment_base_consumed(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun orderbook_segment_output_capacity(arg0: bool, arg1: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::orderbook_segment_output_capacity(arg0, arg1)
    }

    public fun orderbook_stage_from_vectors_with_auxiliary_fee_if(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop {
        if (!arg8) {
            return reuse_current_stage()
        };
        replacement_stage(orderbook_hop_from_vectors_with_auxiliary_fee(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    public fun orderbook_stage_from_vectors_with_input_fee_if(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop {
        if (!arg8) {
            return reuse_current_stage()
        };
        replacement_stage(orderbook_hop_from_vectors_with_input_fee(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    public fun orderbook_terminal(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::orderbook_terminal(arg0, arg1, arg2, arg3)
    }

    public fun passes_bolt_coarse_gate(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u256, arg2: bool) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::passes_bolt_coarse_gate(arg0, arg1, arg2)
    }

    public fun passes_bounded_profit_gate(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u128) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::passes_bounded_profit_gate(arg0, arg1)
    }

    public fun passes_marginal_gate(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u256) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::passes_marginal_gate(arg0, arg1)
    }

    public fun passes_state_gate(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : bool {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::passes_state_gate(arg0)
    }

    public fun pqf_hop_from_prepared(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: bool, arg4: bool, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = if (0x1::vector::length<u128>(&arg0) == 0x1::vector::length<u128>(&arg1)) {
            if (0x1::vector::length<u128>(&arg0) == 0x1::vector::length<u128>(&arg2)) {
                arg8 <= 100
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = a0(3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg0)) {
            let v3 = dlmm_segment(*0x1::vector::borrow<u128>(&arg0, v2), *0x1::vector::borrow<u128>(&arg1, v2), *0x1::vector::borrow<u128>(&arg2, v2), 0, arg3);
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_LinearSegment_price_scale(&mut v3) = 1000000000000000000;
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_linear_segments(&mut v1), v3);
            v2 = v2 + 1;
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_input_minimum(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v1)) = arg5;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v1)) = arg6;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_output_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v1)) = arg7;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_rate(&mut v1) = arg8;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_denominator(&mut v1) = 10000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_linear_rate_inversion(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v1)) = arg4;
        let v4 = if (arg9) {
            0
        } else {
            2
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v1) = v4;
        v1
    }

    public fun prefix_upper_bound_virtual(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3Prefix>, arg1: u64, arg2: u128, arg3: &mut u64) : (u64, u8) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::prefix_upper_bound_virtual(arg0, arg1, arg2, arg3)
    }

    public fun prepare_cpmm(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::PreparedCpmm {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::prepare_cpmm(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun probe_loaded_mk_reversal(arg0: &mut AdaptiveSearch) {
        if (arg0.schedule.remote_done || arg0.schedule.tolerance_bps == 0) {
            return
        };
        let v0 = 0x1::vector::borrow_mut<OptimizeState>(&mut arg0.mk, 0);
        let v1 = if (!v0.finished) {
            true
        } else if (v0.monotone) {
            true
        } else if (!v0.has_linear) {
            true
        } else if (0x1::vector::is_empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&v0.validation_route)) {
            true
        } else if (arg0.evaluations - 0x1::u64::min(v0.result.evaluations, arg0.evaluations) < 2) {
            true
        } else if (v0.work < 16) {
            true
        } else {
            v0.result.status != 0 && v0.result.status != 1
        };
        if (v1) {
            return
        };
        arg0.schedule.remote_done = true;
        let v2 = 0x1::u64::min(v0.work / 4, 1024);
        let v3 = v2;
        let v4 = &mut v3;
        let v5 = loaded_reversal_point(&v0.route, v0.cursor, v0.max_amount_in, v4);
        let v6 = if (v5 > v0.cursor) {
            if (v5 > v0.result.amount_in) {
                v3 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v6) {
            let (v7, v8, v9) = d3(&v0.validation_route, v3);
            let v10 = v7;
            let v11 = v3;
            v3 = v11 - v9;
            if (v8 == 0 && v3 > 0) {
                v0.result.evaluations = v0.result.evaluations + 1;
                let v12 = &mut v10;
                let v13 = &mut v3;
                let (v14, v15, v16, v17) = d5(&v0.validation_route, v12, v5, v13);
                v0.result.crossed_ticks = v0.result.crossed_ticks + v16;
                v0.result.crossed_orders = v0.result.crossed_orders + v17;
                if (v15 == 0) {
                    let v18 = &mut v0.result;
                    h2(&v0.validation_route, v5, v14, v18);
                };
                if (v0.result.found) {
                    v0.result.coarse_rejected = false;
                };
                v0.result.complete = false;
            };
        };
        v0.work = v0.work - v2 - v3;
    }

    public fun progress_result(arg0: &OptimizeState) : OptimizeResult {
        c0(arg0, 16384, 13, false)
    }

    public fun progressive_better(arg0: &ProgressiveSample, arg1: &ProgressiveSample) : bool {
        if (arg0.negative != arg1.negative) {
            return !arg0.negative
        };
        arg0.negative && arg0.magnitude < arg1.magnitude || arg0.magnitude > arg1.magnitude
    }

    public fun q64() : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::q64()
    }

    public fun quote_bucket_psm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_bucket_psm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun quote_capped_ratio_hop(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_capped_ratio_hop(arg0, arg1, arg2, arg3, arg4)
    }

    public fun quote_cpmm_cached_with_slope(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : (u128, u256) {
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::quote_cpmm_cached_with_slope(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun quote_hasui_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_hasui_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun quote_hawal_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: bool, arg7: u128, arg8: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_hawal_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun quote_kriya_v2_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: u128, arg10: u128, arg11: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_kriya_v2_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun quote_linear_hop_bounded_impl(arg0: u64, arg1: bool, arg2: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>, arg3: u128, arg4: &mut u64) : (u128, u8, u64, u128) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_linear_hop_bounded_impl(arg0, arg1, arg2, arg3, arg4)
    }

    public fun quote_linear_segment_value(arg0: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment, arg1: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_linear_segment_value(arg0, arg1)
    }

    public fun quote_linear_with_shortfall(arg0: u64, arg1: bool, arg2: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::LinearSegment>, arg3: u128, arg4: &mut u64, arg5: &mut 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_linear_with_shortfall(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun quote_lst_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_lst_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun quote_orderbook_hop_bounded(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_orderbook_hop_bounded(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun quote_orderbook_prefix(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>, arg8: u128, arg9: &mut u64, arg10: &mut vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookPrefix>) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_orderbook_prefix(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun quote_orderbook_segment(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>, arg6: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_orderbook_segment(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun quote_orderbook_segment_and_consumed_base(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>, arg6: u128) : (u128, u128) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_orderbook_segment_and_consumed_base(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun quote_orderbook_with_shortfall(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookSegment>, arg8: u128, arg9: &mut u64, arg10: &mut 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::OrderbookShortfall, arg11: bool) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_orderbook_with_shortfall(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun quote_prepared_cpmm(arg0: &0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::PreparedCpmm, arg1: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_prepared_cpmm(arg0, arg1)
    }

    public fun quote_steamm_cpmm_hop(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_steamm_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun quote_steamm_omm_hop(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128, arg8: u64, arg9: u128, arg10: u128, arg11: u128, arg12: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_steamm_omm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun quote_v3_cached(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>, arg1: &mut 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache, arg2: u128, arg3: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_v3_cached(arg0, arg1, arg2, arg3)
    }

    public fun quote_v3_cached_with_slope(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>, arg1: &mut 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache, arg2: u128, arg3: &mut u64) : (u128, u256, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::quote_v3_cached_with_slope(arg0, arg1, arg2, arg3)
    }

    public fun quote_ve33_stable_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_ve33_stable_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun quote_virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_virtual_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun reader_price_square_limit(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>, arg1: u64) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::reader_price_square_limit(arg0, arg1)
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

    public fun refinement_point(arg0: &OptimizeResult, arg1: &vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64) : u128 {
        let (v0, _) = 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::bp(arg0.found, arg0.amount_in, arg1, arg2, arg3, arg4, arg5);
        v0
    }

    public fun replacement_stage(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop {
        let v0 = 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>();
        0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>(&mut v0, arg0);
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::new_StagedHop(2, 0, 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(), v0)
    }

    public fun reserve_prefix_window(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>, arg1: &mut 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::V3PrefixCache, arg2: u64, arg3: u64) : (u64, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::reserve_prefix_window(arg0, arg1, arg2, arg3)
    }

    public fun resume_coefficients(arg0: &mut OptimizeState) {
        b9(arg0, (18446744073709551615 as u64));
    }

    public fun reuse_current_stage() : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::new_StagedHop(0, 0, 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(), 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>())
    }

    public fun reuse_current_stage_if(arg0: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop {
        reuse_current_stage()
    }

    public fun round_down_to_quantum(arg0: u128, arg1: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::round_down_to_quantum(arg0, arg1)
    }

    public fun round_up_to_quantum(arg0: u128, arg1: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::round_up_to_quantum(arg0, arg1)
    }

    public fun route_model(arg0: &vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>) : u8 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::route_model(arg0)
    }

    public fun saturating_add(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::saturating_add(arg0, arg1)
    }

    public fun saturating_mul(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::saturating_mul(arg0, arg1)
    }

    public fun search_rejection_code(arg0: u8) : u64 {
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::search_rejection_code(arg0)
    }

    public fun sqrt_down(arg0: u256) : u256 {
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::sqrt_down(arg0)
    }

    public fun stable_abs_diff(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::stable_abs_diff(arg0, arg1)
    }

    public fun stable_compute_d(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::stable_compute_d(arg0, arg1, arg2, arg3)
    }

    public fun stable_compute_d_with_limit(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64, arg4: u64) : (u256, u8) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::stable_compute_d_with_limit(arg0, arg1, arg2, arg3, arg4)
    }

    public fun stable_compute_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::stable_compute_y(arg0, arg1, arg2, arg3)
    }

    public fun stable_fee_remainder(arg0: u128, arg1: u64) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::stable_fee_remainder(arg0, arg1)
    }

    public fun status(arg0: &OptimizeResult) : u8 {
        arg0.status
    }

    public fun steamm_btoken_burn_amount(arg0: u256, arg1: u64) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_btoken_burn_amount(arg0, arg1)
    }

    public fun steamm_btoken_supplies(arg0: u128) : (u64, u64) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_btoken_supplies(arg0)
    }

    public fun steamm_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: u64, arg10: bool, arg11: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
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
        let v5 = a0(14);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_rate(&mut v5) = arg3;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_denominator(&mut v5) = 10000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v5) = v1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v5) = v3;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_sqrt_price_x64(&mut v5) = (arg9 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_liquidity(&mut v5) = (arg1 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v5) = arg10;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v5) = (arg5 as u128) << 64 | (arg8 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v5) = arg4;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v5) = arg7;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_lp_fee(&mut v5) = arg6;
        let v6 = if (v4) {
            0
        } else {
            5
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v5) = v6;
        v5
    }

    public fun steamm_decimal_div(arg0: u256, arg1: u256) : (u256, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_decimal_div(arg0, arg1)
    }

    public fun steamm_decimal_mul(arg0: u256, arg1: u256) : (u256, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_decimal_mul(arg0, arg1)
    }

    public fun steamm_effective_amp(arg0: u64, arg1: bool, arg2: u256, arg3: u256, arg4: u128, arg5: u128, arg6: u8, arg7: u8) : (u64, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_effective_amp(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun steamm_omm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u8, arg10: u8, arg11: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = a0(15);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_rate(&mut v0) = arg1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_denominator(&mut v0) = 10000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v0) = arg7;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v0) = (arg0 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_sqrt_price_x64(&mut v0) = (arg6 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_liquidity(&mut v0) = arg8;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v0) = arg9 >= arg10;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v0) = (arg3 as u128) << 64 | (arg5 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v0) = arg2;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v0) = arg4;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_admin_fee(&mut v0) = (arg9 as u64);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_lp_fee(&mut v0) = (arg10 as u64);
        let v1 = if (0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::steamm_omm_state_ok(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)) {
            0
        } else {
            5
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v0) = v1;
        v0
    }

    public fun steamm_omm_v2_legacy_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: bool, arg15: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = arg15 && (arg12 == 50 || arg12 == 100);
        steamm_omm_v2_legacy_hop_with_migration(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v0, true)
    }

    public fun steamm_omm_v2_legacy_hop_with_migration(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: bool, arg15: bool, arg16: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = if (arg2 >= arg13) {
            arg2
        } else {
            arg13
        };
        let v1 = a0(16);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_rate(&mut v1) = v0;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_denominator(&mut v1) = 10000;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v1) = (arg0 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v1) = (arg1 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_sqrt_price_x64(&mut v1) = (arg7 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_liquidity(&mut v1) = arg8;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v1) = arg14;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_orderbook_lot_size(&mut v1) = arg9;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v1) = (arg4 as u128) << 64 | (arg6 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v1) = arg3;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v1) = arg5;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_admin_fee(&mut v1) = (arg10 as u64);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_lp_fee(&mut v1) = (arg11 as u64);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_th_fee(&mut v1) = arg12;
        let v2 = if (0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::steamm_omm_v2_state_ok(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15)) {
            0
        } else {
            5
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v1) = v2;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_omm_update_flag(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v1)) = arg16;
        v1
    }

    public fun steamm_omm_v2_linear_btoken_output(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool, arg5: u256, arg6: u256, arg7: u256) : (u256, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_omm_v2_linear_btoken_output(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun steamm_q_compute_f(arg0: u128, arg1: u128, arg2: u128) : (u128, bool, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_q_compute_f(arg0, arg1, arg2)
    }

    public fun steamm_q_compute_f_prime(arg0: u128, arg1: u128, arg2: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_q_compute_f_prime(arg0, arg1, arg2)
    }

    public fun steamm_q_div(arg0: u128, arg1: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_q_div(arg0, arg1)
    }

    public fun steamm_q_floor_log2(arg0: u128) : u8 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_q_floor_log2(arg0)
    }

    public fun steamm_q_from_decimal(arg0: u256) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_q_from_decimal(arg0)
    }

    public fun steamm_q_from_integer(arg0: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_q_from_integer(arg0)
    }

    public fun steamm_q_ln_plus_64ln2(arg0: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_q_ln_plus_64ln2(arg0)
    }

    public fun steamm_q_mul(arg0: u128, arg1: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_q_mul(arg0, arg1)
    }

    public fun steamm_q_newton(arg0: u128, arg1: u128) : (u128, bool) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::steamm_q_newton(arg0, arg1)
    }

    public fun suiswap_stable_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: bool, arg11: u8) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = if (arg10) {
            200
        } else {
            201
        };
        let v1 = a0(5);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v1) = (arg0 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v1) = (arg1 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v1) = (arg4 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v1) = (arg2 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v1) = (arg3 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_admin_fee(&mut v1) = arg5;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_lp_fee(&mut v1) = arg6;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_th_fee(&mut v1) = arg7;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_fee_on_input(&mut v1) = arg9 == v0;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v1) = 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::suiswap_stable_state_status(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
        v1
    }

    public fun tick_boundary(arg0: u128, arg1: u128, arg2: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::tick_boundary(arg0, arg1, arg2)
    }

    public fun to_u128(arg0: u256) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::to_u128(arg0)
    }

    public fun v2_curve_output(arg0: u64, arg1: u64, arg2: bool, arg3: u128, arg4: u128, arg5: u128) : u128 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::v2_curve_output(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun v2_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        v2_hop_with_gate(arg0, arg1, arg2, arg3, true)
    }

    public fun v2_hop_split_fee(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = a0(0);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_rate(&mut v0) = arg2;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_denominator(&mut v0) = arg3;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_rate(&mut v0) = arg4;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_output_fee_denominator(&mut v0) = arg5;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v0) = arg0;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v0) = arg1;
        v0
    }

    public fun v2_hop_with_gate(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
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
        let v2 = a0(0);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_rate(&mut v2) = arg2;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_denominator(&mut v2) = arg3;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v2) = arg0;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v2) = arg1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v2) = v0;
        v2
    }

    public fun v3_current_hop(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = a0(4);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_rate(&mut v0) = arg1;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_denominator(&mut v0) = arg2;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_sqrt_price_x64(&mut v0) = arg0;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v0) = arg3;
        v0
    }

    public fun v3_frontier_stage_if(arg0: u128, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<bool>, arg4: u128, arg5: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop {
        if (!arg5) {
            return reuse_current_stage()
        };
        assert!(0x1::vector::length<u128>(&arg1) == 0x1::vector::length<u128>(&arg2) && 0x1::vector::length<u128>(&arg1) == 0x1::vector::length<bool>(&arg3), 3);
        let v0 = 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg1)) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(&mut v0, tick_boundary(*0x1::vector::borrow<u128>(&arg1, v1), *0x1::vector::borrow<u128>(&arg2, v1), *0x1::vector::borrow<bool>(&arg3, v1)));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::is_empty<u128>(&arg1) || arg4 != *0x1::vector::borrow<u128>(&arg1, 0x1::vector::length<u128>(&arg1) - 1);
        if (v2) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(&mut v0, tick_boundary(arg4, 0, false));
        };
        let v3 = if (v2) {
            4
        } else {
            1
        };
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::new_StagedHop(v3, arg0, v0, 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>())
    }

    public fun v3_window_stage(arg0: u128, arg1: vector<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::new_StagedHop(1, arg0, arg1, 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop>())
    }

    public fun v3_window_stage_from_vectors_if(arg0: u128, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<bool>, arg4: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::StagedHop {
        if (!arg4) {
            return reuse_current_stage()
        };
        let v0 = 0x1::vector::length<u128>(&arg1);
        assert!(v0 > 0, 3);
        assert!(0x1::vector::length<u128>(&arg2) == v0 && 0x1::vector::length<bool>(&arg3) == v0, 3);
        let v1 = 0x1::vector::empty<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::TickBoundary>(&mut v1, tick_boundary(*0x1::vector::borrow<u128>(&arg1, v2), *0x1::vector::borrow<u128>(&arg2, v2), *0x1::vector::borrow<bool>(&arg3, v2)));
            v2 = v2 + 1;
        };
        v3_window_stage(arg0, v1)
    }

    public fun ve33_get_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::ve33_get_y(arg0, arg1, arg2, arg3)
    }

    public fun ve33_invariant(arg0: u256, arg1: u256) : u256 {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::ve33_invariant(arg0, arg1)
    }

    public fun ve33_stable_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = a0(6);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_rate(&mut v0) = arg5;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_denominator(&mut v0) = arg6;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v0) = (arg0 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v0) = (arg1 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v0) = (arg4 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v0) = (arg2 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v0) = (arg3 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_fee_on_input(&mut v0) = true;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v0) = 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::ve33_stable_state_status(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        v0
    }

    public fun virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = a0(7);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_rate(&mut v0) = arg7;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_fee_denominator(&mut v0) = 1000000;
        let v1 = if (arg8) {
            (arg0 as u128)
        } else {
            (arg1 as u128)
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_in(&mut v0) = v1;
        let v2 = if (arg8) {
            (arg1 as u128)
        } else {
            (arg0 as u128)
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_reserve_out(&mut v0) = v2;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_sqrt_price_x64(&mut v0) = (arg4 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_liquidity(&mut v0) = (arg5 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_zero_for_one(&mut v0) = arg8;
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_amp(&mut v0) = (arg6 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_in(&mut v0) = (arg2 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_stable_scale_out(&mut v0) = (arg3 as u128);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut v0) = 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::virtual_cpmm_state_status(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11, arg12);
        v0
    }

    public fun virtual_cpmm_state_status(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64) : u8 {
        0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric::virtual_cpmm_state_status(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun with_lst_redemption_bounds(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        if (!*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_zero_for_one(&arg0)) {
            let v0 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_out(&arg0) > 1000) {
                *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_out(&arg0) - 1000
            } else {
                0
            };
            let v1 = if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_out(&arg0) == 0) {
                0
            } else {
                mul_div_down(v0, *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_in(&arg0), *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_out(&arg0))
            };
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut arg0)) = 0x1::u128::min(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(&arg0)), v1);
        };
        arg0
    }

    public fun with_pool_balances(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop, arg1: u64, arg2: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut arg0)) = 0x1::u128::min(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(&arg0)), 18446744073709551615 - (arg1 as u128));
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_output_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut arg0)) = 0x1::u128::min(*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_ExecutionPolicy_output_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_policy(&arg0)), (arg2 as u128));
        arg0
    }

    public fun with_suidex_execution_bounds(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_in(&arg0);
        let v1 = *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_reserve_out(&arg0);
        let v2 = *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_denominator(&arg0);
        let v3 = 1000;
        if (*0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_state_status(&arg0) != 0) {
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
            *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_state_status(&mut arg0) = 2;
            return arg0
        };
        let v5 = div_ceil(((v1 - v3 + 1) as u256) * (v0 as u256) * (v2 as u256), ((v3 - 1) as u256) * ((v2 - *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_Hop_fee_rate(&arg0)) as u256));
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_input_minimum(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut arg0)) = 1000;
        let v6 = if (v5 > (18446744073709551615 as u256)) {
            (18446744073709551615 as u128)
        } else {
            (v5 as u128) - 1
        };
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_input_capacity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut arg0)) = 0x1::u128::min(v6, (18446744073709551615 as u128) - v0);
        arg0
    }

    public fun with_turbos_pool_balances(arg0: 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop, arg1: u64, arg2: u64) : 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::Hop {
        let v0 = with_pool_balances(arg0, arg1, arg2);
        *0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_ExecutionPolicy_stop_at_zero_liquidity(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::optimizer::borrow_mut_Hop_policy(&mut v0)) = true;
        v0
    }

    // decompiled from Move bytecode v7
}

