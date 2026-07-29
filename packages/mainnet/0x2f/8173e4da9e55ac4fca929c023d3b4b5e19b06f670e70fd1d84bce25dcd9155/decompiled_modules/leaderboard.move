module 0x2f8173e4da9e55ac4fca929c023d3b4b5e19b06f670e70fd1d84bce25dcd9155::leaderboard {
    struct Entry has copy, drop, store {
        player: address,
        name: 0x1::string::String,
        score: u64,
        level: u64,
        chain: u64,
    }

    struct Leaderboard has key {
        id: 0x2::object::UID,
        top: vector<Entry>,
        best: 0x2::table::Table<address, Entry>,
    }

    struct ScoreSubmitted has copy, drop {
        player: address,
        name: 0x1::string::String,
        score: u64,
        level: u64,
        chain: u64,
    }

    public fun best_of(arg0: &Leaderboard, arg1: address) : &Entry {
        0x2::table::borrow<address, Entry>(&arg0.best, arg1)
    }

    public fun chain(arg0: &Entry) : u64 {
        arg0.chain
    }

    public fun has_best(arg0: &Leaderboard, arg1: address) : bool {
        0x2::table::contains<address, Entry>(&arg0.best, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id   : 0x2::object::new(arg0),
            top  : 0x1::vector::empty<Entry>(),
            best : 0x2::table::new<address, Entry>(arg0),
        };
        0x2::transfer::share_object<Leaderboard>(v0);
    }

    public fun level(arg0: &Entry) : u64 {
        arg0.level
    }

    public fun max_top() : u64 {
        100
    }

    public fun name(arg0: &Entry) : 0x1::string::String {
        arg0.name
    }

    public fun player(arg0: &Entry) : address {
        arg0.player
    }

    public fun score(arg0: &Entry) : u64 {
        arg0.score
    }

    public fun submit_score(arg0: &mut Leaderboard, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 13906834526530830339);
        assert!(0x1::string::length(&arg1) <= 40, 13906834530826059783);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Entry{
            player : v0,
            name   : arg1,
            score  : arg2,
            level  : arg3,
            chain  : arg4,
        };
        if (0x2::table::contains<address, Entry>(&arg0.best, v0)) {
            let v2 = 0x2::table::borrow_mut<address, Entry>(&mut arg0.best, v0);
            assert!(arg2 > v2.score, 13906834556595732485);
            *v2 = v1;
        } else {
            0x2::table::add<address, Entry>(&mut arg0.best, v0, v1);
        };
        let v3 = &arg0.top;
        let v4 = 0;
        let v5;
        while (v4 < 0x1::vector::length<Entry>(v3)) {
            if (0x1::vector::borrow<Entry>(v3, v4).player == v0) {
                v5 = 0x1::option::some<u64>(v4);
                /* label 16 */
                if (0x1::option::is_some<u64>(&v5)) {
                    0x1::vector::remove<Entry>(&mut arg0.top, 0x1::option::destroy_some<u64>(v5));
                } else {
                    0x1::option::destroy_none<u64>(v5);
                };
                let v6 = &arg0.top;
                let v7 = 0;
                let v8;
                while (v7 < 0x1::vector::length<Entry>(v6)) {
                    if (0x1::vector::borrow<Entry>(v6, v7).score < arg2) {
                        v8 = 0x1::option::some<u64>(v7);
                        /* label 25 */
                        let v9 = if (0x1::option::is_some<u64>(&v8)) {
                            0x1::option::destroy_some<u64>(v8)
                        } else {
                            0x1::option::destroy_none<u64>(v8);
                            0x1::vector::length<Entry>(&arg0.top)
                        };
                        if (v9 < 100) {
                            0x1::vector::insert<Entry>(&mut arg0.top, v1, v9);
                            if (0x1::vector::length<Entry>(&arg0.top) > 100) {
                                0x1::vector::pop_back<Entry>(&mut arg0.top);
                            };
                        };
                        let v10 = ScoreSubmitted{
                            player : v0,
                            name   : arg1,
                            score  : arg2,
                            level  : arg3,
                            chain  : arg4,
                        };
                        0x2::event::emit<ScoreSubmitted>(v10);
                        return
                    };
                    v7 = v7 + 1;
                };
                v8 = 0x1::option::none<u64>();
                /* goto 25 */
            } else {
                v4 = v4 + 1;
            };
        };
        v5 = 0x1::option::none<u64>();
        /* goto 16 */
    }

    public fun top(arg0: &Leaderboard) : &vector<Entry> {
        &arg0.top
    }

    // decompiled from Move bytecode v7
}

