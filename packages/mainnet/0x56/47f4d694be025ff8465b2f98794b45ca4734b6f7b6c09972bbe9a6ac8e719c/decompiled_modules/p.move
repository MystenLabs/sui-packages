module 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::p {
    struct P {
        ladder: vector<u64>,
        rung: u64,
        carry: u64,
        scratch: vector<u64>,
        best_in: u64,
        best_out: u64,
        best_hops: vector<u64>,
        decided: bool,
        step: u8,
        min_profit: u64,
        deadline_ms: u64,
        tol_bp: u64,
        mode: u8,
        blo: u64,
        bhi: u64,
        bx: u64,
        bfx: u64,
        pm: u64,
    }

    public fun aq(arg0: P) {
        let P {
            ladder      : _,
            rung        : _,
            carry       : _,
            scratch     : _,
            best_in     : _,
            best_out    : _,
            best_hops   : _,
            decided     : v7,
            step        : _,
            min_profit  : _,
            deadline_ms : _,
            tol_bp      : _,
            mode        : _,
            blo         : _,
            bhi         : _,
            bx          : _,
            bfx         : _,
            pm          : _,
        } = arg0;
        assert!(!v7, 34);
    }

    public fun av(arg0: &mut P) {
        assert!(!arg0.decided, 34);
        if (arg0.mode == 1) {
            av_bracket(arg0);
            return
        };
        if (arg0.rung >= 0x1::vector::length<u64>(&arg0.ladder)) {
            return
        };
        let v0 = *0x1::vector::borrow<u64>(&arg0.ladder, arg0.rung);
        let v1 = arg0.carry;
        if (arg0.best_in == 0 || 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::sc(v0, v1) > 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::sc(arg0.best_in, arg0.best_out)) {
            arg0.best_in = v0;
            arg0.best_out = v1;
            arg0.best_hops = arg0.scratch;
        };
        arg0.rung = arg0.rung + 1;
        arg0.scratch = vector[];
        let v2 = if (arg0.rung < 0x1::vector::length<u64>(&arg0.ladder)) {
            *0x1::vector::borrow<u64>(&arg0.ladder, arg0.rung)
        } else {
            0
        };
        arg0.carry = v2;
    }

    fun av_bracket(arg0: &mut P) {
        let v0 = arg0.pm;
        let v1 = arg0.carry;
        if (arg0.best_in == 0 || 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::sc(v0, v1) > 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::sc(arg0.best_in, arg0.best_out)) {
            arg0.best_in = v0;
            arg0.best_out = v1;
            arg0.best_hops = arg0.scratch;
        };
        if (arg0.bfx == 0 && arg0.bx == v0) {
            arg0.bfx = v1;
        } else if (0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::sc(v0, v1) > 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::sc(arg0.bx, arg0.bfx)) {
            if (v0 > arg0.bx) {
                arg0.blo = arg0.bx;
            } else {
                arg0.bhi = arg0.bx;
            };
            arg0.bx = v0;
            arg0.bfx = v1;
        } else if (v0 > arg0.bx) {
            arg0.bhi = v0;
        } else {
            arg0.blo = v0;
        };
        arg0.rung = arg0.rung + 1;
        arg0.scratch = vector[];
        let v2 = if (arg0.bhi <= arg0.blo + 1) {
            0
        } else if (arg0.bhi / arg0.bx >= arg0.bx / arg0.blo) {
            gm(arg0.bx, arg0.bhi)
        } else {
            gm(arg0.blo, arg0.bx)
        };
        let v3 = if (v2 == 0 || v2 == arg0.bx) {
            arg0.bx
        } else {
            v2
        };
        arg0.pm = v3;
        arg0.carry = arg0.pm;
    }

    public fun bk(arg0: &P) : (u64, u64) {
        (arg0.blo, arg0.bhi)
    }

    public fun cy(arg0: &P) : u64 {
        arg0.carry
    }

    public fun dc(arg0: &mut P, arg1: &0x2::clock::Clock) {
        assert!(!arg0.decided, 34);
        0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::g::bf(arg1, arg0.deadline_ms);
        assert!(arg0.best_in > 0, 20);
        assert!(arg0.best_out > arg0.best_in, 20);
        0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::g::mn(arg0.best_out - arg0.best_in, arg0.min_profit);
        arg0.decided = true;
        arg0.step = 0;
    }

    public fun eo(arg0: &P, arg1: u8) : u64 {
        assert!(arg0.decided, 34);
        let v0 = (arg1 as u64);
        assert!(v0 < 0x1::vector::length<u64>(&arg0.best_hops), 36);
        *0x1::vector::borrow<u64>(&arg0.best_hops, v0)
    }

    public fun fd(arg0: &mut P, arg1: u64) {
        assert!(!arg0.decided, 34);
        arg0.carry = arg1;
        0x1::vector::push_back<u64>(&mut arg0.scratch, arg1);
    }

    public fun fi<T0>(arg0: P, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let P {
            ladder      : v0,
            rung        : _,
            carry       : _,
            scratch     : _,
            best_in     : v4,
            best_out    : v5,
            best_hops   : _,
            decided     : v7,
            step        : _,
            min_profit  : v9,
            deadline_ms : v10,
            tol_bp      : _,
            mode        : _,
            blo         : _,
            bhi         : _,
            bx          : _,
            bfx         : _,
            pm          : _,
        } = arg0;
        let v18 = v0;
        assert!(v7, 34);
        0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::r::close<T0>(arg1, v4, v5, arg2, (0x1::vector::length<u64>(&v18) as u8), v10, v9, 0, arg3, arg4);
    }

    public fun fx<T0, T1>(arg0: P, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        let P {
            ladder      : v0,
            rung        : _,
            carry       : _,
            scratch     : _,
            best_in     : v4,
            best_out    : v5,
            best_hops   : _,
            decided     : v7,
            step        : _,
            min_profit  : v9,
            deadline_ms : v10,
            tol_bp      : _,
            mode        : _,
            blo         : _,
            bhi         : _,
            bx          : _,
            bfx         : _,
            pm          : _,
        } = arg0;
        let v18 = v0;
        assert!(v7, 34);
        0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::r::close<T0>(arg1, v4, v5, arg5, (0x1::vector::length<u64>(&v18) as u8), v10, v9, 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::r::fee_spent<T1>(arg2, arg3, arg4), arg6, arg7);
    }

    public fun gm(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= arg0) {
            return arg0
        };
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (v0 + 1) / 2;
        while (v1 < v0) {
            let v2 = v1 + v0 / v1;
            v1 = v2 / 2;
        };
        let v3 = (v0 as u64);
        if (v3 <= arg0) {
            arg0 + 1
        } else if (v3 >= arg1) {
            arg1
        } else {
            v3
        }
    }

    public fun hp<T0>(arg0: &mut P, arg1: &0x2::balance::Balance<T0>) {
        assert!(arg0.decided, 34);
        let v0 = arg0.step;
        let v1 = (v0 as u64);
        assert!(v1 < 0x1::vector::length<u64>(&arg0.best_hops), 36);
        let v2 = arg0.tol_bp;
        let v3 = if (v2 >= 10000) {
            0
        } else {
            (((*0x1::vector::borrow<u64>(&arg0.best_hops, v1) as u128) * ((10000 - v2) as u128) / 10000) as u64)
        };
        assert!(0x2::balance::value<T0>(arg1) >= v3, 35);
        arg0.step = v0 + 1;
    }

    public fun hs(arg0: &P) : u8 {
        (0x1::vector::length<u64>(&arg0.best_hops) as u8)
    }

    public fun mode_bracket() : u8 {
        1
    }

    public fun mode_ladder() : u8 {
        0
    }

    public fun op(arg0: vector<u64>, arg1: u64, arg2: u64, arg3: u64, arg4: u8) : P {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 > 0, 31);
        assert!(v0 <= (0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::mx() as u64), 32);
        let v1 = 0;
        while (v1 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg0, v1) > 0, 33);
            v1 = v1 + 1;
        };
        let v2 = *0x1::vector::borrow<u64>(&arg0, 0);
        let v3 = *0x1::vector::borrow<u64>(&arg0, v0 - 1);
        let v4 = if (arg4 == 1) {
            gm(v2, v3)
        } else {
            v2
        };
        P{
            ladder      : arg0,
            rung        : 0,
            carry       : v4,
            scratch     : vector[],
            best_in     : 0,
            best_out    : 0,
            best_hops   : vector[],
            decided     : false,
            step        : 0,
            min_profit  : arg1,
            deadline_ms : arg2,
            tol_bp      : arg3,
            mode        : arg4,
            blo         : v2,
            bhi         : v3,
            bx          : v4,
            bfx         : 0,
            pm          : v4,
        }
    }

    public fun sz(arg0: &P) : u64 {
        assert!(arg0.decided, 34);
        arg0.best_in
    }

    public fun xo(arg0: &P) : u64 {
        assert!(arg0.decided, 34);
        arg0.best_out
    }

    // decompiled from Move bytecode v7
}

