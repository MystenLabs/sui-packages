module 0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::game {
    struct RoundHistory has store {
        round_ids: vector<u64>,
        total_rounds: u64,
        last_cleaned_round: u64,
    }

    struct RoundData has store {
        round_id: u64,
        state: u8,
        start_time: u64,
        end_time: u64,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        players: 0x2::table::Table<address, RoundPlayer>,
        player_count: u8,
        total_tickets: u64,
        players_list: vector<address>,
        winner: address,
        winning_ticket: u64,
        winning_amount: u64,
    }

    struct RoundPlayer has copy, drop, store {
        tickets_start: u64,
        tickets_end: u64,
        bet_amount: u64,
        address: address,
        join_time: u64,
        referrer: address,
    }

    struct RoundStarted has copy, drop {
        round_id: u64,
        start_time: u64,
        end_time: u64,
    }

    struct RoundFinished has copy, drop {
        round_id: u64,
        winner: address,
        prize: u64,
        winning_ticket: u64,
        timestamp: u64,
    }

    struct PlayerJoined has copy, drop {
        round_id: u64,
        player: address,
        bet_amount: u64,
        tickets_start: u64,
        tickets_end: u64,
        timestamp: u64,
        total_players: u8,
        referrer: address,
    }

    struct GameState has key {
        id: 0x2::object::UID,
        admin: address,
        current_round_id: u64,
        next_round_id: u64,
        history: RoundHistory,
    }

    fun cleanup_old_round(arg0: &mut 0x2::object::UID, arg1: u64) {
        if (0x2::dynamic_field::exists_<u64>(arg0, arg1)) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&0x2::dynamic_field::borrow<u64, RoundData>(arg0, arg1).pool) == 0, 9);
            let RoundData {
                round_id       : _,
                state          : _,
                start_time     : _,
                end_time       : _,
                pool           : v4,
                players        : v5,
                player_count   : _,
                total_tickets  : _,
                players_list   : _,
                winner         : _,
                winning_ticket : _,
                winning_amount : _,
            } = 0x2::dynamic_field::remove<u64, RoundData>(arg0, arg1);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
            0x2::table::drop<address, RoundPlayer>(v5);
        };
    }

    fun derive_winning_ticket(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0x1::hash::sha3_256(*arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 8) {
            let v3 = v1 << 8;
            v1 = v3 + (*0x1::vector::borrow<u8>(&v0, v2) as u64);
            v2 = v2 + 1;
        };
        v1 % arg1
    }

    fun find_winner(arg0: &RoundData, arg1: u64) : address {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.players_list)) {
            let v1 = *0x1::vector::borrow<address>(&arg0.players_list, v0);
            let v2 = 0x2::table::borrow<address, RoundPlayer>(&arg0.players, v1);
            if (arg1 >= v2.tickets_start && arg1 < v2.tickets_end) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public entry fun finish_round(arg0: &mut GameState, arg1: &mut 0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::player_registry::Registry, arg2: &mut 0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::player_registry::AdminInfo, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::dynamic_field::borrow_mut<u64, RoundData>(&mut arg0.id, arg0.current_round_id);
        assert!(v1.state == 1, 0);
        assert!(v1.player_count >= 2, 2);
        assert!(v0 >= v1.end_time || v1.player_count == 10, 3);
        let v2 = derive_winning_ticket(&arg3, v1.total_tickets);
        let v3 = find_winner(v1, v2);
        0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::player_registry::add_admin_balance(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v1.pool, 0x2::balance::value<0x2::sui::SUI>(&v1.pool) * 8 / 100));
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.pool, 0x2::balance::value<0x2::sui::SUI>(&v1.pool)), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v3);
        v1.state = 2;
        v1.winner = v3;
        v1.winning_ticket = v2;
        v1.winning_amount = v5;
        let v6 = RoundFinished{
            round_id       : v1.round_id,
            winner         : v3,
            prize          : v5,
            winning_ticket : v2,
            timestamp      : v0,
        };
        0x2::event::emit<RoundFinished>(v6);
        0x1::vector::push_back<u64>(&mut arg0.history.round_ids, arg0.current_round_id);
        arg0.history.total_rounds = arg0.history.total_rounds + 1;
        if (0x1::vector::length<u64>(&arg0.history.round_ids) >= 3) {
            let v7 = 0x1::vector::remove<u64>(&mut arg0.history.round_ids, 0);
            let v8 = &mut arg0.id;
            cleanup_old_round(v8, v7);
            arg0.history.last_cleaned_round = v7;
        };
        let v9 = arg0.next_round_id + 1;
        arg0.current_round_id = arg0.next_round_id;
        arg0.next_round_id = v9;
        let v10 = &mut arg0.id;
        init_round(v10, v9, arg5);
    }

    public fun get_player_tickets(arg0: &GameState, arg1: u64, arg2: address) : (u64, u64) {
        let v0 = 0x2::table::borrow<address, RoundPlayer>(&0x2::dynamic_field::borrow<u64, RoundData>(&arg0.id, arg1).players, arg2);
        (v0.tickets_start, v0.tickets_end)
    }

    public fun get_round_info(arg0: &GameState, arg1: u64) : (address, u64, u64) {
        let v0 = 0x2::dynamic_field::borrow<u64, RoundData>(&arg0.id, arg1);
        (v0.winner, v0.winning_ticket, v0.winning_amount)
    }

    public fun get_round_state(arg0: &GameState, arg1: u64) : (u8, u64, u64, address) {
        let v0 = 0x2::dynamic_field::borrow<u64, RoundData>(&arg0.id, arg1);
        (v0.state, v0.start_time, v0.end_time, v0.winner)
    }

    public fun get_round_tickets(arg0: &GameState, arg1: u64) : u64 {
        0x2::dynamic_field::borrow<u64, RoundData>(&arg0.id, arg1).total_tickets
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RoundHistory{
            round_ids          : 0x1::vector::empty<u64>(),
            total_rounds       : 0,
            last_cleaned_round : 0,
        };
        let v1 = GameState{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            current_round_id : 0,
            next_round_id    : 1,
            history          : v0,
        };
        let v2 = &mut v1.id;
        init_round(v2, 0, arg0);
        let v3 = &mut v1.id;
        init_round(v3, 1, arg0);
        0x2::transfer::share_object<GameState>(v1);
    }

    fun init_round(arg0: &mut 0x2::object::UID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RoundData{
            round_id       : arg1,
            state          : 0,
            start_time     : 0,
            end_time       : 0,
            pool           : 0x2::balance::zero<0x2::sui::SUI>(),
            players        : 0x2::table::new<address, RoundPlayer>(arg2),
            player_count   : 0,
            total_tickets  : 0,
            players_list   : 0x1::vector::empty<address>(),
            winner         : @0x0,
            winning_ticket : 0,
            winning_amount : 0,
        };
        0x2::dynamic_field::add<u64, RoundData>(arg0, arg1, v0);
    }

    public entry fun place_bet(arg0: &mut GameState, arg1: &mut 0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::player_registry::Registry, arg2: &mut 0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::player_registry::AdminInfo, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 >= 1 && v1 <= 1000000000000, 4);
        0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::player_registry::add_admin_balance(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 0x2::coin::value<0x2::sui::SUI>(&arg3) * 8 / 100, arg6)));
        0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::player_registry::register_player(arg1, v0, arg4, arg5);
        let v3 = if (arg4 != 0) {
            0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::player_registry::get_player_address(arg1, arg4)
        } else {
            @0x0
        };
        if (v3 == @0x0) {
            0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::player_registry::add_admin_balance(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 0x2::coin::value<0x2::sui::SUI>(&arg3) * 1 / 100, arg6)));
        } else {
            0xfe267943f0ac89af95308cd6f358c9a95b528ba364ef8a156aa8dfdaeb92f6f9::player_registry::add_referral_reward(arg1, v3, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, 0x2::coin::value<0x2::sui::SUI>(&arg3) * 1 / 100, arg6), arg5);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<u64, RoundData>(&mut arg0.id, arg0.current_round_id);
        assert!(v4.player_count < 10, 5);
        assert!(v4.state != 1 || v2 < v4.end_time, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut v4.pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v5 = v4.total_tickets;
        let v6 = v5 + v1;
        if (0x2::table::contains<address, RoundPlayer>(&v4.players, v0)) {
            let v7 = 0x2::table::borrow_mut<address, RoundPlayer>(&mut v4.players, v0);
            v7.tickets_end = v7.tickets_end + v1;
            v7.bet_amount = v7.bet_amount + v1;
        } else {
            0x1::vector::push_back<address>(&mut v4.players_list, v0);
            let v8 = RoundPlayer{
                tickets_start : v5,
                tickets_end   : v6,
                bet_amount    : v1,
                address       : v0,
                join_time     : v2,
                referrer      : v3,
            };
            0x2::table::add<address, RoundPlayer>(&mut v4.players, v0, v8);
            v4.player_count = v4.player_count + 1;
        };
        v4.total_tickets = v4.total_tickets + v1;
        if (v4.player_count == 2) {
            v4.state = 1;
            v4.start_time = v2;
            v4.end_time = v2 + 118000;
            let v9 = RoundStarted{
                round_id   : v4.round_id,
                start_time : v4.start_time,
                end_time   : v4.end_time,
            };
            0x2::event::emit<RoundStarted>(v9);
        };
        let v10 = PlayerJoined{
            round_id      : v4.round_id,
            player        : v0,
            bet_amount    : v1,
            tickets_start : v5,
            tickets_end   : v6,
            timestamp     : v2,
            total_players : v4.player_count,
            referrer      : v3,
        };
        0x2::event::emit<PlayerJoined>(v10);
    }

    // decompiled from Move bytecode v6
}

