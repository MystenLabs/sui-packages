module 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search {
    struct Search {
        routes: vector<Route>,
        route: u64,
        hop: u64,
        round: u64,
        refine: u64,
        quotes: u64,
    }

    struct Route has drop, store {
        pools: vector<0x2::object::ID>,
        probes: vector<u64>,
        flow: vector<u64>,
        lo: u64,
        mid: u64,
        hi: u64,
        best: u128,
        max_in: u64,
        min_profit: u64,
        alive: bool,
        done: bool,
    }

    struct Decision has copy, drop, store {
        route: u64,
        amount: u64,
        expected: u64,
        min_out: u64,
    }

    struct Decided has copy, drop {
        route: u64,
        amount: u64,
        expected: u64,
        quotes: u64,
        rounds: u64,
    }

    public fun amount(arg0: &Decision, arg1: u64) : u64 {
        if (arg0.route == arg1) {
            arg0.amount
        } else {
            0
        }
    }

    public fun begin(arg0: &mut Search, arg1: 0x2::object::ID) : vector<u64> {
        assert!(arg0.round <= arg0.refine, 7506);
        assert!(arg0.route < 0x1::vector::length<Route>(&arg0.routes), 7503);
        let v0 = 0x1::vector::borrow_mut<Route>(&mut arg0.routes, arg0.route);
        assert!(*0x1::vector::borrow<0x2::object::ID>(&v0.pools, arg0.hop) == arg1, 7502);
        let v1 = v0.flow;
        v0.flow = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            if (*0x1::vector::borrow<u64>(&v1, v2) > 0) {
                arg0.quotes = arg0.quotes + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun chosen(arg0: &Decision) : u64 {
        arg0.route
    }

    public fun decide(arg0: Search) : Decision {
        let Search {
            routes : v0,
            route  : v1,
            hop    : v2,
            round  : v3,
            refine : _,
            quotes : v5,
        } = arg0;
        let v6 = v0;
        let v7 = if (v1 == 0) {
            if (v2 == 0) {
                v3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 7503);
        let v8 = 0x1::vector::length<Route>(&v6);
        let v9 = 0;
        let v10 = v9;
        let v11 = 0;
        while (v11 < v8) {
            let v12 = 0x1::vector::borrow<Route>(&v6, v11);
            if (v12.alive && v12.best > 18446744073709551616) {
                let v13 = ((v12.best - 18446744073709551616) as u64);
                let v14 = if (v13 >= v12.min_profit) {
                    if (v13 > 0) {
                        v8 == v8 || v13 > v9
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v14) {
                    v10 = v13;
                };
            };
            v11 = v11 + 1;
        };
        assert!(v8 < v8, 7501);
        let v15 = 0x1::vector::borrow<Route>(&v6, v8);
        let v16 = Decision{
            route    : v8,
            amount   : v15.mid,
            expected : v10,
            min_out  : v15.min_profit,
        };
        let v17 = Decided{
            route    : v8,
            amount   : v15.mid,
            expected : v10,
            quotes   : v5,
            rounds   : v3,
        };
        0x2::event::emit<Decided>(v17);
        v16
    }

    public fun end(arg0: &mut Search, arg1: vector<u64>) {
        let v0 = arg0.route;
        let v1 = 0x1::vector::borrow_mut<Route>(&mut arg0.routes, v0);
        v1.flow = arg1;
        arg0.hop = arg0.hop + 1;
        if (arg0.hop == 0x1::vector::length<0x2::object::ID>(&v1.pools)) {
            score_round(v1, arg0.round == 0);
            arg0.hop = 0;
            arg0.route = v0 + 1;
        };
    }

    public fun expected(arg0: &Decision) : u64 {
        arg0.expected
    }

    public fun min_out(arg0: &Decision) : u64 {
        arg0.min_out
    }

    public fun new(arg0: vector<vector<0x2::object::ID>>, arg1: vector<vector<u64>>, arg2: vector<u64>, arg3: vector<u64>, arg4: u64, arg5: u64) : Search {
        let v0 = 0x1::vector::length<vector<0x2::object::ID>>(&arg0);
        assert!(v0 > 0 && v0 <= 8, 7504);
        let v1 = if (0x1::vector::length<vector<u64>>(&arg1) == v0) {
            if (0x1::vector::length<u64>(&arg2) == v0) {
                0x1::vector::length<u64>(&arg3) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 7504);
        assert!(arg4 <= 12, 7504);
        let v2 = 0x1::vector::empty<Route>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::length<0x2::object::ID>(0x1::vector::borrow<vector<0x2::object::ID>>(&arg0, v4));
            assert!(v5 > 0 && v5 <= 3, 7504);
            let v6 = *0x1::vector::borrow<vector<u64>>(&arg1, v4);
            let v7 = 0x1::vector::length<u64>(&v6);
            assert!(v7 > 0 && v7 <= 12, 7504);
            let v8 = 0;
            while (v8 < v7) {
                assert!(*0x1::vector::borrow<u64>(&v6, v8) > 0 && *0x1::vector::borrow<u64>(&v6, v8) <= *0x1::vector::borrow<u64>(&arg2, v4), 7504);
                assert!(v8 == 0 || *0x1::vector::borrow<u64>(&v6, v8 - 1) < *0x1::vector::borrow<u64>(&v6, v8), 7504);
                v8 = v8 + 1;
            };
            v3 = v3 + v5 * (v7 + arg4);
            let v9 = Route{
                pools      : *0x1::vector::borrow<vector<0x2::object::ID>>(&arg0, v4),
                probes     : v6,
                flow       : v6,
                lo         : 0,
                mid        : 0,
                hi         : 0,
                best       : 0,
                max_in     : *0x1::vector::borrow<u64>(&arg2, v4),
                min_profit : *0x1::vector::borrow<u64>(&arg3, v4),
                alive      : true,
                done       : false,
            };
            0x1::vector::push_back<Route>(&mut v2, v9);
            v4 = v4 + 1;
        };
        assert!(v3 <= arg5, 7505);
        Search{
            routes : v2,
            route  : 0,
            hop    : 0,
            round  : 0,
            refine : arg4,
            quotes : 0,
        }
    }

    public fun next(arg0: &mut Search) {
        assert!(arg0.route == 0x1::vector::length<Route>(&arg0.routes) && arg0.hop == 0, 7503);
        if (arg0.round == 0) {
            let v0 = false;
            let v1 = 0;
            while (v1 < 0x1::vector::length<Route>(&arg0.routes)) {
                if (0x1::vector::borrow<Route>(&arg0.routes, v1).alive) {
                    v0 = true;
                };
                v1 = v1 + 1;
            };
            assert!(v0, 7501);
        };
        arg0.round = arg0.round + 1;
        arg0.route = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Route>(&arg0.routes)) {
            let v3 = 0x1::vector::borrow_mut<Route>(&mut arg0.routes, v2);
            plan_probe(v3);
            v2 = v2 + 1;
        };
    }

    fun plan_probe(arg0: &mut Route) {
        arg0.probes = vector[];
        arg0.flow = vector[];
        if (!arg0.alive || arg0.done) {
            return
        };
        let v0 = arg0.mid - arg0.lo;
        let v1 = arg0.hi - arg0.mid;
        let v2 = if (v1 >= v0) {
            let v3 = (((v1 as u128) * 382 / 1000) as u64);
            let v4 = if (v3 == 0) {
                1
            } else {
                v3
            };
            arg0.mid + v4
        } else {
            let v5 = (((v0 as u128) * 382 / 1000) as u64);
            let v6 = if (v5 == 0) {
                1
            } else {
                v5
            };
            arg0.mid - v6
        };
        let v7 = if (v2 <= arg0.lo) {
            true
        } else if (v2 >= arg0.hi) {
            true
        } else if (v2 == arg0.mid) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v2 > arg0.max_in
        };
        if (v7) {
            arg0.done = true;
            return
        };
        let v8 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v8, v2);
        arg0.probes = v8;
        let v9 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v9, v2);
        arg0.flow = v9;
    }

    fun score(arg0: u64, arg1: u64) : u128 {
        if (arg1 == 0) {
            0
        } else {
            (arg1 as u128) + 18446744073709551616 - (arg0 as u128)
        }
    }

    fun score_round(arg0: &mut Route, arg1: bool) {
        if (!arg0.alive || arg0.done) {
            arg0.flow = vector[];
            return
        };
        let v0 = 0x1::vector::length<u64>(&arg0.probes);
        if (arg1) {
            let v1 = 0;
            let v2 = v1;
            let v3 = 0;
            while (v3 < v0) {
                let v4 = score(*0x1::vector::borrow<u64>(&arg0.probes, v3), *0x1::vector::borrow<u64>(&arg0.flow, v3));
                if (v4 > v1) {
                    v2 = v4;
                };
                v3 = v3 + 1;
            };
            if (v0 == v0 || v2 <= 18446744073709551616) {
                arg0.alive = false;
            } else {
                arg0.best = v2;
                arg0.mid = *0x1::vector::borrow<u64>(&arg0.probes, v0);
                let v5 = if (v0 == 0) {
                    0
                } else {
                    *0x1::vector::borrow<u64>(&arg0.probes, v0 - 1)
                };
                arg0.lo = v5;
                let v6 = if (v0 + 1 < v0) {
                    *0x1::vector::borrow<u64>(&arg0.probes, v0 + 1)
                } else {
                    let v7 = (arg0.mid as u128) * 2;
                    if (v7 > (arg0.max_in as u128)) {
                        arg0.max_in
                    } else {
                        (v7 as u64)
                    }
                };
                arg0.hi = v6;
            };
        } else if (v0 == 1) {
            let v8 = *0x1::vector::borrow<u64>(&arg0.probes, 0);
            let v9 = score(v8, *0x1::vector::borrow<u64>(&arg0.flow, 0));
            if (v9 > arg0.best) {
                if (v8 > arg0.mid) {
                    arg0.lo = arg0.mid;
                } else {
                    arg0.hi = arg0.mid;
                };
                arg0.mid = v8;
                arg0.best = v9;
            } else if (v8 > arg0.mid) {
                arg0.hi = v8;
            } else {
                arg0.lo = v8;
            };
        };
        arg0.flow = vector[];
    }

    // decompiled from Move bytecode v7
}

