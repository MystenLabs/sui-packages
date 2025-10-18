module 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::ttt {
    struct Game has key {
        id: 0x2::object::UID,
        last_move_timestamp: u64,
        board: vector<u8>,
        turn: u8,
        x: address,
        o: address,
    }

    fun new(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
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
            id                  : 0x2::object::new(arg2),
            last_move_timestamp : 0x2::clock::timestamp_ms(arg1),
            board               : v0,
            turn                : 0,
            x                   : arg0,
            o                   : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<Game>(v2);
    }

    fun burn(arg0: Game, arg1: 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::Control) {
        let Game {
            id                  : v0,
            last_move_timestamp : _,
            board               : _,
            turn                : _,
            x                   : _,
            o                   : _,
        } = arg0;
        0x2::object::delete(v0);
        0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::destroy(arg1);
    }

    entry fun claim_by_timeout(arg0: Game, arg1: 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::Control, arg2: &mut 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::PlayerRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) - arg0.last_move_timestamp >= 30000, 13906834655380635663);
        let (v0, v1, _) = next_player(&arg0);
        assert!(0x2::tx_context::sender(arg4) == v1, 13906834663970045959);
        0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::winner(v1, &mut arg1);
        0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::finish_game(&mut arg1, arg4);
        0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::register_win(arg2, v1);
        0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::register_loss(arg2, v0);
        burn(arg0, arg1);
    }

    fun ended(arg0: &Game) : u8 {
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

    entry fun join_bttt(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::Control, arg3: &mut 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::PlayerRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::sender1(arg2);
        assert!(0x2::tx_context::sender(arg5) != v0, 13906834487877042193);
        0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::get_or_create_profile(arg3, arg5);
        0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::join_bet(arg0, arg1, arg2, arg5);
        new(v0, arg4, arg5);
    }

    public fun mark(arg0: &Game, arg1: u8, arg2: u8) : &u8 {
        0x1::vector::borrow<u8>(&arg0.board, ((arg1 * 3 + arg2) as u64))
    }

    fun mark_mut(arg0: &mut Game, arg1: u8, arg2: u8) : &mut u8 {
        0x1::vector::borrow_mut<u8>(&mut arg0.board, ((arg1 * 3 + arg2) as u64))
    }

    fun next_player(arg0: &Game) : (address, address, u8) {
        if (arg0.turn % 2 == 0) {
            (arg0.x, arg0.o, 1)
        } else {
            (arg0.o, arg0.x, 2)
        }
    }

    entry fun place_mark(arg0: Game, arg1: 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::Control, arg2: &mut 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::PlayerRegistry, arg3: &0x2::clock::Clock, arg4: u8, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(ended(&arg0) == 0, 13906834517941420043);
        assert!(arg4 < 3 && arg5 < 3, 13906834522235994117);
        let (v0, v1, v2) = next_player(&arg0);
        assert!(v0 == 0x2::tx_context::sender(arg6), 13906834530826059783);
        if (*mark(&arg0, arg4, arg5) != 0) {
            abort 13906834539416125449
        };
        let v3 = &mut arg0;
        *mark_mut(v3, arg4, arg5) = v2;
        arg0.turn = arg0.turn + 1;
        arg0.last_move_timestamp = 0x2::clock::timestamp_ms(arg3);
        let v4 = ended(&arg0);
        if (v4 == 2) {
            0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::winner(v0, &mut arg1);
            0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::register_win(arg2, v0);
            0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::register_loss(arg2, v1);
            0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::finish_game(&mut arg1, arg6);
            burn(arg0, arg1);
        } else if (v4 == 1) {
            0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::draw(&mut arg1, arg6);
            0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::register_draw(arg2, v0, v1);
            burn(arg0, arg1);
        } else {
            assert!(v4 == 0, 13906834625315733517);
            0x2::transfer::share_object<Game>(arg0);
            0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::share_control(arg1);
        };
    }

    entry fun start_bttt(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::PlayerRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main::create_bet(arg0, arg1, arg3);
        0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::profile::get_or_create_profile(arg2, arg3);
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

    // decompiled from Move bytecode v6
}

