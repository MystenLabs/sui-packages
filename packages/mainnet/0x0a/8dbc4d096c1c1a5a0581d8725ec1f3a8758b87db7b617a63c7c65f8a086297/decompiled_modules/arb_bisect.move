module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_bisect {
    struct BisectCursor {
        tol: u64,
        grow_left: u8,
        rounds_left: u8,
        rounds_done: u8,
        mode: u8,
        p0: u64,
        p1: u64,
        p2: u64,
        s0: u128,
        s1: u128,
        s2: u128,
        anchor: u64,
        anchor_score: u128,
        has_anchor: bool,
        bracket_lo: u64,
        bracket_hi: u64,
        bracket_lo_score: u128,
        bracket_hi_score: u128,
        best_x: u64,
        best_out: u64,
        best_score: u128,
        evals: u16,
    }

    struct BisectDecision has copy, drop {
        tag: u128,
        sender: address,
        armed: bool,
        x: u64,
        expected_out: u64,
        required_out: u64,
        profit: u64,
        bracket_lo: u64,
        bracket_hi: u64,
        mode: u8,
        rounds: u8,
        evals: u16,
        hops: u8,
    }

    public fun advance(arg0: &mut 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::Session, arg1: &mut BisectCursor, arg2: &0x2::clock::Clock) {
        assert!(arg1.rounds_left > 0, 942);
        arg1.rounds_left = arg1.rounds_left - 1;
        consume_round(arg0, arg1, arg2);
        plan_next(arg0, arg1);
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::set_probes(arg0, arg1.p0, arg1.p1, arg1.p2);
    }

    fun best_index(arg0: &vector<u128>) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v1 < 0x1::vector::length<u128>(arg0)) {
            v1 = v1 + 1;
        };
        v0
    }

    fun consume_round(arg0: &mut 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::Session, arg1: &mut BisectCursor, arg2: &0x2::clock::Clock) {
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::assert_round_complete(arg0, arg2);
        let v0 = 0;
        while (v0 < 3) {
            let v1 = probe_at(arg1, v0);
            let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::probe_output(arg0, v0);
            let v3 = score(v2, v1, fee_for(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::flash_fee(arg0), v1, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::notional(arg0)));
            if (v0 == 0) {
                arg1.s0 = v3;
            } else if (v0 == 1) {
                arg1.s1 = v3;
            } else {
                arg1.s2 = v3;
            };
            if (arg1.evals == 0 || v3 > arg1.best_score) {
                arg1.best_x = v1;
                arg1.best_out = v2;
                arg1.best_score = v3;
            };
            arg1.evals = arg1.evals + 1;
            v0 = v0 + 1;
        };
        arg1.rounds_done = arg1.rounds_done + 1;
    }

    public fun cursor_bracket(arg0: &BisectCursor) : (u64, u64) {
        (arg0.bracket_lo, arg0.bracket_hi)
    }

    public fun cursor_probes(arg0: &BisectCursor) : (u64, u64, u64) {
        (arg0.p0, arg0.p1, arg0.p2)
    }

    fun fee_for(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg2 > 0, 940);
        let v0 = ((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 943);
        (v0 as u64)
    }

    fun grow_step(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1 / 2) {
            arg1
        } else {
            arg0 * 2
        }
    }

    fun grow_triple(arg0: u64, arg1: u64) : (u64, u64, u64) {
        let v0 = if (arg0 > arg1) {
            arg1
        } else {
            arg0
        };
        let v1 = grow_step(v0, arg1);
        (v0, v1, grow_step(v1, arg1))
    }

    fun plan_after_bisect(arg0: &mut BisectCursor) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0.bracket_lo);
        0x1::vector::push_back<u64>(v1, arg0.p0);
        0x1::vector::push_back<u64>(v1, arg0.p1);
        0x1::vector::push_back<u64>(v1, arg0.p2);
        0x1::vector::push_back<u64>(v1, arg0.bracket_hi);
        let v2 = 0x1::vector::empty<u128>();
        let v3 = &mut v2;
        0x1::vector::push_back<u128>(v3, arg0.bracket_lo_score);
        0x1::vector::push_back<u128>(v3, arg0.s0);
        0x1::vector::push_back<u128>(v3, arg0.s1);
        0x1::vector::push_back<u128>(v3, arg0.s2);
        0x1::vector::push_back<u128>(v3, arg0.bracket_hi_score);
        set_bracket(arg0, &v0, &v2, best_index(&v2));
        plan_bisect_probes(arg0);
    }

    fun plan_after_grow(arg0: u64, arg1: &mut BisectCursor) {
        let v0 = vector[];
        let v1 = vector[];
        if (arg1.has_anchor) {
            0x1::vector::push_back<u64>(&mut v0, arg1.anchor);
            0x1::vector::push_back<u128>(&mut v1, arg1.anchor_score);
        };
        0x1::vector::push_back<u64>(&mut v0, arg1.p0);
        0x1::vector::push_back<u128>(&mut v1, arg1.s0);
        0x1::vector::push_back<u64>(&mut v0, arg1.p1);
        0x1::vector::push_back<u128>(&mut v1, arg1.s1);
        0x1::vector::push_back<u64>(&mut v0, arg1.p2);
        0x1::vector::push_back<u128>(&mut v1, arg1.s2);
        let v2 = best_index(&v1);
        let v3 = if (v2 == 0x1::vector::length<u64>(&v0) - 1) {
            if (arg1.p2 < arg0) {
                arg1.grow_left > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            arg1.grow_left = arg1.grow_left - 1;
            arg1.anchor = arg1.p2;
            arg1.anchor_score = arg1.s2;
            arg1.has_anchor = true;
            let (v4, v5, v6) = grow_triple(grow_step(arg1.p2, arg0), arg0);
            arg1.p0 = v4;
            arg1.p1 = v5;
            arg1.p2 = v6;
            return
        };
        set_bracket(arg1, &v0, &v1, v2);
        arg1.mode = 1;
        plan_bisect_probes(arg1);
    }

    fun plan_bisect_probes(arg0: &mut BisectCursor) {
        let v0 = arg0.bracket_hi - arg0.bracket_lo;
        if (v0 <= arg0.tol) {
            arg0.mode = 2;
            return
        };
        let v1 = v0 / 4;
        if (v1 == 0) {
            arg0.mode = 2;
            return
        };
        arg0.p0 = arg0.bracket_lo + v1;
        arg0.p1 = arg0.bracket_lo + 2 * v1;
        arg0.p2 = arg0.bracket_lo + 3 * v1;
    }

    fun plan_next(arg0: &0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::Session, arg1: &mut BisectCursor) {
        if (arg1.mode == 2) {
            return
        };
        if (arg1.mode == 0) {
            plan_after_grow(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::notional(arg0), arg1);
        } else {
            plan_after_bisect(arg1);
        };
    }

    fun probe_at(arg0: &BisectCursor, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0.p0
        } else if (arg1 == 1) {
            arg0.p1
        } else {
            arg0.p2
        }
    }

    fun required_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128) + (arg2 as u128);
        if (v0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v0 as u64)
        }
    }

    fun score(arg0: u64, arg1: u64, arg2: u64) : u128 {
        73786976294838206464 + (arg0 as u128) - (arg1 as u128) - (arg2 as u128)
    }

    public fun search_bisect(arg0: &mut 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::Session, arg1: BisectCursor, arg2: &0x2::clock::Clock) {
        let v0 = &mut arg1;
        consume_round(arg0, v0, arg2);
        let v1 = required_out(arg1.best_x, fee_for(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::flash_fee(arg0), arg1.best_x, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::notional(arg0)), 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::min_profit(arg0));
        let v2 = arg1.best_score >= 73786976294838206464 + (0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::min_profit(arg0) as u128);
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::settle_probe_search(arg0, v2, arg1.best_x, arg1.best_out);
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::emit_search_decision(arg0, v2, arg1.best_out, v1);
        let v3 = if (arg1.best_score > 73786976294838206464) {
            ((arg1.best_score - 73786976294838206464) as u64)
        } else {
            0
        };
        let v4 = BisectDecision{
            tag          : 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::tag(arg0),
            sender       : 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::sender(arg0),
            armed        : v2,
            x            : arg1.best_x,
            expected_out : arg1.best_out,
            required_out : v1,
            profit       : v3,
            bracket_lo   : arg1.bracket_lo,
            bracket_hi   : arg1.bracket_hi,
            mode         : arg1.mode,
            rounds       : arg1.rounds_done,
            evals        : arg1.evals,
            hops         : 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::hops(arg0),
        };
        0x2::event::emit<BisectDecision>(v4);
        let BisectCursor {
            tol              : _,
            grow_left        : _,
            rounds_left      : _,
            rounds_done      : _,
            mode             : _,
            p0               : _,
            p1               : _,
            p2               : _,
            s0               : _,
            s1               : _,
            s2               : _,
            anchor           : _,
            anchor_score     : _,
            has_anchor       : _,
            bracket_lo       : _,
            bracket_hi       : _,
            bracket_lo_score : _,
            bracket_hi_score : _,
            best_x           : _,
            best_out         : _,
            best_score       : _,
            evals            : _,
        } = arg1;
    }

    fun set_bracket(arg0: &mut BisectCursor, arg1: &vector<u64>, arg2: &vector<u128>, arg3: u64) {
        let v0 = 0x1::vector::length<u64>(arg1);
        let v1 = if (arg3 == 0) {
            0
        } else {
            arg3 - 1
        };
        let v2 = if (arg3 + 1 < v0) {
            arg3 + 1
        } else {
            v0 - 1
        };
        arg0.bracket_lo = *0x1::vector::borrow<u64>(arg1, v1);
        arg0.bracket_lo_score = *0x1::vector::borrow<u128>(arg2, v1);
        arg0.bracket_hi = *0x1::vector::borrow<u64>(arg1, v2);
        arg0.bracket_hi_score = *0x1::vector::borrow<u128>(arg2, v2);
    }

    public fun start_bisect<T0>(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::Session, BisectCursor) {
        assert!(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::ladder_len() == 3, 941);
        assert!(arg1 > 0 && arg1 <= arg2, 940);
        assert!(arg4 >= 1, 941);
        let v0 = (arg4 as u64) + (arg5 as u64);
        assert!(v0 >= 1 && v0 <= 12, 941);
        let (v1, v2, v3) = grow_triple(arg1, arg2);
        let v4 = BisectCursor{
            tol              : arg3,
            grow_left        : arg4 - 1,
            rounds_left      : ((v0 - 1) as u8),
            rounds_done      : 0,
            mode             : 0,
            p0               : v1,
            p1               : v2,
            p2               : v3,
            s0               : 0,
            s1               : 0,
            s2               : 0,
            anchor           : 0,
            anchor_score     : 0,
            has_anchor       : false,
            bracket_lo       : 0,
            bracket_hi       : 0,
            bracket_lo_score : 0,
            bracket_hi_score : 0,
            best_x           : 0,
            best_out         : 0,
            best_score       : 0,
            evals            : 0,
        };
        (0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session::new_probe_session<T0>(arg0, arg2, v1, v2, v3, arg6, arg7, arg8, arg9, arg10), v4)
    }

    // decompiled from Move bytecode v7
}

