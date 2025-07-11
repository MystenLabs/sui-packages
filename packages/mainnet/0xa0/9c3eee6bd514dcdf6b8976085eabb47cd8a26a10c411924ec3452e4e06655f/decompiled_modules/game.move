module 0xa09c3eee6bd514dcdf6b8976085eabb47cd8a26a10c411924ec3452e4e06655f::game {
    struct Game has store, key {
        id: 0x2::object::UID,
        player1: address,
        player2: address,
        stake: u64,
        best_of: u8,
        state: u8,
        player1_commitment: vector<u8>,
        player2_commitment: vector<u8>,
        player1_score: u8,
        player2_score: u8,
        current_round: u8,
        house: address,
        rake_percentage: u8,
        created_at: u64,
        last_action_at: u64,
        winner: 0x1::option::Option<address>,
    }

    struct Stake has store, key {
        id: 0x2::object::UID,
        player: address,
        amount: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct GameCreated has copy, drop {
        game_id: 0x2::object::ID,
        player1: address,
        player2: address,
        stake: u64,
        best_of: u8,
    }

    struct PlayerJoined has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
    }

    struct ChoiceCommitted has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        round: u8,
    }

    struct RoundComplete has copy, drop {
        game_id: 0x2::object::ID,
        round: u8,
        winner: 0x1::option::Option<address>,
        player1_score: u8,
        player2_score: u8,
    }

    struct GameFinished has copy, drop {
        game_id: 0x2::object::ID,
        winner: address,
        final_score_p1: u8,
        final_score_p2: u8,
    }

    public entry fun commit_choice(arg0: &mut Game, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.state == 0 || arg0.state == 1, 1002);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 1004);
        if (v0 == arg0.player1) {
            arg0.player1_commitment = arg1;
        } else {
            arg0.player2_commitment = arg1;
        };
        arg0.last_action_at = 0x2::clock::timestamp_ms(arg2);
        if (!0x1::vector::is_empty<u8>(&arg0.player1_commitment) && !0x1::vector::is_empty<u8>(&arg0.player2_commitment)) {
            arg0.state = 1;
        };
        let v1 = ChoiceCommitted{
            game_id : 0x2::object::uid_to_inner(&arg0.id),
            player  : v0,
            round   : arg0.current_round,
        };
        0x2::event::emit<ChoiceCommitted>(v1);
    }

    public entry fun create_game(arg0: address, arg1: u64, arg2: u8, arg3: address, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 1 || arg2 == 3 || arg2 == 5, 1000);
        assert!(arg4 <= 100, 1001);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = Game{
            id                 : v0,
            player1            : 0x2::tx_context::sender(arg6),
            player2            : arg0,
            stake              : arg1,
            best_of            : arg2,
            state              : 0,
            player1_commitment : 0x1::vector::empty<u8>(),
            player2_commitment : 0x1::vector::empty<u8>(),
            player1_score      : 0,
            player2_score      : 0,
            current_round      : 1,
            house              : arg3,
            rake_percentage    : arg4,
            created_at         : v1,
            last_action_at     : v1,
            winner             : 0x1::option::none<address>(),
        };
        let v3 = GameCreated{
            game_id : 0x2::object::uid_to_inner(&v0),
            player1 : 0x2::tx_context::sender(arg6),
            player2 : arg0,
            stake   : arg1,
            best_of : arg2,
        };
        0x2::event::emit<GameCreated>(v3);
        0x2::transfer::share_object<Game>(v2);
    }

    public entry fun finalize_game(arg0: &mut Game, arg1: Stake, arg2: Stake, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 3, 1002);
        assert!(0x1::option::is_some<address>(&arg0.winner), 1002);
        let Stake {
            id     : v0,
            player : _,
            amount : v2,
        } = arg1;
        let v3 = v2;
        let Stake {
            id     : v4,
            player : _,
            amount : v6,
        } = arg2;
        let v7 = v6;
        0x2::object::delete(v0);
        0x2::object::delete(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, (0x2::coin::value<0x2::sui::SUI>(&v3) + 0x2::coin::value<0x2::sui::SUI>(&v7)) * (arg0.rake_percentage as u64) / 100, arg3), arg0.house);
        0x2::coin::join<0x2::sui::SUI>(&mut v3, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, *0x1::option::borrow<address>(&arg0.winner));
    }

    fun finish_game(arg0: &mut Game, arg1: &0x2::clock::Clock) {
        arg0.state = 3;
        arg0.last_action_at = 0x2::clock::timestamp_ms(arg1);
        let v0 = if (arg0.player1_score > arg0.player2_score) {
            arg0.player1
        } else {
            arg0.player2
        };
        arg0.winner = 0x1::option::some<address>(v0);
        let v1 = GameFinished{
            game_id        : 0x2::object::uid_to_inner(&arg0.id),
            winner         : v0,
            final_score_p1 : arg0.player1_score,
            final_score_p2 : arg0.player2_score,
        };
        0x2::event::emit<GameFinished>(v1);
    }

    public fun get_current_round(arg0: &Game) : u8 {
        arg0.current_round
    }

    public fun get_game_state(arg0: &Game) : u8 {
        arg0.state
    }

    public fun get_players(arg0: &Game) : (address, address) {
        (arg0.player1, arg0.player2)
    }

    public fun get_scores(arg0: &Game) : (u8, u8) {
        (arg0.player1_score, arg0.player2_score)
    }

    public fun get_winner(arg0: &Game) : 0x1::option::Option<address> {
        arg0.winner
    }

    public entry fun handle_timeout(arg0: &mut Game, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.last_action_at + 300000, 1007);
        arg0.state = 3;
        let v0 = if (arg0.state == 0) {
            if (!0x1::vector::is_empty<u8>(&arg0.player1_commitment)) {
                arg0.player1
            } else {
                arg0.player2
            }
        } else {
            arg0.player1
        };
        arg0.winner = 0x1::option::some<address>(v0);
        let v1 = GameFinished{
            game_id        : 0x2::object::uid_to_inner(&arg0.id),
            winner         : v0,
            final_score_p1 : arg0.player1_score,
            final_score_p2 : arg0.player2_score,
        };
        0x2::event::emit<GameFinished>(v1);
    }

    fun process_round(arg0: &mut Game, arg1: &0x2::clock::Clock) {
        let v0 = if (arg0.current_round % 2 == 1) {
            0x1::option::some<address>(arg0.player1)
        } else {
            0x1::option::some<address>(arg0.player2)
        };
        let v1 = v0;
        if (0x1::option::is_some<address>(&v1)) {
            if (*0x1::option::borrow<address>(&v1) == arg0.player1) {
                arg0.player1_score = arg0.player1_score + 1;
            } else {
                arg0.player2_score = arg0.player2_score + 1;
            };
        };
        let v2 = RoundComplete{
            game_id       : 0x2::object::uid_to_inner(&arg0.id),
            round         : arg0.current_round,
            winner        : v1,
            player1_score : arg0.player1_score,
            player2_score : arg0.player2_score,
        };
        0x2::event::emit<RoundComplete>(v2);
        let v3 = (arg0.best_of + 1) / 2;
        if (arg0.player1_score >= v3 || arg0.player2_score >= v3) {
            finish_game(arg0, arg1);
        } else {
            arg0.current_round = arg0.current_round + 1;
            arg0.state = 0;
            arg0.player1_commitment = 0x1::vector::empty<u8>();
            arg0.player2_commitment = 0x1::vector::empty<u8>();
        };
    }

    public entry fun reveal_choice(arg0: &mut Game, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.state == 1, 1002);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 1004);
        assert!(arg1 == 0 || arg1 == 1 || arg1 == 2, 1005);
        let v1 = 0x1::vector::singleton<u8>(arg1);
        0x1::vector::append<u8>(&mut v1, arg2);
        if (v0 == arg0.player1) {
            assert!(arg0.player1_commitment == 0x2::hash::keccak256(&v1), 1006);
        } else {
            assert!(arg0.player2_commitment == 0x2::hash::keccak256(&v1), 1006);
        };
        arg0.last_action_at = 0x2::clock::timestamp_ms(arg3);
        arg0.state = 2;
        process_round(arg0, arg3);
    }

    public entry fun submit_stake(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1002);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.stake, 1003);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 1004);
        let v1 = Stake{
            id     : 0x2::object::new(arg3),
            player : v0,
            amount : arg1,
        };
        arg0.last_action_at = 0x2::clock::timestamp_ms(arg2);
        let v2 = PlayerJoined{
            game_id : 0x2::object::uid_to_inner(&arg0.id),
            player  : v0,
        };
        0x2::event::emit<PlayerJoined>(v2);
        0x2::transfer::share_object<Stake>(v1);
    }

    // decompiled from Move bytecode v6
}

