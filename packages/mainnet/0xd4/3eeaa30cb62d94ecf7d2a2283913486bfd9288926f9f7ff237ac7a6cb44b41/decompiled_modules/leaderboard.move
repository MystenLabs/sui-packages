module 0xd43eeaa30cb62d94ecf7d2a2283913486bfd9288926f9f7ff237ac7a6cb44b41::leaderboard {
    struct LeaderboardEntry has copy, drop, store {
        pos0: address,
        pos1: u64,
    }

    struct Leaderboard has drop, store {
        entries: vector<LeaderboardEntry>,
        max_size: u64,
    }

    public fun add_if_eligible(arg0: &mut Leaderboard, arg1: address, arg2: u64) {
        let v0 = entries(arg0);
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<LeaderboardEntry>(v1)) {
            if (addr(0x1::vector::borrow<LeaderboardEntry>(v1, v2)) == arg1) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v3)) {
                    0x1::vector::borrow_mut<LeaderboardEntry>(&mut arg0.entries, 0x1::option::extract<u64>(&mut v3)).pos1 = arg2;
                    sort(arg0);
                    return
                };
                let v4 = 0x1::vector::length<LeaderboardEntry>(&arg0.entries) >= arg0.max_size;
                if (v4 && 0x1::vector::borrow<LeaderboardEntry>(&arg0.entries, arg0.max_size - 1).pos1 >= arg2) {
                    return
                };
                if (v4) {
                    0x1::vector::pop_back<LeaderboardEntry>(&mut arg0.entries);
                };
                let v5 = LeaderboardEntry{
                    pos0 : arg1,
                    pos1 : arg2,
                };
                0x1::vector::push_back<LeaderboardEntry>(&mut arg0.entries, v5);
                sort(arg0);
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun addr(arg0: &LeaderboardEntry) : address {
        arg0.pos0
    }

    public fun entries(arg0: &Leaderboard) : vector<LeaderboardEntry> {
        arg0.entries
    }

    public(friend) fun new(arg0: u64) : Leaderboard {
        assert!(arg0 > 0 && arg0 <= 100, 9223372118459154433);
        Leaderboard{
            entries  : 0x1::vector::empty<LeaderboardEntry>(),
            max_size : arg0,
        }
    }

    public fun sort(arg0: &mut Leaderboard) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<LeaderboardEntry>(&arg0.entries)) {
            while (v0 > 0 && value(0x1::vector::borrow<LeaderboardEntry>(&arg0.entries, v0 - 1)) < value(0x1::vector::borrow<LeaderboardEntry>(&arg0.entries, v0))) {
                0x1::vector::swap<LeaderboardEntry>(&mut arg0.entries, v0 - 1, v0);
                v0 = v0 - 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun value(arg0: &LeaderboardEntry) : u64 {
        arg0.pos1
    }

    // decompiled from Move bytecode v6
}

