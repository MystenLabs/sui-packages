module 0x5df05337341278996ea2dea3ed5a6b9ce9c68a8f6b0a1241c637068cdecc2b79::pvp_blackjack {
    struct RoomCreatedEvent has copy, drop {
        room_id: 0x2::object::ID,
        host: address,
        bet: u64,
        expires_at_ms: u64,
    }

    struct RoomJoinedEvent has copy, drop {
        room_id: 0x2::object::ID,
        host: address,
        guest: address,
    }

    struct RoomCancelledEvent has copy, drop {
        room_id: 0x2::object::ID,
        by: address,
    }

    struct RoomGameStartedEvent has copy, drop {
        room_id: 0x2::object::ID,
        host_sum: u8,
        guest_sum: u8,
    }

    struct RoomGameFinishedEvent has copy, drop {
        room_id: 0x2::object::ID,
        winner: address,
        host_sum: u8,
        guest_sum: u8,
    }

    struct Room<phantom T0> has key {
        id: 0x2::object::UID,
        host: address,
        guest: 0x1::option::Option<address>,
        bet: u64,
        host_stake: 0x2::balance::Balance<T0>,
        guest_stake: 0x2::balance::Balance<T0>,
        status: u8,
        created_at_ms: u64,
        expires_at_ms: u64,
        host_cards: vector<u8>,
        host_sum: u8,
        guest_cards: vector<u8>,
        guest_sum: u8,
        used_cards: vector<u8>,
        turn: u8,
        host_stood: bool,
        guest_stood: bool,
        winner: 0x1::option::Option<address>,
        turn_started_at_ms: u64,
    }

    public fun bet<T0>(arg0: &Room<T0>) : u64 {
        arg0.bet
    }

    fun cancel_and_refund_host<T0>(arg0: &mut Room<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.status = 4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.host_stake, 0x2::balance::value<T0>(&arg0.host_stake), arg1), arg0.host);
        let v0 = RoomCancelledEvent{
            room_id : 0x2::object::uid_to_inner(&arg0.id),
            by      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RoomCancelledEvent>(v0);
    }

    public fun cancel_expired_waiting_room<T0>(arg0: &mut Room<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_at_ms, 7);
        cancel_and_refund_host<T0>(arg0, arg2);
    }

    public fun cancel_waiting_room<T0>(arg0: &mut Room<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::tx_context::sender(arg1) == arg0.host, 6);
        cancel_and_refund_host<T0>(arg0, arg1);
    }

    public fun create_room<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(is_valid_stake(v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = Room<T0>{
            id                 : 0x2::object::new(arg2),
            host               : 0x2::tx_context::sender(arg2),
            guest              : 0x1::option::none<address>(),
            bet                : v0,
            host_stake         : 0x2::coin::into_balance<T0>(arg0),
            guest_stake        : 0x2::balance::zero<T0>(),
            status             : 0,
            created_at_ms      : v1,
            expires_at_ms      : v1 + 300000,
            host_cards         : b"",
            host_sum           : 0,
            guest_cards        : b"",
            guest_sum          : 0,
            used_cards         : b"",
            turn               : 0,
            host_stood         : false,
            guest_stood        : false,
            winner             : 0x1::option::none<address>(),
            turn_started_at_ms : 0,
        };
        let v3 = RoomCreatedEvent{
            room_id       : 0x2::object::id<Room<T0>>(&v2),
            host          : v2.host,
            bet           : v2.bet,
            expires_at_ms : v2.expires_at_ms,
        };
        0x2::event::emit<RoomCreatedEvent>(v3);
        0x2::transfer::share_object<Room<T0>>(v2);
    }

    public fun created_at_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.created_at_ms
    }

    fun current_turn_player<T0>(arg0: &Room<T0>) : address {
        if (arg0.turn == 0) {
            arg0.host
        } else {
            guest_or_abort<T0>(arg0)
        }
    }

    fun current_turn_stood<T0>(arg0: &Room<T0>) : bool {
        arg0.turn == 0 && arg0.host_stood || arg0.guest_stood
    }

    public fun expires_at_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.expires_at_ms
    }

    fun finalize_game<T0>(arg0: &mut Room<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.status = 3;
        let v0 = if (arg0.host_sum > 21) {
            0
        } else {
            arg0.host_sum
        };
        let v1 = if (arg0.guest_sum > 21) {
            0
        } else {
            arg0.guest_sum
        };
        let v2 = guest_or_abort<T0>(arg0);
        let v3 = (0x2::balance::value<T0>(&arg0.host_stake) + 0x2::balance::value<T0>(&arg0.guest_stake)) * 500 / 10000;
        if (v0 > v1) {
            arg0.winner = 0x1::option::some<address>(arg0.host);
            0x2::balance::join<T0>(&mut arg0.guest_stake, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg0.host_stake, 0x2::balance::value<T0>(&arg0.host_stake), arg1)));
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.guest_stake, v3, arg1), @0x4f3d3835f08ad1078bc8ad9fc0e8d8d20ae8e3b37cd3717b826f398351528023);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.guest_stake, 0x2::balance::value<T0>(&arg0.guest_stake), arg1), arg0.host);
            let v4 = RoomGameFinishedEvent{
                room_id   : 0x2::object::uid_to_inner(&arg0.id),
                winner    : arg0.host,
                host_sum  : arg0.host_sum,
                guest_sum : arg0.guest_sum,
            };
            0x2::event::emit<RoomGameFinishedEvent>(v4);
        } else if (v1 > v0) {
            arg0.winner = 0x1::option::some<address>(v2);
            0x2::balance::join<T0>(&mut arg0.guest_stake, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg0.host_stake, 0x2::balance::value<T0>(&arg0.host_stake), arg1)));
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.guest_stake, v3, arg1), @0x4f3d3835f08ad1078bc8ad9fc0e8d8d20ae8e3b37cd3717b826f398351528023);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.guest_stake, 0x2::balance::value<T0>(&arg0.guest_stake), arg1), v2);
            let v5 = RoomGameFinishedEvent{
                room_id   : 0x2::object::uid_to_inner(&arg0.id),
                winner    : v2,
                host_sum  : arg0.host_sum,
                guest_sum : arg0.guest_sum,
            };
            0x2::event::emit<RoomGameFinishedEvent>(v5);
        } else {
            arg0.winner = 0x1::option::none<address>();
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.host_stake, 0x2::balance::value<T0>(&arg0.host_stake), arg1), arg0.host);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.guest_stake, 0x2::balance::value<T0>(&arg0.guest_stake), arg1), v2);
            let v6 = RoomGameFinishedEvent{
                room_id   : 0x2::object::uid_to_inner(&arg0.id),
                winner    : @0x0,
                host_sum  : arg0.host_sum,
                guest_sum : arg0.guest_sum,
            };
            0x2::event::emit<RoomGameFinishedEvent>(v6);
        };
    }

    public fun force_stand_if_timeout<T0>(arg0: &mut Room<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 10);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.turn_started_at_ms + 300000, 13);
        assert!(!current_turn_stood<T0>(arg0), 12);
        stand_current_turn<T0>(arg0, 0x2::clock::timestamp_ms(arg1), arg2);
    }

    fun get_card_sum(arg0: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg0)) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2) % 13 + 1;
            let v4 = v3;
            if (v3 == 1) {
                v1 = true;
            };
            if (v3 > 10) {
                v4 = 10;
            };
            v0 = v0 + v4;
            v2 = v2 + 1;
        };
        if (v1 && v0 + 10 <= 21) {
            v0 = v0 + 10;
        };
        v0
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

    public fun guest<T0>(arg0: &Room<T0>) : 0x1::option::Option<address> {
        arg0.guest
    }

    public fun guest_cards<T0>(arg0: &Room<T0>) : vector<u8> {
        arg0.guest_cards
    }

    fun guest_or_abort<T0>(arg0: &Room<T0>) : address {
        assert!(0x1::option::is_some<address>(&arg0.guest), 8);
        *0x1::option::borrow<address>(&arg0.guest)
    }

    public fun guest_stood<T0>(arg0: &Room<T0>) : bool {
        arg0.guest_stood
    }

    public fun guest_sum<T0>(arg0: &Room<T0>) : u8 {
        arg0.guest_sum
    }

    public fun hit<T0>(arg0: &mut Room<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 10);
        assert!(0x2::tx_context::sender(arg3) == current_turn_player<T0>(arg0), 11);
        assert!(!current_turn_stood<T0>(arg0), 12);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let v1 = &mut v0;
        let v2 = get_next_random_card<T0>(v1, arg0);
        if (arg0.turn == 0) {
            0x1::vector::push_back<u8>(&mut arg0.host_cards, v2);
            arg0.host_sum = get_card_sum(&arg0.host_cards);
            if (arg0.host_sum >= 21) {
                arg0.host_stood = true;
                if (arg0.guest_stood) {
                    finalize_game<T0>(arg0, arg3);
                } else {
                    arg0.turn = 1;
                    arg0.turn_started_at_ms = 0x2::clock::timestamp_ms(arg2);
                };
            } else {
                arg0.turn_started_at_ms = 0x2::clock::timestamp_ms(arg2);
            };
        } else {
            0x1::vector::push_back<u8>(&mut arg0.guest_cards, v2);
            arg0.guest_sum = get_card_sum(&arg0.guest_cards);
            if (arg0.guest_sum >= 21) {
                arg0.guest_stood = true;
                if (arg0.host_stood) {
                    finalize_game<T0>(arg0, arg3);
                } else {
                    arg0.turn = 0;
                    arg0.turn_started_at_ms = 0x2::clock::timestamp_ms(arg2);
                };
            } else {
                arg0.turn_started_at_ms = 0x2::clock::timestamp_ms(arg2);
            };
        };
    }

    public fun host<T0>(arg0: &Room<T0>) : address {
        arg0.host
    }

    public fun host_cards<T0>(arg0: &Room<T0>) : vector<u8> {
        arg0.host_cards
    }

    public fun host_stood<T0>(arg0: &Room<T0>) : bool {
        arg0.host_stood
    }

    public fun host_sum<T0>(arg0: &Room<T0>) : u8 {
        arg0.host_sum
    }

    fun is_valid_stake(arg0: u64) : bool {
        if (arg0 == 10000000000) {
            true
        } else if (arg0 == 100000000000) {
            true
        } else {
            arg0 == 1000000000000
        }
    }

    public fun join_room<T0>(arg0: &mut Room<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::tx_context::sender(arg2) != arg0.host, 3);
        assert!(0x1::option::is_none<address>(&arg0.guest), 4);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.bet, 5);
        let v0 = 0x2::tx_context::sender(arg2);
        arg0.guest = 0x1::option::some<address>(v0);
        0x2::balance::join<T0>(&mut arg0.guest_stake, 0x2::coin::into_balance<T0>(arg1));
        arg0.status = 1;
        let v1 = RoomJoinedEvent{
            room_id : 0x2::object::uid_to_inner(&arg0.id),
            host    : arg0.host,
            guest   : v0,
        };
        0x2::event::emit<RoomJoinedEvent>(v1);
    }

    public fun platform_fee_bps() : u64 {
        500
    }

    public fun stand<T0>(arg0: &mut Room<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 10);
        assert!(0x2::tx_context::sender(arg2) == current_turn_player<T0>(arg0), 11);
        assert!(!current_turn_stood<T0>(arg0), 12);
        stand_current_turn<T0>(arg0, 0x2::clock::timestamp_ms(arg1), arg2);
    }

    fun stand_current_turn<T0>(arg0: &mut Room<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.turn == 0) {
            arg0.host_stood = true;
            if (arg0.guest_stood) {
                finalize_game<T0>(arg0, arg2);
            } else {
                arg0.turn = 1;
                arg0.turn_started_at_ms = arg1;
            };
        } else {
            arg0.guest_stood = true;
            if (arg0.host_stood) {
                finalize_game<T0>(arg0, arg2);
            } else {
                arg0.turn = 0;
                arg0.turn_started_at_ms = arg1;
            };
        };
    }

    public fun start_game<T0>(arg0: &mut Room<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg0.guest;
        assert!(v0 == arg0.host || 0x1::option::is_some<address>(&v1) && 0x1::option::borrow<address>(&v1) == &v0, 9);
        let v2 = 0x2::random::new_generator(arg1, arg3);
        let v3 = &mut v2;
        let v4 = get_next_random_card<T0>(v3, arg0);
        0x1::vector::push_back<u8>(&mut arg0.host_cards, v4);
        let v5 = &mut v2;
        let v6 = get_next_random_card<T0>(v5, arg0);
        0x1::vector::push_back<u8>(&mut arg0.host_cards, v6);
        arg0.host_sum = get_card_sum(&arg0.host_cards);
        let v7 = &mut v2;
        let v8 = get_next_random_card<T0>(v7, arg0);
        0x1::vector::push_back<u8>(&mut arg0.guest_cards, v8);
        let v9 = &mut v2;
        let v10 = get_next_random_card<T0>(v9, arg0);
        0x1::vector::push_back<u8>(&mut arg0.guest_cards, v10);
        arg0.guest_sum = get_card_sum(&arg0.guest_cards);
        arg0.status = 2;
        arg0.turn = 0;
        arg0.host_stood = arg0.host_sum >= 21;
        arg0.guest_stood = arg0.guest_sum >= 21;
        arg0.winner = 0x1::option::none<address>();
        if (arg0.host_stood && !arg0.guest_stood) {
            arg0.turn = 1;
        };
        if (arg0.host_stood && arg0.guest_stood) {
            finalize_game<T0>(arg0, arg3);
        };
        arg0.turn_started_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v11 = RoomGameStartedEvent{
            room_id   : 0x2::object::uid_to_inner(&arg0.id),
            host_sum  : arg0.host_sum,
            guest_sum : arg0.guest_sum,
        };
        0x2::event::emit<RoomGameStartedEvent>(v11);
    }

    public fun status<T0>(arg0: &Room<T0>) : u8 {
        arg0.status
    }

    public fun turn<T0>(arg0: &Room<T0>) : u8 {
        arg0.turn
    }

    public fun turn_started_at_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.turn_started_at_ms
    }

    public fun winner<T0>(arg0: &Room<T0>) : 0x1::option::Option<address> {
        arg0.winner
    }

    // decompiled from Move bytecode v6
}

