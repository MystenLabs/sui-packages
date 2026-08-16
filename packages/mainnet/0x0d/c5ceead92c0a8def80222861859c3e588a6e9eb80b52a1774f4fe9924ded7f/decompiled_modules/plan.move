module 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan {
    struct RouteState has drop, store {
        pool_ids: vector<0x2::object::ID>,
        current: vector<u64>,
        external_cost: vector<u64>,
    }

    struct Plan<phantom T0> {
        funds: 0x2::balance::Balance<T0>,
        principal: u64,
        required_final: u64,
        grid: vector<u64>,
        routes: vector<RouteState>,
        committed: bool,
        best_route: u64,
        best_amount_in: u64,
        best_expected_out: u64,
        exec_cursor: u64,
    }

    public(friend) fun abandon<T0>(arg0: Plan<T0>) : 0x2::balance::Balance<T0> {
        let Plan {
            funds             : v0,
            principal         : _,
            required_final    : _,
            grid              : _,
            routes            : _,
            committed         : v5,
            best_route        : _,
            best_amount_in    : _,
            best_expected_out : _,
            exec_cursor       : _,
        } = arg0;
        assert!(!v5, 1);
        v0
    }

    public(friend) fun add_external_cost<T0>(arg0: &mut Plan<T0>, arg1: u64, arg2: vector<u64>) {
        assert!(!arg0.committed, 1);
        assert!(arg1 < 0x1::vector::length<RouteState>(&arg0.routes), 4);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg0.grid), 9);
        let v0 = 0x1::vector::borrow_mut<RouteState>(&mut arg0.routes, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = 0x1::vector::borrow_mut<u64>(&mut v0.external_cost, v1);
            *v2 = *v2 + *0x1::vector::borrow<u64>(&arg2, v1);
            v1 = v1 + 1;
        };
    }

    public(friend) fun add_required<T0>(arg0: &mut Plan<T0>, arg1: u64) {
        assert!(arg0.committed, 2);
        arg0.required_final = arg0.required_final + arg1;
    }

    public(friend) fun advance<T0>(arg0: &mut Plan<T0>, arg1: u64, arg2: 0x2::object::ID) {
        assert!(arg0.committed, 2);
        assert!(arg0.best_route == arg1, 4);
        let v0 = arg0.exec_cursor;
        let v1 = &0x1::vector::borrow<RouteState>(&arg0.routes, arg1).pool_ids;
        assert!(v0 < 0x1::vector::length<0x2::object::ID>(v1), 6);
        assert!(*0x1::vector::borrow<0x2::object::ID>(v1, v0) == arg2, 5);
        arg0.exec_cursor = v0 + 1;
    }

    public fun best_amount_in<T0>(arg0: &Plan<T0>) : u64 {
        arg0.best_amount_in
    }

    public fun best_expected_out<T0>(arg0: &Plan<T0>) : u64 {
        arg0.best_expected_out
    }

    public fun best_route<T0>(arg0: &Plan<T0>) : u64 {
        arg0.best_route
    }

    public fun commit<T0>(arg0: &mut Plan<T0>) {
        assert!(!arg0.committed, 1);
        let (v0, v1, v2, v3) = scan<T0>(arg0);
        assert!(v0 != 18446744073709551615 && v3 >= arg0.required_final - arg0.principal, 7);
        arg0.best_route = v0;
        arg0.best_amount_in = v1;
        arg0.best_expected_out = v2;
        arg0.committed = true;
    }

    public(friend) fun finish<T0>(arg0: Plan<T0>) : 0x2::balance::Balance<T0> {
        let Plan {
            funds             : v0,
            principal         : _,
            required_final    : v2,
            grid              : _,
            routes            : _,
            committed         : v5,
            best_route        : _,
            best_amount_in    : _,
            best_expected_out : _,
            exec_cursor       : _,
        } = arg0;
        let v10 = v0;
        assert!(v5, 2);
        assert!(0x2::balance::value<T0>(&v10) >= v2, 10);
        v10
    }

    public fun funds_value<T0>(arg0: &Plan<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun grid<T0>(arg0: &Plan<T0>) : vector<u64> {
        arg0.grid
    }

    public(friend) fun hop_inputs<T0>(arg0: &mut Plan<T0>, arg1: u64) : vector<u64> {
        assert!(!arg0.committed, 1);
        let v0 = 0x1::vector::length<RouteState>(&arg0.routes);
        assert!(arg1 <= v0, 3);
        if (arg1 == v0) {
            let v1 = vector[];
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(&arg0.grid)) {
                0x1::vector::push_back<u64>(&mut v1, 0);
                v2 = v2 + 1;
            };
            let v3 = RouteState{
                pool_ids      : 0x1::vector::empty<0x2::object::ID>(),
                current       : arg0.grid,
                external_cost : v1,
            };
            0x1::vector::push_back<RouteState>(&mut arg0.routes, v3);
        };
        0x1::vector::borrow<RouteState>(&arg0.routes, arg1).current
    }

    public fun is_selected<T0>(arg0: &Plan<T0>, arg1: u64) : bool {
        arg0.committed && arg0.best_route == arg1
    }

    public(friend) fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: vector<u64>) : Plan<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(arg1 >= v0, 11);
        Plan<T0>{
            funds             : arg0,
            principal         : v0,
            required_final    : arg1,
            grid              : arg2,
            routes            : 0x1::vector::empty<RouteState>(),
            committed         : false,
            best_route        : 18446744073709551615,
            best_amount_in    : 0,
            best_expected_out : 0,
            exec_cursor       : 0,
        }
    }

    public fun no_route() : u64 {
        18446744073709551615
    }

    public fun principal<T0>(arg0: &Plan<T0>) : u64 {
        arg0.principal
    }

    public fun put_out<T0>(arg0: &mut Plan<T0>, arg1: u64, arg2: 0x2::balance::Balance<T0>) {
        assert!(arg0.committed, 2);
        if (arg0.best_route != arg1) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        assert!(arg0.exec_cursor == 0x1::vector::length<0x2::object::ID>(&0x1::vector::borrow<RouteState>(&arg0.routes, arg1).pool_ids), 8);
        0x2::balance::join<T0>(&mut arg0.funds, arg2);
    }

    public(friend) fun record_hop<T0>(arg0: &mut Plan<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: vector<u64>) {
        assert!(!arg0.committed, 1);
        assert!(arg1 < 0x1::vector::length<RouteState>(&arg0.routes), 4);
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg0.grid), 9);
        let v0 = 0x1::vector::borrow_mut<RouteState>(&mut arg0.routes, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut v0.pool_ids, arg2);
        v0.current = arg3;
    }

    public fun refund<T0>(arg0: &mut Plan<T0>, arg1: u64, arg2: 0x2::balance::Balance<T0>) {
        assert!(arg0.committed, 2);
        if (arg0.best_route != arg1) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        0x2::balance::join<T0>(&mut arg0.funds, arg2);
    }

    public fun required_final<T0>(arg0: &Plan<T0>) : u64 {
        arg0.required_final
    }

    public fun scan<T0>(arg0: &Plan<T0>) : (u64, u64, u64, u64) {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<RouteState>(&arg0.routes)) {
            let v5 = 0;
            while (v5 < 0x1::vector::length<u64>(&arg0.grid)) {
                let v6 = *0x1::vector::borrow<u64>(&arg0.grid, v5);
                let v7 = *0x1::vector::borrow<u64>(&0x1::vector::borrow<RouteState>(&arg0.routes, v4).current, v5);
                let v8 = v6 + *0x1::vector::borrow<u64>(&0x1::vector::borrow<RouteState>(&arg0.routes, v4).external_cost, v5);
                if (v7 > v8) {
                    let v9 = v7 - v8;
                    if (v9 > v0) {
                        v1 = v9;
                        v2 = v6;
                        v3 = v7;
                    };
                };
                v5 = v5 + 1;
            };
            v4 = v4 + 1;
        };
        (18446744073709551615, v2, v3, v1)
    }

    public fun take_in<T0>(arg0: &mut Plan<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg0.committed, 2);
        if (arg0.best_route != arg1) {
            return 0x2::balance::zero<T0>()
        };
        assert!(arg0.exec_cursor == 0, 12);
        0x2::balance::split<T0>(&mut arg0.funds, arg0.best_amount_in)
    }

    // decompiled from Move bytecode v7
}

