module 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::game {
    struct MatchCreated has copy, drop {
        match_id: address,
        name_0: 0x1::string::String,
        name_1: 0x1::string::String,
    }

    struct ActionTaken has copy, drop {
        match_id: address,
        hand_index: u32,
        street: u8,
        seat: u8,
        action_type: u8,
        amount: u32,
        agent_state: u64,
        pot: u32,
        stacks_0: u32,
        stacks_1: u32,
        community_cards: vector<u8>,
    }

    struct EngineActionTaken has copy, drop {
        match_id: address,
        hand_index: u32,
        action_type: u8,
        street: u8,
        button: u8,
        small_blind: u32,
        big_blind: u32,
        pot: u32,
        awarded_pot: u32,
        stacks_0: u32,
        stacks_1: u32,
        ended_by: u8,
        winner_0: bool,
        winner_1: bool,
        winner: u8,
        total_hands: u32,
        hole_0_0: u8,
        hole_0_1: u8,
        hole_1_0: u8,
        hole_1_1: u8,
        community_cards: vector<u8>,
    }

    struct GameCap has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
    }

    struct MatchConfig has copy, drop, store {
        starting_stack: u32,
        opening_big_blind: u32,
        hands_per_level: u32,
        growth_numerator: u32,
        growth_denominator: u32,
        blind_schedule_type: u8,
        bias_start_hand: u32,
        max_hands: u32,
    }

    struct Match has store, key {
        id: 0x2::object::UID,
        config: MatchConfig,
        agent_names: vector<0x1::string::String>,
        stacks: vector<u32>,
        button: u8,
        hand_index: u32,
        active: bool,
        winner: u8,
        street: u8,
        small_blind: u32,
        big_blind: u32,
        pot: u32,
        round_bet: vector<u32>,
        hole_cards: vector<u8>,
        community_cards: vector<u8>,
        scheduled_board: vector<u8>,
        deck: vector<u8>,
        to_act: u8,
        acted_since_full_raise: vector<bool>,
        last_full_raise_size: u32,
        folded: vector<bool>,
        action_log: vector<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ActionLogEntry>,
        hand_summaries: vector<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::HandSummary>,
        action_count: u32,
        entropy_counter: u64,
        start_time: u64,
        last_update_time: u64,
    }

    public(friend) fun acted_since_raise(arg0: &Match, arg1: u8) : bool {
        *0x1::vector::borrow<bool>(&arg0.acted_since_full_raise, (arg1 as u64))
    }

    public(friend) fun action_count(arg0: &Match) : u32 {
        arg0.action_count
    }

    public(friend) fun action_log(arg0: &Match) : &vector<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ActionLogEntry> {
        &arg0.action_log
    }

    public(friend) fun active(arg0: &Match) : bool {
        arg0.active
    }

    fun active_with_chips(arg0: &Match) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (!*0x1::vector::borrow<bool>(&arg0.folded, 0) && *0x1::vector::borrow<u32>(&arg0.stacks, 0) > 0) {
            v1 = v0 + 1;
        };
        if (!*0x1::vector::borrow<bool>(&arg0.folded, 1) && *0x1::vector::borrow<u32>(&arg0.stacks, 1) > 0) {
            v1 = v1 + 1;
        };
        v1
    }

    fun advance_forced_progress(arg0: &mut Match, arg1: &0x2::tx_context::TxContext, arg2: u8) {
        assert!(arg2 < 100, 13906836141438926857);
        loop {
            if (!arg0.active) {
                return
            };
            if (*0x1::vector::borrow<bool>(&arg0.folded, 0) || *0x1::vector::borrow<bool>(&arg0.folded, 1)) {
                resolve_fold(arg0, arg1, arg2);
                return
            };
            let v0 = active_with_chips(arg0);
            if (v0 == 0 || v0 == 1 && *0x1::vector::borrow<u32>(&arg0.round_bet, 0) == *0x1::vector::borrow<u32>(&arg0.round_bet, 1)) {
                runout_and_showdown(arg0, arg1, arg2);
                return
            };
            if (round_closed(arg0)) {
                if (arg0.street == 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::river()) {
                    runout_and_showdown(arg0, arg1, arg2);
                    return
                };
                advance_street(arg0, arg1);
                emit_engine_action_taken(arg0, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::engine_action_advance_street(), 0, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::no_winner(), false, false, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::no_winner());
                continue
            };
            let v1 = (arg0.to_act as u64);
            if (*0x1::vector::borrow<u32>(&arg0.stacks, v1) == 0) {
                *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, v1) = true;
                arg0.to_act = 1 - arg0.to_act;
            } else {
                break
            };
        };
    }

    fun advance_street(arg0: &mut Match, arg1: &0x2::tx_context::TxContext) {
        arg0.street = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::street_next(arg0.street);
        *0x1::vector::borrow_mut<u32>(&mut arg0.round_bet, 0) = 0;
        *0x1::vector::borrow_mut<u32>(&mut arg0.round_bet, 1) = 0;
        *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, 0) = false;
        *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, 1) = false;
        arg0.last_full_raise_size = max(arg0.big_blind, 1);
        arg0.to_act = 1 - arg0.button;
        let v0 = 0x2::object::id<Match>(arg0);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = *0x2::tx_context::digest(arg1);
        burn_before_board_if_random(arg0, &v2, v1);
        if (arg0.street == 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::flop()) {
            let v3 = draw_board_card(arg0, &v2, v1);
            let v4 = draw_board_card(arg0, &v2, v1);
            let v5 = draw_board_card(arg0, &v2, v1);
            0x1::vector::push_back<u8>(&mut arg0.community_cards, v3);
            0x1::vector::push_back<u8>(&mut arg0.community_cards, v4);
            0x1::vector::push_back<u8>(&mut arg0.community_cards, v5);
        } else {
            let v6 = draw_board_card(arg0, &v2, v1);
            0x1::vector::push_back<u8>(&mut arg0.community_cards, v6);
        };
    }

    public(friend) fun agent_name(arg0: &Match, arg1: u8) : &0x1::string::String {
        0x1::vector::borrow<0x1::string::String>(&arg0.agent_names, (arg1 as u64))
    }

    public(friend) fun apply_move(arg0: &mut Match, arg1: &GameCap, arg2: u8, arg3: u32, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.game_id == 0x2::object::id<Match>(arg0), 13906835690467229703);
        assert!(arg0.active, 13906835694761934851);
        let v0 = arg0.to_act;
        let v1 = (v0 as u64);
        assert!(!*0x1::vector::borrow<bool>(&arg0.folded, v1), 13906835711941935109);
        assert!(*0x1::vector::borrow<u32>(&arg0.stacks, v1) > 0 || arg3 == 0, 13906835716236902405);
        let v2 = current_bet(arg0);
        let v3 = *0x1::vector::borrow<u32>(&arg0.round_bet, v1);
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        if (arg2 == 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::action_fold()) {
            assert!(v4 > 0, 13906835746301673477);
            *0x1::vector::borrow_mut<bool>(&mut arg0.folded, v1) = true;
            log_action(arg0, v0, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::action_fold(), 0);
        } else if (arg2 == 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::action_check()) {
            assert!(v4 == 0, 13906835763481542661);
            *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, v1) = true;
            log_action(arg0, v0, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::action_check(), 0);
            arg0.to_act = 1 - v0;
        } else {
            assert!(arg2 == 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::action_commit_to(), 13906835870855725061);
            let (v5, v6) = classify_commit_to(arg0, v0, arg3);
            assert!(v5, 13906835797841281029);
            commit_to_total(arg0, v0, arg3);
            if (v6) {
                *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, 0) = false;
                *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, 1) = false;
                arg0.last_full_raise_size = max(arg3 - v2, 1);
            };
            *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, v1) = true;
            log_action(arg0, v0, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::action_commit_to(), arg3);
            arg0.to_act = 1 - v0;
        };
        arg0.last_update_time = 0x2::clock::timestamp_ms(arg5);
        let v7 = 0x1::vector::borrow<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ActionLogEntry>(&arg0.action_log, 0x1::vector::length<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ActionLogEntry>(&arg0.action_log) - 1);
        let v8 = 0x2::object::id<Match>(arg0);
        let v9 = ActionTaken{
            match_id        : 0x2::object::id_to_address(&v8),
            hand_index      : arg0.hand_index,
            street          : 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ale_street(v7),
            seat            : 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ale_seat(v7),
            action_type     : 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ale_action_type(v7),
            amount          : 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ale_amount(v7),
            agent_state     : arg4,
            pot             : arg0.pot,
            stacks_0        : *0x1::vector::borrow<u32>(&arg0.stacks, 0),
            stacks_1        : *0x1::vector::borrow<u32>(&arg0.stacks, 1),
            community_cards : arg0.community_cards,
        };
        0x2::event::emit<ActionTaken>(v9);
        advance_forced_progress(arg0, arg6, 0);
    }

    public(friend) fun bias_start_hand(arg0: &Match) : u32 {
        arg0.config.bias_start_hand
    }

    public(friend) fun big_blind(arg0: &Match) : u32 {
        arg0.big_blind
    }

    public fun blind_schedule_geometric() : u8 {
        0
    }

    public fun blind_schedule_linear() : u8 {
        1
    }

    public(friend) fun blind_schedule_type(arg0: &Match) : u8 {
        arg0.config.blind_schedule_type
    }

    public fun blinds_for_hand(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u8, arg5: u32) : (u32, u32) {
        assert!(arg4 == 0 || arg4 == 1, 13906837752051138561);
        let v0 = if (arg5 <= 1) {
            0
        } else {
            (arg5 - 1) / max(arg1, 1)
        };
        let v1 = (arg0 as u128);
        let v2 = (arg3 as u128);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = if (arg4 == 0) {
                v1 * (arg2 as u128)
            } else {
                v1 * v2 + (arg2 as u128)
            };
            let v5 = (v4 + v2 / 2) / v2;
            if (v5 > v1) {
                v1 = v5;
            };
            if (v1 >= 4294967295) {
                v1 = 4294967295;
                break
            };
            v3 = v3 + 1;
        };
        let v6 = (v1 as u32);
        (max(v6 / 2, 1), v6)
    }

    fun burn_before_board_if_random(arg0: &mut Match, arg1: &vector<u8>, arg2: address) {
        if (0x1::vector::length<u8>(&arg0.scheduled_board) == 0) {
            0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::deck::burn_card(&mut arg0.deck, arg1, arg2, &mut arg0.entropy_counter);
        };
    }

    public(friend) fun button(arg0: &Match) : u8 {
        arg0.button
    }

    fun chip_leader(arg0: &Match) : u8 {
        if (*0x1::vector::borrow<u32>(&arg0.stacks, 0) > *0x1::vector::borrow<u32>(&arg0.stacks, 1)) {
            0
        } else if (*0x1::vector::borrow<u32>(&arg0.stacks, 1) > *0x1::vector::borrow<u32>(&arg0.stacks, 0)) {
            1
        } else {
            0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::no_winner()
        }
    }

    fun classify_commit_to(arg0: &Match, arg1: u8, arg2: u32) : (bool, bool) {
        let v0 = (arg1 as u64);
        let v1 = current_bet(arg0);
        let v2 = max_total_for(arg0, arg1);
        if (arg2 <= *0x1::vector::borrow<u32>(&arg0.round_bet, v0) || arg2 > v2) {
            return (false, false)
        };
        if (arg2 <= v1) {
            return (arg2 == min(v1, v2), false)
        };
        let v3 = !*0x1::vector::borrow<bool>(&arg0.acted_since_full_raise, v0) && v2 > v1;
        if (!v3) {
            return (false, false)
        };
        if (v1 == 0) {
            if (arg2 < min(arg0.big_blind, v2)) {
                return (false, false)
            };
            return (true, true)
        };
        let v4 = v1 + arg0.last_full_raise_size;
        if (v2 >= v4) {
            if (arg2 < v4) {
                return (false, false)
            };
        } else if (arg2 != v2) {
            return (false, false)
        };
        (true, arg2 - v1 >= arg0.last_full_raise_size)
    }

    fun commit_to_total(arg0: &mut Match, arg1: u8, arg2: u32) {
        let v0 = (arg1 as u64);
        let v1 = *0x1::vector::borrow<u32>(&arg0.round_bet, v0);
        let v2 = if (arg2 > v1) {
            arg2 - v1
        } else {
            0
        };
        let v3 = min(v2, *0x1::vector::borrow<u32>(&arg0.stacks, v0));
        *0x1::vector::borrow_mut<u32>(&mut arg0.round_bet, v0) = *0x1::vector::borrow<u32>(&arg0.round_bet, v0) + v3;
        *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, v0) = *0x1::vector::borrow<u32>(&arg0.stacks, v0) - v3;
        arg0.pot = arg0.pot + v3;
    }

    public(friend) fun community_cards(arg0: &Match) : &vector<u8> {
        &arg0.community_cards
    }

    fun complete_match(arg0: &mut Match, arg1: u8) {
        arg0.active = false;
        arg0.winner = arg1;
        emit_engine_action_taken(arg0, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::engine_action_complete_match(), 0, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::no_winner(), arg1 == 0, arg1 == 1, arg1);
    }

    public fun create_match(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u32, arg5: u8, arg6: u32, arg7: u32, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : GameCap {
        let (v0, v1) = new_match(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::share_object<Match>(v1);
        v0
    }

    public fun current_bet(arg0: &Match) : u32 {
        max(*0x1::vector::borrow<u32>(&arg0.round_bet, 0), *0x1::vector::borrow<u32>(&arg0.round_bet, 1))
    }

    fun distribute_pot(arg0: &mut Match, arg1: u32, arg2: bool, arg3: bool) {
        if (arg2 && arg3) {
            let v0 = arg1 / 2;
            let v1 = arg1 % 2;
            *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, 0) = *0x1::vector::borrow<u32>(&arg0.stacks, 0) + v0;
            *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, 1) = *0x1::vector::borrow<u32>(&arg0.stacks, 1) + v0;
            if (v1 > 0) {
                let v2 = 1 - arg0.button;
                *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, (v2 as u64)) = *0x1::vector::borrow<u32>(&arg0.stacks, (v2 as u64)) + v1;
            };
        } else if (arg2) {
            *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, 0) = *0x1::vector::borrow<u32>(&arg0.stacks, 0) + arg1;
        } else {
            *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, 1) = *0x1::vector::borrow<u32>(&arg0.stacks, 1) + arg1;
        };
    }

    fun draw_board_card(arg0: &mut Match, arg1: &vector<u8>, arg2: address) : u8 {
        if (0x1::vector::length<u8>(&arg0.scheduled_board) > 0) {
            0x1::vector::remove<u8>(&mut arg0.scheduled_board, 0)
        } else {
            0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::deck::draw_card(&mut arg0.deck, arg1, arg2, &mut arg0.entropy_counter)
        }
    }

    fun effective_blinds(arg0: &Match, arg1: u32, arg2: u32) : (u32, u32) {
        let v0 = max(min(arg2, min(*0x1::vector::borrow<u32>(&arg0.stacks, 0), *0x1::vector::borrow<u32>(&arg0.stacks, 1))), 1);
        (min(arg1, v0), v0)
    }

    fun emit_engine_action_taken(arg0: &Match, arg1: u8, arg2: u32, arg3: u8, arg4: bool, arg5: bool, arg6: u8) {
        let v0 = 0x2::object::id<Match>(arg0);
        let v1 = EngineActionTaken{
            match_id        : 0x2::object::id_to_address(&v0),
            hand_index      : arg0.hand_index,
            action_type     : arg1,
            street          : arg0.street,
            button          : arg0.button,
            small_blind     : arg0.small_blind,
            big_blind       : arg0.big_blind,
            pot             : arg0.pot,
            awarded_pot     : arg2,
            stacks_0        : *0x1::vector::borrow<u32>(&arg0.stacks, 0),
            stacks_1        : *0x1::vector::borrow<u32>(&arg0.stacks, 1),
            ended_by        : arg3,
            winner_0        : arg4,
            winner_1        : arg5,
            winner          : arg6,
            total_hands     : arg0.hand_index,
            hole_0_0        : *0x1::vector::borrow<u8>(&arg0.hole_cards, 0),
            hole_0_1        : *0x1::vector::borrow<u8>(&arg0.hole_cards, 1),
            hole_1_0        : *0x1::vector::borrow<u8>(&arg0.hole_cards, 2),
            hole_1_1        : *0x1::vector::borrow<u8>(&arg0.hole_cards, 3),
            community_cards : arg0.community_cards,
        };
        0x2::event::emit<EngineActionTaken>(v1);
    }

    public(friend) fun folded(arg0: &Match, arg1: u8) : bool {
        *0x1::vector::borrow<bool>(&arg0.folded, (arg1 as u64))
    }

    public fun game_cap_game_id(arg0: &GameCap) : 0x2::object::ID {
        arg0.game_id
    }

    public(friend) fun growth_denominator(arg0: &Match) : u32 {
        arg0.config.growth_denominator
    }

    public(friend) fun growth_numerator(arg0: &Match) : u32 {
        arg0.config.growth_numerator
    }

    public(friend) fun hand_index(arg0: &Match) : u32 {
        arg0.hand_index
    }

    public(friend) fun hand_summaries(arg0: &Match) : &vector<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::HandSummary> {
        &arg0.hand_summaries
    }

    public(friend) fun hands_per_level(arg0: &Match) : u32 {
        arg0.config.hands_per_level
    }

    public(friend) fun hole_card(arg0: &Match, arg1: u8, arg2: u8) : u8 {
        *0x1::vector::borrow<u8>(&arg0.hole_cards, (arg1 as u64) * 2 + (arg2 as u64))
    }

    public(friend) fun increment_action_count(arg0: &mut Match) : u32 {
        arg0.action_count = arg0.action_count + 1;
        arg0.action_count
    }

    public fun is_legal(arg0: &Match, arg1: u8, arg2: u32) : bool {
        if (!arg0.active) {
            return false
        };
        let v0 = arg0.to_act;
        let v1 = (v0 as u64);
        if (*0x1::vector::borrow<bool>(&arg0.folded, v1) || *0x1::vector::borrow<u32>(&arg0.stacks, v1) == 0) {
            return false
        };
        let v2 = current_bet(arg0);
        let v3 = *0x1::vector::borrow<u32>(&arg0.round_bet, v1);
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        if (arg1 == 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::action_fold()) {
            v4 > 0
        } else if (arg1 == 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::action_check()) {
            v4 == 0
        } else if (arg1 == 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::action_commit_to()) {
            let (v6, _) = classify_commit_to(arg0, v0, arg2);
            v6
        } else {
            false
        }
    }

    public(friend) fun last_full_raise_size(arg0: &Match) : u32 {
        arg0.last_full_raise_size
    }

    public fun legal_action_bounds(arg0: &Match) : (bool, bool, bool, u32, u32, u32, u32) {
        if (!arg0.active) {
            return (false, false, false, 0, 0, 0, 0)
        };
        let v0 = arg0.to_act;
        let v1 = (v0 as u64);
        if (*0x1::vector::borrow<bool>(&arg0.folded, v1) || *0x1::vector::borrow<u32>(&arg0.stacks, v1) == 0) {
            return (false, false, false, 0, 0, 0, 0)
        };
        let v2 = current_bet(arg0);
        let v3 = *0x1::vector::borrow<u32>(&arg0.round_bet, v1);
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        let v5 = max_total_for(arg0, v0);
        let v6 = !*0x1::vector::borrow<bool>(&arg0.acted_since_full_raise, v1) && v5 > v2;
        let (v7, v8) = if (v2 == 0 && v6) {
            (min(arg0.big_blind, v5), v5)
        } else {
            (0, 0)
        };
        let (v9, v10) = if (v2 > 0 && v6) {
            let v11 = v2 + arg0.last_full_raise_size;
            let v12 = if (v5 >= v11) {
                v11
            } else {
                v5
            };
            (v12, v5)
        } else {
            (0, 0)
        };
        (v4 > 0, v4 == 0, v4 > 0, v7, v8, v9, v10)
    }

    fun log_action(arg0: &mut Match, arg1: u8, arg2: u8, arg3: u32) {
        0x1::vector::push_back<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ActionLogEntry>(&mut arg0.action_log, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::new_action_log_entry(arg0.street, arg1, arg2, arg3));
    }

    public(friend) fun match_id(arg0: &Match) : 0x2::object::ID {
        0x2::object::id<Match>(arg0)
    }

    fun max(arg0: u32, arg1: u32) : u32 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_total_for(arg0: &Match, arg1: u8) : u32 {
        let v0 = (arg1 as u64);
        let v1 = ((1 - arg1) as u64);
        min(*0x1::vector::borrow<u32>(&arg0.round_bet, v0) + *0x1::vector::borrow<u32>(&arg0.stacks, v0), *0x1::vector::borrow<u32>(&arg0.round_bet, v1) + *0x1::vector::borrow<u32>(&arg0.stacks, v1))
    }

    fun min(arg0: u32, arg1: u32) : u32 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public(friend) fun new_match(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u32, arg5: u8, arg6: u32, arg7: u32, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (GameCap, Match) {
        assert!(arg0 > 0, 13906835303919779841);
        assert!(arg0 <= 2147483647, 13906835325394616321);
        assert!(arg1 > 0, 13906835329689583617);
        assert!(arg2 > 0, 13906835333984550913);
        assert!(arg4 > 0, 13906835338279518209);
        assert!(arg5 == 0 || arg5 == 1, 13906835355459387393);
        if (arg5 == 0) {
            assert!(arg3 >= arg4, 13906835368344289281);
        };
        assert!(arg6 > 0, 13906835376934223873);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = MatchConfig{
            starting_stack      : arg0,
            opening_big_blind   : arg1,
            hands_per_level     : arg2,
            growth_numerator    : arg3,
            growth_denominator  : arg4,
            blind_schedule_type : arg5,
            bias_start_hand     : arg6,
            max_hands           : arg7,
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg8));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg9));
        let v4 = 0x1::vector::empty<u32>();
        let v5 = &mut v4;
        0x1::vector::push_back<u32>(v5, arg0);
        0x1::vector::push_back<u32>(v5, arg0);
        let v6 = Match{
            id                     : 0x2::object::new(arg11),
            config                 : v1,
            agent_names            : v2,
            stacks                 : v4,
            button                 : 0,
            hand_index             : 0,
            active                 : true,
            winner                 : 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::no_winner(),
            street                 : 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::preflop(),
            small_blind            : 0,
            big_blind              : 0,
            pot                    : 0,
            round_bet              : vector[0, 0],
            hole_cards             : x"00000000",
            community_cards        : b"",
            scheduled_board        : b"",
            deck                   : b"",
            to_act                 : 0,
            acted_since_full_raise : vector[false, false],
            last_full_raise_size   : 0,
            folded                 : vector[false, false],
            action_log             : 0x1::vector::empty<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ActionLogEntry>(),
            hand_summaries         : 0x1::vector::empty<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::HandSummary>(),
            action_count           : 0,
            entropy_counter        : 0,
            start_time             : v0,
            last_update_time       : v0,
        };
        let v7 = 0x2::object::id<Match>(&v6);
        let v8 = GameCap{
            id      : 0x2::object::new(arg11),
            game_id : v7,
        };
        let v9 = &mut v6;
        start_hand(v9, arg11);
        let v10 = MatchCreated{
            match_id : 0x2::object::id_to_address(&v7),
            name_0   : *0x1::vector::borrow<0x1::string::String>(&v6.agent_names, 0),
            name_1   : *0x1::vector::borrow<0x1::string::String>(&v6.agent_names, 1),
        };
        0x2::event::emit<MatchCreated>(v10);
        (v8, v6)
    }

    public(friend) fun opening_big_blind(arg0: &Match) : u32 {
        arg0.config.opening_big_blind
    }

    fun post_blind(arg0: &mut Match, arg1: u8, arg2: u32) {
        if (arg2 == 0) {
            return
        };
        let v0 = (arg1 as u64);
        let v1 = min(arg2, *0x1::vector::borrow<u32>(&arg0.stacks, v0));
        *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, v0) = *0x1::vector::borrow<u32>(&arg0.stacks, v0) - v1;
        *0x1::vector::borrow_mut<u32>(&mut arg0.round_bet, v0) = *0x1::vector::borrow<u32>(&arg0.round_bet, v0) + v1;
        arg0.pot = arg0.pot + v1;
    }

    public(friend) fun pot(arg0: &Match) : u32 {
        arg0.pot
    }

    public(friend) fun preflop_pressure_beta_milli(arg0: &Match) : u64 {
        12000
    }

    fun resolve_fold(arg0: &mut Match, arg1: &0x2::tx_context::TxContext, arg2: u8) {
        let v0 = if (*0x1::vector::borrow<bool>(&arg0.folded, 0)) {
            0
        } else {
            1
        };
        let v1 = 1 - v0;
        let v2 = arg0.pot;
        *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, (v1 as u64)) = *0x1::vector::borrow<u32>(&arg0.stacks, (v1 as u64)) + v2;
        arg0.pot = 0;
        let v3 = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::new_hand_summary(arg0.hand_index, arg0.button, v2, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::hand_end_fold(), v1 == 0, v1 == 1, *0x1::vector::borrow<u32>(&arg0.stacks, 0), *0x1::vector::borrow<u32>(&arg0.stacks, 1));
        transition_after_hand(arg0, v3, arg1, arg2);
    }

    fun reveal_remaining_board(arg0: &mut Match, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Match>(arg0);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = *0x2::tx_context::digest(arg1);
        while (0x1::vector::length<u8>(&arg0.community_cards) < 5) {
            let v3 = if (0x1::vector::length<u8>(&arg0.community_cards) == 0) {
                0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::flop()
            } else if (0x1::vector::length<u8>(&arg0.community_cards) == 3) {
                0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::turn()
            } else {
                0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::river()
            };
            burn_before_board_if_random(arg0, &v2, v1);
            if (v3 == 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::flop()) {
                let v4 = draw_board_card(arg0, &v2, v1);
                let v5 = draw_board_card(arg0, &v2, v1);
                let v6 = draw_board_card(arg0, &v2, v1);
                0x1::vector::push_back<u8>(&mut arg0.community_cards, v4);
                0x1::vector::push_back<u8>(&mut arg0.community_cards, v5);
                0x1::vector::push_back<u8>(&mut arg0.community_cards, v6);
            } else {
                let v7 = draw_board_card(arg0, &v2, v1);
                0x1::vector::push_back<u8>(&mut arg0.community_cards, v7);
            };
            arg0.street = v3;
        };
    }

    public(friend) fun round_bet_seat(arg0: &Match, arg1: u8) : u32 {
        *0x1::vector::borrow<u32>(&arg0.round_bet, (arg1 as u64))
    }

    fun round_closed(arg0: &Match) : bool {
        if (*0x1::vector::borrow<u32>(&arg0.round_bet, 0) != *0x1::vector::borrow<u32>(&arg0.round_bet, 1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 2) {
            let v1 = if (!*0x1::vector::borrow<bool>(&arg0.folded, v0)) {
                if (*0x1::vector::borrow<u32>(&arg0.stacks, v0) > 0) {
                    !*0x1::vector::borrow<bool>(&arg0.acted_since_full_raise, v0)
                } else {
                    false
                }
            } else {
                false
            };
            if (v1) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun runout_and_showdown(arg0: &mut Match, arg1: &0x2::tx_context::TxContext, arg2: u8) {
        reveal_remaining_board(arg0, arg1);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.hole_cards, 0));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.hole_cards, 1));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.community_cards, 0));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.community_cards, 1));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.community_cards, 2));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.community_cards, 3));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.community_cards, 4));
        let v2 = 0x1::vector::empty<u8>();
        let v3 = &mut v2;
        0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&arg0.hole_cards, 2));
        0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&arg0.hole_cards, 3));
        0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&arg0.community_cards, 0));
        0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&arg0.community_cards, 1));
        0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&arg0.community_cards, 2));
        0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&arg0.community_cards, 3));
        0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&arg0.community_cards, 4));
        let v4 = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::eval::best_of_seven(&v0);
        let v5 = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::eval::best_of_seven(&v2);
        let v6 = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::eval::hand_rank_cmp(&v4, &v5);
        let (v7, v8) = if (v6 == 2) {
            (true, false)
        } else if (v6 == 0) {
            (false, true)
        } else {
            (true, true)
        };
        let v9 = arg0.pot;
        distribute_pot(arg0, v9, v7, v8);
        arg0.pot = 0;
        let v10 = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::new_hand_summary(arg0.hand_index, arg0.button, v9, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::hand_end_showdown(), v7, v8, *0x1::vector::borrow<u32>(&arg0.stacks, 0), *0x1::vector::borrow<u32>(&arg0.stacks, 1));
        transition_after_hand(arg0, v10, arg1, arg2);
    }

    fun scheduled_bias_beta_milli(arg0: u32, arg1: u32) : u64 {
        if (arg1 < arg0) {
            return 0
        };
        12000
    }

    public(friend) fun scheduled_board_len(arg0: &Match) : u64 {
        0x1::vector::length<u8>(&arg0.scheduled_board)
    }

    public(friend) fun small_blind(arg0: &Match) : u32 {
        arg0.small_blind
    }

    public(friend) fun stack(arg0: &Match, arg1: u8) : u32 {
        *0x1::vector::borrow<u32>(&arg0.stacks, (arg1 as u64))
    }

    fun start_hand(arg0: &mut Match, arg1: &0x2::tx_context::TxContext) {
        start_hand_with_depth(arg0, arg1, 0);
    }

    fun start_hand_with_depth(arg0: &mut Match, arg1: &0x2::tx_context::TxContext, arg2: u8) {
        assert!(arg2 < 100, 13906837326849900553);
        arg0.hand_index = arg0.hand_index + 1;
        let (v0, v1) = blinds_for_hand(arg0.config.opening_big_blind, arg0.config.hands_per_level, arg0.config.growth_numerator, arg0.config.growth_denominator, arg0.config.blind_schedule_type, arg0.hand_index);
        let (v2, v3) = effective_blinds(arg0, v0, v1);
        arg0.street = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::preflop();
        arg0.small_blind = v2;
        arg0.big_blind = v3;
        arg0.pot = 0;
        *0x1::vector::borrow_mut<u32>(&mut arg0.round_bet, 0) = 0;
        *0x1::vector::borrow_mut<u32>(&mut arg0.round_bet, 1) = 0;
        arg0.community_cards = b"";
        arg0.scheduled_board = b"";
        arg0.deck = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::deck::standard_deck();
        arg0.to_act = arg0.button;
        *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, 0) = false;
        *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, 1) = false;
        arg0.last_full_raise_size = max(v3, 1);
        *0x1::vector::borrow_mut<bool>(&mut arg0.folded, 0) = false;
        *0x1::vector::borrow_mut<bool>(&mut arg0.folded, 1) = false;
        arg0.action_log = 0x1::vector::empty<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::ActionLogEntry>();
        let v4 = 0x2::object::id<Match>(arg0);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = *0x2::tx_context::digest(arg1);
        let v7 = arg0.button;
        let v8 = 1 - v7;
        let v9 = scheduled_bias_beta_milli(arg0.config.bias_start_hand, arg0.hand_index);
        if (v9 == 0) {
            *0x1::vector::borrow_mut<u8>(&mut arg0.hole_cards, (v7 as u64) * 2) = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::deck::draw_card(&mut arg0.deck, &v6, v5, &mut arg0.entropy_counter);
            *0x1::vector::borrow_mut<u8>(&mut arg0.hole_cards, (v8 as u64) * 2) = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::deck::draw_card(&mut arg0.deck, &v6, v5, &mut arg0.entropy_counter);
            *0x1::vector::borrow_mut<u8>(&mut arg0.hole_cards, (v7 as u64) * 2 + 1) = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::deck::draw_card(&mut arg0.deck, &v6, v5, &mut arg0.entropy_counter);
            *0x1::vector::borrow_mut<u8>(&mut arg0.hole_cards, (v8 as u64) * 2 + 1) = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::deck::draw_card(&mut arg0.deck, &v6, v5, &mut arg0.entropy_counter);
        } else {
            let (v10, v11) = 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::deck::deal_preflop_pressure_runout(&mut arg0.deck, &v6, v5, &mut arg0.entropy_counter, v7, v9);
            arg0.hole_cards = v10;
            arg0.scheduled_board = v11;
        };
        post_blind(arg0, v7, v2);
        post_blind(arg0, v8, v3);
        emit_engine_action_taken(arg0, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::engine_action_deal_hand(), 0, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::no_winner(), false, false, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::no_winner());
        advance_forced_progress(arg0, arg1, arg2);
    }

    public(friend) fun starting_stack(arg0: &Match) : u32 {
        arg0.config.starting_stack
    }

    public(friend) fun street(arg0: &Match) : u8 {
        arg0.street
    }

    fun terminal_winner_after_hand(arg0: &Match) : u8 {
        if (*0x1::vector::borrow<u32>(&arg0.stacks, 0) == 0) {
            return 1
        };
        if (*0x1::vector::borrow<u32>(&arg0.stacks, 1) == 0) {
            return 0
        };
        if (arg0.config.max_hands > 0 && arg0.hand_index >= arg0.config.max_hands) {
            return chip_leader(arg0)
        };
        0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::no_winner()
    }

    public(friend) fun to_act(arg0: &Match) : u8 {
        arg0.to_act
    }

    fun transition_after_hand(arg0: &mut Match, arg1: 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::HandSummary, arg2: &0x2::tx_context::TxContext, arg3: u8) {
        emit_engine_action_taken(arg0, 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::engine_action_complete_hand(), 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::hs_pot(&arg1), 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::hs_ended_by(&arg1), 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::hs_winner_0(&arg1), 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::hs_winner_1(&arg1), 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::no_winner());
        0x1::vector::push_back<0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::HandSummary>(&mut arg0.hand_summaries, arg1);
        let v0 = terminal_winner_after_hand(arg0);
        if (v0 != 0xffd19e681da6d2c7a1e2793ff727cd154b599101d93522f937e6a023772bd50b::types::no_winner()) {
            complete_match(arg0, v0);
            return
        };
        arg0.button = 1 - arg0.button;
        start_hand_with_depth(arg0, arg2, arg3 + 1);
    }

    public(friend) fun winner(arg0: &Match) : u8 {
        arg0.winner
    }

    // decompiled from Move bytecode v7
}

