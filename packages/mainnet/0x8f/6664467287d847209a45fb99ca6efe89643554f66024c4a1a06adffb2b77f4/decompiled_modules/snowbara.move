module 0x8f6664467287d847209a45fb99ca6efe89643554f66024c4a1a06adffb2b77f4::snowbara {
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
        version: u64,
        top: vector<Entry>,
        best: 0x2::table::Table<address, Entry>,
        treasury: 0x2::coin::TreasuryCap<SNOWBARA>,
        submit_key: vector<u8>,
        spent: 0x2::table::Table<u256, bool>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SubmitMsg has copy, drop {
        board: address,
        player: address,
        name: 0x1::string::String,
        score: u64,
        level: u64,
        chain: u64,
        duration_ms: u64,
        nonce: u256,
    }

    struct SubmitKeyRotated has copy, drop {
        key: vector<u8>,
    }

    struct BoardMigrated has copy, drop {
        version: u64,
    }

    struct RowPruned has copy, drop {
        player: address,
        score: u64,
        rank: u64,
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

    fun assert_score_fits_duration(arg0: u64, arg1: u64) {
        assert!(arg1 > 0, 13906835961051283480);
        assert!((arg0 as u128) <= (arg1 as u128) * (100000 as u128) / 1000, 13906835978231021590);
    }

    fun assert_score_fits_level(arg0: u64, arg1: u64) {
        assert!(arg1 >= 1, 13906836051245072400);
        let v0 = (30000 as u128) * 1000000;
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg1 + 1) {
            v1 = v1 + v0;
            v2 = v2 + 1;
            if (v1 > (arg0 as u128) * 1000000) {
                assert!(v2 + 1 >= arg1, 13906836102784942100);
                return
            };
            let v3 = v0 * 10405;
            v0 = v3 / 10000;
        };
        abort 13906836132849582098
    }

    public fun best_of(arg0: &Leaderboard, arg1: address) : &Entry {
        0x2::table::borrow<address, Entry>(&arg0.best, arg1)
    }

    public fun chain(arg0: &Entry) : u64 {
        arg0.chain
    }

    fun file_run(arg0: &mut Leaderboard, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Entry{
            player : arg1,
            name   : arg2,
            score  : arg3,
            level  : arg4,
            chain  : arg5,
        };
        if (0x2::table::contains<address, Entry>(&arg0.best, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, Entry>(&mut arg0.best, arg1);
            if (arg3 > v1.score) {
                *v1 = v0;
            };
        } else {
            0x2::table::add<address, Entry>(&mut arg0.best, arg1, v0);
        };
        let v2 = &arg0.top;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<Entry>(v2)) {
            if (0x1::vector::borrow<Entry>(v2, v3).score < arg3) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 11 */
                let v5 = if (0x1::option::is_some<u64>(&v4)) {
                    0x1::option::destroy_some<u64>(v4)
                } else {
                    0x1::option::destroy_none<u64>(v4);
                    0x1::vector::length<Entry>(&arg0.top)
                };
                let v6 = 0;
                if (v5 < 100) {
                    0x1::vector::insert<Entry>(&mut arg0.top, v0, v5);
                    if (0x1::vector::length<Entry>(&arg0.top) > 100) {
                        0x1::vector::pop_back<Entry>(&mut arg0.top);
                    };
                    v6 = v5 + 1;
                };
                let v7 = vector[1000, 500, 250, 150, 100, 75, 50, 40, 30, 20];
                let v8 = 0;
                if (v6 > 0 && v6 <= 0x1::vector::length<u64>(&v7)) {
                    let v9 = *0x1::vector::borrow<u64>(&v7, v6 - 1);
                    v8 = v9;
                    0x2::transfer::public_transfer<0x2::coin::Coin<SNOWBARA>>(0x2::coin::mint<SNOWBARA>(&mut arg0.treasury, v9, arg6), arg1);
                };
                let v10 = ScoreSubmitted{
                    player : arg1,
                    name   : arg2,
                    score  : arg3,
                    level  : arg4,
                    chain  : arg5,
                    rank   : v6,
                    reward : v8,
                };
                0x2::event::emit<ScoreSubmitted>(v10);
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 11 */
    }

    public fun has_best(arg0: &Leaderboard, arg1: address) : bool {
        0x2::table::contains<address, Entry>(&arg0.best, arg1)
    }

    fun init(arg0: SNOWBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SNOWBARA>(arg0, 0, 0x1::string::utf8(b"SNOWBARA"), 0x1::string::utf8(b"Snowbara Coin"), 0x1::string::utf8(b"The coin of Snowbara, a snowboarding capybara."), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/snowbara/coin.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SNOWBARA>>(0x2::coin_registry::finalize<SNOWBARA>(v0, arg1), 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = Leaderboard{
            id         : 0x2::object::new(arg1),
            version    : 1,
            top        : 0x1::vector::empty<Entry>(),
            best       : 0x2::table::new<address, Entry>(arg1),
            treasury   : v1,
            submit_key : b"",
            spent      : 0x2::table::new<u256, bool>(arg1),
        };
        0x2::transfer::share_object<Leaderboard>(v3);
    }

    public fun level(arg0: &Entry) : u64 {
        arg0.level
    }

    public fun max_top() : u64 {
        100
    }

    public fun migrate(arg0: &mut Leaderboard, arg1: &AdminCap) {
        assert!(1 > arg0.version, 13906835815023181860);
        arg0.version = 1;
        let v0 = BoardMigrated{version: 1};
        0x2::event::emit<BoardMigrated>(v0);
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

    public fun prune_row(arg0: &mut Leaderboard, arg1: &AdminCap, arg2: u64) : Entry {
        assert!(arg0.version == 1, 13906835888037494818);
        let v0 = 0x1::vector::remove<Entry>(&mut arg0.top, arg2 - 1);
        let v1 = RowPruned{
            player : v0.player,
            score  : v0.score,
            rank   : arg2,
        };
        0x2::event::emit<RowPruned>(v1);
        v0
    }

    public fun rotate_submit_key(arg0: &mut Leaderboard, arg1: &AdminCap, arg2: vector<u8>) {
        assert!(arg0.version == 1, 13906835763483443234);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906835767778279456);
        arg0.submit_key = arg2;
        let v0 = SubmitKeyRotated{key: arg2};
        0x2::event::emit<SubmitKeyRotated>(v0);
    }

    public fun score(arg0: &Entry) : u64 {
        arg0.score
    }

    public fun submit_key(arg0: &Leaderboard) : &vector<u8> {
        &arg0.submit_key
    }

    public fun submit_score(arg0: &mut Leaderboard, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906835372641419298);
        assert!(arg2 > 0, 13906835376934944780);
        assert!(0x1::string::length(&arg1) <= 40, 13906835381230043150);
        assert_score_fits_level(arg2, arg3);
        assert_score_fits_duration(arg2, arg5);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x1::vector::length<u8>(&arg0.submit_key) == 32, 13906835407000895518);
        let v1 = SubmitMsg{
            board       : 0x2::object::uid_to_address(&arg0.id),
            player      : v0,
            name        : arg1,
            score       : arg2,
            level       : arg3,
            chain       : arg4,
            duration_ms : arg5,
            nonce       : arg6,
        };
        let v2 = 0x1::bcs::to_bytes<SubmitMsg>(&v1);
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg0.submit_key, &v2), 13906835462835208218);
        assert!(!0x2::table::contains<u256, bool>(&arg0.spent, arg6), 13906835484310175772);
        0x2::table::add<u256, bool>(&mut arg0.spent, arg6, true);
        file_run(arg0, v0, arg1, arg2, arg3, arg4, arg8);
    }

    public fun top(arg0: &Leaderboard) : &vector<Entry> {
        &arg0.top
    }

    public fun version(arg0: &Leaderboard) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

