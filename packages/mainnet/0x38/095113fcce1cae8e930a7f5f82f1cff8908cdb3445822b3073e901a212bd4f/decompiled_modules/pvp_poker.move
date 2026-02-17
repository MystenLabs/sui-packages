module 0x38095113fcce1cae8e930a7f5f82f1cff8908cdb3445822b3073e901a212bd4f::pvp_poker {
    struct RoomCreatedEvent has copy, drop {
        room_id: 0x2::object::ID,
        host: address,
        bet: u64,
        expires_at_ms: u64,
    }

    struct RoomJoinedEvent has copy, drop {
        room_id: 0x2::object::ID,
        player: address,
        players_count: u64,
    }

    struct RoomCancelledEvent has copy, drop {
        room_id: 0x2::object::ID,
        by: address,
    }

    struct PokerStartedEvent has copy, drop {
        room_id: 0x2::object::ID,
        players_count: u64,
        board_cards: vector<u8>,
    }

    struct PokerFinishedEvent has copy, drop {
        room_id: 0x2::object::ID,
        winners: vector<address>,
        best_score: u64,
    }

    struct Room<phantom T0> has key {
        id: 0x2::object::UID,
        host: address,
        players: vector<address>,
        bet: u64,
        bank: 0x2::balance::Balance<T0>,
        status: u8,
        created_at_ms: u64,
        expires_at_ms: u64,
        hole_cards: vector<vector<u8>>,
        board_cards: vector<u8>,
        used_cards: vector<u8>,
        folded: vector<bool>,
        checked: vector<bool>,
        scores: vector<u64>,
        turn_index: u64,
        winners: vector<address>,
        turn_started_at_ms: u64,
    }

    fun active_players_count<T0>(arg0: &Room<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.players)) {
            if (!*0x1::vector::borrow<bool>(&arg0.folded, v1)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun all_active_players_checked<T0>(arg0: &Room<T0>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.players)) {
            if (!*0x1::vector::borrow<bool>(&arg0.folded, v0) && !*0x1::vector::borrow<bool>(&arg0.checked, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun bet<T0>(arg0: &Room<T0>) : u64 {
        arg0.bet
    }

    public fun board_cards<T0>(arg0: &Room<T0>) : vector<u8> {
        arg0.board_cards
    }

    public fun cancel_expired_waiting_room<T0>(arg0: &mut Room<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 14);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_at_ms, 7);
        arg0.status = 4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.bank, 0x2::balance::value<T0>(&arg0.bank), arg2), arg0.host);
        let v0 = RoomCancelledEvent{
            room_id : 0x2::object::uid_to_inner(&arg0.id),
            by      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RoomCancelledEvent>(v0);
    }

    public fun cancel_waiting_room<T0>(arg0: &mut Room<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 14);
        assert!(0x2::tx_context::sender(arg1) == arg0.host, 6);
        arg0.status = 4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.bank, 0x2::balance::value<T0>(&arg0.bank), arg1), arg0.host);
        let v0 = RoomCancelledEvent{
            room_id : 0x2::object::uid_to_inner(&arg0.id),
            by      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RoomCancelledEvent>(v0);
    }

    public fun check<T0>(arg0: &mut Room<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 10);
        let v0 = arg0.turn_index;
        assert!(player_index_or_abort(&arg0.players, 0x2::tx_context::sender(arg2)) == v0, 11);
        assert!(!*0x1::vector::borrow<bool>(&arg0.folded, v0), 12);
        assert!(!*0x1::vector::borrow<bool>(&arg0.checked, v0), 12);
        *0x1::vector::borrow_mut<bool>(&mut arg0.checked, v0) = true;
        if (active_players_count<T0>(arg0) <= 1 || all_active_players_checked<T0>(arg0)) {
            finalize_game<T0>(arg0, arg2);
        } else {
            arg0.turn_index = find_next_turn_index<T0>(arg0, v0);
            arg0.turn_started_at_ms = 0x2::clock::timestamp_ms(arg1);
        };
    }

    public fun checked<T0>(arg0: &Room<T0>) : vector<bool> {
        arg0.checked
    }

    fun contains_address(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun count_rank(arg0: &vector<u8>, arg1: u8) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            if (rank_from_card(*0x1::vector::borrow<u8>(arg0, v1)) == arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_room<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(is_valid_stake(v0), 1);
        let v1 = vector[];
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg2));
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = Room<T0>{
            id                 : 0x2::object::new(arg2),
            host               : 0x2::tx_context::sender(arg2),
            players            : v1,
            bet                : v0,
            bank               : 0x2::coin::into_balance<T0>(arg0),
            status             : 0,
            created_at_ms      : v2,
            expires_at_ms      : v2 + 300000,
            hole_cards         : vector[],
            board_cards        : b"",
            used_cards         : b"",
            folded             : vector[],
            checked            : vector[],
            scores             : vector[],
            turn_index         : 0,
            winners            : vector[],
            turn_started_at_ms : 0,
        };
        let v4 = RoomCreatedEvent{
            room_id       : 0x2::object::id<Room<T0>>(&v3),
            host          : v3.host,
            bet           : v3.bet,
            expires_at_ms : v3.expires_at_ms,
        };
        0x2::event::emit<RoomCreatedEvent>(v4);
        0x2::transfer::share_object<Room<T0>>(v3);
    }

    public fun created_at_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.created_at_ms
    }

    fun evaluate_hand(arg0: &vector<u8>, arg1: &vector<u8>) : u64 {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        let v3 = 0;
        let v4 = false;
        let v5 = false;
        let v6 = 2;
        while (v6 <= 14) {
            let v7 = count_rank(&v0, v6);
            if (v7 == 4) {
                v5 = true;
            };
            if (v7 == 3) {
                v4 = true;
            };
            if (v7 == 2) {
                v3 = v3 + 1;
            };
            v6 = v6 + 1;
        };
        let v8 = 0;
        if (v5) {
            v8 = 7;
        } else if (v4 && v3 >= 1) {
            v8 = 6;
        } else if (v4) {
            v8 = 3;
        } else if (v3 >= 2) {
            v8 = 2;
        } else if (v3 == 1) {
            v8 = 1;
        };
        (v8 as u64) * 1000000 + top_five_rank_sum(&v0)
    }

    public fun expires_at_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.expires_at_ms
    }

    fun finalize_game<T0>(arg0: &mut Room<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.status = 3;
        arg0.winners = vector[];
        let v0 = 0;
        let v1 = v0;
        if (active_players_count<T0>(arg0) == 1) {
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(&arg0.players)) {
                if (!*0x1::vector::borrow<bool>(&arg0.folded, v2)) {
                    0x1::vector::push_back<address>(&mut arg0.winners, *0x1::vector::borrow<address>(&arg0.players, v2));
                    v1 = *0x1::vector::borrow<u64>(&arg0.scores, v2);
                };
                v2 = v2 + 1;
            };
        } else {
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(&arg0.players)) {
                if (!*0x1::vector::borrow<bool>(&arg0.folded, v3)) {
                    let v4 = *0x1::vector::borrow<u64>(&arg0.scores, v3);
                    if (0x1::vector::length<address>(&arg0.winners) == 0 || v4 > v0) {
                        arg0.winners = vector[];
                        0x1::vector::push_back<address>(&mut arg0.winners, *0x1::vector::borrow<address>(&arg0.players, v3));
                        v1 = v4;
                    } else if (v4 == v0) {
                        0x1::vector::push_back<address>(&mut arg0.winners, *0x1::vector::borrow<address>(&arg0.players, v3));
                    };
                };
                v3 = v3 + 1;
            };
        };
        let v5 = 0x1::vector::length<address>(&arg0.winners);
        let v6 = 0x2::balance::value<T0>(&arg0.bank);
        if (v5 == 1) {
            let v7 = v6 * 500 / 10000;
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.bank, v7, arg1), @0x4f3d3835f08ad1078bc8ad9fc0e8d8d20ae8e3b37cd3717b826f398351528023);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.bank, 0x2::balance::value<T0>(&arg0.bank), arg1), *0x1::vector::borrow<address>(&arg0.winners, 0));
        } else {
            let v8 = v6 / v5;
            let v9 = 0;
            while (v9 < v5) {
                let v10 = v8;
                if (v9 == 0) {
                    v10 = v8 + v6 % v5;
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.bank, v10, arg1), *0x1::vector::borrow<address>(&arg0.winners, v9));
                v9 = v9 + 1;
            };
        };
        let v11 = PokerFinishedEvent{
            room_id    : 0x2::object::uid_to_inner(&arg0.id),
            winners    : arg0.winners,
            best_score : v1,
        };
        0x2::event::emit<PokerFinishedEvent>(v11);
    }

    fun find_next_turn_index<T0>(arg0: &Room<T0>, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<address>(&arg0.players);
        let v1 = 1;
        while (v1 <= v0) {
            let v2 = (arg1 + v1) % v0;
            if (!*0x1::vector::borrow<bool>(&arg0.folded, v2) && !*0x1::vector::borrow<bool>(&arg0.checked, v2)) {
                return v2
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fold<T0>(arg0: &mut Room<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 10);
        let v0 = arg0.turn_index;
        assert!(player_index_or_abort(&arg0.players, 0x2::tx_context::sender(arg2)) == v0, 11);
        assert!(!*0x1::vector::borrow<bool>(&arg0.folded, v0), 12);
        *0x1::vector::borrow_mut<bool>(&mut arg0.folded, v0) = true;
        *0x1::vector::borrow_mut<bool>(&mut arg0.checked, v0) = true;
        if (active_players_count<T0>(arg0) <= 1 || all_active_players_checked<T0>(arg0)) {
            finalize_game<T0>(arg0, arg2);
        } else {
            arg0.turn_index = find_next_turn_index<T0>(arg0, v0);
            arg0.turn_started_at_ms = 0x2::clock::timestamp_ms(arg1);
        };
    }

    public fun folded<T0>(arg0: &Room<T0>) : vector<bool> {
        arg0.folded
    }

    public fun force_check_if_timeout<T0>(arg0: &mut Room<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 10);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.turn_started_at_ms + 300000, 13);
        check<T0>(arg0, arg1, arg2);
    }

    fun get_next_random_card<T0>(arg0: &mut 0x2::random::RandomGenerator, arg1: &mut Room<T0>) : u8 {
        let v0 = 0;
        loop {
            let v1 = 0x2::random::generate_u8_in_range(arg0, 0, 51);
            let v2 = false;
            let v3 = &arg1.used_cards;
            let v4 = 0;
            while (v4 < 0x1::vector::length<u8>(v3)) {
                if (*0x1::vector::borrow<u8>(v3, v4) == v1) {
                    v2 = true;
                };
                v4 = v4 + 1;
            };
            if (!v2) {
                0x1::vector::push_back<u8>(&mut arg1.used_cards, v1);
                return v1
            };
            v0 = v0 + 1;
            if (v0 >= 100) {
                break
            };
        };
        abort 0
    }

    public fun hole_cards<T0>(arg0: &Room<T0>) : vector<vector<u8>> {
        arg0.hole_cards
    }

    public fun host<T0>(arg0: &Room<T0>) : address {
        arg0.host
    }

    fun is_valid_stake(arg0: u64) : bool {
        if (arg0 == 100000000) {
            true
        } else if (arg0 == 1000000000) {
            true
        } else if (arg0 == 10000000000) {
            true
        } else if (arg0 == 100000000000) {
            true
        } else {
            arg0 == 1000000000000
        }
    }

    public fun join_room<T0>(arg0: &mut Room<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0 || arg0.status == 1, 2);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.bet, 5);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!contains_address(&arg0.players, v0), 3);
        assert!(0x1::vector::length<address>(&arg0.players) < 5, 4);
        0x1::vector::push_back<address>(&mut arg0.players, v0);
        0x2::balance::join<T0>(&mut arg0.bank, 0x2::coin::into_balance<T0>(arg1));
        if (0x1::vector::length<address>(&arg0.players) >= 2) {
            arg0.status = 1;
        };
        let v1 = RoomJoinedEvent{
            room_id       : 0x2::object::uid_to_inner(&arg0.id),
            player        : v0,
            players_count : 0x1::vector::length<address>(&arg0.players),
        };
        0x2::event::emit<RoomJoinedEvent>(v1);
    }

    public fun max_players() : u64 {
        5
    }

    public fun min_players() : u64 {
        2
    }

    public fun platform_fee_bps() : u64 {
        500
    }

    fun player_index_or_abort(arg0: &vector<address>, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 11
    }

    public fun players<T0>(arg0: &Room<T0>) : vector<address> {
        arg0.players
    }

    fun rank_from_card(arg0: u8) : u8 {
        let v0 = arg0 % 13 + 1;
        if (v0 == 1) {
            14
        } else {
            v0
        }
    }

    public fun scores<T0>(arg0: &Room<T0>) : vector<u64> {
        arg0.scores
    }

    public fun start_game<T0>(arg0: &mut Room<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 8);
        assert!(contains_address(&arg0.players, 0x2::tx_context::sender(arg3)), 9);
        let v0 = 0x1::vector::length<address>(&arg0.players);
        assert!(v0 >= 2, 8);
        arg0.hole_cards = vector[];
        arg0.board_cards = b"";
        arg0.used_cards = b"";
        arg0.folded = vector[];
        arg0.checked = vector[];
        arg0.scores = vector[];
        arg0.winners = vector[];
        let v1 = 0;
        while (v1 < v0) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.hole_cards, b"");
            0x1::vector::push_back<bool>(&mut arg0.folded, false);
            0x1::vector::push_back<bool>(&mut arg0.checked, false);
            0x1::vector::push_back<u64>(&mut arg0.scores, 0);
            v1 = v1 + 1;
        };
        let v2 = 0x2::random::new_generator(arg1, arg3);
        let v3 = 0;
        while (v3 < 2) {
            let v4 = 0;
            while (v4 < v0) {
                let v5 = &mut v2;
                let v6 = get_next_random_card<T0>(v5, arg0);
                0x1::vector::push_back<u8>(0x1::vector::borrow_mut<vector<u8>>(&mut arg0.hole_cards, v4), v6);
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        let v7 = 0;
        while (v7 < 5) {
            let v8 = &mut v2;
            let v9 = get_next_random_card<T0>(v8, arg0);
            0x1::vector::push_back<u8>(&mut arg0.board_cards, v9);
            v7 = v7 + 1;
        };
        let v10 = 0;
        while (v10 < v0) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.scores, v10) = evaluate_hand(0x1::vector::borrow<vector<u8>>(&arg0.hole_cards, v10), &arg0.board_cards);
            v10 = v10 + 1;
        };
        arg0.status = 2;
        arg0.turn_index = 0;
        arg0.turn_started_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v11 = PokerStartedEvent{
            room_id       : 0x2::object::uid_to_inner(&arg0.id),
            players_count : v0,
            board_cards   : arg0.board_cards,
        };
        0x2::event::emit<PokerStartedEvent>(v11);
    }

    public fun status<T0>(arg0: &Room<T0>) : u8 {
        arg0.status
    }

    fun top_five_rank_sum(arg0: &vector<u8>) : u64 {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, rank_from_card(*0x1::vector::borrow<u8>(arg0, v1)));
            v1 = v1 + 1;
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < 5 && 0x1::vector::length<u8>(&v0) > 0) {
            let v4 = 0;
            let v5 = 1;
            while (v5 < 0x1::vector::length<u8>(&v0)) {
                v5 = v5 + 1;
            };
            v2 = v2 + (0x1::vector::remove<u8>(&mut v0, v4) as u64);
            v3 = v3 + 1;
        };
        v2
    }

    public fun turn_index<T0>(arg0: &Room<T0>) : u64 {
        arg0.turn_index
    }

    public fun turn_started_at_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.turn_started_at_ms
    }

    public fun winners<T0>(arg0: &Room<T0>) : vector<address> {
        arg0.winners
    }

    // decompiled from Move bytecode v6
}

