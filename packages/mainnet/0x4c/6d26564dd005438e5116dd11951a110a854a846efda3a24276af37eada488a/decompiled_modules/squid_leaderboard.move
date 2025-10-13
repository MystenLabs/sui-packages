module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::squid_leaderboard {
    struct SquidLeaderboard has key {
        id: 0x2::object::UID,
        top: vector<TopEntry>,
    }

    struct TopEntry has copy, store {
        nft_id: 0x2::object::ID,
        level: u32,
    }

    fun find_index(arg0: &vector<TopEntry>, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TopEntry>(arg0)) {
            if (0x1::vector::borrow<TopEntry>(arg0, v0).nft_id == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun get_nft_position(arg0: &SquidLeaderboard, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = find_index(&arg0.top, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::some<u64>(*0x1::option::borrow<u64>(&v0) + 1)
        } else {
            0x1::option::none<u64>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SquidLeaderboard{
            id  : 0x2::object::new(arg0),
            top : 0x1::vector::empty<TopEntry>(),
        };
        0x2::transfer::share_object<SquidLeaderboard>(v0);
    }

    public fun top(arg0: &SquidLeaderboard) : &vector<TopEntry> {
        &arg0.top
    }

    public(friend) fun update(arg0: &mut SquidLeaderboard, arg1: 0x2::object::ID, arg2: u32) {
        let v0 = &mut arg0.top;
        let v1 = find_index(v0, arg1);
        if (0x1::option::is_some<u64>(&v1)) {
            let TopEntry {
                nft_id : _,
                level  : _,
            } = 0x1::vector::remove<TopEntry>(v0, *0x1::option::borrow<u64>(&v1));
        };
        let v4 = 0;
        let v5 = 0x1::vector::length<TopEntry>(v0);
        while (v4 < v5) {
            if (0x1::vector::borrow<TopEntry>(v0, v4).level < arg2) {
                break
            };
            v4 = v4 + 1;
        };
        if (v4 < v5 || v5 < 10) {
            let v6 = TopEntry{
                nft_id : arg1,
                level  : arg2,
            };
            0x1::vector::insert<TopEntry>(v0, v6, v4);
            while (0x1::vector::length<TopEntry>(v0) > 10) {
                let TopEntry {
                    nft_id : _,
                    level  : _,
                } = 0x1::vector::pop_back<TopEntry>(v0);
            };
        };
    }

    // decompiled from Move bytecode v6
}

