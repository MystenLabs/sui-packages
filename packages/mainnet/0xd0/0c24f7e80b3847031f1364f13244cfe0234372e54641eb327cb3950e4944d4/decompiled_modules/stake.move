module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::stake {
    struct StakeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        g_rate: u64,
        l_rate: u64,
    }

    struct StakeLedger has key {
        id: 0x2::object::UID,
        version: u64,
        entries: 0x2::table::Table<0x2::object::ID, Entry>,
    }

    struct Entry has copy, drop, store {
        last_ms: u64,
        owner: address,
    }

    struct Started has copy, drop {
        by: address,
        card: 0x2::object::ID,
    }

    struct Claimed has copy, drop {
        by: address,
        card: 0x2::object::ID,
        pearls: u64,
    }

    fun assert_rate(arg0: u64, arg1: u64) {
        assert!(arg0 <= 200 && arg1 <= 200, 1);
    }

    public fun claim(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling, arg1: &StakeConfig, arg2: &mut StakeLedger, arg3: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 0);
        assert!(arg2.version == 1, 0);
        let v0 = rate_for(arg1, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::rarity(arg0));
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::object::id<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(arg0);
        let v4 = 0;
        if (0x2::table::contains<0x2::object::ID, Entry>(&arg2.entries, v3)) {
            let v5 = 0x2::table::borrow_mut<0x2::object::ID, Entry>(&mut arg2.entries, v3);
            if (v5.owner == v2) {
                if (v1 > v5.last_ms) {
                    v4 = (v1 - v5.last_ms) * v0 / 86400000;
                };
                if (v4 > 0) {
                    v5.last_ms = v5.last_ms + v4 * 86400000 / v0;
                };
            } else {
                v5.owner = v2;
                v5.last_ms = v1;
            };
        } else {
            let v6 = Entry{
                last_ms : v1,
                owner   : v2,
            };
            0x2::table::add<0x2::object::ID, Entry>(&mut arg2.entries, v3, v6);
            let v7 = Started{
                by   : v2,
                card : v3,
            };
            0x2::event::emit<Started>(v7);
        };
        if (v4 > 0) {
            0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::award_soulbound(arg3, v2, v4);
        };
        let v8 = Claimed{
            by     : v2,
            card   : v3,
            pearls : v4,
        };
        0x2::event::emit<Claimed>(v8);
    }

    public fun g_rate(arg0: &StakeConfig) : u64 {
        arg0.g_rate
    }

    public fun l_rate(arg0: &StakeConfig) : u64 {
        arg0.l_rate
    }

    public fun migrate_config(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut StakeConfig) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public fun migrate_ledger(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut StakeLedger) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public fun new_config(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_rate(arg1, arg2);
        let v0 = StakeConfig{
            id      : 0x2::object::new(arg3),
            version : 1,
            g_rate  : arg1,
            l_rate  : arg2,
        };
        0x2::transfer::share_object<StakeConfig>(v0);
    }

    public fun new_ledger(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeLedger{
            id      : 0x2::object::new(arg1),
            version : 1,
            entries : 0x2::table::new<0x2::object::ID, Entry>(arg1),
        };
        0x2::transfer::share_object<StakeLedger>(v0);
    }

    fun rate_for(arg0: &StakeConfig, arg1: &0x1::string::String) : u64 {
        if (*arg1 == 0x1::string::utf8(b"G")) {
            arg0.g_rate
        } else if (*arg1 == 0x1::string::utf8(b"L")) {
            arg0.l_rate
        } else {
            0
        }
    }

    public fun set_rates(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut StakeConfig, arg2: u64, arg3: u64) {
        assert!(arg1.version == 1, 0);
        assert_rate(arg2, arg3);
        arg1.g_rate = arg2;
        arg1.l_rate = arg3;
    }

    // decompiled from Move bytecode v7
}

