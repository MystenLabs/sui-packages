module 0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::level_dividend {
    struct DividendItem has copy, drop, store {
        user: address,
        amount: u64,
    }

    struct LevelDividend has key {
        id: 0x2::object::UID,
        p6_users: vector<address>,
        p7_users: vector<address>,
        p8_users: vector<address>,
        p9_users: vector<address>,
        total_dividend_amount: u64,
        p6_ratio: u64,
        p7_ratio: u64,
        p8_ratio: u64,
        p9_ratio: u64,
    }

    fun add_user(arg0: &mut LevelDividend, arg1: address, arg2: u8) {
        if (arg2 == 6) {
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

    fun contains_any(arg0: &LevelDividend, arg1: address) : bool {
        if (contains(&arg0.p6_users, arg1)) {
            true
        } else if (contains(&arg0.p7_users, arg1)) {
            true
        } else if (contains(&arg0.p8_users, arg1)) {
            true
        } else {
            contains(&arg0.p9_users, arg1)
        }
    }

    public fun create_level_dividend(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(@0xed32c207b585e6861bb7b75ee3ea491d61e0e8c9034d3b1fab24aafc994c61ca == 0x2::tx_context::sender(arg0), 1);
        let v0 = LevelDividend{
            id                    : 0x2::object::new(arg0),
            p6_users              : 0x1::vector::empty<address>(),
            p7_users              : 0x1::vector::empty<address>(),
            p8_users              : 0x1::vector::empty<address>(),
            p9_users              : 0x1::vector::empty<address>(),
            total_dividend_amount : 600000000,
            p6_ratio              : 95,
            p7_ratio              : 0,
            p8_ratio              : 0,
            p9_ratio              : 5,
        };
        0x2::transfer::share_object<LevelDividend>(v0);
    }

    public(friend) fun distribute(arg0: &LevelDividend, arg1: u64) : vector<DividendItem> {
        let v0 = 0x1::vector::empty<DividendItem>();
        if (arg1 == 0) {
            return v0
        };
        let v1 = arg1 * arg0.p6_ratio / 100;
        let v2 = arg1 * arg0.p7_ratio / 100;
        let v3 = arg1 * arg0.p8_ratio / 100;
        let v4 = &mut v0;
        distribute_level(&arg0.p6_users, 0x1::vector::length<address>(&arg0.p6_users), v1, v4);
        let v5 = &mut v0;
        distribute_level(&arg0.p7_users, 0x1::vector::length<address>(&arg0.p7_users), v2, v5);
        let v6 = &mut v0;
        distribute_level(&arg0.p8_users, 0x1::vector::length<address>(&arg0.p8_users), v3, v6);
        let v7 = &mut v0;
        distribute_level(&arg0.p9_users, 0x1::vector::length<address>(&arg0.p9_users), arg1 - v1 - v2 - v3, v7);
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

    public fun init_level_data(arg0: &mut LevelDividend, arg1: vector<address>, arg2: vector<address>, arg3: vector<address>, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(@0xed32c207b585e6861bb7b75ee3ea491d61e0e8c9034d3b1fab24aafc994c61ca == 0x2::tx_context::sender(arg5), 1);
        reset_users(arg0);
        init_level_users(arg0, arg1, 6);
        init_level_users(arg0, arg2, 7);
        init_level_users(arg0, arg3, 8);
        init_level_users(arg0, arg4, 9);
    }

    fun init_level_users(arg0: &mut LevelDividend, arg1: vector<address>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            assert!(!contains_any(arg0, v1), 2);
            add_user(arg0, v1, arg2);
            v0 = v0 + 1;
        };
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
        if (arg2 == 6) {
            let v0 = &mut arg0.p6_users;
            remove_from_list(v0, arg1);
        } else if (arg2 == 7) {
            let v1 = &mut arg0.p7_users;
            remove_from_list(v1, arg1);
        } else if (arg2 == 8) {
            let v2 = &mut arg0.p8_users;
            remove_from_list(v2, arg1);
        } else if (arg2 == 9) {
            let v3 = &mut arg0.p9_users;
            remove_from_list(v3, arg1);
        };
    }

    fun reset_users(arg0: &mut LevelDividend) {
        arg0.p6_users = 0x1::vector::empty<address>();
        arg0.p7_users = 0x1::vector::empty<address>();
        arg0.p8_users = 0x1::vector::empty<address>();
        arg0.p9_users = 0x1::vector::empty<address>();
    }

    public fun set_ratios(arg0: &mut LevelDividend, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(@0xed32c207b585e6861bb7b75ee3ea491d61e0e8c9034d3b1fab24aafc994c61ca == 0x2::tx_context::sender(arg5), 1);
        assert!(arg1 + arg2 + arg3 + arg4 == 100, 3);
        arg0.p6_ratio = arg1;
        arg0.p7_ratio = arg2;
        arg0.p8_ratio = arg3;
        arg0.p9_ratio = arg4;
    }

    public fun set_total_dividend_amount(arg0: &mut LevelDividend, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xed32c207b585e6861bb7b75ee3ea491d61e0e8c9034d3b1fab24aafc994c61ca == 0x2::tx_context::sender(arg2), 1);
        arg0.total_dividend_amount = arg1;
    }

    public fun total_dividend_amount(arg0: &LevelDividend) : u64 {
        arg0.total_dividend_amount
    }

    public(friend) fun update_user_level(arg0: &mut LevelDividend, arg1: address, arg2: u8, arg3: u8) {
        remove_user(arg0, arg1, arg2);
        add_user(arg0, arg1, arg3);
    }

    // decompiled from Move bytecode v7
}

