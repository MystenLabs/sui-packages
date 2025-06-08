module 0x42a8bcf7072f7a9573e779ff7e719dadbbe02e403d93c8b231170d38fb632c2b::tic_tac {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_fees_collected: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Game has key {
        id: 0x2::object::UID,
        board: vector<u8>,
        turn: u8,
        x: address,
        o: address,
        mode: u8,
        status: u8,
        stake_amount: u64,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: address,
        winner: address,
        game_link: 0x1::string::String,
        viewer_link: 0x1::string::String,
        created_at: u64,
        completed_at: u64,
    }

    struct Trophy has store, key {
        id: 0x2::object::UID,
        game_id: address,
        winner: address,
        loser: address,
        stake_amount: u64,
        won_amount: u64,
        game_mode: 0x1::string::String,
    }

    struct GameCreated has copy, drop {
        game_id: address,
        creator: address,
        mode: u8,
        stake_amount: u64,
        game_link: 0x1::string::String,
        viewer_link: 0x1::string::String,
    }

    struct GameJoined has copy, drop {
        game_id: address,
        player: address,
        stake_amount: u64,
    }

    struct MoveMade has copy, drop {
        game_id: address,
        player: address,
        row: u8,
        col: u8,
        mark: u8,
    }

    struct GameCompleted has copy, drop {
        game_id: address,
        winner: address,
        loser: address,
        prize_amount: u64,
        platform_fee: u64,
    }

    public fun cancel_expired_game(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        if (arg0.mode == 1 && 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize_pool), arg1), arg0.creator);
        };
        arg0.status = 3;
    }

    fun check_line(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: u64) : bool {
        let v0 = *0x1::vector::borrow<u8>(arg0, arg1);
        let v1 = *0x1::vector::borrow<u8>(arg0, arg2);
        if (v0 != 0) {
            if (v0 == v1) {
                v1 == *0x1::vector::borrow<u8>(arg0, arg3)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun check_winner(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 9) {
            if (check_line(arg0, v0, v0 + 1, v0 + 2)) {
                return true
            };
            v0 = v0 + 3;
        };
        v0 = 0;
        while (v0 < 3) {
            if (check_line(arg0, v0, v0 + 3, v0 + 6)) {
                return true
            };
            v0 = v0 + 1;
        };
        check_line(arg0, 0, 4, 8) || check_line(arg0, 2, 4, 6)
    }

    public fun create_competitive_game(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : (0x1::string::String, 0x1::string::String) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::object::new(arg1);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = generate_game_link(v2, false);
        let v4 = generate_game_link(v2, true);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = &mut v5;
        0x1::vector::push_back<u8>(v6, 0);
        0x1::vector::push_back<u8>(v6, 0);
        0x1::vector::push_back<u8>(v6, 0);
        0x1::vector::push_back<u8>(v6, 0);
        0x1::vector::push_back<u8>(v6, 0);
        0x1::vector::push_back<u8>(v6, 0);
        0x1::vector::push_back<u8>(v6, 0);
        0x1::vector::push_back<u8>(v6, 0);
        0x1::vector::push_back<u8>(v6, 0);
        let v7 = Game{
            id           : v1,
            board        : v5,
            turn         : 0,
            x            : 0x2::tx_context::sender(arg1),
            o            : @0x0,
            mode         : 1,
            status       : 0,
            stake_amount : v0,
            prize_pool   : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            creator      : 0x2::tx_context::sender(arg1),
            winner       : @0x0,
            game_link    : v3,
            viewer_link  : v4,
            created_at   : 0x2::tx_context::epoch(arg1),
            completed_at : 0,
        };
        let v8 = GameCreated{
            game_id      : v2,
            creator      : 0x2::tx_context::sender(arg1),
            mode         : 1,
            stake_amount : v0,
            game_link    : v3,
            viewer_link  : v4,
        };
        0x2::event::emit<GameCreated>(v8);
        0x2::transfer::share_object<Game>(v7);
        (v3, v4)
    }

    public fun create_friendly_game(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (0x1::string::String, 0x1::string::String) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = generate_game_link(v1, false);
        let v3 = generate_game_link(v1, true);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = &mut v4;
        0x1::vector::push_back<u8>(v5, 0);
        0x1::vector::push_back<u8>(v5, 0);
        0x1::vector::push_back<u8>(v5, 0);
        0x1::vector::push_back<u8>(v5, 0);
        0x1::vector::push_back<u8>(v5, 0);
        0x1::vector::push_back<u8>(v5, 0);
        0x1::vector::push_back<u8>(v5, 0);
        0x1::vector::push_back<u8>(v5, 0);
        0x1::vector::push_back<u8>(v5, 0);
        let v6 = Game{
            id           : v0,
            board        : v4,
            turn         : 0,
            x            : 0x2::tx_context::sender(arg1),
            o            : arg0,
            mode         : 0,
            status       : 1,
            stake_amount : 0,
            prize_pool   : 0x2::balance::zero<0x2::sui::SUI>(),
            creator      : 0x2::tx_context::sender(arg1),
            winner       : @0x0,
            game_link    : v2,
            viewer_link  : v3,
            created_at   : 0x2::tx_context::epoch(arg1),
            completed_at : 0,
        };
        let v7 = GameCreated{
            game_id      : v1,
            creator      : 0x2::tx_context::sender(arg1),
            mode         : 0,
            stake_amount : 0,
            game_link    : v2,
            viewer_link  : v3,
        };
        0x2::event::emit<GameCreated>(v7);
        0x2::transfer::share_object<Game>(v6);
        (v2, v3)
    }

    fun create_trophy(arg0: &Game, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.winner == arg0.x) {
            arg0.o
        } else {
            arg0.x
        };
        let v1 = Trophy{
            id           : 0x2::object::new(arg1),
            game_id      : 0x2::object::uid_to_address(&arg0.id),
            winner       : arg0.winner,
            loser        : v0,
            stake_amount : 0,
            won_amount   : 0,
            game_mode    : 0x1::string::utf8(b"Friendly"),
        };
        0x2::transfer::public_transfer<Trophy>(v1, arg0.winner);
    }

    fun distribute_prizes(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v1 = v0 * 1000 / 10000;
        let v2 = v0 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize_pool), arg1), arg0.winner);
        let v3 = if (arg0.winner == arg0.x) {
            arg0.o
        } else {
            arg0.x
        };
        let v4 = Trophy{
            id           : 0x2::object::new(arg1),
            game_id      : 0x2::object::uid_to_address(&arg0.id),
            winner       : arg0.winner,
            loser        : v3,
            stake_amount : arg0.stake_amount,
            won_amount   : v2,
            game_mode    : 0x1::string::utf8(b"Competitive"),
        };
        0x2::transfer::public_transfer<Trophy>(v4, arg0.winner);
        let v5 = GameCompleted{
            game_id      : 0x2::object::uid_to_address(&arg0.id),
            winner       : arg0.winner,
            loser        : v3,
            prize_amount : v2,
            platform_fee : v1,
        };
        0x2::event::emit<GameCompleted>(v5);
    }

    fun generate_game_link(arg0: address, arg1: bool) : 0x1::string::String {
        if (arg1) {
            0x1::string::utf8(b"viewer_link_placeholder")
        } else {
            0x1::string::utf8(b"game_link_placeholder")
        }
    }

    public fun get_board(arg0: &Game) : vector<u8> {
        arg0.board
    }

    public fun get_game_status(arg0: &Game) : (u8, address, u8, u64) {
        (arg0.status, arg0.winner, arg0.mode, arg0.stake_amount)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                   : 0x2::object::new(arg0),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            total_fees_collected : 0,
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_draw(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 9) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun is_viewer_link(arg0: &Game, arg1: 0x1::string::String) : bool {
        arg0.viewer_link == arg1
    }

    public fun join_competitive_game(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        assert!(arg0.mode == 1, 7);
        assert!(0x2::tx_context::sender(arg2) != arg0.creator, 9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.stake_amount, 4);
        arg0.o = 0x2::tx_context::sender(arg2);
        arg0.status = 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = GameJoined{
            game_id      : 0x2::object::uid_to_address(&arg0.id),
            player       : 0x2::tx_context::sender(arg2),
            stake_amount : arg0.stake_amount,
        };
        0x2::event::emit<GameJoined>(v0);
    }

    public fun place_mark(arg0: &mut Game, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 7);
        assert!(arg1 < 3 && arg2 < 3, 1);
        let v0 = if (arg0.turn % 2 == 0) {
            arg0.x
        } else {
            arg0.o
        };
        assert!(0x2::tx_context::sender(arg3) == v0, 0);
        let v1 = (arg1 as u64) * 3 + (arg2 as u64);
        assert!(*0x1::vector::borrow<u8>(&arg0.board, v1) == 0, 3);
        let v2 = if (arg0.turn % 2 == 0) {
            1
        } else {
            2
        };
        *0x1::vector::borrow_mut<u8>(&mut arg0.board, v1) = v2;
        let v3 = MoveMade{
            game_id : 0x2::object::uid_to_address(&arg0.id),
            player  : v0,
            row     : arg1,
            col     : arg2,
            mark    : v2,
        };
        0x2::event::emit<MoveMade>(v3);
        if (check_winner(&arg0.board)) {
            arg0.winner = v0;
            arg0.status = 2;
            arg0.completed_at = 0x2::tx_context::epoch(arg3);
            if (arg0.mode == 1) {
                distribute_prizes(arg0, arg3);
            } else {
                create_trophy(arg0, arg3);
            };
        } else if (is_draw(&arg0.board)) {
            arg0.status = 2;
            arg0.completed_at = 0x2::tx_context::epoch(arg3);
            if (arg0.mode == 1) {
                return_stakes(arg0, arg3);
            };
        } else {
            arg0.turn = arg0.turn + 1;
        };
    }

    fun return_stakes(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) / 2), arg1), arg0.x);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize_pool), arg1), arg0.o);
    }

    public fun withdraw_fees(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

