module 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::leaderboard {
    struct LeaderData has copy, drop, store {
        account: address,
        shares: u64,
    }

    struct Leaderboard has copy, drop, store {
        max_size: u64,
        contents: vector<LeaderData>,
    }

    public fun insert(arg0: &mut Leaderboard, arg1: address, arg2: u64) {
        let v0 = &mut arg0.contents;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<LeaderData>(v0)) {
            if (0x1::vector::borrow<LeaderData>(v0, v1).account == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 4 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::remove<LeaderData>(v0, 0x1::option::destroy_some<u64>(v2));
                };
                let v3 = 0;
                let v4;
                while (v3 < 0x1::vector::length<LeaderData>(v0)) {
                    if (0x1::vector::borrow<LeaderData>(v0, v3).shares <= arg2) {
                        v4 = 0x1::option::some<u64>(v3);
                        /* label 10 */
                        if (0x1::option::is_some<u64>(&v4)) {
                            let v5 = LeaderData{
                                account : arg1,
                                shares  : arg2,
                            };
                            0x1::vector::insert<LeaderData>(v0, v5, 0x1::option::destroy_some<u64>(v4));
                            if (0x1::vector::length<LeaderData>(v0) > arg0.max_size) {
                                0x1::vector::pop_back<LeaderData>(v0);
                            };
                        } else if (0x1::vector::length<LeaderData>(v0) < arg0.max_size) {
                            let v6 = LeaderData{
                                account : arg1,
                                shares  : arg2,
                            };
                            0x1::vector::push_back<LeaderData>(v0, v6);
                        };
                        return
                    };
                    v3 = v3 + 1;
                };
                v4 = 0x1::option::none<u64>();
                /* goto 10 */
            } else {
                v1 = v1 + 1;
            };
        };
        v2 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    public fun contents(arg0: &Leaderboard) : &vector<LeaderData> {
        &arg0.contents
    }

    public fun data(arg0: &LeaderData) : (address, u64) {
        (arg0.account, arg0.shares)
    }

    public fun max_size(arg0: &Leaderboard) : u64 {
        arg0.max_size
    }

    public fun new(arg0: u64) : Leaderboard {
        Leaderboard{
            max_size : arg0,
            contents : 0x1::vector::empty<LeaderData>(),
        }
    }

    // decompiled from Move bytecode v6
}

