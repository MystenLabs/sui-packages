module 0x518a7c0bac2759b90197e28d7aac04e25a0fec0005eb9778a900f07ebeef9e2e::game {
    struct Game has store, key {
        id: 0x2::object::UID,
        player1: address,
        player2: address,
        stake: u64,
        best_of: u8,
        state: u8,
        player1_commitment: vector<u8>,
        player2_commitment: vector<u8>,
        player1_revealed_choice: 0x1::option::Option<u8>,
        player2_revealed_choice: 0x1::option::Option<u8>,
        player1_score: u8,
        player2_score: u8,
        current_round: u8,
        created_at: u64,
        last_action_at: u64,
        winner: 0x1::option::Option<address>,
        player1_stake_submitted: bool,
        player2_stake_submitted: bool,
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

    struct StakeSubmitted has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        amount: u64,
    }

    struct ChoiceCommitted has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        round: u8,
    }

    struct ChoiceRevealed has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        choice: u8,
        round: u8,
    }

    struct RoundComplete has copy, drop {
        game_id: 0x2::object::ID,
        round: u8,
        player1_choice: u8,
        player2_choice: u8,
        winner: 0x1::option::Option<address>,
        player1_score: u8,
        player2_score: u8,
    }

    struct GameFinished has copy, drop {
        game_id: 0x2::object::ID,
        winner: address,
        final_score_p1: u8,
        final_score_p2: u8,
        payout_amount: u64,
        house_fee: u64,
    }

    struct GameCancelled has copy, drop {
        game_id: 0x2::object::ID,
        cancelled_by: address,
        refunded_amount: u64,
    }

    struct GameForfeited has copy, drop {
        game_id: 0x2::object::ID,
        forfeited_by: address,
        winner: address,
    }

    struct TimeoutClaimed has copy, drop {
        game_id: 0x2::object::ID,
        claimed_by: address,
        reason: vector<u8>,
    }

    public entry fun cancel_game(arg0: &mut Game, arg1: Stake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.player1, 1010);
        assert!(arg0.state == 1 || !arg0.player1_stake_submitted || !arg0.player2_stake_submitted, 1002);
        let Stake {
            id     : v1,
            player : v2,
            amount : v3,
        } = arg1;
        let v4 = v3;
        assert!(v2 == arg0.player1, 1010);
        0x2::object::delete(v1);
        arg0.state = 7;
        arg0.last_action_at = 0x2::clock::timestamp_ms(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, arg0.player1);
        let v5 = GameCancelled{
            game_id         : 0x2::object::uid_to_inner(&arg0.id),
            cancelled_by    : v0,
            refunded_amount : 0x2::coin::value<0x2::sui::SUI>(&v4),
        };
        0x2::event::emit<GameCancelled>(v5);
    }

    public entry fun claim_timeout_win(arg0: &mut Game, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 > arg0.last_action_at + 60000, 1007);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 1004);
        let (v2, v3) = if (arg0.state == 3) {
            if (!0x1::vector::is_empty<u8>(&arg0.player1_commitment) && 0x1::vector::is_empty<u8>(&arg0.player2_commitment)) {
                (arg0.player1, b"Player 2 failed to commit choice")
            } else if (0x1::vector::is_empty<u8>(&arg0.player1_commitment) && !0x1::vector::is_empty<u8>(&arg0.player2_commitment)) {
                (arg0.player2, b"Player 1 failed to commit choice")
            } else {
                (v0, b"Timeout claimed")
            }
        } else if (arg0.state == 4) {
            if (0x1::option::is_some<u8>(&arg0.player1_revealed_choice) && 0x1::option::is_none<u8>(&arg0.player2_revealed_choice)) {
                (arg0.player1, b"Player 2 failed to reveal choice")
            } else if (0x1::option::is_none<u8>(&arg0.player1_revealed_choice) && 0x1::option::is_some<u8>(&arg0.player2_revealed_choice)) {
                (arg0.player2, b"Player 1 failed to reveal choice")
            } else {
                (v0, b"Timeout claimed")
            }
        } else {
            (v0, b"General timeout")
        };
        arg0.state = 6;
        arg0.winner = 0x1::option::some<address>(v2);
        arg0.last_action_at = v1;
        let v4 = TimeoutClaimed{
            game_id    : 0x2::object::uid_to_inner(&arg0.id),
            claimed_by : v0,
            reason     : v3,
        };
        0x2::event::emit<TimeoutClaimed>(v4);
    }

    public entry fun commit_choice(arg0: &mut Game, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.state == 3, 1002);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 1004);
        if (v0 == arg0.player1) {
            assert!(0x1::vector::is_empty<u8>(&arg0.player1_commitment), 1002);
            arg0.player1_commitment = arg1;
        } else {
            assert!(0x1::vector::is_empty<u8>(&arg0.player2_commitment), 1002);
            arg0.player2_commitment = arg1;
        };
        arg0.last_action_at = 0x2::clock::timestamp_ms(arg2);
        if (!0x1::vector::is_empty<u8>(&arg0.player1_commitment) && !0x1::vector::is_empty<u8>(&arg0.player2_commitment)) {
            arg0.state = 4;
        };
        let v1 = ChoiceCommitted{
            game_id : 0x2::object::uid_to_inner(&arg0.id),
            player  : v0,
            round   : arg0.current_round,
        };
        0x2::event::emit<ChoiceCommitted>(v1);
    }

    public entry fun create_game(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 1 || arg2 == 3 || arg2 == 5, 1000);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = Game{
            id                      : v1,
            player1                 : v4,
            player2                 : arg0,
            stake                   : v0,
            best_of                 : arg2,
            state                   : 1,
            player1_commitment      : 0x1::vector::empty<u8>(),
            player2_commitment      : 0x1::vector::empty<u8>(),
            player1_revealed_choice : 0x1::option::none<u8>(),
            player2_revealed_choice : 0x1::option::none<u8>(),
            player1_score           : 0,
            player2_score           : 0,
            current_round           : 1,
            created_at              : v3,
            last_action_at          : v3,
            winner                  : 0x1::option::none<address>(),
            player1_stake_submitted : true,
            player2_stake_submitted : false,
        };
        let v6 = Stake{
            id     : 0x2::object::new(arg4),
            player : v4,
            amount : arg1,
        };
        let v7 = GameCreated{
            game_id : v2,
            player1 : v4,
            player2 : arg0,
            stake   : v0,
            best_of : arg2,
        };
        0x2::event::emit<GameCreated>(v7);
        let v8 = StakeSubmitted{
            game_id : v2,
            player  : v4,
            amount  : v0,
        };
        0x2::event::emit<StakeSubmitted>(v8);
        0x2::transfer::share_object<Game>(v5);
        0x2::transfer::share_object<Stake>(v6);
    }

    public entry fun finalize_game(arg0: &mut Game, arg1: Stake, arg2: Stake, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 6 || arg0.state == 8, 1002);
        assert!(0x1::option::is_some<address>(&arg0.winner), 1002);
        let Stake {
            id     : v0,
            player : v1,
            amount : v2,
        } = arg1;
        let v3 = v2;
        let Stake {
            id     : v4,
            player : v5,
            amount : v6,
        } = arg2;
        let v7 = v6;
        assert!(v1 == arg0.player1 && v5 == arg0.player2 || v1 == arg0.player2 && v5 == arg0.player1, 1004);
        0x2::object::delete(v0);
        0x2::object::delete(v4);
        let v8 = *0x1::option::borrow<address>(&arg0.winner);
        let v9 = arg0.stake * (5 as u64) / 100;
        0x2::coin::join<0x2::sui::SUI>(&mut v3, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v9, arg3), @0x47f0a8a77587ff3712b911c6e8371717615c13d1fb294bb01069dcde40edfbe5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v8);
        let v10 = GameFinished{
            game_id        : 0x2::object::uid_to_inner(&arg0.id),
            winner         : v8,
            final_score_p1 : arg0.player1_score,
            final_score_p2 : arg0.player2_score,
            payout_amount  : 0x2::coin::value<0x2::sui::SUI>(&v3) + 0x2::coin::value<0x2::sui::SUI>(&v7) - v9,
            house_fee      : v9,
        };
        0x2::event::emit<GameFinished>(v10);
    }

    fun finish_game(arg0: &mut Game, arg1: &0x2::clock::Clock) {
        arg0.state = 6;
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
            payout_amount  : 0,
            house_fee      : 0,
        };
        0x2::event::emit<GameFinished>(v1);
    }

    public entry fun forfeit_game(arg0: &mut Game, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 1004);
        assert!(arg0.player1_stake_submitted && arg0.player2_stake_submitted, 1009);
        assert!(arg0.state != 6 && arg0.state != 7 && arg0.state != 8, 1002);
        arg0.state = 8;
        arg0.last_action_at = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 == arg0.player1) {
            arg0.player2
        } else {
            arg0.player1
        };
        arg0.winner = 0x1::option::some<address>(v1);
        let v2 = GameForfeited{
            game_id      : 0x2::object::uid_to_inner(&arg0.id),
            forfeited_by : v0,
            winner       : v1,
        };
        0x2::event::emit<GameForfeited>(v2);
    }

    public fun get_current_round(arg0: &Game) : u8 {
        arg0.current_round
    }

    public fun get_game_state(arg0: &Game) : u8 {
        arg0.state
    }

    public fun get_house_address() : address {
        @0x47f0a8a77587ff3712b911c6e8371717615c13d1fb294bb01069dcde40edfbe5
    }

    public fun get_players(arg0: &Game) : (address, address) {
        (arg0.player1, arg0.player2)
    }

    fun get_round_winner(arg0: address, arg1: address, arg2: u8, arg3: u8) : 0x1::option::Option<address> {
        if (arg2 == arg3) {
            0x1::option::none<address>()
        } else if (arg2 == 0 && arg3 == 2 || arg2 == 1 && arg3 == 0 || arg2 == 2 && arg3 == 1) {
            0x1::option::some<address>(arg0)
        } else {
            0x1::option::some<address>(arg1)
        }
    }

    public fun get_scores(arg0: &Game) : (u8, u8) {
        (arg0.player1_score, arg0.player2_score)
    }

    public fun get_stakes_submitted(arg0: &Game) : (bool, bool) {
        (arg0.player1_stake_submitted, arg0.player2_stake_submitted)
    }

    public fun get_timeout_duration() : u64 {
        60000
    }

    public fun get_winner(arg0: &Game) : 0x1::option::Option<address> {
        arg0.winner
    }

    public entry fun join_game(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 1002);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.stake, 1003);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.player2, 1004);
        assert!(!arg0.player2_stake_submitted, 1002);
        arg0.player2_stake_submitted = true;
        arg0.state = 2;
        arg0.last_action_at = 0x2::clock::timestamp_ms(arg2);
        let v1 = Stake{
            id     : 0x2::object::new(arg3),
            player : v0,
            amount : arg1,
        };
        let v2 = StakeSubmitted{
            game_id : 0x2::object::uid_to_inner(&arg0.id),
            player  : v0,
            amount  : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<StakeSubmitted>(v2);
        0x2::transfer::share_object<Stake>(v1);
    }

    fun process_round(arg0: &mut Game, arg1: &0x2::clock::Clock) {
        let v0 = *0x1::option::borrow<u8>(&arg0.player1_revealed_choice);
        let v1 = *0x1::option::borrow<u8>(&arg0.player2_revealed_choice);
        let v2 = get_round_winner(arg0.player1, arg0.player2, v0, v1);
        if (0x1::option::is_some<address>(&v2)) {
            if (*0x1::option::borrow<address>(&v2) == arg0.player1) {
                arg0.player1_score = arg0.player1_score + 1;
            } else {
                arg0.player2_score = arg0.player2_score + 1;
            };
        };
        let v3 = RoundComplete{
            game_id        : 0x2::object::uid_to_inner(&arg0.id),
            round          : arg0.current_round,
            player1_choice : v0,
            player2_choice : v1,
            winner         : v2,
            player1_score  : arg0.player1_score,
            player2_score  : arg0.player2_score,
        };
        0x2::event::emit<RoundComplete>(v3);
        let v4 = (arg0.best_of + 1) / 2;
        if (arg0.player1_score >= v4 || arg0.player2_score >= v4) {
            finish_game(arg0, arg1);
        } else {
            arg0.current_round = arg0.current_round + 1;
            arg0.state = 5;
        };
    }

    public entry fun reveal_choice(arg0: &mut Game, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.state == 4, 1002);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 1004);
        assert!(arg1 == 0 || arg1 == 1 || arg1 == 2, 1005);
        let v1 = 0x1::vector::singleton<u8>(arg1);
        0x1::vector::append<u8>(&mut v1, arg2);
        if (v0 == arg0.player1) {
            assert!(arg0.player1_commitment == 0x2::hash::keccak256(&v1), 1006);
            assert!(0x1::option::is_none<u8>(&arg0.player1_revealed_choice), 1002);
            arg0.player1_revealed_choice = 0x1::option::some<u8>(arg1);
        } else {
            assert!(arg0.player2_commitment == 0x2::hash::keccak256(&v1), 1006);
            assert!(0x1::option::is_none<u8>(&arg0.player2_revealed_choice), 1002);
            arg0.player2_revealed_choice = 0x1::option::some<u8>(arg1);
        };
        arg0.last_action_at = 0x2::clock::timestamp_ms(arg3);
        let v2 = ChoiceRevealed{
            game_id : 0x2::object::uid_to_inner(&arg0.id),
            player  : v0,
            choice  : arg1,
            round   : arg0.current_round,
        };
        0x2::event::emit<ChoiceRevealed>(v2);
        if (0x1::option::is_some<u8>(&arg0.player1_revealed_choice) && 0x1::option::is_some<u8>(&arg0.player2_revealed_choice)) {
            process_round(arg0, arg3);
        };
    }

    public entry fun start_round(arg0: &mut Game, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2 || arg0.state == 5, 1002);
        assert!(arg0.player1_stake_submitted && arg0.player2_stake_submitted, 1008);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.player1 || v0 == arg0.player2, 1004);
        arg0.state = 3;
        arg0.player1_commitment = 0x1::vector::empty<u8>();
        arg0.player2_commitment = 0x1::vector::empty<u8>();
        arg0.player1_revealed_choice = 0x1::option::none<u8>();
        arg0.player2_revealed_choice = 0x1::option::none<u8>();
        arg0.last_action_at = 0x2::clock::timestamp_ms(arg1);
    }

    // decompiled from Move bytecode v6
}

