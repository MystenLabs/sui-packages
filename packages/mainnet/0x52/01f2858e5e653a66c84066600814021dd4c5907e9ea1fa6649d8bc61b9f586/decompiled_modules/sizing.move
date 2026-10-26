module 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::sizing {
    struct Plan has drop {
        pending: vector<u64>,
        seen: vector<u64>,
        used: u8,
        budget: u8,
        lot: u64,
        min: u64,
        ceiling: u64,
    }

    public fun bracket(arg0: u64, arg1: u64, arg2: u8) : Plan {
        assert!(arg2 >= 3 && arg2 <= 4, 0);
        let v0 = Plan{
            pending : vector[],
            seen    : vector[],
            used    : 0,
            budget  : arg2,
            lot     : 0,
            min     : 1,
            ceiling : arg1,
        };
        if (arg1 == 0) {
            return v0
        };
        let v1 = if (arg0 > arg1) {
            arg1
        } else {
            arg0
        };
        let v2 = &mut v0;
        push(v2, v1);
        let v3 = &mut v0;
        push(v3, v1 / 4);
        let v4 = &mut v0;
        push(v4, arg1);
        let v5 = &mut v0;
        push(v5, v1 / 2);
        v0
    }

    fun cap(arg0: u256) : u64 {
        if (arg0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (arg0 as u64)
        }
    }

    public fun direct_bracket(arg0: u64, arg1: u64, arg2: u8) : Plan {
        assert!(arg2 >= 3 && arg2 <= 4, 0);
        let v0 = cap((arg0 as u256) * 2);
        let v1 = if (arg1 < v0) {
            arg1
        } else {
            v0
        };
        let v2 = Plan{
            pending : vector[],
            seen    : vector[],
            used    : 0,
            budget  : arg2,
            lot     : 0,
            min     : 1,
            ceiling : v1,
        };
        if (v1 == 0) {
            return v2
        };
        let v3 = if (arg0 < v1) {
            arg0
        } else {
            v1
        };
        let v4 = &mut v2;
        push(v4, v3);
        let v5 = &mut v2;
        push(v5, v1);
        let v6 = &mut v2;
        push(v6, positive(v3 / 2));
        let v7 = &mut v2;
        push(v7, positive(v3 / 4));
        let v8 = &mut v2;
        push(v8, positive((((v3 as u256) * 3 / 4) as u64)));
        v2
    }

    fun grid(arg0: &Plan, arg1: u64) : u64 {
        let v0 = if (arg0.ceiling > 0 && arg1 > arg0.ceiling) {
            arg0.ceiling
        } else {
            arg1
        };
        if (arg0.lot == 0) {
            return if (v0 < arg0.min) {
                0
            } else {
                v0
            }
        };
        let v2 = v0 / arg0.lot * arg0.lot;
        if (v2 < arg0.min) {
            0
        } else {
            v2
        }
    }

    fun known(arg0: &Plan, arg1: u64) : bool {
        0x1::vector::contains<u64>(&arg0.pending, &arg1) || 0x1::vector::contains<u64>(&arg0.seen, &arg1)
    }

    public fun next(arg0: &mut Plan) : (bool, u64) {
        if (arg0.used >= arg0.budget || 0x1::vector::is_empty<u64>(&arg0.pending)) {
            return (false, 0)
        };
        let v0 = 0x1::vector::remove<u64>(&mut arg0.pending, 0);
        0x1::vector::push_back<u64>(&mut arg0.seen, v0);
        arg0.used = arg0.used + 1;
        (true, v0)
    }

    public fun plan(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8) : Plan {
        assert!(arg5 > 0, 0);
        let v0 = if (arg5 > 8) {
            8
        } else {
            arg5
        };
        let v1 = Plan{
            pending : vector[],
            seen    : vector[],
            used    : 0,
            budget  : v0,
            lot     : arg3,
            min     : arg4,
            ceiling : arg2,
        };
        let v2 = &mut v1;
        push(v2, arg0);
        let v3 = &mut v1;
        push(v3, arg1);
        let v4 = if (arg0 > 0) {
            arg0
        } else {
            arg1
        };
        if (v4 > 0) {
            let v5 = v4 / 8;
            let v6 = &mut v1;
            let v7 = if (v5 > arg4) {
                v5
            } else {
                arg4
            };
            push(v6, v7);
            let v8 = &mut v1;
            push(v8, v4 / 2);
            let v9 = &mut v1;
            push(v9, cap((v4 as u256) * 2));
        };
        let v10 = &mut v1;
        push(v10, arg2);
        v1
    }

    fun positive(arg0: u64) : u64 {
        if (arg0 == 0) {
            1
        } else {
            arg0
        }
    }

    public fun prefer(arg0: &mut Plan, arg1: u64) {
        let v0 = grid(arg0, arg1);
        if (v0 == 0 || known(arg0, v0)) {
            return
        };
        if (!room(arg0)) {
            if (0x1::vector::length<u64>(&arg0.pending) <= 1) {
                return
            };
            0x1::vector::pop_back<u64>(&mut arg0.pending);
        };
        let v1 = if (0x1::vector::length<u64>(&arg0.pending) > 0) {
            1
        } else {
            0
        };
        0x1::vector::insert<u64>(&mut arg0.pending, v0, v1);
    }

    fun push(arg0: &mut Plan, arg1: u64) {
        let v0 = grid(arg0, arg1);
        let v1 = if (v0 > 0) {
            if (!known(arg0, v0)) {
                room(arg0)
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            0x1::vector::push_back<u64>(&mut arg0.pending, v0);
        };
    }

    public fun remaining(arg0: &Plan) : u64 {
        0x1::vector::length<u64>(&arg0.pending)
    }

    fun room(arg0: &Plan) : bool {
        (0x1::vector::length<u64>(&arg0.pending) as u64) + (arg0.used as u64) < (arg0.budget as u64)
    }

    public fun used(arg0: &Plan) : u8 {
        arg0.used
    }

    // decompiled from Move bytecode v7
}

