module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket {
    struct Match has copy, drop, store {
        a: 0x1::option::Option<u64>,
        b: 0x1::option::Option<u64>,
        available_ms: u64,
        state: u8,
        winner: 0x1::option::Option<u64>,
        loser: 0x1::option::Option<u64>,
    }

    public fun empty() : vector<Match> {
        0x1::vector::empty<Match>()
    }

    fun activate(arg0: &mut Match, arg1: u64) {
        arg0.available_ms = arg1;
        arg0.state = 1;
        if (0x1::option::is_none<u64>(&arg0.a) || 0x1::option::is_none<u64>(&arg0.b)) {
            let v0 = if (0x1::option::is_some<u64>(&arg0.a)) {
                arg0.a
            } else {
                arg0.b
            };
            arg0.winner = v0;
            arg0.state = 2;
        };
    }

    fun advance(arg0: &mut vector<Match>, arg1: u64) {
        let v0 = tree_count(arg0);
        let v1 = v0;
        while (v1 > 0) {
            v1 = v1 - 1;
            if (0x1::vector::borrow<Match>(arg0, v1).state != 0) {
                continue
            };
            if (2 * v1 + 1 < v0) {
                let v2 = 0x1::vector::borrow<Match>(arg0, 2 * v1 + 1);
                let v3 = 0x1::vector::borrow<Match>(arg0, 2 * v1 + 2);
                if (v2.state != 2 || v3.state != 2) {
                    continue
                };
                0x1::vector::borrow_mut<Match>(arg0, v1).a = v2.winner;
                0x1::vector::borrow_mut<Match>(arg0, v1).b = v3.winner;
            };
            let v4 = 0x1::vector::borrow_mut<Match>(arg0, v1);
            activate(v4, arg1);
        };
        let v5 = if (v0 > 1) {
            if (0x1::vector::borrow<Match>(arg0, v0).state == 0) {
                if (0x1::vector::borrow<Match>(arg0, 1).state == 2) {
                    0x1::vector::borrow<Match>(arg0, 2).state == 2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            0x1::vector::borrow_mut<Match>(arg0, v0).a = 0x1::vector::borrow<Match>(arg0, 1).loser;
            0x1::vector::borrow_mut<Match>(arg0, v0).b = 0x1::vector::borrow<Match>(arg0, 2).loser;
            let v6 = 0x1::vector::borrow_mut<Match>(arg0, v0);
            activate(v6, arg1);
        };
    }

    public fun available_ms(arg0: &Match) : u64 {
        arg0.available_ms
    }

    public fun done(arg0: &vector<Match>) : bool {
        let v0 = tree_count(arg0);
        0x1::vector::borrow<Match>(arg0, 0).state == 2 && (v0 == 1 || 0x1::vector::borrow<Match>(arg0, v0).state == 2)
    }

    fun empty_match() : Match {
        Match{
            a            : 0x1::option::none<u64>(),
            b            : 0x1::option::none<u64>(),
            available_ms : 0,
            state        : 0,
            winner       : 0x1::option::none<u64>(),
            loser        : 0x1::option::none<u64>(),
        }
    }

    public fun loser(arg0: &Match) : 0x1::option::Option<u64> {
        arg0.loser
    }

    public fun max_teams() : u64 {
        64
    }

    public fun minimum_teams(arg0: &vector<u64>, arg1: &vector<u64>, arg2: vector<u8>) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < 5) {
            if (*0x1::vector::borrow<u64>(arg0, v1) > 0 || *0x1::vector::borrow<u64>(arg1, v1) > 0) {
                v0 = v1 + 1;
            };
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg2)) {
            v0 = 0x1::u64::max(v0, (*0x1::vector::borrow<u8>(&arg2, v1) as u64));
            v1 = v1 + 1;
        };
        if (v0 >= 5) {
            8
        } else if (v0 >= 3) {
            4
        } else {
            2
        }
    }

    public fun new(arg0: vector<u64>, arg1: u64) : vector<Match> {
        let v0 = 0x1::vector::length<u64>(&arg0);
        let v1 = if (v0 >= 2) {
            if (v0 <= 64) {
                arg1 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3301);
        let v2 = 2;
        while (v2 < v0) {
            v2 = v2 * 2;
        };
        let v3 = 0x1::vector::empty<Match>();
        let v4 = 0;
        while (v4 < v2 - 1) {
            0x1::vector::push_back<Match>(&mut v3, empty_match());
            v4 = v4 + 1;
        };
        if (v2 >= 4) {
            0x1::vector::push_back<Match>(&mut v3, empty_match());
        };
        v4 = 0;
        while (v4 < v2 / 2) {
            let v5 = 0x1::vector::borrow_mut<Match>(&mut v3, v2 / 2 - 1 + v4);
            v5.a = 0x1::option::some<u64>(*0x1::vector::borrow<u64>(&arg0, v4));
            if (v4 + v2 / 2 < v0) {
                v5.b = 0x1::option::some<u64>(*0x1::vector::borrow<u64>(&arg0, v4 + v2 / 2));
            };
            v4 = v4 + 1;
        };
        let v6 = &mut v3;
        advance(v6, arg1);
        v3
    }

    public fun placement(arg0: &vector<Match>, arg1: u64) : u8 {
        assert!(done(arg0), 3302);
        let v0 = 0x1::option::some<u64>(arg1);
        if (0x1::vector::borrow<Match>(arg0, 0).winner == v0) {
            return 1
        };
        if (0x1::vector::borrow<Match>(arg0, 0).loser == v0) {
            return 2
        };
        let v1 = tree_count(arg0);
        if (v1 > 1) {
            if (0x1::vector::borrow<Match>(arg0, v1).winner == v0) {
                return 3
            };
            if (0x1::vector::borrow<Match>(arg0, v1).loser == v0) {
                return 4
            };
        };
        if (v1 >= 7) {
            let v2 = 3;
            while (v2 < 7) {
                if (0x1::vector::borrow<Match>(arg0, v2).loser == v0) {
                    return 5
                };
                v2 = v2 + 1;
            };
        };
        0
    }

    public fun resolve(arg0: &mut vector<Match>, arg1: u64, arg2: 0x1::option::Option<u8>, arg3: bool, arg4: u64) {
        let v0 = 0x1::vector::borrow_mut<Match>(arg0, arg1);
        assert!(v0.state == 1, 3302);
        v0.state = 2;
        if (0x1::option::is_some<u8>(&arg2)) {
            let v1 = 0x1::option::destroy_some<u8>(arg2);
            assert!(v1 <= 1, 3301);
            let v2 = if (v1 == 0) {
                v0.a
            } else {
                v0.b
            };
            v0.winner = v2;
            if (arg3) {
                let v3 = if (v1 == 0) {
                    v0.b
                } else {
                    v0.a
                };
                v0.loser = v3;
            };
        };
        advance(arg0, arg4);
    }

    public fun state(arg0: &Match) : u8 {
        arg0.state
    }

    public fun team(arg0: &Match, arg1: u8) : u64 {
        assert!(arg1 <= 1, 3301);
        if (arg1 == 0) {
            0x1::option::destroy_some<u64>(arg0.a)
        } else {
            0x1::option::destroy_some<u64>(arg0.b)
        }
    }

    fun tree_count(arg0: &vector<Match>) : u64 {
        if (0x1::vector::length<Match>(arg0) == 1) {
            1
        } else {
            0x1::vector::length<Match>(arg0) - 1
        }
    }

    public fun validate_bps(arg0: &vector<u64>) {
        assert!(0x1::vector::length<u64>(arg0) == 5, 3303);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 5) {
            assert!(*0x1::vector::borrow<u64>(arg0, v1) <= 10000, 3303);
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        assert!(v0 == 10000, 3303);
    }

    public fun winner(arg0: &Match) : 0x1::option::Option<u64> {
        arg0.winner
    }

    // decompiled from Move bytecode v7
}

