module 0xefc33796abf5bebfbd404730a3b3cdfc9d8df8bc95b91db03218bb060946907a::game {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_rounds: u64,
    }

    struct Round has key {
        id: 0x2::object::UID,
        round_number: u64,
        asset: 0x1::string::String,
        difficulty: 0x1::string::String,
        puzzle_blob_id: 0x1::string::String,
        entry_fee: u64,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        window_end_ms: u64,
        status: u8,
        creator: address,
        players: 0x2::table::Table<address, bool>,
        answers: 0x2::table::Table<address, PlayerAnswer>,
        correct_order: vector<u8>,
        result_blob_id: 0x1::string::String,
        archive_blob_id: 0x1::string::String,
    }

    struct PlayerAnswer has drop, store {
        player: address,
        answer_blob_id: 0x1::string::String,
        segment_order: vector<u8>,
        submitted_at_ms: u64,
        score: u8,
    }

    struct RoundOpened has copy, drop {
        round_id: 0x2::object::ID,
        round_number: u64,
        asset: 0x1::string::String,
        difficulty: 0x1::string::String,
        puzzle_blob_id: 0x1::string::String,
        entry_fee: u64,
        window_end_ms: u64,
        creator: address,
    }

    struct PlayerJoined has copy, drop {
        round_id: 0x2::object::ID,
        player: address,
        prize_pool_total: u64,
    }

    struct AnswerSubmitted has copy, drop {
        round_id: 0x2::object::ID,
        player: address,
        answer_blob_id: 0x1::string::String,
        segment_order: vector<u8>,
        submitted_at_ms: u64,
    }

    struct RoundSettled has copy, drop {
        round_id: 0x2::object::ID,
        result_blob_id: 0x1::string::String,
        correct_order: vector<u8>,
        winner_count: u64,
        prize_per_winner: u64,
        platform_fee: u64,
    }

    struct RoundCancelled has copy, drop {
        round_id: 0x2::object::ID,
        refund_total: u64,
    }

    public fun cancel_round(arg0: &GameConfig, arg1: &mut Round, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.creator || v0 == arg0.admin, 0);
        assert!(arg1.status == 0, 8);
        arg1.status = 1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (0x2::table::contains<address, bool>(&arg1.players, v2) && 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool) >= arg1.entry_fee) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, arg1.entry_fee), arg3), v2);
            };
            v1 = v1 + 1;
        };
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, v3), arg3), arg1.creator);
        };
        let v4 = RoundCancelled{
            round_id     : 0x2::object::id<Round>(arg1),
            refund_total : v3,
        };
        0x2::event::emit<RoundCancelled>(v4);
    }

    public fun has_submitted(arg0: &Round, arg1: address) : bool {
        0x2::table::contains<address, PlayerAnswer>(&arg0.answers, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = GameConfig{
            id           : 0x2::object::new(arg0),
            admin        : v0,
            treasury     : 0x2::balance::zero<0x2::sui::SUI>(),
            total_rounds : 0,
        };
        0x2::transfer::share_object<GameConfig>(v2);
    }

    public fun is_active(arg0: &Round) : bool {
        arg0.status == 0
    }

    public fun is_player(arg0: &Round, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.players, arg1)
    }

    public fun is_settled(arg0: &Round) : bool {
        arg0.status == 2
    }

    public fun join_round(arg0: &mut Round, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.window_end_ms, 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.players, v0), 4);
        assert!(0x2::table::length<address, bool>(&arg0.players) == 0, 11);
        assert!(v0 != arg0.creator, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.entry_fee, 7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.entry_fee, arg3)));
        0x2::table::add<address, bool>(&mut arg0.players, v0, true);
        let v1 = PlayerJoined{
            round_id         : 0x2::object::id<Round>(arg0),
            player           : v0,
            prize_pool_total : 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<PlayerJoined>(v1);
    }

    public fun open_round(arg0: &mut GameConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 10);
        assert!(arg5 >= 60 && arg5 <= 3600, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg6) >= arg4, 7);
        arg0.total_rounds = arg0.total_rounds + 1;
        let v0 = 0x2::clock::timestamp_ms(arg7) + arg5 * 1000;
        let v1 = Round{
            id              : 0x2::object::new(arg8),
            round_number    : arg0.total_rounds,
            asset           : 0x1::string::utf8(arg2),
            difficulty      : 0x1::string::utf8(arg3),
            puzzle_blob_id  : 0x1::string::utf8(arg1),
            entry_fee       : arg4,
            prize_pool      : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg6, arg4, arg8)),
            window_end_ms   : v0,
            status          : 0,
            creator         : 0x2::tx_context::sender(arg8),
            players         : 0x2::table::new<address, bool>(arg8),
            answers         : 0x2::table::new<address, PlayerAnswer>(arg8),
            correct_order   : b"",
            result_blob_id  : 0x1::string::utf8(b""),
            archive_blob_id : 0x1::string::utf8(b""),
        };
        let v2 = RoundOpened{
            round_id       : 0x2::object::id<Round>(&v1),
            round_number   : arg0.total_rounds,
            asset          : v1.asset,
            difficulty     : v1.difficulty,
            puzzle_blob_id : v1.puzzle_blob_id,
            entry_fee      : arg4,
            window_end_ms  : v0,
            creator        : v1.creator,
        };
        0x2::event::emit<RoundOpened>(v2);
        0x2::transfer::share_object<Round>(v1);
    }

    public fun prize_pool_value(arg0: &Round) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun puzzle_blob(arg0: &Round) : &0x1::string::String {
        &arg0.puzzle_blob_id
    }

    public fun result_blob(arg0: &Round) : &0x1::string::String {
        &arg0.result_blob_id
    }

    public fun round_number(arg0: &Round) : u64 {
        arg0.round_number
    }

    public fun round_status(arg0: &Round) : u8 {
        arg0.status
    }

    public fun settle_round(arg0: &mut GameConfig, arg1: &mut Round, arg2: vector<u8>, arg3: vector<address>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 == arg1.creator || v0 == arg0.admin, 0);
        assert!(arg1.status == 0, 8);
        assert!(0x2::clock::timestamp_ms(arg6) >= arg1.window_end_ms, 3);
        assert!(0x1::vector::length<u8>(&arg2) == 6, 9);
        assert!(0x1::vector::length<u8>(&arg4) > 0, 10);
        arg1.correct_order = arg2;
        arg1.result_blob_id = 0x1::string::utf8(arg4);
        arg1.archive_blob_id = 0x1::string::utf8(arg5);
        arg1.status = 2;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool) * 1000 / 10000;
        if (v1 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, v1));
        };
        let v2 = 0x1::vector::length<address>(&arg3);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool);
        let v4 = if (v2 > 0 && v3 > 0) {
            let v5 = v3 / v2;
            let v6 = 0;
            while (v6 < v2) {
                if (v5 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool) >= v5) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, v5), arg7), *0x1::vector::borrow<address>(&arg3, v6));
                };
                v6 = v6 + 1;
            };
            let v7 = 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool);
            if (v7 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, v7));
            };
            v5
        } else {
            let v8 = 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool);
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, v8), arg7), arg1.creator);
            };
            0
        };
        let v9 = RoundSettled{
            round_id         : 0x2::object::id<Round>(arg1),
            result_blob_id   : arg1.result_blob_id,
            correct_order    : arg1.correct_order,
            winner_count     : v2,
            prize_per_winner : v4,
            platform_fee     : v1,
        };
        0x2::event::emit<RoundSettled>(v9);
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_cancelled() : u8 {
        1
    }

    public fun status_settled() : u8 {
        2
    }

    public fun submit_answer(arg0: &mut Round, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.window_end_ms, 2);
        assert!(0x2::table::contains<address, bool>(&arg0.players, v0), 5);
        assert!(!0x2::table::contains<address, PlayerAnswer>(&arg0.answers, v0), 6);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 10);
        assert!(0x1::vector::length<u8>(&arg2) == 6, 9);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x1::string::utf8(arg1);
        let v3 = AnswerSubmitted{
            round_id        : 0x2::object::id<Round>(arg0),
            player          : v0,
            answer_blob_id  : v2,
            segment_order   : arg2,
            submitted_at_ms : v1,
        };
        0x2::event::emit<AnswerSubmitted>(v3);
        let v4 = PlayerAnswer{
            player          : v0,
            answer_blob_id  : v2,
            segment_order   : arg2,
            submitted_at_ms : v1,
            score           : 0,
        };
        0x2::table::add<address, PlayerAnswer>(&mut arg0.answers, v0, v4);
    }

    public fun total_rounds(arg0: &GameConfig) : u64 {
        arg0.total_rounds
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut GameConfig) {
        arg2.admin = arg1;
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun treasury_balance(arg0: &GameConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun withdraw_treasury(arg0: &AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury) >= arg2, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

