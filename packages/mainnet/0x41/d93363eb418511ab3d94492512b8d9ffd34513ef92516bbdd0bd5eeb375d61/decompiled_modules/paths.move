module 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths {
    struct PriceNode has copy, drop, store {
        from: u64,
        to: u64,
        arg: u16,
        sqrtPrice: u128,
    }

    struct PriceEvent has copy, drop, store {
        prices: vector<PriceNode>,
    }

    struct Route has copy, drop {
        route: vector<PriceNode>,
        visited: vector<u16>,
        sqrtPrice: u128,
    }

    fun add_all<T0>(arg0: &mut vector<T0>, arg1: &mut vector<T0>) {
        while (0x1::vector::length<T0>(arg0) > 0) {
            0x1::vector::push_back<T0>(arg1, 0x1::vector::pop_back<T0>(arg0));
        };
    }

    public(friend) fun copy_price_node(arg0: &PriceNode) : PriceNode {
        new_price_node(arg0.from, arg0.to, arg0.arg, arg0.sqrtPrice)
    }

    public(friend) fun emit_prices(arg0: vector<PriceNode>) {
        let v0 = PriceEvent{prices: arg0};
        0x2::event::emit<PriceEvent>(v0);
    }

    public(friend) fun emit_route(arg0: Route) {
        0x2::event::emit<Route>(arg0);
    }

    public(friend) fun evolve(arg0: &mut vector<vector<Route>>, arg1: &vector<PriceNode>, arg2: u64, arg3: u64) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PriceNode>(arg1)) {
            let v2 = *0x1::vector::borrow<PriceNode>(arg1, v1);
            let v3 = *0x1::vector::borrow<vector<Route>>(arg0, v2.from);
            let v4 = 0x1::vector::length<Route>(&v3);
            if (v4 > 0) {
                let v5 = 0;
                while (v5 < v4) {
                    let v6 = 0x1::vector::length<Route>(0x1::vector::borrow<vector<Route>>(arg0, v2.to));
                    let v7 = if (v6 > 0) {
                        0x1::vector::borrow<Route>(0x1::vector::borrow<vector<Route>>(arg0, v2.to), v6 - 1).sqrtPrice
                    } else {
                        0
                    };
                    let v8 = 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::mul_128(0x1::vector::borrow<Route>(&v3, v5).sqrtPrice, v2.sqrtPrice);
                    if (v8 > v7 || v6 < arg2) {
                        let (v9, _) = 0x1::vector::index_of<u16>(&0x1::vector::borrow<Route>(&v3, v5).visited, &v2.arg);
                        if (0x1::vector::length<PriceNode>(&0x1::vector::borrow<Route>(&v3, v5).route) < arg3 && !v9) {
                            v0 = true;
                            let v11 = 0x1::vector::empty<PriceNode>();
                            let v12 = &0x1::vector::borrow<Route>(&v3, v5).route;
                            let v13 = 0;
                            while (v13 < 0x1::vector::length<PriceNode>(v12)) {
                                0x1::vector::push_back<PriceNode>(&mut v11, copy_price_node(0x1::vector::borrow<PriceNode>(v12, v13)));
                                v13 = v13 + 1;
                            };
                            0x1::vector::push_back<PriceNode>(&mut v11, copy_price_node(&v2));
                            let v14 = Route{
                                route     : v11,
                                visited   : vector[],
                                sqrtPrice : v8,
                            };
                            let v15 = 0x1::vector::borrow_mut<vector<Route>>(arg0, v2.to);
                            insert(v14, v15, arg2);
                            0x1::vector::push_back<u16>(&mut 0x1::vector::borrow_mut<Route>(0x1::vector::borrow_mut<vector<Route>>(arg0, v2.from), v5).visited, v2.arg);
                        };
                        v5 = v5 + 1;
                    } else {
                        break
                    };
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun get_route_route(arg0: &Route) : vector<PriceNode> {
        arg0.route
    }

    public(friend) fun get_route_sqrt_price(arg0: &Route) : u128 {
        arg0.sqrtPrice
    }

    fun insert(arg0: Route, arg1: &mut vector<Route>, arg2: u64) {
        let v0 = 0x1::vector::length<Route>(arg1);
        if (v0 == 0) {
            0x1::vector::push_back<Route>(arg1, arg0);
        } else if (v0 < arg2) {
            let v1 = 0x1::vector::pop_back<Route>(arg1);
            let v2 = 0x1::vector::empty<Route>();
            while (v1.sqrtPrice < arg0.sqrtPrice) {
                0x1::vector::push_back<Route>(&mut v2, v1);
                if (0x1::vector::length<Route>(arg1) == 0) {
                    break
                };
                v1 = 0x1::vector::pop_back<Route>(arg1);
            };
            0x1::vector::push_back<Route>(&mut v2, arg0);
            if (v1.sqrtPrice >= arg0.sqrtPrice) {
                0x1::vector::push_back<Route>(arg1, v1);
            };
            let v3 = &mut v2;
            add_all<Route>(v3, arg1);
        } else {
            let v4 = 0x1::vector::pop_back<Route>(arg1);
            if (v4.sqrtPrice < arg0.sqrtPrice) {
                insert(arg0, arg1, arg2);
            } else {
                0x1::vector::push_back<Route>(arg1, v4);
            };
        };
    }

    public(friend) fun new_price_node(arg0: u64, arg1: u64, arg2: u16, arg3: u128) : PriceNode {
        PriceNode{
            from      : arg0,
            to        : arg1,
            arg       : arg2,
            sqrtPrice : arg3,
        }
    }

    public(friend) fun new_state(arg0: u64, arg1: u64) : vector<vector<Route>> {
        let v0 = 0x1::vector::empty<vector<Route>>();
        let v1 = 0;
        while (v1 < arg1) {
            if (v1 == arg0) {
                let v2 = Route{
                    route     : 0x1::vector::empty<PriceNode>(),
                    visited   : vector[],
                    sqrtPrice : 18446744073709551616,
                };
                let v3 = 0x1::vector::empty<Route>();
                0x1::vector::push_back<Route>(&mut v3, v2);
                0x1::vector::push_back<vector<Route>>(&mut v0, v3);
            } else {
                0x1::vector::push_back<vector<Route>>(&mut v0, 0x1::vector::empty<Route>());
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun price_node_arg(arg0: &PriceNode) : u16 {
        arg0.arg
    }

    public(friend) fun price_node_from(arg0: &PriceNode) : u64 {
        arg0.from
    }

    public(friend) fun price_node_sqrt_price(arg0: &PriceNode) : u128 {
        arg0.sqrtPrice
    }

    public(friend) fun price_node_to(arg0: &PriceNode) : u64 {
        arg0.to
    }

    // decompiled from Move bytecode v6
}

