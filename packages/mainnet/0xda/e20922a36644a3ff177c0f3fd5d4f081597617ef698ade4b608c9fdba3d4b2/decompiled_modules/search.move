module 0xdae20922a36644a3ff177c0f3fd5d4f081597617ef698ade4b608c9fdba3d4b2::search {
    struct Search has drop {
        min: u64,
        max: u64,
        rounds: u64,
        round: u64,
        left: u64,
        center: u64,
        right: u64,
        visited: vector<u64>,
        scores: vector<u128>,
        best: u64,
        output: u64,
        fee: u64,
        score: u128,
    }

    public fun advance(arg0: &mut Search) {
        assert!(arg0.round < arg0.rounds, 4);
        let v0 = score_at(arg0, arg0.left);
        let v1 = score_at(arg0, arg0.center);
        let v2 = score_at(arg0, arg0.right);
        let v3 = if (v2 > v1) {
            if (v2 > v0) {
                arg0.right < arg0.max
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            arg0.left = arg0.center;
            arg0.center = arg0.right;
            arg0.right = double_clamped(arg0.right, arg0.max);
        } else {
            let v4 = if (v0 > v1) {
                if (v0 >= v2) {
                    arg0.left > arg0.min
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                arg0.right = arg0.center;
                arg0.center = arg0.left;
                arg0.left = 0x1::u64::max(arg0.left / 2, arg0.min);
            } else {
                let v5 = if (v0 > v1 && v0 >= v2) {
                    arg0.left
                } else if (v2 > v1) {
                    arg0.right
                } else {
                    arg0.center
                };
                arg0.left = arg0.left + (v5 - arg0.left) / 2;
                arg0.right = v5 + (arg0.right - v5) / 2;
                arg0.center = v5;
            };
        };
        arg0.round = arg0.round + 1;
    }

    public fun assert_repaid_surplus(arg0: u64, arg1: u64, arg2: u64) {
        assert!((arg0 as u128) >= (arg1 as u128) + (arg2 as u128), 10);
    }

    public fun candidates(arg0: &Search) : vector<u64> {
        if (arg0.round >= arg0.rounds) {
            return vector[]
        };
        let v0 = vector[];
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg0.left);
        0x1::vector::push_back<u64>(v2, arg0.center);
        0x1::vector::push_back<u64>(v2, arg0.right);
        0x1::vector::reverse<u64>(&mut v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1)) {
            let v4 = 0x1::vector::pop_back<u64>(&mut v1);
            if (!0x1::vector::contains<u64>(&arg0.visited, &v4) && !0x1::vector::contains<u64>(&v0, &v4)) {
                0x1::vector::push_back<u64>(&mut v0, v4);
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        v0
    }

    public fun ceil_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = if (v0 % (arg2 as u128) > 0) {
            1
        } else {
            0
        };
        let v2 = v0 / (arg2 as u128) + v1;
        assert!(v2 <= 18446744073709551615, 5);
        (v2 as u64)
    }

    public fun checked_sum(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 5);
        (v0 as u64)
    }

    public fun default_rounds() : u64 {
        2
    }

    public fun double_clamped(arg0: u64, arg1: u64) : u64 {
        (0x1::u128::min((arg0 as u128) * 2, (arg1 as u128)) as u64)
    }

    public fun finished(arg0: &Search) : bool {
        arg0.round >= arg0.rounds
    }

    public fun floor_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 5);
        (v0 as u64)
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : Search {
        let v0 = if (arg0 >= 1000000) {
            if (arg1 <= 300000000000) {
                if (arg0 <= arg2) {
                    arg2 <= arg1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(arg3 > 0 && arg3 <= 6, 2);
        Search{
            min     : arg0,
            max     : arg1,
            rounds  : arg3,
            round   : 0,
            left    : 0x1::u64::max(arg2 / 2, arg0),
            center  : arg2,
            right   : double_clamped(arg2, arg1),
            visited : vector[],
            scores  : vector[],
            best    : 0,
            output  : 0,
            fee     : 0,
            score   : 0,
        }
    }

    public fun qualifies(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg1 > 0 && (arg1 as u128) >= (arg0 as u128) + (arg2 as u128) + (arg3 as u128)
    }

    public fun record(arg0: &mut Search, arg1: u64, arg2: u64, arg3: u64, arg4: bool) {
        assert!(arg0.round < arg0.rounds && 0x1::vector::length<u64>(&arg0.visited) < arg0.rounds * 3, 4);
        let v0 = if (arg1 == arg0.left) {
            true
        } else if (arg1 == arg0.center) {
            true
        } else {
            arg1 == arg0.right
        };
        assert!(v0, 4);
        assert!(!0x1::vector::contains<u64>(&arg0.visited, &arg1), 3);
        let v1 = if (arg4 && arg2 > 0) {
            36893488147419103232 + (arg2 as u128) - (arg1 as u128) - (arg3 as u128)
        } else {
            0
        };
        0x1::vector::push_back<u64>(&mut arg0.visited, arg1);
        0x1::vector::push_back<u128>(&mut arg0.scores, v1);
        let v2 = if (v1 > arg0.score) {
            true
        } else if (v1 > 0) {
            if (v1 == arg0.score) {
                arg1 < arg0.best
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            arg0.best = arg1;
            arg0.output = arg2;
            arg0.fee = arg3;
            arg0.score = v1;
        };
    }

    public fun result(arg0: &Search) : (u64, u64, u64, u64) {
        (arg0.best, arg0.output, arg0.fee, 0x1::vector::length<u64>(&arg0.visited))
    }

    fun score_at(arg0: &Search, arg1: u64) : u128 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.visited)) {
            if (*0x1::vector::borrow<u64>(&arg0.visited, v0) == arg1) {
                return *0x1::vector::borrow<u128>(&arg0.scores, v0)
            };
            v0 = v0 + 1;
        };
        abort 4
    }

    // decompiled from Move bytecode v7
}

