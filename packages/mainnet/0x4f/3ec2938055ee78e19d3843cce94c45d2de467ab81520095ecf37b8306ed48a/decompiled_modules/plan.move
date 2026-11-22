module 0x4f3ec2938055ee78e19d3843cce94c45d2de467ab81520095ecf37b8306ed48a::plan {
    struct Plan {
        sizes: vector<u64>,
        outputs: vector<u64>,
        input_change: vector<u64>,
        pools: vector<address>,
        base: 0x1::type_name::TypeName,
        current: 0x1::type_name::TypeName,
        floor: u64,
        active: bool,
        chosen: u64,
        expected: u64,
    }

    struct CycleFired has copy, drop {
        pools: vector<address>,
        x: u64,
        expected_out: u64,
        realized_out: u64,
        probes: u8,
        buy_on_a: bool,
    }

    public(friend) fun bank<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public(friend) fun choose<T0>(arg0: &mut Plan, arg1: address) : u64 {
        let v0 = if (0x1::vector::length<address>(&arg0.pools) >= 2) {
            if (0x1::vector::length<address>(&arg0.pools) <= 4) {
                *0x1::vector::borrow<address>(&arg0.pools, 0) == arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 900);
        assert!(arg0.base == 0x1::type_name::with_defining_ids<T0>() && arg0.current == arg0.base, 900);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.sizes)) {
            let v2 = (*0x1::vector::borrow<u64>(&arg0.outputs, v1) as u128) + (*0x1::vector::borrow<u64>(&arg0.input_change, v1) as u128);
            let v3 = if (arg0.active) {
                if (v2 >= (*0x1::vector::borrow<u64>(&arg0.sizes, v1) as u128)) {
                    v2 <= 18446744073709551615
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                let v4 = (v2 as u64) - *0x1::vector::borrow<u64>(&arg0.sizes, v1);
                if (v4 >= arg0.floor && v4 > 0) {
                    arg0.chosen = *0x1::vector::borrow<u64>(&arg0.sizes, v1);
                    arg0.expected = (v2 as u64);
                };
            };
            v1 = v1 + 1;
        };
        arg0.chosen
    }

    public(friend) fun count(arg0: &Plan) : u64 {
        0x1::vector::length<u64>(&arg0.outputs)
    }

    public(friend) fun finish<T0>(arg0: Plan, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let Plan {
            sizes        : v0,
            outputs      : _,
            input_change : _,
            pools        : v3,
            base         : v4,
            current      : _,
            floor        : v6,
            active       : _,
            chosen       : v8,
            expected     : v9,
        } = arg0;
        let v10 = v0;
        assert!(v4 == 0x1::type_name::with_defining_ids<T0>(), 900);
        if (v8 == 0) {
            assert!(arg2 == 0, 900);
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v11 = 0x2::balance::value<T0>(&arg1);
        assert!(v11 >= v6, 910);
        let v12 = CycleFired{
            pools        : v3,
            x            : arg2,
            expected_out : v9,
            realized_out : arg2 + v11,
            probes       : (0x1::vector::length<u64>(&v10) as u8),
            buy_on_a     : true,
        };
        0x2::event::emit<CycleFired>(v12);
        bank<T0>(arg1, arg3);
    }

    public(friend) fun first_input_change<T0>(arg0: &mut Plan, arg1: u64, arg2: u64) {
        if (0x1::vector::length<address>(&arg0.pools) != 1) {
            return
        };
        assert!(arg0.base == 0x1::type_name::with_defining_ids<T0>() && arg2 <= *0x1::vector::borrow<u64>(&arg0.sizes, arg1), 900);
        *0x1::vector::borrow_mut<u64>(&mut arg0.input_change, arg1) = arg2;
    }

    public(friend) fun hop<T0, T1>(arg0: &mut Plan, arg1: address, arg2: bool) {
        assert!(0x1::vector::length<address>(&arg0.pools) < 4 && !0x1::vector::contains<address>(&arg0.pools, &arg1), 900);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = if (arg2) {
            v0
        } else {
            v1
        };
        assert!(arg0.current == v2, 900);
        let v3 = if (arg2) {
            v1
        } else {
            v0
        };
        arg0.current = v3;
        0x1::vector::push_back<address>(&mut arg0.pools, arg1);
    }

    public(friend) fun input(arg0: &Plan, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.outputs, arg1)
    }

    public fun new<T0>(arg0: vector<u64>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : Plan {
        let v0 = if (0x1::vector::length<u64>(&arg0) > 0) {
            if (0x1::vector::length<u64>(&arg0) <= 3) {
                arg1 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 900);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2 > 0 && (arg2 as u128) <= (v1 as u128) + 3000, 900);
        let v2 = v1 <= arg2;
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg0)) {
            assert!(*0x1::vector::borrow<u64>(&arg0, v5) > 0 && (v5 == 0 || *0x1::vector::borrow<u64>(&arg0, v5) > *0x1::vector::borrow<u64>(&arg0, v5 - 1)), 900);
            let v6 = if (v2) {
                *0x1::vector::borrow<u64>(&arg0, v5)
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v3, v6);
            0x1::vector::push_back<u64>(&mut v4, 0);
            v5 = v5 + 1;
        };
        Plan{
            sizes        : arg0,
            outputs      : v3,
            input_change : v4,
            pools        : vector[],
            base         : 0x1::type_name::with_defining_ids<T0>(),
            current      : 0x1::type_name::with_defining_ids<T0>(),
            floor        : arg1,
            active       : v2,
            chosen       : 0,
            expected     : 0,
        }
    }

    public(friend) fun output(arg0: &mut Plan, arg1: u64, arg2: u64) {
        *0x1::vector::borrow_mut<u64>(&mut arg0.outputs, arg1) = arg2;
    }

    public(friend) fun repay<T0>(arg0: &Plan, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!((0x2::balance::value<T0>(arg1) as u128) >= (arg2 as u128) + (arg0.floor as u128), 910);
        0x2::balance::split<T0>(arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

