module 0x170e188e029d65d526972c2fd8c51ccf3c750b009cce157ac162f53b38a8b0d9::battleship {
    struct State has key {
        id: 0x2::object::UID,
        game_index: u256,
        games: 0x2::table::Table<u256, Game>,
        playing: 0x2::table::Table<address, u256>,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        nonce: u64,
        shots: 0x2::table::Table<u64, vector<u256>>,
        hits: 0x2::table::Table<u64, u256>,
        participants: vector<address>,
        boards: vector<vector<u8>>,
        hit_nonce: vector<u256>,
        winner: address,
    }

    struct StartedEvent has copy, drop {
        nonce: u256,
        by: address,
    }

    struct JoindEvent has copy, drop {
        nonce: u256,
        by: address,
    }

    struct ShotEvent has copy, drop {
        x: u256,
        y: u256,
        game_index: u256,
    }

    struct ReportEvent has copy, drop {
        hit: u256,
        game_index: u256,
    }

    struct WonEvent has copy, drop {
        winner: address,
        nonce: u256,
        by: address,
    }

    public entry fun first_turn(arg0: &mut State, arg1: u256, arg2: u256, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u256, Game>(&mut arg0.games, arg1), 1);
        let v0 = 0x2::table::borrow_mut<u256, Game>(&mut arg0.games, arg1);
        assert!(v0.winner == 0x2::address::from_u256(0), 4);
        assert!(v0.nonce == 0, 5);
        let v1 = 0x1::vector::empty<u256>();
        let v2 = &mut v1;
        0x1::vector::push_back<u256>(v2, arg2);
        0x1::vector::push_back<u256>(v2, arg3);
        0x2::table::add<u64, vector<u256>>(&mut v0.shots, v0.nonce, v1);
        v0.nonce = v0.nonce + 1;
        let v3 = ShotEvent{
            x          : arg2,
            y          : arg3,
            game_index : arg1,
        };
        0x2::event::emit<ShotEvent>(v3);
    }

    public fun game_over(arg0: &mut State, arg1: u256) {
        let v0 = 0x2::table::borrow_mut<u256, Game>(&mut arg0.games, arg1);
        assert!(*0x1::vector::borrow<u256>(&v0.hit_nonce, 0) == 17 || *0x1::vector::borrow<u256>(&v0.hit_nonce, 1) == 17, 4);
        assert!(v0.winner == 0x2::address::from_u256(0), 4);
        if (*0x1::vector::borrow<u256>(&v0.hit_nonce, 0) == 17) {
            v0.winner = *0x1::vector::borrow<address>(&v0.participants, 0);
        } else {
            v0.winner = *0x1::vector::borrow<address>(&v0.participants, 1);
        };
        let v1 = WonEvent{
            winner : v0.winner,
            nonce  : arg1,
            by     : v0.winner,
        };
        0x2::event::emit<WonEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id         : 0x2::object::new(arg0),
            game_index : 0,
            games      : 0x2::table::new<u256, Game>(arg0),
            playing    : 0x2::table::new<address, u256>(arg0),
        };
        0x2::transfer::share_object<State>(v0);
    }

    public entry fun join_game(arg0: &mut State, arg1: u256, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u256, Game>(&mut arg0.games, arg1), 1);
        assert!(0x1::vector::length<address>(&0x2::table::borrow_mut<u256, Game>(&mut arg0.games, arg1).participants) == 1, 3);
        assert!(0x170e188e029d65d526972c2fd8c51ccf3c750b009cce157ac162f53b38a8b0d9::board_verifier::verify(arg2, arg3) == true, 8);
        let v0 = 0x2::table::borrow_mut<u256, Game>(&mut arg0.games, arg1);
        0x1::vector::push_back<address>(&mut v0.participants, 0x2::tx_context::sender(arg4));
        0x1::vector::push_back<vector<u8>>(&mut v0.boards, arg2);
        let v1 = JoindEvent{
            nonce : arg1,
            by    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<JoindEvent>(v1);
    }

    public entry fun new_game(arg0: &mut State, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x170e188e029d65d526972c2fd8c51ccf3c750b009cce157ac162f53b38a8b0d9::board_verifier::verify(arg1, arg2) == true, 8);
        let v0 = Game{
            id           : 0x2::object::new(arg3),
            nonce        : 0,
            shots        : 0x2::table::new<u64, vector<u256>>(arg3),
            hits         : 0x2::table::new<u64, u256>(arg3),
            participants : 0x1::vector::empty<address>(),
            boards       : 0x1::vector::empty<vector<u8>>(),
            hit_nonce    : vector[0, 0],
            winner       : 0x2::address::from_u256(0),
        };
        0x1::vector::push_back<address>(&mut v0.participants, 0x2::tx_context::sender(arg3));
        0x1::vector::push_back<vector<u8>>(&mut v0.boards, arg1);
        arg0.game_index = arg0.game_index + 1;
        0x2::table::add<u256, Game>(&mut arg0.games, arg0.game_index, v0);
        let v1 = StartedEvent{
            nonce : arg0.game_index,
            by    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<StartedEvent>(v1);
    }

    public entry fun turn(arg0: &mut State, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u256, Game>(&mut arg0.games, arg1), 1);
        let v0 = 0x2::table::borrow_mut<u256, Game>(&mut arg0.games, arg1);
        assert!(v0.winner == 0x2::address::from_u256(0), 4);
        let v1 = if (v0.nonce % 2 == 0) {
            *0x1::vector::borrow<address>(&v0.participants, 0)
        } else {
            *0x1::vector::borrow<address>(&v0.participants, 1)
        };
        assert!(0x2::tx_context::sender(arg6) == v1, 6);
        assert!(v0.nonce != 0, 7);
        let v2 = *0x2::table::borrow<u64, vector<u256>>(&v0.shots, v0.nonce - 1);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, *0x1::vector::borrow<vector<u8>>(&v0.boards, v0.nonce % 2));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u256>(0x1::vector::borrow<u256>(&v2, 0)));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u256>(0x1::vector::borrow<u256>(&v2, 1)));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u256>(&arg2));
        assert!(0x170e188e029d65d526972c2fd8c51ccf3c750b009cce157ac162f53b38a8b0d9::shot_verify::verify(v3, arg5) == true, 9);
        0x2::table::add<u64, u256>(&mut v0.hits, v0.nonce - 1, arg2);
        if (arg2 > 0) {
            *0x1::vector::borrow_mut<u256>(&mut v0.hit_nonce, (v0.nonce - 1) % 2) = *0x1::vector::borrow_mut<u256>(&mut v0.hit_nonce, (v0.nonce - 1) % 2) + 1;
        };
        let v4 = ReportEvent{
            hit        : arg2,
            game_index : arg1,
        };
        0x2::event::emit<ReportEvent>(v4);
        if (*0x1::vector::borrow<u256>(&v0.hit_nonce, (v0.nonce - 1) % 2) >= 17) {
            game_over(arg0, arg1);
        } else {
            let v5 = 0x1::vector::empty<u256>();
            let v6 = &mut v5;
            0x1::vector::push_back<u256>(v6, arg3);
            0x1::vector::push_back<u256>(v6, arg4);
            0x2::table::add<u64, vector<u256>>(&mut v0.shots, v0.nonce, v5);
            v0.nonce = v0.nonce + 1;
            let v7 = ShotEvent{
                x          : arg3,
                y          : arg4,
                game_index : arg1,
            };
            0x2::event::emit<ShotEvent>(v7);
        };
    }

    // decompiled from Move bytecode v6
}

