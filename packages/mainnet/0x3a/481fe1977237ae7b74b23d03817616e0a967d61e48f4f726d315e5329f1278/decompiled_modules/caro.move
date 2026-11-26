module 0x3a481fe1977237ae7b74b23d03817616e0a967d61e48f4f726d315e5329f1278::caro {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        min_wager: u64,
        is_paused: bool,
    }

    struct GameRoom has key {
        id: 0x2::object::UID,
        player_x: address,
        player_o: 0x1::option::Option<address>,
        wager: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        board: vector<u8>,
        turn: u8,
        move_count: u16,
        status: u8,
        winner: 0x1::option::Option<address>,
        last_move_ms: u64,
    }

    struct RoomCreated has copy, drop {
        room_id: 0x2::object::ID,
        player_x: address,
        wager: u64,
    }

    struct RoomJoined has copy, drop {
        room_id: 0x2::object::ID,
        player_x: address,
        player_o: address,
        total_pot: u64,
    }

    struct MoveMade has copy, drop {
        room_id: 0x2::object::ID,
        player: address,
        piece: u8,
        row: u8,
        col: u8,
        next_turn: u8,
    }

    struct GameSettled has copy, drop {
        room_id: 0x2::object::ID,
        winner: 0x1::option::Option<address>,
        payout_winner: u64,
        protocol_fee: u64,
        reason: u8,
    }

    struct RoomCancelled has copy, drop {
        room_id: 0x2::object::ID,
        player_x: address,
        refunded: u64,
    }

    public fun board(arg0: &GameRoom) : vector<u8> {
        arg0.board
    }

    public fun cancel_room(arg0: &mut GameRoom, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 4);
        assert!(0x2::tx_context::sender(arg1) == arg0.player_x, 6);
        arg0.status = 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.vault, 0x2::balance::value<0x2::sui::SUI>(&arg0.vault), arg1), arg0.player_x);
        let v0 = RoomCancelled{
            room_id  : 0x2::object::id<GameRoom>(arg0),
            player_x : arg0.player_x,
            refunded : arg0.wager,
        };
        0x2::event::emit<RoomCancelled>(v0);
    }

    public fun claim_timeout_win(arg0: &ProtocolConfig, arg1: &mut GameRoom, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1);
        assert!(arg1.status == 1, 4);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.last_move_ms + 300000, 10);
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg1.turn == 1) {
            assert!(v0 == *0x1::option::borrow<address>(&arg1.player_o), 6);
        } else {
            assert!(v0 == arg1.player_x, 6);
        };
        settle_win(arg0, arg1, v0, 3, arg3);
    }

    fun count_dir(arg0: &vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: bool, arg7: bool) : u64 {
        let v0 = 0;
        let v1 = arg1;
        let v2 = arg2;
        loop {
            if (arg6) {
                if (v1 < arg4) {
                    break
                };
                v1 = v1 - arg4;
            } else {
                let v3 = v1 + arg4;
                v1 = v3;
                if (v3 >= 15) {
                    break
                };
            };
            if (arg7) {
                if (v2 < arg5) {
                    break
                };
                v2 = v2 - arg5;
            } else {
                let v4 = v2 + arg5;
                v2 = v4;
                if (v4 >= 15) {
                    break
                };
            };
            if (*0x1::vector::borrow<u8>(arg0, (v1 as u64) * (15 as u64) + (v2 as u64)) == arg3) {
                v0 = v0 + 1;
            } else {
                break
            };
        };
        v0
    }

    fun count_line(arg0: &vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: bool, arg7: bool) : u64 {
        1 + count_dir(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7) + count_dir(arg0, arg1, arg2, arg3, arg4, arg5, !arg6, !arg7)
    }

    public fun create_room(arg0: &ProtocolConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.min_wager, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 225) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = GameRoom{
            id           : 0x2::object::new(arg3),
            player_x     : 0x2::tx_context::sender(arg3),
            player_o     : 0x1::option::none<address>(),
            wager        : v0,
            vault        : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            board        : v1,
            turn         : 1,
            move_count   : 0,
            status       : 0,
            winner       : 0x1::option::none<address>(),
            last_move_ms : 0x2::clock::timestamp_ms(arg2),
        };
        let v4 = RoomCreated{
            room_id  : 0x2::object::id<GameRoom>(&v3),
            player_x : 0x2::tx_context::sender(arg3),
            wager    : v0,
        };
        0x2::event::emit<RoomCreated>(v4);
        0x2::transfer::share_object<GameRoom>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ProtocolConfig{
            id        : 0x2::object::new(arg0),
            treasury  : 0x2::tx_context::sender(arg0),
            min_wager : 100000000,
            is_paused : false,
        };
        0x2::transfer::share_object<ProtocolConfig>(v1);
    }

    fun is_five_in_a_row(arg0: &vector<u8>, arg1: u8, arg2: u8, arg3: u8) : bool {
        if (count_line(arg0, arg1, arg2, arg3, 0, 1, false, false) >= 5) {
            true
        } else if (count_line(arg0, arg1, arg2, arg3, 1, 0, false, false) >= 5) {
            true
        } else if (count_line(arg0, arg1, arg2, arg3, 1, 1, false, false) >= 5) {
            true
        } else {
            count_line(arg0, arg1, arg2, arg3, 1, 1, false, true) >= 5
        }
    }

    public fun is_paused(arg0: &ProtocolConfig) : bool {
        arg0.is_paused
    }

    public fun join_room(arg0: &ProtocolConfig, arg1: &mut GameRoom, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1);
        assert!(arg1.status == 0, 4);
        assert!(0x2::tx_context::sender(arg4) != arg1.player_x, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.wager, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.player_o = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        arg1.status = 1;
        arg1.turn = 1;
        arg1.last_move_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = RoomJoined{
            room_id   : 0x2::object::id<GameRoom>(arg1),
            player_x  : arg1.player_x,
            player_o  : 0x2::tx_context::sender(arg4),
            total_pot : 0x2::balance::value<0x2::sui::SUI>(&arg1.vault),
        };
        0x2::event::emit<RoomJoined>(v0);
    }

    public fun make_move(arg0: &ProtocolConfig, arg1: &mut GameRoom, arg2: u8, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1);
        assert!(arg1.status == 1, 4);
        assert!(arg2 < 15 && arg3 < 15, 8);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = arg1.turn;
        if (v1 == 1) {
            assert!(v0 == arg1.player_x, 7);
        } else {
            assert!(v0 == *0x1::option::borrow<address>(&arg1.player_o), 7);
        };
        let v2 = (arg2 as u64) * (15 as u64) + (arg3 as u64);
        assert!(*0x1::vector::borrow<u8>(&arg1.board, v2) == 0, 9);
        *0x1::vector::borrow_mut<u8>(&mut arg1.board, v2) = v1;
        arg1.move_count = arg1.move_count + 1;
        arg1.last_move_ms = 0x2::clock::timestamp_ms(arg4);
        if (is_five_in_a_row(&arg1.board, arg2, arg3, v1)) {
            settle_win(arg0, arg1, v0, 1, arg5);
        } else if ((arg1.move_count as u64) == 225) {
            arg1.status = 2;
            arg1.winner = 0x1::option::none<address>();
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.vault, arg1.wager, arg5), arg1.player_x);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.vault, 0x2::balance::value<0x2::sui::SUI>(&arg1.vault), arg5), *0x1::option::borrow<address>(&arg1.player_o));
            let v3 = GameSettled{
                room_id       : 0x2::object::id<GameRoom>(arg1),
                winner        : 0x1::option::none<address>(),
                payout_winner : 0,
                protocol_fee  : 0,
                reason        : 2,
            };
            0x2::event::emit<GameSettled>(v3);
        } else {
            let v4 = if (v1 == 1) {
                2
            } else {
                1
            };
            arg1.turn = v4;
            let v5 = MoveMade{
                room_id   : 0x2::object::id<GameRoom>(arg1),
                player    : v0,
                piece     : v1,
                row       : arg2,
                col       : arg3,
                next_turn : arg1.turn,
            };
            0x2::event::emit<MoveMade>(v5);
        };
    }

    public fun min_wager(arg0: &ProtocolConfig) : u64 {
        arg0.min_wager
    }

    public fun move_count(arg0: &GameRoom) : u16 {
        arg0.move_count
    }

    public fun player_o(arg0: &GameRoom) : 0x1::option::Option<address> {
        arg0.player_o
    }

    public fun player_x(arg0: &GameRoom) : address {
        arg0.player_x
    }

    public fun set_min_wager(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64) {
        arg1.min_wager = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: bool) {
        arg1.is_paused = arg2;
    }

    fun settle_win(arg0: &ProtocolConfig, arg1: &mut GameRoom, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.status = 2;
        arg1.winner = 0x1::option::some<address>(arg2);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.vault);
        let v1 = (((v0 as u128) * 500 / 10000) as u64);
        let v2 = v0 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.vault, v2, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.vault, 0x2::balance::value<0x2::sui::SUI>(&arg1.vault), arg4), arg0.treasury);
        let v3 = GameSettled{
            room_id       : 0x2::object::id<GameRoom>(arg1),
            winner        : 0x1::option::some<address>(arg2),
            payout_winner : v2,
            protocol_fee  : v1,
            reason        : arg3,
        };
        0x2::event::emit<GameSettled>(v3);
    }

    public fun status(arg0: &GameRoom) : u8 {
        arg0.status
    }

    public fun treasury(arg0: &ProtocolConfig) : address {
        arg0.treasury
    }

    public fun turn(arg0: &GameRoom) : u8 {
        arg0.turn
    }

    public fun update_treasury(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun vault_value(arg0: &GameRoom) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    public fun wager(arg0: &GameRoom) : u64 {
        arg0.wager
    }

    public fun winner(arg0: &GameRoom) : 0x1::option::Option<address> {
        arg0.winner
    }

    // decompiled from Move bytecode v7
}

