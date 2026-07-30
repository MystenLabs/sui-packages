module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::StakePearl {
    struct StakeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        g_rate: u64,
        l_rate: u64,
        g_cap: u64,
        l_cap: u64,
    }

    struct StakeLedger has key {
        id: 0x2::object::UID,
        version: u64,
        entries: 0x2::table::Table<0x2::object::ID, Entry>,
        counts: 0x2::table::Table<address, Slots>,
    }

    struct Entry has copy, drop, store {
        last_ms: u64,
        owner: address,
        g: bool,
    }

    struct Slots has copy, drop, store {
        l: u64,
        g: u64,
    }

    struct Staked has copy, drop {
        by: address,
        card: 0x2::object::ID,
    }

    struct Unstaked has copy, drop {
        by: address,
        card: 0x2::object::ID,
        pearls: u64,
    }

    struct Claimed has copy, drop {
        by: address,
        card: 0x2::object::ID,
        pearls: u64,
    }

    public fun admin_evict(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut StakeLedger, arg2: 0x2::object::ID) {
        assert!(arg1.version == 2, 0);
        assert!(0x2::table::contains<0x2::object::ID, Entry>(&arg1.entries, arg2), 5);
        let v0 = 0x2::table::remove<0x2::object::ID, Entry>(&mut arg1.entries, arg2);
        let v1 = &mut arg1.counts;
        dec_slot(v1, v0.owner, v0.g);
    }

    fun assert_cap(arg0: u64, arg1: u64) {
        assert!(arg0 <= 1000 && arg1 <= 1000, 6);
    }

    fun assert_rate(arg0: u64, arg1: u64) {
        assert!(arg0 <= 200 && arg1 <= 200, 1);
    }

    public fun claim(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling, arg1: &StakeConfig, arg2: &mut StakeLedger, arg3: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 2 && arg2.version == 2, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(arg0);
        if (!0x2::table::contains<0x2::object::ID, Entry>(&arg2.entries, v1)) {
            return
        };
        if (0x2::table::borrow<0x2::object::ID, Entry>(&arg2.entries, v1).owner != v0) {
            return
        };
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, Entry>(&mut arg2.entries, v1);
        let v3 = Claimed{
            by     : v0,
            card   : v1,
            pearls : pay(v2, rate_for(arg1, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::rarity(arg0)), 0x2::clock::timestamp_ms(arg4), v0, arg3),
        };
        0x2::event::emit<Claimed>(v3);
    }

    fun dec_slot(arg0: &mut 0x2::table::Table<address, Slots>, arg1: address, arg2: bool) {
        if (0x2::table::contains<address, Slots>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, Slots>(arg0, arg1);
            if (arg2) {
                if (v0.g > 0) {
                    v0.g = v0.g - 1;
                };
            } else if (v0.l > 0) {
                v0.l = v0.l - 1;
            };
        };
    }

    public fun g_cap(arg0: &StakeConfig) : u64 {
        arg0.g_cap
    }

    public fun g_rate(arg0: &StakeConfig) : u64 {
        arg0.g_rate
    }

    fun inc_slot(arg0: &mut 0x2::table::Table<address, Slots>, arg1: address, arg2: bool, arg3: u64, arg4: u64) {
        if (!0x2::table::contains<address, Slots>(arg0, arg1)) {
            let v0 = Slots{
                l : 0,
                g : 0,
            };
            0x2::table::add<address, Slots>(arg0, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, Slots>(arg0, arg1);
        if (arg2) {
            assert!(v1.g < arg3, 4);
            v1.g = v1.g + 1;
        } else {
            assert!(v1.l < arg4, 4);
            v1.l = v1.l + 1;
        };
    }

    fun is_g(arg0: &0x1::string::String) : bool {
        *arg0 == 0x1::string::utf8(b"G")
    }

    fun is_l(arg0: &0x1::string::String) : bool {
        *arg0 == 0x1::string::utf8(b"L")
    }

    public fun is_staked(arg0: &StakeLedger, arg1: 0x2::object::ID, arg2: address) : bool {
        0x2::table::contains<0x2::object::ID, Entry>(&arg0.entries, arg1) && 0x2::table::borrow<0x2::object::ID, Entry>(&arg0.entries, arg1).owner == arg2
    }

    public fun l_cap(arg0: &StakeConfig) : u64 {
        arg0.l_cap
    }

    public fun l_rate(arg0: &StakeConfig) : u64 {
        arg0.l_rate
    }

    public fun new_config(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_rate(arg1, arg2);
        assert_cap(arg3, arg4);
        let v0 = StakeConfig{
            id      : 0x2::object::new(arg5),
            version : 2,
            g_rate  : arg1,
            l_rate  : arg2,
            g_cap   : arg3,
            l_cap   : arg4,
        };
        0x2::transfer::share_object<StakeConfig>(v0);
    }

    public fun new_ledger(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeLedger{
            id      : 0x2::object::new(arg1),
            version : 2,
            entries : 0x2::table::new<0x2::object::ID, Entry>(arg1),
            counts  : 0x2::table::new<address, Slots>(arg1),
        };
        0x2::transfer::share_object<StakeLedger>(v0);
    }

    fun pay(arg0: &mut Entry, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint) : u64 {
        let v0 = 0;
        if (arg1 > 0 && arg2 > arg0.last_ms) {
            v0 = (arg2 - arg0.last_ms) * arg1 / 86400000;
        };
        if (v0 > 0) {
            arg0.last_ms = arg0.last_ms + v0 * 86400000 / arg1;
            0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::award_soulbound(arg4, arg3, v0);
        };
        v0
    }

    fun rate_for(arg0: &StakeConfig, arg1: &0x1::string::String) : u64 {
        if (is_g(arg1)) {
            arg0.g_rate
        } else if (is_l(arg1)) {
            arg0.l_rate
        } else {
            0
        }
    }

    public fun release_slot(arg0: &mut StakeLedger, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<0x2::object::ID, Entry>(&arg0.entries, arg1), 5);
        assert!(0x2::table::borrow<0x2::object::ID, Entry>(&arg0.entries, arg1).owner == v0, 5);
        let v1 = 0x2::table::remove<0x2::object::ID, Entry>(&mut arg0.entries, arg1);
        let v2 = &mut arg0.counts;
        dec_slot(v2, v0, v1.g);
        let v3 = Unstaked{
            by     : v0,
            card   : arg1,
            pearls : 0,
        };
        0x2::event::emit<Unstaked>(v3);
    }

    public fun set_caps(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut StakeConfig, arg2: u64, arg3: u64) {
        assert!(arg1.version == 2, 0);
        assert_cap(arg2, arg3);
        arg1.g_cap = arg2;
        arg1.l_cap = arg3;
    }

    public fun set_rates(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut StakeConfig, arg2: u64, arg3: u64) {
        assert!(arg1.version == 2, 0);
        assert_rate(arg2, arg3);
        arg1.g_rate = arg2;
        arg1.l_rate = arg3;
    }

    public fun slots_of(arg0: &StakeLedger, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, Slots>(&arg0.counts, arg1)) {
            let v2 = 0x2::table::borrow<address, Slots>(&arg0.counts, arg1);
            (v2.g, v2.l)
        } else {
            (0, 0)
        }
    }

    public fun stake(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling, arg1: &StakeConfig, arg2: &mut StakeLedger, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 2 && arg2.version == 2, 0);
        let v0 = 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::rarity(arg0);
        assert!(is_g(v0) || is_l(v0), 2);
        let v1 = is_g(v0);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::object::id<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(arg0);
        if (0x2::table::contains<0x2::object::ID, Entry>(&arg2.entries, v3)) {
            let v4 = 0x2::table::borrow<0x2::object::ID, Entry>(&arg2.entries, v3).owner;
            assert!(v4 != v2, 3);
            let v5 = &mut arg2.counts;
            dec_slot(v5, v4, v1);
            let v6 = &mut arg2.counts;
            inc_slot(v6, v2, v1, arg1.g_cap, arg1.l_cap);
            let v7 = 0x2::table::borrow_mut<0x2::object::ID, Entry>(&mut arg2.entries, v3);
            v7.owner = v2;
            v7.last_ms = 0x2::clock::timestamp_ms(arg3);
            v7.g = v1;
        } else {
            let v8 = &mut arg2.counts;
            inc_slot(v8, v2, v1, arg1.g_cap, arg1.l_cap);
            let v9 = Entry{
                last_ms : 0x2::clock::timestamp_ms(arg3),
                owner   : v2,
                g       : v1,
            };
            0x2::table::add<0x2::object::ID, Entry>(&mut arg2.entries, v3, v9);
        };
        let v10 = Staked{
            by   : v2,
            card : v3,
        };
        0x2::event::emit<Staked>(v10);
    }

    public fun unstake(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling, arg1: &StakeConfig, arg2: &mut StakeLedger, arg3: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 2 && arg2.version == 2, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(arg0);
        assert!(0x2::table::contains<0x2::object::ID, Entry>(&arg2.entries, v1), 5);
        assert!(0x2::table::borrow<0x2::object::ID, Entry>(&arg2.entries, v1).owner == v0, 5);
        let v2 = 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::rarity(arg0);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, Entry>(&mut arg2.entries, v1);
        let v4 = pay(v3, rate_for(arg1, v2), 0x2::clock::timestamp_ms(arg4), v0, arg3);
        0x2::table::remove<0x2::object::ID, Entry>(&mut arg2.entries, v1);
        let v5 = &mut arg2.counts;
        dec_slot(v5, v0, is_g(v2));
        let v6 = Unstaked{
            by     : v0,
            card   : v1,
            pearls : v4,
        };
        0x2::event::emit<Unstaked>(v6);
    }

    // decompiled from Move bytecode v7
}

