module 0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::level_dividend {
    struct DividendItem has copy, drop, store {
        user: address,
        amount: u64,
    }

    struct LevelDividend has key {
        id: 0x2::object::UID,
        p4_users: vector<address>,
        p5_users: vector<address>,
        p6_users: vector<address>,
        p7_users: vector<address>,
        p8_users: vector<address>,
        p9_users: vector<address>,
        p4_ratio: u64,
        p5_ratio: u64,
        p6_ratio: u64,
        p7_ratio: u64,
        p8_ratio: u64,
        p9_ratio: u64,
    }

    fun add_user(arg0: &mut LevelDividend, arg1: address, arg2: u8) {
        if (arg2 < 4 || arg2 > 9) {
            return
        };
        if (arg2 == 4) {
            if (!contains(&arg0.p4_users, arg1)) {
                0x1::vector::push_back<address>(&mut arg0.p4_users, arg1);
            };
        } else if (arg2 == 5) {
            if (!contains(&arg0.p5_users, arg1)) {
                0x1::vector::push_back<address>(&mut arg0.p5_users, arg1);
            };
        } else if (arg2 == 6) {
            if (!contains(&arg0.p6_users, arg1)) {
                0x1::vector::push_back<address>(&mut arg0.p6_users, arg1);
            };
        } else if (arg2 == 7) {
            if (!contains(&arg0.p7_users, arg1)) {
                0x1::vector::push_back<address>(&mut arg0.p7_users, arg1);
            };
        } else if (arg2 == 8) {
            if (!contains(&arg0.p8_users, arg1)) {
                0x1::vector::push_back<address>(&mut arg0.p8_users, arg1);
            };
        } else if (arg2 == 9) {
            if (!contains(&arg0.p9_users, arg1)) {
                0x1::vector::push_back<address>(&mut arg0.p9_users, arg1);
            };
        };
    }

    fun calc_ratio_pool(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        arg0 * arg1 / 100
    }

    fun contains(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun distribute(arg0: &LevelDividend, arg1: u64) : vector<DividendItem> {
        let v0 = 0x1::vector::empty<DividendItem>();
        if (arg1 == 0) {
            return v0
        };
        let v1 = calc_ratio_pool(arg1, arg0.p4_ratio);
        let v2 = calc_ratio_pool(arg1, arg0.p5_ratio);
        let v3 = calc_ratio_pool(arg1, arg0.p6_ratio);
        let v4 = calc_ratio_pool(arg1, arg0.p7_ratio);
        let v5 = calc_ratio_pool(arg1, arg0.p8_ratio);
        let v6 = &mut v0;
        distribute_level(&arg0.p4_users, 0x1::vector::length<address>(&arg0.p4_users), v1, v6);
        let v7 = &mut v0;
        distribute_level(&arg0.p5_users, 0x1::vector::length<address>(&arg0.p5_users), v2, v7);
        let v8 = &mut v0;
        distribute_level(&arg0.p6_users, 0x1::vector::length<address>(&arg0.p6_users), v3, v8);
        let v9 = &mut v0;
        distribute_level(&arg0.p7_users, 0x1::vector::length<address>(&arg0.p7_users), v4, v9);
        let v10 = &mut v0;
        distribute_level(&arg0.p8_users, 0x1::vector::length<address>(&arg0.p8_users), v5, v10);
        let v11 = &mut v0;
        distribute_level(&arg0.p9_users, 0x1::vector::length<address>(&arg0.p9_users), arg1 - v1 - v2 - v3 - v4 - v5, v11);
        v0
    }

    fun distribute_level(arg0: &vector<address>, arg1: u64, arg2: u64, arg3: &mut vector<DividendItem>) {
        if (arg1 == 0 || arg2 == 0) {
            return
        };
        let v0 = arg2 / arg1;
        let v1 = arg2 - v0 * arg1;
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = v0;
            if (v1 > 0) {
                v3 = v0 + 1;
                v1 = v1 - 1;
            };
            let v4 = DividendItem{
                user   : *0x1::vector::borrow<address>(arg0, v2),
                amount : v3,
            };
            0x1::vector::push_back<DividendItem>(arg3, v4);
            v2 = v2 + 1;
        };
    }

    public fun get_amount(arg0: &DividendItem) : u64 {
        arg0.amount
    }

    public fun get_user(arg0: &DividendItem) : address {
        arg0.user
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LevelDividend{
            id       : 0x2::object::new(arg0),
            p4_users : vector[],
            p5_users : vector[],
            p6_users : vector[],
            p7_users : vector[],
            p8_users : vector[],
            p9_users : vector[],
            p4_ratio : 29,
            p5_ratio : 24,
            p6_ratio : 19,
            p7_ratio : 14,
            p8_ratio : 9,
            p9_ratio : 5,
        };
        0x2::transfer::share_object<LevelDividend>(v0);
    }

    public fun p4_count(arg0: &LevelDividend) : u64 {
        0x1::vector::length<address>(&arg0.p4_users)
    }

    public fun p5_count(arg0: &LevelDividend) : u64 {
        0x1::vector::length<address>(&arg0.p5_users)
    }

    public fun p6_count(arg0: &LevelDividend) : u64 {
        0x1::vector::length<address>(&arg0.p6_users)
    }

    public fun p7_count(arg0: &LevelDividend) : u64 {
        0x1::vector::length<address>(&arg0.p7_users)
    }

    public fun p8_count(arg0: &LevelDividend) : u64 {
        0x1::vector::length<address>(&arg0.p8_users)
    }

    public fun p9_count(arg0: &LevelDividend) : u64 {
        0x1::vector::length<address>(&arg0.p9_users)
    }

    fun remove_from_list(arg0: &mut vector<address>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                0x1::vector::swap_remove<address>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    fun remove_user(arg0: &mut LevelDividend, arg1: address, arg2: u8) {
        if (arg2 < 4 || arg2 > 9) {
            return
        };
        if (arg2 == 4) {
            let v0 = &mut arg0.p4_users;
            remove_from_list(v0, arg1);
        } else if (arg2 == 5) {
            let v1 = &mut arg0.p5_users;
            remove_from_list(v1, arg1);
        } else if (arg2 == 6) {
            let v2 = &mut arg0.p6_users;
            remove_from_list(v2, arg1);
        } else if (arg2 == 7) {
            let v3 = &mut arg0.p7_users;
            remove_from_list(v3, arg1);
        } else if (arg2 == 8) {
            let v4 = &mut arg0.p8_users;
            remove_from_list(v4, arg1);
        } else if (arg2 == 9) {
            let v5 = &mut arg0.p9_users;
            remove_from_list(v5, arg1);
        };
    }

    public(friend) fun set_ratios(arg0: &mut LevelDividend, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg1 + arg2 + arg3 + arg4 + arg5 + arg6 == 100, 3);
        arg0.p4_ratio = arg1;
        arg0.p5_ratio = arg2;
        arg0.p6_ratio = arg3;
        arg0.p7_ratio = arg4;
        arg0.p8_ratio = arg5;
        arg0.p9_ratio = arg6;
    }

    public(friend) fun update_user_level(arg0: &mut LevelDividend, arg1: address, arg2: u8, arg3: u8) {
        remove_user(arg0, arg1, arg2);
        add_user(arg0, arg1, arg3);
    }

    // decompiled from Move bytecode v7
}

