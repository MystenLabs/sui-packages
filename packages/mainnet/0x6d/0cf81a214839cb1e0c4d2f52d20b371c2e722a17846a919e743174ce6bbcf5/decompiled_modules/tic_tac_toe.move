module 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::tic_tac_toe {
    struct TicTacToe has key {
        id: 0x2::object::UID,
        gameboard: vector<vector<0x1::option::Option<Mark>>>,
        cur_turn: u8,
        game_status: u8,
        x_address: address,
        o_address: address,
    }

    struct MarkMintCap has key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        remaining_supply: u8,
    }

    struct Mark has store, key {
        id: 0x2::object::UID,
        player: address,
        row: u64,
        col: u64,
    }

    struct Trophy has key {
        id: 0x2::object::UID,
    }

    struct MarkSentEvent has copy, drop {
        game_id: 0x2::object::ID,
        mark_id: 0x2::object::ID,
    }

    struct GameEndEvent has copy, drop {
        game_id: 0x2::object::ID,
    }

    fun check_all_equal(arg0: &TicTacToe, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x1::option::Option<address> {
        let v0 = get_cell_ref(arg0, arg1, arg2);
        let v1 = get_cell_ref(arg0, arg3, arg4);
        let v2 = get_cell_ref(arg0, arg5, arg6);
        if (0x1::option::is_some<Mark>(v0) && 0x1::option::is_some<Mark>(v1) && 0x1::option::is_some<Mark>(v2)) {
            let v3 = 0x1::option::borrow<Mark>(v0).player;
            let v4 = 0x1::option::borrow<Mark>(v1).player;
            let v5 = 0x1::option::borrow<Mark>(v2).player;
            if (&v3 == &v4 && &v3 == &v5) {
                return 0x1::option::some<address>(v3)
            };
        };
        0x1::option::none<address>()
    }

    fun check_for_winner(arg0: &mut TicTacToe, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        if (arg0.game_status != 0) {
            return
        };
        let v0 = check_all_equal(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        if (0x1::option::is_some<address>(&v0)) {
            let v1 = 0x1::option::extract<address>(&mut v0);
            let v2 = if (&v1 == &arg0.x_address) {
                1
            } else {
                2
            };
            arg0.game_status = v2;
        };
    }

    public entry fun create_game(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x1::vector::empty<0x1::option::Option<Mark>>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::option::Option<Mark>>(v3, 0x1::option::none<Mark>());
        0x1::vector::push_back<0x1::option::Option<Mark>>(v3, 0x1::option::none<Mark>());
        0x1::vector::push_back<0x1::option::Option<Mark>>(v3, 0x1::option::none<Mark>());
        let v4 = 0x1::vector::empty<0x1::option::Option<Mark>>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::option::Option<Mark>>(v5, 0x1::option::none<Mark>());
        0x1::vector::push_back<0x1::option::Option<Mark>>(v5, 0x1::option::none<Mark>());
        0x1::vector::push_back<0x1::option::Option<Mark>>(v5, 0x1::option::none<Mark>());
        let v6 = 0x1::vector::empty<0x1::option::Option<Mark>>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::option::Option<Mark>>(v7, 0x1::option::none<Mark>());
        0x1::vector::push_back<0x1::option::Option<Mark>>(v7, 0x1::option::none<Mark>());
        0x1::vector::push_back<0x1::option::Option<Mark>>(v7, 0x1::option::none<Mark>());
        let v8 = 0x1::vector::empty<vector<0x1::option::Option<Mark>>>();
        let v9 = &mut v8;
        0x1::vector::push_back<vector<0x1::option::Option<Mark>>>(v9, v2);
        0x1::vector::push_back<vector<0x1::option::Option<Mark>>>(v9, v4);
        0x1::vector::push_back<vector<0x1::option::Option<Mark>>>(v9, v6);
        let v10 = TicTacToe{
            id          : v0,
            gameboard   : v8,
            cur_turn    : 0,
            game_status : 0,
            x_address   : arg0,
            o_address   : arg1,
        };
        0x2::transfer::transfer<TicTacToe>(v10, 0x2::tx_context::sender(arg2));
        let v11 = MarkMintCap{
            id               : 0x2::object::new(arg2),
            game_id          : v1,
            remaining_supply : 5,
        };
        0x2::transfer::transfer<MarkMintCap>(v11, arg0);
        let v12 = MarkMintCap{
            id               : 0x2::object::new(arg2),
            game_id          : v1,
            remaining_supply : 5,
        };
        0x2::transfer::transfer<MarkMintCap>(v12, arg1);
    }

    public entry fun delete_cap(arg0: MarkMintCap) {
        let MarkMintCap {
            id               : v0,
            game_id          : _,
            remaining_supply : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun delete_game(arg0: TicTacToe) {
        let TicTacToe {
            id          : v0,
            gameboard   : v1,
            cur_turn    : _,
            game_status : _,
            x_address   : _,
            o_address   : _,
        } = arg0;
        let v6 = v1;
        while (0x1::vector::length<vector<0x1::option::Option<Mark>>>(&v6) > 0) {
            let v7 = 0x1::vector::pop_back<vector<0x1::option::Option<Mark>>>(&mut v6);
            while (0x1::vector::length<0x1::option::Option<Mark>>(&v7) > 0) {
                let v8 = 0x1::vector::pop_back<0x1::option::Option<Mark>>(&mut v7);
                if (0x1::option::is_some<Mark>(&v8)) {
                    delete_mark(0x1::option::extract<Mark>(&mut v8));
                };
                0x1::option::destroy_none<Mark>(v8);
            };
            0x1::vector::destroy_empty<0x1::option::Option<Mark>>(v7);
        };
        0x1::vector::destroy_empty<vector<0x1::option::Option<Mark>>>(v6);
        0x2::object::delete(v0);
    }

    fun delete_mark(arg0: Mark) {
        let Mark {
            id     : v0,
            player : _,
            row    : _,
            col    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun delete_trophy(arg0: Trophy) {
        let Trophy { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun get_cell_mut_ref(arg0: &mut TicTacToe, arg1: u64, arg2: u64) : &mut 0x1::option::Option<Mark> {
        0x1::vector::borrow_mut<0x1::option::Option<Mark>>(0x1::vector::borrow_mut<vector<0x1::option::Option<Mark>>>(&mut arg0.gameboard, arg1), arg2)
    }

    fun get_cell_ref(arg0: &TicTacToe, arg1: u64, arg2: u64) : &0x1::option::Option<Mark> {
        0x1::vector::borrow<0x1::option::Option<Mark>>(0x1::vector::borrow<vector<0x1::option::Option<Mark>>>(&arg0.gameboard, arg1), arg2)
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

    public fun mark_col(arg0: &Mark) : u64 {
        arg0.col
    }

    public fun mark_player(arg0: &Mark) : &address {
        &arg0.player
    }

    public fun mark_row(arg0: &Mark) : u64 {
        arg0.row
    }

    fun mint_mark(arg0: &mut MarkMintCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Mark {
        if (arg0.remaining_supply == 0) {
            abort 1
        };
        arg0.remaining_supply = arg0.remaining_supply - 1;
        Mark{
            id     : 0x2::object::new(arg3),
            player : 0x2::tx_context::sender(arg3),
            row    : arg1,
            col    : arg2,
        }
    }

    public entry fun place_mark(arg0: &mut TicTacToe, arg1: Mark, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_cur_turn_address(arg0);
        if (arg0.game_status != 0 || &v0 != &arg1.player) {
            delete_mark(arg1);
            return
        };
        let v1 = get_cell_mut_ref(arg0, arg1.row, arg1.col);
        if (0x1::option::is_some<Mark>(v1)) {
            delete_mark(arg1);
            return
        };
        0x1::option::fill<Mark>(v1, arg1);
        update_winner(arg0);
        arg0.cur_turn = arg0.cur_turn + 1;
        if (arg0.game_status != 0) {
            let v2 = GameEndEvent{game_id: 0x2::object::id<TicTacToe>(arg0)};
            0x2::event::emit<GameEndEvent>(v2);
            if (arg0.game_status == 1) {
                let v3 = Trophy{id: 0x2::object::new(arg2)};
                0x2::transfer::transfer<Trophy>(v3, arg0.x_address);
            } else if (arg0.game_status == 2) {
                let v4 = Trophy{id: 0x2::object::new(arg2)};
                0x2::transfer::transfer<Trophy>(v4, arg0.o_address);
            };
        };
    }

    public entry fun send_mark_to_game(arg0: &mut MarkMintCap, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 2 || arg3 > 2) {
            abort 0
        };
        let v0 = mint_mark(arg0, arg2, arg3, arg4);
        let v1 = MarkSentEvent{
            game_id : arg0.game_id,
            mark_id : 0x2::object::id<Mark>(&v0),
        };
        0x2::event::emit<MarkSentEvent>(v1);
        0x2::transfer::public_transfer<Mark>(v0, arg1);
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

