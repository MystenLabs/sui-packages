module 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::shared_tic_tac_toe {
    struct TicTacToe has key {
        id: 0x2::object::UID,
        gameboard: vector<vector<u8>>,
        cur_turn: u8,
        game_status: u8,
        x_address: address,
        o_address: address,
    }

    struct Trophy has key {
        id: 0x2::object::UID,
    }

    struct GameEndEvent has copy, drop {
        game_id: 0x2::object::ID,
    }

    fun check_for_winner(arg0: &mut TicTacToe, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        if (arg0.game_status != 0) {
            return
        };
        let v0 = get_winner_if_all_equal(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        if (v0 != 2) {
            let v1 = if (v0 == 0) {
                1
            } else {
                2
            };
            arg0.game_status = v1;
        };
    }

    public entry fun create_game(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, 2);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = &mut v2;
        0x1::vector::push_back<u8>(v3, 2);
        0x1::vector::push_back<u8>(v3, 2);
        0x1::vector::push_back<u8>(v3, 2);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = &mut v4;
        0x1::vector::push_back<u8>(v5, 2);
        0x1::vector::push_back<u8>(v5, 2);
        0x1::vector::push_back<u8>(v5, 2);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<u8>>(v7, v0);
        0x1::vector::push_back<vector<u8>>(v7, v2);
        0x1::vector::push_back<vector<u8>>(v7, v4);
        let v8 = TicTacToe{
            id          : 0x2::object::new(arg2),
            gameboard   : v6,
            cur_turn    : 0,
            game_status : 0,
            x_address   : arg0,
            o_address   : arg1,
        };
        0x2::transfer::share_object<TicTacToe>(v8);
    }

    public entry fun delete_game(arg0: TicTacToe) {
        let TicTacToe {
            id          : v0,
            gameboard   : _,
            cur_turn    : _,
            game_status : _,
            x_address   : _,
            o_address   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun delete_trophy(arg0: Trophy) {
        let Trophy { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun get_cell(arg0: &TicTacToe, arg1: u64, arg2: u64) : u8 {
        *0x1::vector::borrow<u8>(0x1::vector::borrow<vector<u8>>(&arg0.gameboard, arg1), arg2)
    }

    fun get_cur_turn_address(arg0: &TicTacToe) : address {
        if (arg0.cur_turn % 2 == 0) {
            arg0.x_address
        } else {
            arg0.o_address
        }
    }

    public fun get_status(arg0: &TicTacToe) : u8 {
        arg0.game_status
    }

    fun get_winner_if_all_equal(arg0: &TicTacToe, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u8 {
        let v0 = get_cell(arg0, arg1, arg2);
        if (v0 == get_cell(arg0, arg3, arg4) && v0 == get_cell(arg0, arg5, arg6)) {
            v0
        } else {
            2
        }
    }

    public entry fun place_mark(arg0: &mut TicTacToe, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 3 && arg2 < 3, 2);
        assert!(arg0.game_status == 0, 1);
        assert!(get_cur_turn_address(arg0) == 0x2::tx_context::sender(arg3), 0);
        let v0 = 0x1::vector::borrow_mut<u8>(0x1::vector::borrow_mut<vector<u8>>(&mut arg0.gameboard, (arg1 as u64)), (arg2 as u64));
        assert!(*v0 == 2, 3);
        *v0 = arg0.cur_turn % 2;
        update_winner(arg0);
        arg0.cur_turn = arg0.cur_turn + 1;
        if (arg0.game_status != 0) {
            let v1 = GameEndEvent{game_id: 0x2::object::id<TicTacToe>(arg0)};
            0x2::event::emit<GameEndEvent>(v1);
            if (arg0.game_status == 1) {
                let v2 = Trophy{id: 0x2::object::new(arg3)};
                0x2::transfer::transfer<Trophy>(v2, arg0.x_address);
            } else if (arg0.game_status == 2) {
                let v3 = Trophy{id: 0x2::object::new(arg3)};
                0x2::transfer::transfer<Trophy>(v3, arg0.o_address);
            };
        };
    }

    fun update_winner(arg0: &mut TicTacToe) {
        check_for_winner(arg0, 0, 0, 0, 1, 0, 2);
        check_for_winner(arg0, 1, 0, 1, 1, 1, 2);
        check_for_winner(arg0, 2, 0, 2, 1, 2, 2);
        check_for_winner(arg0, 0, 0, 1, 0, 2, 0);
        check_for_winner(arg0, 0, 1, 1, 1, 2, 1);
        check_for_winner(arg0, 0, 2, 1, 2, 2, 2);
        check_for_winner(arg0, 0, 0, 1, 1, 2, 2);
        check_for_winner(arg0, 2, 0, 1, 1, 0, 2);
        if (arg0.game_status == 0 && arg0.cur_turn == 8) {
            arg0.game_status = 3;
        };
    }

    // decompiled from Move bytecode v6
}

