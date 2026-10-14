module 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::search {
    struct Search has copy, drop, store {
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
        let v0 = arg0.left;
        let v1 = arg0.center;
        let v2 = arg0.right;
        let v3 = score_of(arg0, v0);
        let v4 = score_of(arg0, v1);
        let v5 = score_of(arg0, v2);
        let v6 = if (v5 > v4 && v5 >= v3) {
            v2
        } else if (v3 > v4) {
            v0
        } else {
            v1
        };
        if (v6 == v2 && v2 < arg0.max) {
            arg0.left = v1;
            arg0.center = v2;
            let v7 = if (v2 - v1 > (arg0.max - v2) / 2) {
                arg0.max
            } else {
                v2 + 2 * (v2 - v1)
            };
            arg0.right = v7;
        } else if (v6 == v0 && v0 > arg0.min) {
            arg0.right = v1;
            arg0.center = v0;
            arg0.left = 0x1::u64::max(v0 - (v1 - v0) / 2, arg0.min);
        } else {
            let (v8, v9) = if (v6 == v2) {
                (v2, v1)
            } else {
                let v10 = if (v6 == v0) {
                    v1
                } else {
                    v2
                };
                (v10, v0)
            };
            arg0.left = v6 - (v6 - v9) / 2;
            arg0.center = v6;
            arg0.right = v6 + (v8 - v6) / 2;
        };
        arg0.round = arg0.round + 1;
    }

    public fun best(arg0: &Search) : u64 {
        arg0.best
    }

    public fun candidates(arg0: &Search) : vector<u64> {
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

    fun double_clamped(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1 / 2) {
            arg1
        } else {
            arg0 * 2
        }
    }

    public fun evaluations(arg0: &Search) : u64 {
        0x1::vector::length<u64>(&arg0.visited)
    }

    public fun fee(arg0: &Search) : u64 {
        arg0.fee
    }

    public fun is_finished(arg0: &Search) : bool {
        arg0.round >= arg0.rounds
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : Search {
        let v0 = if (0 < arg0) {
            if (arg0 <= arg2) {
                arg2 <= arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(1 <= arg3 && arg3 <= 6, 2);
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

    public fun output(arg0: &Search) : u64 {
        arg0.output
    }

    public fun qualifies(arg0: &Search, arg1: u64) : bool {
        arg0.score > 36893488147419103232 && arg0.score - 36893488147419103232 >= (arg1 as u128)
    }

    public fun record(arg0: &mut Search, arg1: u64, arg2: u64, arg3: u64) {
        assert!(!0x1::vector::contains<u64>(&arg0.visited, &arg1), 3);
        let v0 = (arg2 as u128) + 36893488147419103232 - (arg1 as u128) - (arg3 as u128);
        0x1::vector::push_back<u64>(&mut arg0.visited, arg1);
        0x1::vector::push_back<u128>(&mut arg0.scores, v0);
        if (v0 > arg0.score) {
            arg0.best = arg1;
            arg0.output = arg2;
            arg0.fee = arg3;
            arg0.score = v0;
        };
    }

    fun score_of(arg0: &Search, arg1: u64) : u128 {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.visited, &arg1);
        assert!(v0, 4);
        *0x1::vector::borrow<u128>(&arg0.scores, v1)
    }

    // decompiled from Move bytecode v7
}

