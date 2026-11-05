module 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m {
    struct M {
        ladders: vector<vector<u64>>,
        mins: vector<u64>,
        outs: vector<u64>,
        phase: u8,
        route: u64,
        chosen: u64,
        carry: u64,
        scratch: vector<u64>,
        rung: u64,
        best_in: u64,
        best_out: u64,
        best_hops: vector<u64>,
        step: u64,
        paid: bool,
        deadline_ms: u64,
        tol_bp: u64,
    }

    public fun av(arg0: &mut M) {
        assert!(arg0.phase == 1, 34);
        if (arg0.route != arg0.chosen) {
            return
        };
        let v0 = 0x1::vector::borrow<vector<u64>>(&arg0.ladders, arg0.chosen);
        if (arg0.rung >= 0x1::vector::length<u64>(v0)) {
            return
        };
        let v1 = *0x1::vector::borrow<u64>(v0, arg0.rung);
        let v2 = arg0.carry;
        if (arg0.best_in == 0 || 0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::n::sc(v1, v2) > 0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::n::sc(arg0.best_in, arg0.best_out)) {
            arg0.best_in = v1;
            arg0.best_out = v2;
            arg0.best_hops = arg0.scratch;
        };
        arg0.rung = arg0.rung + 1;
        if (v2 <= v1) {
            arg0.rung = 0x1::vector::length<u64>(v0);
        };
        arg0.scratch = vector[];
        let v3 = if (arg0.rung < 0x1::vector::length<u64>(v0)) {
            *0x1::vector::borrow<u64>(v0, arg0.rung)
        } else {
            0
        };
        arg0.carry = v3;
    }

    public fun ch(arg0: &mut M) {
        assert!(arg0.phase == 0 && arg0.route == 0x1::vector::length<vector<u64>>(&arg0.ladders), 34);
        let v0 = 0x1::vector::length<vector<u64>>(&arg0.ladders);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.ladders, v1), 0);
            let v3 = *0x1::vector::borrow<u64>(&arg0.outs, v1);
            if (v3 > v2) {
                if (v0 == v0) {
                };
            };
            v1 = v1 + 1;
        };
        assert!(v0 < v0, 40);
        arg0.chosen = v0;
        arg0.phase = 1;
        arg0.route = 0;
        arg0.rung = 0;
        arg0.scratch = vector[];
        arg0.carry = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.ladders, v0), 0);
    }

    public fun cy(arg0: &M) : u64 {
        arg0.carry
    }

    public fun dc(arg0: &mut M, arg1: &0x2::clock::Clock) {
        assert!(arg0.phase == 1 && arg0.route == 0x1::vector::length<vector<u64>>(&arg0.ladders), 34);
        0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::g::bf(arg1, arg0.deadline_ms);
        assert!(arg0.best_in > 0 && arg0.best_out > arg0.best_in, 20);
        0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::g::mn(arg0.best_out - arg0.best_in, *0x1::vector::borrow<u64>(&arg0.mins, arg0.chosen));
        arg0.phase = 2;
        arg0.route = 0;
        arg0.step = 0;
    }

    public fun en(arg0: M) {
        let M {
            ladders     : v0,
            mins        : _,
            outs        : _,
            phase       : v3,
            route       : v4,
            chosen      : _,
            carry       : _,
            scratch     : _,
            rung        : _,
            best_in     : _,
            best_out    : _,
            best_hops   : _,
            step        : _,
            paid        : v13,
            deadline_ms : _,
            tol_bp      : _,
        } = arg0;
        let v16 = v0;
        let v17 = if (v3 == 2) {
            if (v4 == 0x1::vector::length<vector<u64>>(&v16)) {
                v13
            } else {
                false
            }
        } else {
            false
        };
        assert!(v17, 42);
    }

    public fun es(arg0: &mut M) {
        assert!(arg0.phase == 0, 34);
        0x1::vector::push_back<u64>(&mut arg0.outs, arg0.carry);
        arg0.route = arg0.route + 1;
        let v0 = if (arg0.route < 0x1::vector::length<vector<u64>>(&arg0.ladders)) {
            *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.ladders, arg0.route), 0)
        } else {
            0
        };
        arg0.carry = v0;
    }

    public fun fd(arg0: &mut M, arg1: u64) {
        assert!(arg0.phase != 2, 34);
        if (!live(arg0)) {
            return
        };
        arg0.carry = arg1;
        if (arg0.phase == 1) {
            0x1::vector::push_back<u64>(&mut arg0.scratch, arg1);
        };
    }

    public fun hp<T0>(arg0: &mut M, arg1: &0x2::balance::Balance<T0>) {
        assert!(arg0.phase == 2, 34);
        if (arg0.route != arg0.chosen) {
            return
        };
        let v0 = arg0.step;
        assert!(v0 < 0x1::vector::length<u64>(&arg0.best_hops), 36);
        let v1 = if (arg0.tol_bp >= 10000) {
            0
        } else {
            (((*0x1::vector::borrow<u64>(&arg0.best_hops, v0) as u128) * ((10000 - arg0.tol_bp) as u128) / 10000) as u64)
        };
        assert!(0x2::balance::value<T0>(arg1) >= v1, 35);
        arg0.step = v0 + 1;
    }

    public fun live(arg0: &M) : bool {
        if (arg0.phase == 0) {
            return true
        };
        if (arg0.route != arg0.chosen) {
            return false
        };
        let v0 = arg0.phase == 1 && arg0.rung >= 0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(&arg0.ladders, arg0.chosen));
        !v0
    }

    public fun nb(arg0: &mut M) {
        assert!(arg0.phase == 1, 34);
        arg0.route = arg0.route + 1;
    }

    public fun op(arg0: vector<vector<u64>>, arg1: vector<u64>, arg2: u64, arg3: u64) : M {
        let v0 = 0x1::vector::length<vector<u64>>(&arg0);
        assert!(v0 > 0 && v0 == 0x1::vector::length<u64>(&arg1), 41);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<vector<u64>>(&arg0, v1);
            assert!(0x1::vector::length<u64>(v2) > 0 && 0x1::vector::length<u64>(v2) <= (0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::n::mx() as u64), 41);
            let v3 = 0;
            while (v3 < 0x1::vector::length<u64>(v2)) {
                assert!(*0x1::vector::borrow<u64>(v2, v3) > 0, 41);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        M{
            ladders     : arg0,
            mins        : arg1,
            outs        : vector[],
            phase       : 0,
            route       : 0,
            chosen      : 0,
            carry       : *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0, 0), 0),
            scratch     : vector[],
            rung        : 0,
            best_in     : 0,
            best_out    : 0,
            best_hops   : vector[],
            step        : 0,
            paid        : false,
            deadline_ms : arg2,
            tol_bp      : arg3,
        }
    }

    public fun pay<T0>(arg0: &mut M, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.phase == 2, 34);
        if (arg0.route == arg0.chosen) {
            0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::r::st<T0>(arg1, arg0.best_in, arg0.best_out, arg2, ((0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(&arg0.ladders, arg0.chosen)) + 0x1::vector::length<vector<u64>>(&arg0.ladders)) as u8), arg0.deadline_ms, *0x1::vector::borrow<u64>(&arg0.mins, arg0.chosen), arg3, arg4);
            arg0.paid = true;
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
        arg0.route = arg0.route + 1;
        arg0.step = 0;
    }

    public fun sf(arg0: &mut M, arg1: u128, arg2: u64, arg3: bool) {
        if (!live(arg0)) {
            return
        };
        let v0 = so(arg0.carry, arg1, arg2, arg3);
        fd(arg0, v0);
    }

    public fun so(arg0: u64, arg1: u128, arg2: u64, arg3: bool) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 >= 1000000
        };
        if (v0) {
            return 0
        };
        let v1 = (arg1 as u256);
        let v2 = if (arg3) {
            (arg0 as u256) * v1 * v1 >> 128
        } else {
            ((arg0 as u256) << 128) / v1 * v1
        };
        let v3 = v2 * ((1000000 - arg2) as u256) / 1000000;
        if (v3 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v3 as u64)
        }
    }

    public fun sz(arg0: &M) : 0x1::option::Option<u64> {
        assert!(arg0.phase == 2, 34);
        if (arg0.route == arg0.chosen) {
            0x1::option::some<u64>(arg0.best_in)
        } else {
            0x1::option::none<u64>()
        }
    }

    // decompiled from Move bytecode v7
}

