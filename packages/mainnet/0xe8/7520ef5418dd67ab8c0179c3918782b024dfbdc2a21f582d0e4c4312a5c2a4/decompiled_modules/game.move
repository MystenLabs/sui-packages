module 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game {
    struct RoundResolved has copy, drop {
        match_id: 0x2::object::ID,
        matchup: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Matchup,
        round: u32,
        actions: vector<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action>,
        emotions: vector<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState>,
        focus_scores: vector<u8>,
        damage_dealt: vector<u64>,
        hp_after: vector<u64>,
        attack_results: vector<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::AttackResult>,
        defend_results: vector<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::DefendResult>,
        block_pcts: vector<u64>,
        first_actor: u8,
        signals: vector<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal>,
        guesses: vector<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess>,
        call_successes: vector<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess>,
        bluff_caught: vector<bool>,
        rewards_applied: vector<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::BluffReward>,
        charge_vulnerable: vector<bool>,
        can_win_in: vector<u32>,
        banters: vector<vector<u8>>,
        confidences: vector<u8>,
        rng_seed: vector<u8>,
        timestamp: u64,
    }

    struct MatchCompleted has copy, drop {
        match_id: 0x2::object::ID,
        matchup: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Matchup,
        winner: u8,
        final_hp: vector<u64>,
        total_rounds: u32,
    }

    struct CompactRound has copy, drop, store {
        round: u32,
        actions: vector<u8>,
        damages: vector<u64>,
        hp_after: vector<u64>,
        attack_results: vector<u8>,
        first_actor: u8,
        bluff_caught: vector<bool>,
    }

    struct ReplayExtra has copy, drop, store {
        emotions: vector<u8>,
        focus_scores: vector<u8>,
        signals: vector<u8>,
        guesses: vector<u8>,
        defend_results: vector<u8>,
        block_pcts: vector<u64>,
        call_successes: vector<u8>,
        rewards_applied: vector<u8>,
        charge_vulnerable: vector<bool>,
    }

    struct FighterState has copy, drop, store {
        hp_max: u64,
        attack: u64,
        defense: u64,
        speed: u64,
        nft_id: u32,
        hp_current: u64,
        fp_left: u8,
        miss_count: u8,
        crit_hit_count: u8,
        charging: bool,
        emotional_state: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState,
        last_signal: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal,
        last_actual_action: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action,
        last_call_guess: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess,
        last_call_success: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess,
    }

    struct PendingMove has copy, drop, store {
        action: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action,
        emotional_state: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState,
        preparing_signal: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal,
        call_guess: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess,
        banter: vector<u8>,
        confidence: u8,
    }

    struct Match has key {
        id: 0x2::object::UID,
        matchup: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Matchup,
        fighters: vector<FighterState>,
        round: u32,
        turn: u8,
        pending_move: PendingMove,
        active: bool,
        winner: u8,
        round_history: vector<CompactRound>,
        replay_extras: vector<ReplayExtra>,
        start_time: u64,
        last_update_time: u64,
    }

    struct GameCap has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
    }

    public fun active(arg0: &Match) : bool {
        arg0.active
    }

    fun apply_resolution(arg0: &mut Match, arg1: &PendingMove, arg2: &PendingMove, arg3: &0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::CombatResolution, arg4: &0x2::clock::Clock) {
        let v0 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::player_0(arg3);
        let v1 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::player_1(arg3);
        0x1::vector::borrow_mut<FighterState>(&mut arg0.fighters, 0).hp_current = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::hp_after(v0);
        0x1::vector::borrow_mut<FighterState>(&mut arg0.fighters, 1).hp_current = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::hp_after(v1);
        0x1::vector::borrow_mut<FighterState>(&mut arg0.fighters, 0).emotional_state = arg1.emotional_state;
        0x1::vector::borrow_mut<FighterState>(&mut arg0.fighters, 1).emotional_state = arg2.emotional_state;
        let v2 = 0x1::vector::borrow_mut<FighterState>(&mut arg0.fighters, 0);
        update_fighter_state(v2, arg1, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::genuine_miss(v0), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::genuine_crit(v0), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::bluff_caught(v0), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::call_success(v0));
        let v3 = 0x1::vector::borrow_mut<FighterState>(&mut arg0.fighters, 1);
        update_fighter_state(v3, arg2, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::genuine_miss(v1), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::genuine_crit(v1), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::bluff_caught(v1), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::call_success(v1));
        arg0.round = arg0.round + 1;
        arg0.turn = 0;
        arg0.last_update_time = 0x2::clock::timestamp_ms(arg4);
    }

    public fun assert_game_cap(arg0: &Match, arg1: &GameCap) {
        assert!(arg1.game_id == 0x2::object::uid_to_inner(&arg0.id), 17);
    }

    fun assert_raw_stat_bounds(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 > 0 && arg0 <= 100000000, 19);
        assert!(arg1 > 0 && arg1 <= 100000000, 19);
        assert!(arg2 > 0 && arg2 <= 100000000, 19);
        assert!(arg3 > 0 && arg3 <= 100000000, 19);
    }

    fun assert_scaled_stat_bounds(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 100000000 * 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::scale();
        assert!(arg0 > 0 && arg0 <= v0, 21);
        assert!(arg1 > 0 && arg1 <= v0, 21);
        assert!(arg2 > 0 && arg2 <= v0, 21);
        assert!(arg3 > 0 && arg3 <= v0, 21);
    }

    fun check_win_condition(arg0: &mut Match) {
        let v0 = 0x1::vector::borrow<FighterState>(&arg0.fighters, 0).hp_current;
        let v1 = 0x1::vector::borrow<FighterState>(&arg0.fighters, 1).hp_current;
        if (v0 == 0 && v1 == 0) {
            let v2 = 0x1::vector::borrow<FighterState>(&arg0.fighters, 0).speed;
            let v3 = 0x1::vector::borrow<FighterState>(&arg0.fighters, 1).speed;
            let v4 = if (v2 > v3) {
                0
            } else if (v3 > v2) {
                1
            } else if (0x1::vector::borrow<FighterState>(&arg0.fighters, 0).nft_id <= 0x1::vector::borrow<FighterState>(&arg0.fighters, 1).nft_id) {
                0
            } else {
                1
            };
            finalize_match(arg0, v4);
        } else if (v0 == 0) {
            finalize_match(arg0, 1);
        } else if (v1 == 0) {
            finalize_match(arg0, 0);
        };
    }

    public fun compact_round_action(arg0: &CompactRound, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(&arg0.actions, arg1)
    }

    public fun compact_round_attack_result(arg0: &CompactRound, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(&arg0.attack_results, arg1)
    }

    public fun compact_round_bluff_caught(arg0: &CompactRound, arg1: u64) : bool {
        *0x1::vector::borrow<bool>(&arg0.bluff_caught, arg1)
    }

    public fun compact_round_damage(arg0: &CompactRound, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.damages, arg1)
    }

    public fun compact_round_first_actor(arg0: &CompactRound) : u8 {
        arg0.first_actor
    }

    public fun compact_round_hp_after(arg0: &CompactRound, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.hp_after, arg1)
    }

    public fun compact_round_round(arg0: &CompactRound) : u32 {
        arg0.round
    }

    public fun create_match(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u32, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u8, arg13: u8, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_raw_stat_bounds(arg0, arg1, arg2, arg3);
        assert_raw_stat_bounds(arg7, arg8, arg9, arg10);
        let v0 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::scale();
        create_match_scaled(arg0 * v0, arg1 * v0, arg2 * v0, arg3 * v0, arg4, arg5, arg6, arg7 * v0, arg8 * v0, arg9 * v0, arg10 * v0, arg11, arg12, arg13, arg14, arg15)
    }

    fun create_match_impl(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u32, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u8, arg13: u8, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!is_unique_nft(arg4), 16);
        assert!(!is_unique_nft(arg11), 16);
        assert!(arg0 > 0 && arg7 > 0, 18);
        assert!(arg1 > 0 && arg8 > 0, 18);
        assert!(arg2 > 0 && arg9 > 0, 18);
        assert!(arg3 > 0 && arg10 > 0, 18);
        let v0 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::emotion_from_u8(arg6);
        let v1 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::emotion_from_u8(arg13);
        let v2 = 0x2::clock::timestamp_ms(arg14);
        let v3 = FighterState{
            hp_max             : arg0,
            attack             : arg1,
            defense            : arg2,
            speed              : arg3,
            nft_id             : arg4,
            hp_current         : arg0,
            fp_left            : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::max_fp(),
            miss_count         : 0,
            crit_hit_count     : 0,
            charging           : false,
            emotional_state    : v0,
            last_signal        : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_none(),
            last_actual_action : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_none(),
            last_call_guess    : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_none(),
            last_call_success  : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::call_success_no_call(),
        };
        let v4 = FighterState{
            hp_max             : arg7,
            attack             : arg8,
            defense            : arg9,
            speed              : arg10,
            nft_id             : arg11,
            hp_current         : arg7,
            fp_left            : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::max_fp(),
            miss_count         : 0,
            crit_hit_count     : 0,
            charging           : false,
            emotional_state    : v1,
            last_signal        : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_none(),
            last_actual_action : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_none(),
            last_call_guess    : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_none(),
            last_call_success  : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::call_success_no_call(),
        };
        let v5 = 0x1::vector::empty<FighterState>();
        let v6 = &mut v5;
        0x1::vector::push_back<FighterState>(v6, v3);
        0x1::vector::push_back<FighterState>(v6, v4);
        let v7 = PendingMove{
            action           : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_none(),
            emotional_state  : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::emotion_neutral(),
            preparing_signal : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_none(),
            call_guess       : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_none(),
            banter           : b"",
            confidence       : 0,
        };
        let v8 = Match{
            id               : 0x2::object::new(arg15),
            matchup          : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::new_matchup(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::new_fighter_identity(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::controller_from_u8(arg5), arg4), v0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::new_fighter_identity(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::controller_from_u8(arg12), arg11), v1),
            fighters         : v5,
            round            : 1,
            turn             : 0,
            pending_move     : v7,
            active           : true,
            winner           : 255,
            round_history    : 0x1::vector::empty<CompactRound>(),
            replay_extras    : 0x1::vector::empty<ReplayExtra>(),
            start_time       : v2,
            last_update_time : v2,
        };
        0x2::transfer::share_object<Match>(v8);
        0x2::object::uid_to_inner(&v8.id)
    }

    public fun create_match_scaled(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u32, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u8, arg13: u8, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_scaled_stat_bounds(arg0, arg1, arg2, arg3);
        assert_scaled_stat_bounds(arg7, arg8, arg9, arg10);
        create_match_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    public fun create_match_with_cap(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u32, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u8, arg13: u8, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : GameCap {
        assert_raw_stat_bounds(arg0, arg1, arg2, arg3);
        assert_raw_stat_bounds(arg7, arg8, arg9, arg10);
        let v0 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::scale();
        let v1 = create_match_impl(arg0 * v0, arg1 * v0, arg2 * v0, arg3 * v0, arg4, arg5, arg6, arg7 * v0, arg8 * v0, arg9 * v0, arg10 * v0, arg11, arg12, arg13, arg14, arg15);
        GameCap{
            id      : 0x2::object::new(arg15),
            game_id : v1,
        }
    }

    public fun fighter_attack(arg0: &Match, arg1: u8) : u64 {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).attack
    }

    public fun fighter_charging(arg0: &Match, arg1: u8) : bool {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).charging
    }

    public fun fighter_crit_hit_count(arg0: &Match, arg1: u8) : u8 {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).crit_hit_count
    }

    public fun fighter_defense(arg0: &Match, arg1: u8) : u64 {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).defense
    }

    public fun fighter_emotional_state(arg0: &Match, arg1: u8) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).emotional_state
    }

    public fun fighter_fp_left(arg0: &Match, arg1: u8) : u8 {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).fp_left
    }

    public fun fighter_hp(arg0: &Match, arg1: u8) : u64 {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).hp_current
    }

    public fun fighter_hp_max(arg0: &Match, arg1: u8) : u64 {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).hp_max
    }

    public fun fighter_last_actual_action(arg0: &Match, arg1: u8) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).last_actual_action
    }

    public fun fighter_last_call_guess(arg0: &Match, arg1: u8) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).last_call_guess
    }

    public fun fighter_last_call_success(arg0: &Match, arg1: u8) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).last_call_success
    }

    public fun fighter_last_signal(arg0: &Match, arg1: u8) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).last_signal
    }

    public fun fighter_miss_count(arg0: &Match, arg1: u8) : u8 {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).miss_count
    }

    public fun fighter_nft_id(arg0: &Match, arg1: u8) : u32 {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).nft_id
    }

    public fun fighter_speed(arg0: &Match, arg1: u8) : u64 {
        assert!(arg1 <= 1, 15);
        0x1::vector::borrow<FighterState>(&arg0.fighters, (arg1 as u64)).speed
    }

    fun finalize_match(arg0: &mut Match, arg1: u8) {
        arg0.active = false;
        arg0.winner = arg1;
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 0x1::vector::borrow<FighterState>(&arg0.fighters, 0).hp_current);
        0x1::vector::push_back<u64>(v1, 0x1::vector::borrow<FighterState>(&arg0.fighters, 1).hp_current);
        let v2 = MatchCompleted{
            match_id     : 0x2::object::uid_to_inner(&arg0.id),
            matchup      : arg0.matchup,
            winner       : arg1,
            final_hp     : v0,
            total_rounds : arg0.round - 1,
        };
        0x2::event::emit<MatchCompleted>(v2);
    }

    public fun game_cap_game_id(arg0: &GameCap) : 0x2::object::ID {
        arg0.game_id
    }

    public(friend) fun is_unique_nft(arg0: u32) : bool {
        let v0 = vector[854, 2371, 2761, 3489, 5089];
        0x1::vector::contains<u32>(&v0, &arg0)
    }

    public fun last_update_time(arg0: &Match) : u64 {
        arg0.last_update_time
    }

    public fun match_id(arg0: &Match) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun matchup(arg0: &Match) : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Matchup {
        arg0.matchup
    }

    public fun replay_extra_block_pct(arg0: &ReplayExtra, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.block_pcts, arg1)
    }

    public fun replay_extra_call_success(arg0: &ReplayExtra, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(&arg0.call_successes, arg1)
    }

    public fun replay_extra_charge_vulnerable(arg0: &ReplayExtra, arg1: u64) : bool {
        *0x1::vector::borrow<bool>(&arg0.charge_vulnerable, arg1)
    }

    public fun replay_extra_defend_result(arg0: &ReplayExtra, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(&arg0.defend_results, arg1)
    }

    public fun replay_extra_emotion(arg0: &ReplayExtra, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(&arg0.emotions, arg1)
    }

    public fun replay_extra_focus_score(arg0: &ReplayExtra, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(&arg0.focus_scores, arg1)
    }

    public fun replay_extra_guess(arg0: &ReplayExtra, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(&arg0.guesses, arg1)
    }

    public fun replay_extra_reward_applied(arg0: &ReplayExtra, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(&arg0.rewards_applied, arg1)
    }

    public fun replay_extra_signal(arg0: &ReplayExtra, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(&arg0.signals, arg1)
    }

    public fun replay_extras(arg0: &Match) : &vector<ReplayExtra> {
        &arg0.replay_extras
    }

    public fun round(arg0: &Match) : u32 {
        arg0.round
    }

    public fun round_history(arg0: &Match) : &vector<CompactRound> {
        &arg0.round_history
    }

    public fun start_time(arg0: &Match) : u64 {
        arg0.start_time
    }

    public fun submit_action(arg0: &mut Match, arg1: &GameCap, arg2: &0x2::random::Random, arg3: u8, arg4: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action, arg5: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState, arg6: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal, arg7: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess, arg8: vector<u8>, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg11);
        let v1 = 0x2::random::generate_bytes(&mut v0, 80);
        submit_action_inner(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, &v1, arg10);
    }

    fun submit_action_inner(arg0: &mut Match, arg1: &GameCap, arg2: u8, arg3: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action, arg4: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState, arg5: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal, arg6: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess, arg7: vector<u8>, arg8: u8, arg9: &vector<u8>, arg10: &0x2::clock::Clock) {
        assert!(arg0.active, 0);
        assert!(arg1.game_id == 0x2::object::uid_to_inner(&arg0.id), 17);
        assert!(arg2 == arg0.turn, 1);
        let v0 = 0x1::vector::borrow<FighterState>(&arg0.fighters, (arg2 as u64));
        let v1 = if (arg2 == 0) {
            1
        } else {
            0
        };
        let v2 = 0x1::vector::borrow<FighterState>(&arg0.fighters, v1);
        let v3 = if (arg3 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_special_attack() || arg3 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_defend()) {
            1
        } else {
            0
        };
        let v4 = if (arg6 != 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_none()) {
            1
        } else {
            0
        };
        if (v0.charging) {
            assert!(arg3 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_none(), 10);
            assert!(arg5 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_none(), 20);
        } else {
            assert!(arg3 != 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_none(), 11);
            if (arg3 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_special_attack()) {
                assert!(v0.fp_left >= v3 + v4, 6);
                assert!(arg5 != 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_none(), 12);
            } else if (arg3 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_defend()) {
                assert!(v0.fp_left >= v3 + v4, 6);
                assert!(arg5 != 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_none(), 12);
            } else {
                assert!(arg5 == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_none(), 13);
            };
        };
        if (arg6 != 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_none()) {
            assert!(v0.fp_left >= v3 + v4, 6);
            assert!(v2.last_signal != 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::sig_none(), 9);
        };
        let v5 = PendingMove{
            action           : arg3,
            emotional_state  : arg4,
            preparing_signal : arg5,
            call_guess       : arg6,
            banter           : arg7,
            confidence       : arg8,
        };
        if (arg2 == 0) {
            arg0.pending_move = v5;
            arg0.turn = 1;
        } else {
            let v6 = arg0.pending_move;
            let v7 = 0x1::vector::borrow<FighterState>(&arg0.fighters, 0);
            let v8 = 0x1::vector::borrow<FighterState>(&arg0.fighters, 1);
            let v9 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::resolve_round(v7.hp_current, v7.attack, v7.defense, v7.speed, v7.nft_id, v7.charging, v7.miss_count, v7.crit_hit_count, v7.last_signal, v7.last_actual_action, v8.hp_current, v8.attack, v8.defense, v8.speed, v8.nft_id, v8.charging, v8.miss_count, v8.crit_hit_count, v8.last_signal, v8.last_actual_action, v6.action, v6.emotional_state, v6.preparing_signal, v6.call_guess, v5.action, v5.emotional_state, v5.preparing_signal, v5.call_guess, arg9);
            apply_resolution(arg0, &v6, &v5, &v9, arg10);
            let v10 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::player_0(&v9);
            let v11 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::player_1(&v9);
            let v12 = 0x1::vector::empty<u8>();
            let v13 = &mut v12;
            0x1::vector::push_back<u8>(v13, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_to_u8(v6.action));
            0x1::vector::push_back<u8>(v13, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_to_u8(v5.action));
            let v14 = 0x1::vector::empty<u64>();
            let v15 = &mut v14;
            0x1::vector::push_back<u64>(v15, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::damage_dealt(v10));
            0x1::vector::push_back<u64>(v15, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::damage_dealt(v11));
            let v16 = 0x1::vector::empty<u64>();
            let v17 = &mut v16;
            0x1::vector::push_back<u64>(v17, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::hp_after(v10));
            0x1::vector::push_back<u64>(v17, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::hp_after(v11));
            let v18 = 0x1::vector::empty<u8>();
            let v19 = &mut v18;
            0x1::vector::push_back<u8>(v19, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::attack_result(v10)));
            0x1::vector::push_back<u8>(v19, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::attack_result_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::attack_result(v11)));
            let v20 = 0x1::vector::empty<bool>();
            let v21 = &mut v20;
            0x1::vector::push_back<bool>(v21, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::bluff_caught(v10));
            0x1::vector::push_back<bool>(v21, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::bluff_caught(v11));
            let v22 = CompactRound{
                round          : arg0.round - 1,
                actions        : v12,
                damages        : v14,
                hp_after       : v16,
                attack_results : v18,
                first_actor    : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::first_actor(&v9),
                bluff_caught   : v20,
            };
            0x1::vector::push_back<CompactRound>(&mut arg0.round_history, v22);
            let v23 = 0x1::vector::empty<u8>();
            let v24 = &mut v23;
            0x1::vector::push_back<u8>(v24, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::emotion_to_u8(v6.emotional_state));
            0x1::vector::push_back<u8>(v24, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::emotion_to_u8(v5.emotional_state));
            let v25 = 0x1::vector::empty<u8>();
            let v26 = &mut v25;
            0x1::vector::push_back<u8>(v26, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::focus_score(v6.emotional_state));
            0x1::vector::push_back<u8>(v26, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::focus_score(v5.emotional_state));
            let v27 = 0x1::vector::empty<u8>();
            let v28 = &mut v27;
            0x1::vector::push_back<u8>(v28, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::signal_to_u8(v6.preparing_signal));
            0x1::vector::push_back<u8>(v28, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::signal_to_u8(v5.preparing_signal));
            let v29 = 0x1::vector::empty<u8>();
            let v30 = &mut v29;
            0x1::vector::push_back<u8>(v30, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_to_u8(v6.call_guess));
            0x1::vector::push_back<u8>(v30, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_to_u8(v5.call_guess));
            let v31 = 0x1::vector::empty<u8>();
            let v32 = &mut v31;
            0x1::vector::push_back<u8>(v32, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::defend_result_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::defend_result(v10)));
            0x1::vector::push_back<u8>(v32, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::defend_result_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::defend_result(v11)));
            let v33 = 0x1::vector::empty<u64>();
            let v34 = &mut v33;
            0x1::vector::push_back<u64>(v34, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::block_pct(v10));
            0x1::vector::push_back<u64>(v34, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::block_pct(v11));
            let v35 = 0x1::vector::empty<u8>();
            let v36 = &mut v35;
            0x1::vector::push_back<u8>(v36, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::call_success_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::call_success(v10)));
            0x1::vector::push_back<u8>(v36, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::call_success_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::call_success(v11)));
            let v37 = 0x1::vector::empty<u8>();
            let v38 = &mut v37;
            0x1::vector::push_back<u8>(v38, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::bluff_reward_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::reward_applied(v10)));
            0x1::vector::push_back<u8>(v38, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::bluff_reward_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::reward_applied(v11)));
            let v39 = 0x1::vector::empty<bool>();
            let v40 = &mut v39;
            0x1::vector::push_back<bool>(v40, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::newly_charging(v10));
            0x1::vector::push_back<bool>(v40, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::newly_charging(v11));
            let v41 = ReplayExtra{
                emotions          : v23,
                focus_scores      : v25,
                signals           : v27,
                guesses           : v29,
                defend_results    : v31,
                block_pcts        : v33,
                call_successes    : v35,
                rewards_applied   : v37,
                charge_vulnerable : v39,
            };
            0x1::vector::push_back<ReplayExtra>(&mut arg0.replay_extras, v41);
            let v42 = 0x1::vector::borrow<FighterState>(&arg0.fighters, 0);
            let v43 = 0x1::vector::borrow<FighterState>(&arg0.fighters, 1);
            let v44 = 0x1::vector::empty<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action>();
            let v45 = &mut v44;
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action>(v45, v6.action);
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action>(v45, v5.action);
            let v46 = 0x1::vector::empty<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState>();
            let v47 = &mut v46;
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState>(v47, v6.emotional_state);
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState>(v47, v5.emotional_state);
            let v48 = 0x1::vector::empty<u8>();
            let v49 = &mut v48;
            0x1::vector::push_back<u8>(v49, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::focus_score(v6.emotional_state));
            0x1::vector::push_back<u8>(v49, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::focus_score(v5.emotional_state));
            let v50 = 0x1::vector::empty<u64>();
            let v51 = &mut v50;
            0x1::vector::push_back<u64>(v51, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::damage_dealt(v10));
            0x1::vector::push_back<u64>(v51, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::damage_dealt(v11));
            let v52 = 0x1::vector::empty<u64>();
            let v53 = &mut v52;
            0x1::vector::push_back<u64>(v53, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::hp_after(v10));
            0x1::vector::push_back<u64>(v53, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::hp_after(v11));
            let v54 = 0x1::vector::empty<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::AttackResult>();
            let v55 = &mut v54;
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::AttackResult>(v55, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::attack_result(v10));
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::AttackResult>(v55, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::attack_result(v11));
            let v56 = 0x1::vector::empty<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::DefendResult>();
            let v57 = &mut v56;
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::DefendResult>(v57, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::defend_result(v10));
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::DefendResult>(v57, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::defend_result(v11));
            let v58 = 0x1::vector::empty<u64>();
            let v59 = &mut v58;
            0x1::vector::push_back<u64>(v59, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::block_pct(v10));
            0x1::vector::push_back<u64>(v59, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::block_pct(v11));
            let v60 = 0x1::vector::empty<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal>();
            let v61 = &mut v60;
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal>(v61, v6.preparing_signal);
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal>(v61, v5.preparing_signal);
            let v62 = 0x1::vector::empty<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess>();
            let v63 = &mut v62;
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess>(v63, v6.call_guess);
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess>(v63, v5.call_guess);
            let v64 = 0x1::vector::empty<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess>();
            let v65 = &mut v64;
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess>(v65, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::call_success(v10));
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess>(v65, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::call_success(v11));
            let v66 = 0x1::vector::empty<bool>();
            let v67 = &mut v66;
            0x1::vector::push_back<bool>(v67, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::bluff_caught(v10));
            0x1::vector::push_back<bool>(v67, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::bluff_caught(v11));
            let v68 = 0x1::vector::empty<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::BluffReward>();
            let v69 = &mut v68;
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::BluffReward>(v69, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::reward_applied(v10));
            0x1::vector::push_back<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::BluffReward>(v69, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::reward_applied(v11));
            let v70 = 0x1::vector::empty<bool>();
            let v71 = &mut v70;
            0x1::vector::push_back<bool>(v71, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::newly_charging(v10));
            0x1::vector::push_back<bool>(v71, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::newly_charging(v11));
            let v72 = 0x1::vector::empty<u32>();
            let v73 = &mut v72;
            0x1::vector::push_back<u32>(v73, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::estimate_can_win_in(v43.hp_current, v42.attack, v43.defense, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::max_crit_hits() - v42.crit_hit_count));
            0x1::vector::push_back<u32>(v73, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::estimate_can_win_in(v42.hp_current, v43.attack, v42.defense, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::max_crit_hits() - v43.crit_hit_count));
            let v74 = 0x1::vector::empty<vector<u8>>();
            let v75 = &mut v74;
            0x1::vector::push_back<vector<u8>>(v75, v6.banter);
            0x1::vector::push_back<vector<u8>>(v75, v5.banter);
            let v76 = 0x1::vector::empty<u8>();
            let v77 = &mut v76;
            0x1::vector::push_back<u8>(v77, v6.confidence);
            0x1::vector::push_back<u8>(v77, v5.confidence);
            let v78 = RoundResolved{
                match_id          : 0x2::object::uid_to_inner(&arg0.id),
                matchup           : arg0.matchup,
                round             : arg0.round - 1,
                actions           : v44,
                emotions          : v46,
                focus_scores      : v48,
                damage_dealt      : v50,
                hp_after          : v52,
                attack_results    : v54,
                defend_results    : v56,
                block_pcts        : v58,
                first_actor       : 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::first_actor(&v9),
                signals           : v60,
                guesses           : v62,
                call_successes    : v64,
                bluff_caught      : v66,
                rewards_applied   : v68,
                charge_vulnerable : v70,
                can_win_in        : v72,
                banters           : v74,
                confidences       : v76,
                rng_seed          : 0x2::hash::blake2b256(arg9),
                timestamp         : 0x2::clock::timestamp_ms(arg10),
            };
            0x2::event::emit<RoundResolved>(v78);
            check_win_condition(arg0);
        };
    }

    public fun submit_action_seeded(arg0: &mut Match, arg1: &GameCap, arg2: u8, arg3: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Action, arg4: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::EmotionalState, arg5: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Signal, arg6: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::Guess, arg7: vector<u8>, arg8: u8, arg9: &vector<u8>, arg10: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(arg9) >= 80, 13906836506510622719);
        submit_action_inner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun turn(arg0: &Match) : u8 {
        arg0.turn
    }

    fun update_fighter_state(arg0: &mut FighterState, arg1: &PendingMove, arg2: bool, arg3: bool, arg4: bool, arg5: 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::CallSuccess) {
        if (arg0.charging) {
            arg0.charging = false;
        } else if (arg1.action == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_special_attack()) {
            arg0.charging = true;
        };
        if (arg1.action == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_special_attack() || arg1.action == 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_defend()) {
            arg0.fp_left = arg0.fp_left - 1;
        };
        if (arg1.call_guess != 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_none()) {
            arg0.fp_left = arg0.fp_left - 1;
        };
        if (arg4) {
            if (arg0.fp_left < 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::max_fp()) {
                arg0.fp_left = arg0.fp_left + 1;
            };
        };
        if (arg2) {
            arg0.miss_count = arg0.miss_count + 1;
        };
        if (arg3) {
            arg0.crit_hit_count = arg0.crit_hit_count + 1;
        };
        arg0.last_signal = arg1.preparing_signal;
        arg0.last_actual_action = arg1.action;
        arg0.last_call_guess = arg1.call_guess;
        arg0.last_call_success = arg5;
    }

    public fun winner(arg0: &Match) : u8 {
        arg0.winner
    }

    // decompiled from Move bytecode v7
}

