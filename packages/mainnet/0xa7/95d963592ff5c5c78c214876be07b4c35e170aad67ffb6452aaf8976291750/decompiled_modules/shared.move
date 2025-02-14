module 0xa795d963592ff5c5c78c214876be07b4c35e170aad67ffb6452aaf8976291750::shared {
    struct Game has key {
        id: 0x2::object::UID,
        board: vector<u8>,
        turn: u8,
        x: address,
        o: address,
    }

    struct State has key {
        id: 0x2::object::UID,
        scores: 0x2::table::Table<address, u64>,
    }

    struct Trophy has key {
        id: 0x2::object::UID,
        status: u8,
        board: vector<u8>,
        turn: u8,
        other: address,
    }

    public fun new(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 0);
        let v2 = Game{
            id    : 0x2::object::new(arg2),
            board : v0,
            turn  : 0,
            x     : arg0,
            o     : arg1,
        };
        0x2::transfer::share_object<Game>(v2);
    }

    public fun burn(arg0: Game) {
        assert!(ended(&arg0) != 0, 9223372784179675146);
        let Game {
            id    : v0,
            board : _,
            turn  : _,
            x     : _,
            o     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun ended(arg0: &Game) : u8 {
        let v0 = if (test_triple(arg0, 0, 1, 2)) {
            true
        } else if (test_triple(arg0, 3, 4, 5)) {
            true
        } else if (test_triple(arg0, 6, 7, 8)) {
            true
        } else if (test_triple(arg0, 0, 3, 6)) {
            true
        } else if (test_triple(arg0, 1, 4, 7)) {
            true
        } else if (test_triple(arg0, 2, 5, 8)) {
            true
        } else if (test_triple(arg0, 0, 4, 8)) {
            true
        } else {
            test_triple(arg0, 2, 4, 6)
        };
        if (v0) {
            2
        } else if (arg0.turn == 9) {
            1
        } else {
            0
        }
    }

    public fun get_score(arg0: &State, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.scores, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id     : 0x2::object::new(arg0),
            scores : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<State>(v0);
    }

    public fun mark(arg0: &Game, arg1: u8, arg2: u8) : &u8 {
        0x1::vector::borrow<u8>(&arg0.board, ((arg1 * 3 + arg2) as u64))
    }

    fun mark_mut(arg0: &mut Game, arg1: u8, arg2: u8) : &mut u8 {
        0x1::vector::borrow_mut<u8>(&mut arg0.board, ((arg1 * 3 + arg2) as u64))
    }

    fun mint_trophy(arg0: &Game, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Trophy {
        Trophy{
            id     : 0x2::object::new(arg3),
            status : arg1,
            board  : arg0.board,
            turn   : arg0.turn,
            other  : arg2,
        }
    }

    fun next_player(arg0: &Game) : (address, address, u8) {
        if (arg0.turn % 2 == 0) {
            (arg0.x, arg0.o, 1)
        } else {
            (arg0.o, arg0.x, 2)
        }
    }

    public fun place_mark(arg0: &mut Game, arg1: &mut State, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(ended(arg0) == 0, 9223372517891833868);
        assert!(arg2 < 3 && arg3 < 3, 9223372522186276868);
        let (v0, v1, v2) = next_player(arg0);
        assert!(v0 == 0x2::tx_context::sender(arg4), 9223372539366277126);
        if (*mark(arg0, arg2, arg3) != 0) {
            abort 9223372552251310088
        };
        let v3 = mark_mut(arg0, arg2, arg3);
        *v3 = v2;
        arg0.turn = arg0.turn + 1;
        let v4 = ended(arg0);
        if (v4 == 2) {
            0x2::transfer::transfer<Trophy>(mint_trophy(arg0, v4, v1, arg4), v0);
            let v5 = &mut arg1.scores;
            update_leaderboard(v5, v0);
        } else if (v4 == 1) {
            let v6 = mint_trophy(arg0, v4, v1, arg4);
            0x2::transfer::transfer<Trophy>(v6, v0);
            0x2::transfer::transfer<Trophy>(mint_trophy(arg0, v4, v0, arg4), v1);
        } else if (v4 != 0) {
            abort 9223372616676212750
        };
    }

    fun test_triple(arg0: &Game, arg1: u8, arg2: u8, arg3: u8) : bool {
        let v0 = *0x1::vector::borrow<u8>(&arg0.board, (arg1 as u64));
        let v1 = *0x1::vector::borrow<u8>(&arg0.board, (arg2 as u64));
        if (0 != v0) {
            if (v0 == v1) {
                v1 == *0x1::vector::borrow<u8>(&arg0.board, (arg3 as u64))
            } else {
                false
            }
        } else {
            false
        }
    }

    fun update_leaderboard(arg0: &mut 0x2::table::Table<address, u64>, arg1: address) {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
        } else {
            0x2::table::add<address, u64>(arg0, arg1, 1);
        };
    }

    // decompiled from Move bytecode v6
}

