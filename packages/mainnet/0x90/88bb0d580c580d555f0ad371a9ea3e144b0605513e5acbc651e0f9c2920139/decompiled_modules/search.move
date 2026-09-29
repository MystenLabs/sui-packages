module 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search {
    struct Candidate has copy, drop {
        sui: bool,
        amount: u64,
    }

    struct Search has drop {
        pending: vector<Candidate>,
        seen: vector<Candidate>,
        used: u8,
        hi_sui: u64,
        hi_usdc: u64,
        lot_sui: u64,
        lot_usdc: u64,
        min_sui: u64,
        min_usdc: u64,
        best_sui: u64,
        best_usdc: u64,
        gain_sui: u64,
        gain_usdc: u64,
    }

    fun add(arg0: &mut Search, arg1: bool, arg2: u64) {
        let v0 = Candidate{
            sui    : arg1,
            amount : normalize(arg0, arg1, arg2),
        };
        let v1 = if (v0.amount > 0) {
            if (!known(arg0, v0)) {
                0x1::vector::length<Candidate>(&arg0.pending) + (arg0.used as u64) < 5
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            0x1::vector::push_back<Candidate>(&mut arg0.pending, v0);
        };
    }

    public fun boundary(arg0: &mut Search, arg1: bool, arg2: u64) {
        if (arg2 == 0 || arg0.used > 3) {
            return
        };
        let v0 = if (arg1) {
            arg0.lot_sui
        } else {
            arg0.lot_usdc
        };
        let v1 = if (arg2 > v0) {
            arg2 - v0
        } else {
            0
        };
        prioritize(arg0, arg1, v1);
        prioritize(arg0, arg1, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::cap((arg2 as u256) + (v0 as u256)));
    }

    fun known(arg0: &Search, arg1: Candidate) : bool {
        0x1::vector::contains<Candidate>(&arg0.pending, &arg1) || 0x1::vector::contains<Candidate>(&arg0.seen, &arg1)
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : Search {
        let v0 = Search{
            pending   : 0x1::vector::empty<Candidate>(),
            seen      : 0x1::vector::empty<Candidate>(),
            used      : 0,
            hi_sui    : arg1,
            hi_usdc   : arg3,
            lot_sui   : arg7,
            lot_usdc  : arg8,
            min_sui   : arg9,
            min_usdc  : arg10,
            best_sui  : 0,
            best_usdc : 0,
            gain_sui  : 0,
            gain_usdc : 0,
        };
        let v1 = arg4 && arg5 && arg6 || arg4;
        let v2 = v1 && arg4 || arg5;
        if (v2) {
            let v3 = if (v1) {
                arg0
            } else {
                arg2
            };
            let v4 = if (v1) {
                arg9
            } else {
                arg10
            };
            let v5 = &mut v0;
            let v6 = if (v3 / 8 > v4) {
                v3 / 8
            } else {
                v4
            };
            add(v5, v1, v6);
            let v7 = &mut v0;
            add(v7, v1, v3);
        };
        if (arg4 && arg5) {
            let v8 = &mut v0;
            let v9 = if (v1) {
                arg2
            } else {
                arg0
            };
            add(v8, !v1, v9);
        };
        if (v2) {
            let v10 = &mut v0;
            let v11 = if (v1) {
                arg1
            } else {
                arg3
            };
            add(v10, v1, v11);
        };
        if (arg4 && arg5) {
            let v12 = &mut v0;
            let v13 = if (v1) {
                arg3
            } else {
                arg1
            };
            add(v12, !v1, v13);
        };
        if (v2) {
            let v14 = if (v1) {
                arg0
            } else {
                arg2
            };
            let v15 = &mut v0;
            add(v15, v1, v14 / 2);
            let v16 = &mut v0;
            add(v16, v1, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::cap((v14 as u256) * 2));
        };
        v0
    }

    public fun next(arg0: &mut Search) : (bool, bool, u64) {
        if (arg0.used >= 5 || 0x1::vector::is_empty<Candidate>(&arg0.pending)) {
            return (false, false, 0)
        };
        let v0 = 0x1::vector::remove<Candidate>(&mut arg0.pending, 0);
        0x1::vector::push_back<Candidate>(&mut arg0.seen, v0);
        arg0.used = arg0.used + 1;
        (true, v0.sui, v0.amount)
    }

    fun normalize(arg0: &Search, arg1: bool, arg2: u64) : u64 {
        let v0 = if (arg1) {
            arg0.hi_sui
        } else {
            arg0.hi_usdc
        };
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        let v2 = if (arg1) {
            arg0.lot_sui
        } else {
            arg0.lot_usdc
        };
        let v3 = if (arg1) {
            arg0.min_sui
        } else {
            arg0.min_usdc
        };
        0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::round_down(v1, v2, v3)
    }

    fun prioritize(arg0: &mut Search, arg1: bool, arg2: u64) {
        let v0 = Candidate{
            sui    : arg1,
            amount : normalize(arg0, arg1, arg2),
        };
        if (v0.amount == 0 || known(arg0, v0)) {
            return
        };
        if (0x1::vector::length<Candidate>(&arg0.pending) + (arg0.used as u64) >= 5) {
            if (0x1::vector::length<Candidate>(&arg0.pending) <= 1) {
                return
            };
            0x1::vector::pop_back<Candidate>(&mut arg0.pending);
        };
        let v1 = if (arg0.used < 3 && 0x1::vector::length<Candidate>(&arg0.pending) > 0) {
            1
        } else {
            0
        };
        0x1::vector::insert<Candidate>(&mut arg0.pending, v0, v1);
    }

    public fun record(arg0: &mut Search, arg1: bool, arg2: u64, arg3: u64, arg4: u64) {
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clears(arg3, arg2, arg4)) {
            return
        };
        let v0 = arg3 - arg2;
        if (arg1 && v0 > arg0.gain_sui) {
            arg0.best_sui = arg2;
            arg0.gain_sui = v0;
        } else if (!arg1 && v0 > arg0.gain_usdc) {
            arg0.best_usdc = arg2;
            arg0.gain_usdc = v0;
        };
    }

    public fun result(arg0: &Search, arg1: bool) : (bool, u64, u8) {
        let v0 = arg1 && arg0.best_sui > 0 || arg0.best_usdc == 0;
        let v1 = if (v0) {
            arg0.best_sui
        } else {
            arg0.best_usdc
        };
        (v0, v1, arg0.used)
    }

    // decompiled from Move bytecode v7
}

