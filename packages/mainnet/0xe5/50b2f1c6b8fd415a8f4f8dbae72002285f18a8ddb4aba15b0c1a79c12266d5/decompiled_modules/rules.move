module 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules {
    struct Rules has copy, drop, store {
        values: 0x2::vec_map::VecMap<u8, u64>,
    }

    public fun empty() : Rules {
        Rules{values: 0x2::vec_map::empty<u8, u64>()}
    }

    public fun get(arg0: &Rules, arg1: u8) : u64 {
        if (0x2::vec_map::contains<u8, u64>(&arg0.values, &arg1)) {
            *0x2::vec_map::get<u8, u64>(&arg0.values, &arg1)
        } else {
            default_of(arg1)
        }
    }

    public fun add_max_bps() : u8 {
        12
    }

    public fun default_of(arg0: u8) : u64 {
        if (arg0 == 0) {
            7 * 86400000
        } else if (arg0 == 1) {
            86400000
        } else if (arg0 == 2) {
            86400000
        } else if (arg0 == 3) {
            7 * 86400000
        } else if (arg0 == 4) {
            100
        } else if (arg0 == 5) {
            2000
        } else if (arg0 == 6) {
            7 * 86400000
        } else if (arg0 == 7) {
            100
        } else if (arg0 == 8) {
            5000
        } else if (arg0 == 10) {
            100
        } else if (arg0 == 11) {
            5000
        } else if (arg0 == 12) {
            500
        } else if (arg0 == 13) {
            500
        } else if (arg0 == 14) {
            1000
        } else if (arg0 == 15) {
            30 * 86400000
        } else if (arg0 == 16) {
            12
        } else if (arg0 == 24) {
            5000
        } else if (arg0 == 25) {
            2500
        } else if (arg0 == 40) {
            5000
        } else if (arg0 == 41) {
            7
        } else if (arg0 == 42) {
            1500
        } else if (arg0 == 43) {
            2500
        } else if (arg0 == 44) {
            10000000000
        } else {
            assert!(arg0 == 45, 300);
            500
        }
    }

    public fun delay_ms() : u8 {
        1
    }

    public fun exit_lock_ms() : u8 {
        3
    }

    public fun in_range(arg0: u8, arg1: u64) : bool {
        if (!known(arg0)) {
            false
        } else if (arg0 == 0 || arg0 == 1) {
            arg1 >= 3600000 && arg1 <= 30 * 86400000
        } else if (arg0 == 2) {
            arg1 <= 30 * 86400000
        } else if (arg0 == 3) {
            arg1 <= 7 * 86400000
        } else if (arg0 == 6) {
            arg1 <= 90 * 86400000
        } else if (arg0 == 15) {
            arg1 <= 365 * 86400000
        } else if (arg0 == 4) {
            arg1 >= 1 && arg1 <= 1000
        } else if (arg0 == 5) {
            arg1 <= 5000
        } else if (arg0 == 8) {
            arg1 >= 5000 && arg1 <= 10000
        } else if (arg0 == 10) {
            arg1 >= 1 && arg1 <= 10000
        } else {
            let v1 = if (arg0 == 11) {
                true
            } else if (arg0 == 12) {
                true
            } else if (arg0 == 13) {
                true
            } else {
                arg0 == 14
            };
            v1 && arg1 >= 1 && arg1 <= 10000 || arg0 == 16 && arg1 >= 1 && arg1 <= 20 || arg0 == 24 && arg1 <= 10000 || arg0 == 25 && arg1 >= 1 && arg1 <= 10000 || (arg0 == 42 || arg0 == 45) && arg1 <= 10000 || (arg0 == 43 || arg0 == 44) && arg1 >= 1 || true
        }
    }

    public fun increase_max_bps() : u8 {
        13
    }

    public fun keeper_daily_out_bps() : u8 {
        25
    }

    public fun known(arg0: u8) : bool {
        if (arg0 <= 8) {
            true
        } else if (arg0 >= 10 && arg0 <= 16) {
            true
        } else if (arg0 >= 24 && arg0 <= 25) {
            true
        } else {
            arg0 >= 40 && arg0 <= 45
        }
    }

    public fun lock_age_ms() : u8 {
        2
    }

    public fun majority_bps() : u8 {
        8
    }

    public fun max_bps() : u8 {
        11
    }

    public fun max_coins() : u8 {
        16
    }

    public fun min_bps() : u8 {
        10
    }

    public fun note_min_bps() : u8 {
        7
    }

    public fun plurality_bps() : u8 {
        5
    }

    public fun pol_share_bps() : u8 {
        24
    }

    public fun propose_bps() : u8 {
        4
    }

    public fun raise_cooldown_ms() : u8 {
        6
    }

    public(friend) fun set(arg0: &mut Rules, arg1: u8, arg2: u64) {
        if (0x2::vec_map::contains<u8, u64>(&arg0.values, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<u8, u64>(&mut arg0.values, &arg1);
        };
        0x2::vec_map::insert<u8, u64>(&mut arg0.values, arg1, arg2);
    }

    public fun vote_ms() : u8 {
        0
    }

    public fun young_max_bps() : u8 {
        14
    }

    public fun young_ms() : u8 {
        15
    }

    // decompiled from Move bytecode v7
}

