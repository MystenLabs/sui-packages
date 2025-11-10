module 0x91b27d7ba6d692ce32b634f8ef04aee5108913b13de24d22f34aa2a0a7cae7c::game_room {
    struct GameRoom has key {
        id: 0x2::object::UID,
        creator: address,
        bet_amount: u64,
        max_players: u8,
        players: 0x2::vec_set::VecSet<address>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
        winner: 0x1::option::Option<address>,
        started_at: 0x1::option::Option<u64>,
        finished_at: 0x1::option::Option<u64>,
        backend_validator: address,
    }

    struct RoomCreated has copy, drop {
        room_id: address,
        creator: address,
        bet_amount: u64,
        max_players: u8,
        timestamp: u64,
    }

    struct PlayerJoined has copy, drop {
        room_id: address,
        player: address,
        players_count: u64,
        current_pool: u64,
        timestamp: u64,
    }

    struct GameStarted has copy, drop {
        room_id: address,
        players: vector<address>,
        total_pool: u64,
        timestamp: u64,
    }

    struct GameFinished has copy, drop {
        room_id: address,
        winner: address,
        prize_amount: u64,
        protocol_fee: u64,
        timestamp: u64,
    }

    public fun cancel_game(arg0: &mut GameRoom, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 5);
        assert!(arg0.status == 0, 4);
        let v0 = 0x2::vec_set::into_keys<address>(arg0.players);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, arg0.bet_amount), arg1), *0x1::vector::borrow<address>(&v0, v1));
            v1 = v1 + 1;
        };
        arg0.status = 2;
    }

    public fun create_room(arg0: u64, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1 >= 2 && arg1 <= 4, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0, 2);
        assert!(arg0 > 0, 2);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = GameRoom{
            id                : 0x2::object::new(arg5),
            creator           : v0,
            bet_amount        : arg0,
            max_players       : arg1,
            players           : v1,
            prize_pool        : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            status            : 0,
            winner            : 0x1::option::none<address>(),
            started_at        : 0x1::option::none<u64>(),
            finished_at       : 0x1::option::none<u64>(),
            backend_validator : arg3,
        };
        let v3 = RoomCreated{
            room_id     : 0x2::object::uid_to_address(&v2.id),
            creator     : v0,
            bet_amount  : arg0,
            max_players : arg1,
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RoomCreated>(v3);
        0x2::transfer::share_object<GameRoom>(v2);
    }

    public fun finish_game(arg0: &mut GameRoom, arg1: address, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.backend_validator, 5);
        assert!(arg0.status == 1, 4);
        assert!(0x2::vec_set::contains<address>(&arg0.players, &arg1), 6);
        arg0.status = 2;
        arg0.winner = 0x1::option::some<address>(arg1);
        arg0.finished_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg4));
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v1 = v0 * arg2 / 10000;
        let v2 = v0 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v2), arg5), arg1);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v1), arg5), arg3);
        };
        let v3 = GameFinished{
            room_id      : 0x2::object::uid_to_address(&arg0.id),
            winner       : arg1,
            prize_amount : v2,
            protocol_fee : v1,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<GameFinished>(v3);
    }

    public fun get_players_count(arg0: &GameRoom) : u64 {
        0x2::vec_set::length<address>(&arg0.players)
    }

    public fun get_prize_pool(arg0: &GameRoom) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_room_info(arg0: &GameRoom) : (address, u64, u8, u8, u64) {
        (arg0.creator, arg0.bet_amount, arg0.max_players, arg0.status, 0x2::vec_set::length<address>(&arg0.players))
    }

    public fun get_status(arg0: &GameRoom) : u8 {
        arg0.status
    }

    public fun get_winner(arg0: &GameRoom) : 0x1::option::Option<address> {
        arg0.winner
    }

    public fun is_player(arg0: &GameRoom, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.players, &arg1)
    }

    public fun join_room(arg0: &mut GameRoom, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.status == 0, 4);
        assert!(0x2::vec_set::length<address>(&arg0.players) < (arg0.max_players as u64), 0);
        assert!(!0x2::vec_set::contains<address>(&arg0.players, &v0), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.bet_amount, 2);
        0x2::vec_set::insert<address>(&mut arg0.players, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = PlayerJoined{
            room_id       : 0x2::object::uid_to_address(&arg0.id),
            player        : v0,
            players_count : 0x2::vec_set::length<address>(&arg0.players),
            current_pool  : 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlayerJoined>(v1);
        if (0x2::vec_set::length<address>(&arg0.players) == (arg0.max_players as u64)) {
            start_game_internal(arg0, arg2);
        };
    }

    public fun start_game(arg0: &mut GameRoom, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 4);
        assert!(0x2::vec_set::length<address>(&arg0.players) >= 2, 3);
        start_game_internal(arg0, arg1);
    }

    fun start_game_internal(arg0: &mut GameRoom, arg1: &0x2::clock::Clock) {
        arg0.status = 1;
        arg0.started_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
        let v0 = GameStarted{
            room_id    : 0x2::object::uid_to_address(&arg0.id),
            players    : 0x2::vec_set::into_keys<address>(arg0.players),
            total_pool : 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool),
            timestamp  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<GameStarted>(v0);
    }

    // decompiled from Move bytecode v6
}

