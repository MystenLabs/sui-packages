module 0xf05969ee9e62f5139254ef304186cefae383029c51e81fa7ae0e50f29c9e3b44::snowbara {
    struct SNOWBARA has drop {
        dummy_field: bool,
    }

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
        treasury: 0x2::coin::TreasuryCap<SNOWBARA>,
    }

    struct ScoreSubmitted has copy, drop {
        player: address,
        name: 0x1::string::String,
        score: u64,
        level: u64,
        chain: u64,
        rank: u64,
        reward: u64,
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

    fun init(arg0: SNOWBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SNOWBARA>(arg0, 0, 0x1::string::utf8(b"SNOWBARA"), 0x1::string::utf8(b"Snowbara Coin"), 0x1::string::utf8(b"The coin of Snowbara, a snowboarding capybara."), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/snowbara/coin.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SNOWBARA>>(0x2::coin_registry::finalize<SNOWBARA>(v0, arg1), 0x2::tx_context::sender(arg1));
        let v2 = Leaderboard{
            id       : 0x2::object::new(arg1),
            top      : 0x1::vector::empty<Entry>(),
            best     : 0x2::table::new<address, Entry>(arg1),
            treasury : v1,
        };
        0x2::transfer::share_object<Leaderboard>(v2);
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

    public fun payouts() : vector<u64> {
        vector[1000, 500, 250, 150, 100, 75, 50, 40, 30, 20]
    }

    public fun player(arg0: &Entry) : address {
        arg0.player
    }

    public fun score(arg0: &Entry) : u64 {
        arg0.score
    }

    public fun submit_score(arg0: &mut Leaderboard, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 13906834715509522437);
        assert!(0x1::string::length(&arg1) <= 40, 13906834719804620807);
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
            if (arg2 > v2.score) {
                *v2 = v1;
            };
        } else {
            0x2::table::add<address, Entry>(&mut arg0.best, v0, v1);
        };
        let v3 = &arg0.top;
        let v4 = 0;
        let v5;
        while (v4 < 0x1::vector::length<Entry>(v3)) {
            if (0x1::vector::borrow<Entry>(v3, v4).score < arg2) {
                v5 = 0x1::option::some<u64>(v4);
                /* label 15 */
                let v6 = if (0x1::option::is_some<u64>(&v5)) {
                    0x1::option::destroy_some<u64>(v5)
                } else {
                    0x1::option::destroy_none<u64>(v5);
                    0x1::vector::length<Entry>(&arg0.top)
                };
                let v7 = 0;
                if (v6 < 100) {
                    0x1::vector::insert<Entry>(&mut arg0.top, v1, v6);
                    if (0x1::vector::length<Entry>(&arg0.top) > 100) {
                        0x1::vector::pop_back<Entry>(&mut arg0.top);
                    };
                    v7 = v6 + 1;
                };
                let v8 = vector[1000, 500, 250, 150, 100, 75, 50, 40, 30, 20];
                let v9 = 0;
                if (v7 > 0 && v7 <= 0x1::vector::length<u64>(&v8)) {
                    let v10 = *0x1::vector::borrow<u64>(&v8, v7 - 1);
                    v9 = v10;
                    0x2::transfer::public_transfer<0x2::coin::Coin<SNOWBARA>>(0x2::coin::mint<SNOWBARA>(&mut arg0.treasury, v10, arg5), v0);
                };
                let v11 = ScoreSubmitted{
                    player : v0,
                    name   : arg1,
                    score  : arg2,
                    level  : arg3,
                    chain  : arg4,
                    rank   : v7,
                    reward : v9,
                };
                0x2::event::emit<ScoreSubmitted>(v11);
                return
            };
            v4 = v4 + 1;
        };
        v5 = 0x1::option::none<u64>();
        /* goto 15 */
    }

    public fun top(arg0: &Leaderboard) : &vector<Entry> {
        &arg0.top
    }

    // decompiled from Move bytecode v7
}

