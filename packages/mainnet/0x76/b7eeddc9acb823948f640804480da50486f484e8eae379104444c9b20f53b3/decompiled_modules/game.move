module 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game {
    struct MatchCreated has copy, drop {
        match_id: address,
        name_0: 0x1::string::String,
        name_1: 0x1::string::String,
        name_2: 0x1::string::String,
        name_3: 0x1::string::String,
        name_4: 0x1::string::String,
        name_5: 0x1::string::String,
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
        stacks: vector<u32>,
        community_cards: vector<u8>,
    }

    struct EngineActionTaken has copy, drop {
        match_id: address,
        hand_index: u32,
        action_type: u8,
        street: u8,
        button: u8,
        small_blind_seat: u8,
        big_blind_seat: u8,
        small_blind: u32,
        big_blind: u32,
        pot: u32,
        winner: u8,
        stacks: vector<u32>,
        hole_cards: vector<u8>,
        community_cards: vector<u8>,
    }

    struct GameCap has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
    }

    struct Match has store, key {
        id: 0x2::object::UID,
        starting_stack: u32,
        opening_big_blind: u32,
        hands_per_level: u32,
        growth_numerator: u32,
        growth_denominator: u32,
        agent_names: vector<0x1::string::String>,
        active_seats: vector<bool>,
        stacks: vector<u32>,
        button: u8,
        small_blind_seat: u8,
        big_blind_seat: u8,
        hand_index: u32,
        active: bool,
        winner: u8,
        street: u8,
        small_blind: u32,
        big_blind: u32,
        pot: u32,
        round_bet: vector<u32>,
        commitments: vector<u32>,
        hole_cards: vector<u8>,
        community_cards: vector<u8>,
        deck: vector<u8>,
        to_act: u8,
        acted_since_full_raise: vector<bool>,
        last_full_raise_size: u32,
        folded: vector<bool>,
        action_log: vector<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::ActionLogEntry>,
        hand_summaries: vector<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::HandSummary>,
        entropy_counter: u64,
    }

    public(friend) fun action_log(arg0: &Match) : &vector<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::ActionLogEntry> {
        &arg0.action_log
    }

    public(friend) fun active(arg0: &Match) : bool {
        arg0.active
    }

    fun active_agent_names_from_raw(arg0: &vector<vector<u8>>) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun active_count(arg0: &Match) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 6) {
            if (is_active(arg0, v1)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun active_seat(arg0: &Match, arg1: u8) : bool {
        is_active(arg0, arg1)
    }

    fun active_seats_for(arg0: u8) : vector<bool> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 6) {
            0x1::vector::push_back<bool>(&mut v0, v1 < arg0);
            v1 = v1 + 1;
        };
        v0
    }

    fun advance_forced_progress(arg0: &mut Match, arg1: &0x2::tx_context::TxContext, arg2: u8) {
        assert!(arg2 < 100, 105);
        loop {
            if (!arg0.active) {
                return
            };
            if (live_count(arg0) == 1) {
                resolve_fold(arg0, arg1, arg2);
                return
            };
            if (all_remaining_all_in(arg0)) {
                runout_and_showdown(arg0, arg1, arg2);
                return
            };
            if (round_closed(arg0)) {
                if (arg0.street == 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::river()) {
                    runout_and_showdown(arg0, arg1, arg2);
                    return
                };
                advance_street(arg0, arg1);
                emit_engine_action(arg0, 1, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::no_seat());
                continue
            };
            if (!can_act(arg0, arg0.to_act)) {
                arg0.to_act = next_actor_after(arg0, arg0.to_act);
            } else {
                break
            };
        };
    }

    fun advance_street(arg0: &mut Match, arg1: &0x2::tx_context::TxContext) {
        arg0.street = arg0.street + 1;
        arg0.round_bet = zeros();
        arg0.acted_since_full_raise = bools(false);
        arg0.last_full_raise_size = max(arg0.big_blind, 1);
        arg0.to_act = next_active_after(arg0, arg0.button);
        let v0 = *0x2::tx_context::digest(arg1);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::object::id_to_address(&v1);
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::deck::draw_card(&mut arg0.deck, &v0, v2, &mut arg0.entropy_counter);
        let v3 = if (arg0.street == 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::flop()) {
            3
        } else {
            1
        };
        let v4 = 0;
        while (v4 < v3) {
            0x1::vector::push_back<u8>(&mut arg0.community_cards, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::deck::draw_card(&mut arg0.deck, &v0, v2, &mut arg0.entropy_counter));
            v4 = v4 + 1;
        };
    }

    public(friend) fun agent_name(arg0: &Match, arg1: u8) : &0x1::string::String {
        0x1::vector::borrow<0x1::string::String>(&arg0.agent_names, (arg1 as u64))
    }

    fun all_remaining_all_in(arg0: &Match) : bool {
        let v0 = 0;
        while (v0 < 6) {
            let v1 = if (is_active(arg0, v0)) {
                if (!*0x1::vector::borrow<bool>(&arg0.folded, (v0 as u64))) {
                    *0x1::vector::borrow<u32>(&arg0.stacks, (v0 as u64)) > 0
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

    public(friend) fun apply_move(arg0: &mut Match, arg1: &GameCap, arg2: u8, arg3: u32, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.game_id == 0x2::object::uid_to_inner(&arg0.id), 104);
        assert!(arg0.active, 101);
        let v0 = arg0.to_act;
        assert!(can_act(arg0, v0), 103);
        if (arg2 == 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_fold()) {
            assert!(to_call(arg0, v0) > 0, 103);
            *0x1::vector::borrow_mut<bool>(&mut arg0.folded, (v0 as u64)) = true;
            *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, (v0 as u64)) = true;
            log_action(arg0, v0, arg2, 0);
        } else if (arg2 == 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_check()) {
            assert!(to_call(arg0, v0) == 0, 103);
            *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, (v0 as u64)) = true;
            log_action(arg0, v0, arg2, 0);
        } else {
            assert!(arg2 == 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_commit_to(), 103);
            let (v1, v2) = classify_commit_to(arg0, v0, arg3);
            assert!(v1, 103);
            let v3 = current_bet(arg0);
            commit_to_total(arg0, v0, arg3);
            if (v2) {
                reopen_action(arg0);
                arg0.last_full_raise_size = max(*0x1::vector::borrow<u32>(&arg0.round_bet, (v0 as u64)) - v3, 1);
            };
            *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, (v0 as u64)) = true;
            log_action(arg0, v0, arg2, arg3);
        };
        let v4 = 0x1::vector::borrow<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::ActionLogEntry>(&arg0.action_log, 0x1::vector::length<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::ActionLogEntry>(&arg0.action_log) - 1);
        let v5 = 0x2::object::uid_to_inner(&arg0.id);
        let v6 = ActionTaken{
            match_id        : 0x2::object::id_to_address(&v5),
            hand_index      : arg0.hand_index,
            street          : 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::street(v4),
            seat            : 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::seat(v4),
            action_type     : 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_type(v4),
            amount          : 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::amount(v4),
            agent_state     : arg4,
            pot             : arg0.pot,
            stacks          : arg0.stacks,
            community_cards : arg0.community_cards,
        };
        0x2::event::emit<ActionTaken>(v6);
        arg0.to_act = next_actor_after(arg0, v0);
        advance_forced_progress(arg0, arg6, 0);
    }

    fun award_to_winners(arg0: &mut Match, arg1: u32, arg2: &vector<u8>) {
        let v0 = arg1 % (0x1::vector::length<u8>(arg2) as u32);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg2)) {
            let v2 = *0x1::vector::borrow<u8>(arg2, v1);
            *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, (v2 as u64)) = *0x1::vector::borrow<u32>(&arg0.stacks, (v2 as u64)) + arg1 / (0x1::vector::length<u8>(arg2) as u32);
            v1 = v1 + 1;
        };
        let v3 = next_active_after(arg0, arg0.button);
        let v4 = 0;
        while (v0 > 0 && v4 < 6) {
            if (0x1::vector::contains<u8>(arg2, &v3)) {
                *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, (v3 as u64)) = *0x1::vector::borrow<u32>(&arg0.stacks, (v3 as u64)) + 1;
                v0 = v0 - 1;
            };
            v3 = next_active_after(arg0, v3);
            v4 = v4 + 1;
        };
    }

    public(friend) fun big_blind(arg0: &Match) : u32 {
        arg0.big_blind
    }

    public(friend) fun big_blind_seat(arg0: &Match) : u8 {
        arg0.big_blind_seat
    }

    public fun blinds_for_hand(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u32) : (u32, u32) {
        let v0 = if (arg4 <= 1) {
            0
        } else {
            (arg4 - 1) / max(arg1, 1)
        };
        let v1 = (arg0 as u128) + (v0 as u128) * (arg2 as u128) / (max(arg3, 1) as u128);
        let v2 = v1;
        if (v1 > 4294967295) {
            v2 = 4294967295;
        };
        let v3 = (v2 as u32);
        (max(v3 / 2, 1), v3)
    }

    fun bools(arg0: bool) : vector<bool> {
        let v0 = 0x1::vector::empty<bool>();
        let v1 = &mut v0;
        0x1::vector::push_back<bool>(v1, arg0);
        0x1::vector::push_back<bool>(v1, arg0);
        0x1::vector::push_back<bool>(v1, arg0);
        0x1::vector::push_back<bool>(v1, arg0);
        0x1::vector::push_back<bool>(v1, arg0);
        0x1::vector::push_back<bool>(v1, arg0);
        v0
    }

    public(friend) fun button(arg0: &Match) : u8 {
        arg0.button
    }

    fun can_act(arg0: &Match, arg1: u8) : bool {
        if (arg1 < 6) {
            if (is_active(arg0, arg1)) {
                if (!*0x1::vector::borrow<bool>(&arg0.folded, (arg1 as u64))) {
                    *0x1::vector::borrow<u32>(&arg0.stacks, (arg1 as u64)) > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun classify_commit_to(arg0: &Match, arg1: u8, arg2: u32) : (bool, bool) {
        let v0 = current_bet(arg0);
        let v1 = max_total_for(arg0, arg1);
        if (arg2 <= *0x1::vector::borrow<u32>(&arg0.round_bet, (arg1 as u64)) || arg2 > v1) {
            return (false, false)
        };
        if (arg2 <= v0) {
            return (arg2 == min(v0, v1), false)
        };
        if (v0 == 0) {
            return (arg2 >= min(arg0.big_blind, v1), true)
        };
        let v2 = v0 + arg0.last_full_raise_size;
        if (v1 >= v2 && arg2 < v2) {
            return (false, false)
        };
        if (v1 < v2 && arg2 != v1) {
            return (false, false)
        };
        (true, arg2 - v0 >= arg0.last_full_raise_size)
    }

    fun commit_to_total(arg0: &mut Match, arg1: u8, arg2: u32) {
        let v0 = *0x1::vector::borrow<u32>(&arg0.round_bet, (arg1 as u64));
        let v1 = if (arg2 > v0) {
            arg2 - v0
        } else {
            0
        };
        let v2 = min(v1, *0x1::vector::borrow<u32>(&arg0.stacks, (arg1 as u64)));
        *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, (arg1 as u64)) = *0x1::vector::borrow<u32>(&arg0.stacks, (arg1 as u64)) - v2;
        *0x1::vector::borrow_mut<u32>(&mut arg0.round_bet, (arg1 as u64)) = *0x1::vector::borrow<u32>(&arg0.round_bet, (arg1 as u64)) + v2;
        *0x1::vector::borrow_mut<u32>(&mut arg0.commitments, (arg1 as u64)) = *0x1::vector::borrow<u32>(&arg0.commitments, (arg1 as u64)) + v2;
        arg0.pot = arg0.pot + v2;
    }

    fun commitment_levels(arg0: &Match) : vector<u32> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 6) {
            let v2 = *0x1::vector::borrow<u32>(&arg0.commitments, (v1 as u64));
            if (v2 > 0 && !0x1::vector::contains<u32>(&v0, &v2)) {
                let v3 = &mut v0;
                insert_sorted(v3, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun community_cards(arg0: &Match) : &vector<u8> {
        &arg0.community_cards
    }

    fun contributors_at(arg0: &Match, arg1: u32) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 6) {
            if (*0x1::vector::borrow<u32>(&arg0.commitments, (v1 as u64)) >= arg1) {
                0x1::vector::push_back<u8>(&mut v0, v1);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_match(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u32, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : GameCap {
        let (v0, v1) = new_match(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::share_object<Match>(v1);
        v0
    }

    public fun current_bet(arg0: &Match) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 6) {
            v0 = max(v0, *0x1::vector::borrow<u32>(&arg0.round_bet, (v1 as u64)));
            v1 = v1 + 1;
        };
        v0
    }

    fun deal_hole_cards(arg0: &mut Match, arg1: &0x2::tx_context::TxContext) {
        let v0 = *0x2::tx_context::digest(arg1);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0;
        while (v2 < 2) {
            let v3 = 0;
            while (v3 < 6) {
                if (is_active(arg0, v3)) {
                    *0x1::vector::borrow_mut<u8>(&mut arg0.hole_cards, (v3 as u64) * 2 + (v2 as u64)) = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::deck::draw_card(&mut arg0.deck, &v0, 0x2::object::id_to_address(&v1), &mut arg0.entropy_counter);
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
    }

    fun eligible_at(arg0: &Match, arg1: u32) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 6) {
            if (*0x1::vector::borrow<u32>(&arg0.commitments, (v1 as u64)) >= arg1 && !*0x1::vector::borrow<bool>(&arg0.folded, (v1 as u64))) {
                0x1::vector::push_back<u8>(&mut v0, v1);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun emit_engine_action(arg0: &Match, arg1: u8, arg2: u8) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = EngineActionTaken{
            match_id         : 0x2::object::id_to_address(&v0),
            hand_index       : arg0.hand_index,
            action_type      : arg1,
            street           : arg0.street,
            button           : arg0.button,
            small_blind_seat : arg0.small_blind_seat,
            big_blind_seat   : arg0.big_blind_seat,
            small_blind      : arg0.small_blind,
            big_blind        : arg0.big_blind,
            pot              : arg0.pot,
            winner           : arg2,
            stacks           : arg0.stacks,
            hole_cards       : arg0.hole_cards,
            community_cards  : arg0.community_cards,
        };
        0x2::event::emit<EngineActionTaken>(v1);
    }

    fun finish_hand(arg0: &mut Match, arg1: u8, arg2: u32, arg3: &0x2::tx_context::TxContext, arg4: u8) {
        0x1::vector::push_back<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::HandSummary>(&mut arg0.hand_summaries, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::new_hand_summary(arg0.hand_index, arg0.button, arg2, arg1, arg0.stacks));
        emit_engine_action(arg0, 2, arg1);
        let v0 = 0;
        while (v0 < 6) {
            if (*0x1::vector::borrow<u32>(&arg0.stacks, (v0 as u64)) == 0) {
                *0x1::vector::borrow_mut<bool>(&mut arg0.active_seats, (v0 as u64)) = false;
            };
            v0 = v0 + 1;
        };
        if (active_count(arg0) <= 1) {
            arg0.active = false;
            arg0.winner = first_active_seat_or_none(arg0);
            emit_engine_action(arg0, 3, arg0.winner);
            return
        };
        start_hand(arg0, arg3, arg4 + 1);
    }

    fun first_active_seat_or_none(arg0: &Match) : u8 {
        let v0 = 0;
        while (v0 < 6) {
            if (is_active(arg0, v0)) {
                return v0
            };
            v0 = v0 + 1;
        };
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::no_seat()
    }

    fun first_live_seat(arg0: &Match) : u8 {
        let v0 = 0;
        while (v0 < 6) {
            if (is_active(arg0, v0) && !*0x1::vector::borrow<bool>(&arg0.folded, (v0 as u64))) {
                return v0
            };
            v0 = v0 + 1;
        };
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::no_seat()
    }

    public(friend) fun folded(arg0: &Match, arg1: u8) : bool {
        *0x1::vector::borrow<bool>(&arg0.folded, (arg1 as u64))
    }

    public fun game_id(arg0: &GameCap) : 0x2::object::ID {
        arg0.game_id
    }

    public(friend) fun growth_denominator(arg0: &Match) : u32 {
        arg0.growth_denominator
    }

    public(friend) fun growth_numerator(arg0: &Match) : u32 {
        arg0.growth_numerator
    }

    public(friend) fun hand_index(arg0: &Match) : u32 {
        arg0.hand_index
    }

    public(friend) fun hand_summaries(arg0: &Match) : &vector<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::HandSummary> {
        &arg0.hand_summaries
    }

    public(friend) fun hands_per_level(arg0: &Match) : u32 {
        arg0.hands_per_level
    }

    public(friend) fun hole_card(arg0: &Match, arg1: u8, arg2: u8) : u8 {
        *0x1::vector::borrow<u8>(&arg0.hole_cards, (arg1 as u64) * 2 + (arg2 as u64))
    }

    fun insert_sorted(arg0: &mut vector<u32>, arg1: u32) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(arg0) && *0x1::vector::borrow<u32>(arg0, v0) < arg1) {
            v0 = v0 + 1;
        };
        0x1::vector::insert<u32>(arg0, arg1, v0);
    }

    fun is_active(arg0: &Match, arg1: u8) : bool {
        if (arg1 < 6) {
            if (*0x1::vector::borrow<bool>(&arg0.active_seats, (arg1 as u64))) {
                *0x1::vector::borrow<u32>(&arg0.stacks, (arg1 as u64)) > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_legal(arg0: &Match, arg1: u8, arg2: u32) : bool {
        if (!arg0.active || !can_act(arg0, arg0.to_act)) {
            return false
        };
        if (arg1 == 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_fold()) {
            to_call(arg0, arg0.to_act) > 0
        } else if (arg1 == 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_check()) {
            to_call(arg0, arg0.to_act) == 0
        } else if (arg1 == 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_commit_to()) {
            let (v1, _) = classify_commit_to(arg0, arg0.to_act, arg2);
            v1
        } else {
            false
        }
    }

    public(friend) fun last_full_raise_size(arg0: &Match) : u32 {
        arg0.last_full_raise_size
    }

    public fun legal_action_bounds(arg0: &Match) : (bool, bool, bool, u32, u32, u32, u32) {
        if (!arg0.active || !can_act(arg0, arg0.to_act)) {
            return (false, false, false, 0, 0, 0, 0)
        };
        let v0 = arg0.to_act;
        let v1 = to_call(arg0, v0);
        let v2 = max_total_for(arg0, v0);
        let (v3, v4) = if (current_bet(arg0) == 0 && v2 > 0) {
            (min(arg0.big_blind, v2), v2)
        } else {
            (0, 0)
        };
        let (v5, v6) = if (current_bet(arg0) > 0 && v2 > current_bet(arg0)) {
            let v7 = current_bet(arg0) + arg0.last_full_raise_size;
            let v8 = if (v2 >= v7) {
                v7
            } else {
                v2
            };
            (v8, v2)
        } else {
            (0, 0)
        };
        (v1 > 0, v1 == 0, v1 > 0, v3, v4, v5, v6)
    }

    fun live_count(arg0: &Match) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 6) {
            if (is_active(arg0, v1) && !*0x1::vector::borrow<bool>(&arg0.folded, (v1 as u64))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun log_action(arg0: &mut Match, arg1: u8, arg2: u8, arg3: u32) {
        0x1::vector::push_back<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::ActionLogEntry>(&mut arg0.action_log, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::new_action_log_entry(arg0.street, arg1, arg2, arg3));
    }

    public(friend) fun match_id(arg0: &Match) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun max(arg0: u32, arg1: u32) : u32 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_total_for(arg0: &Match, arg1: u8) : u32 {
        *0x1::vector::borrow<u32>(&arg0.round_bet, (arg1 as u64)) + *0x1::vector::borrow<u32>(&arg0.stacks, (arg1 as u64))
    }

    fun min(arg0: u32, arg1: u32) : u32 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public(friend) fun new_match(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u32, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (GameCap, Match) {
        assert!(arg0 > 0, 100);
        assert!(arg1 > 0, 100);
        assert!(arg2 > 0, 100);
        assert!(arg3 > 0, 100);
        assert!(arg4 > 0, 100);
        let v0 = 0x1::vector::length<vector<u8>>(&arg5);
        assert!(v0 >= 2 && v0 <= (6 as u64), 100);
        let v1 = padded_agent_names(&arg5);
        let v2 = Match{
            id                     : 0x2::object::new(arg7),
            starting_stack         : arg0,
            opening_big_blind      : arg1,
            hands_per_level        : arg2,
            growth_numerator       : arg3,
            growth_denominator     : arg4,
            agent_names            : padded_agent_names(&arg5),
            active_seats           : active_seats_for((v0 as u8)),
            stacks                 : starting_stacks_for((v0 as u8), arg0),
            button                 : 0,
            small_blind_seat       : 1,
            big_blind_seat         : 2,
            hand_index             : 0,
            active                 : true,
            winner                 : 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::no_seat(),
            street                 : 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::preflop(),
            small_blind            : 0,
            big_blind              : 0,
            pot                    : 0,
            round_bet              : zeros(),
            commitments            : zeros(),
            hole_cards             : x"000000000000000000000000",
            community_cards        : b"",
            deck                   : b"",
            to_act                 : 0,
            acted_since_full_raise : bools(false),
            last_full_raise_size   : 0,
            folded                 : bools(false),
            action_log             : 0x1::vector::empty<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::ActionLogEntry>(),
            hand_summaries         : 0x1::vector::empty<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::HandSummary>(),
            entropy_counter        : 0,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        let v4 = GameCap{
            id      : 0x2::object::new(arg7),
            game_id : v3,
        };
        let v5 = &mut v2;
        start_hand(v5, arg7, 0);
        let v6 = MatchCreated{
            match_id : 0x2::object::id_to_address(&v3),
            name_0   : *0x1::vector::borrow<0x1::string::String>(&v1, 0),
            name_1   : *0x1::vector::borrow<0x1::string::String>(&v1, 1),
            name_2   : *0x1::vector::borrow<0x1::string::String>(&v1, 2),
            name_3   : *0x1::vector::borrow<0x1::string::String>(&v1, 3),
            name_4   : *0x1::vector::borrow<0x1::string::String>(&v1, 4),
            name_5   : *0x1::vector::borrow<0x1::string::String>(&v1, 5),
        };
        0x2::event::emit<MatchCreated>(v6);
        (v4, v2)
    }

    fun next_active_after(arg0: &Match, arg1: u8) : u8 {
        let v0 = (arg1 + 1) % 6;
        let v1 = 0;
        while (v1 < 6) {
            if (is_active(arg0, v0)) {
                return v0
            };
            let v2 = v0 + 1;
            v0 = v2 % 6;
            v1 = v1 + 1;
        };
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::no_seat()
    }

    fun next_actor_after(arg0: &Match, arg1: u8) : u8 {
        let v0 = next_active_after(arg0, arg1);
        let v1 = 0;
        while (v1 < 6) {
            if (can_act(arg0, v0)) {
                return v0
            };
            v0 = next_active_after(arg0, v0);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun opening_big_blind(arg0: &Match) : u32 {
        arg0.opening_big_blind
    }

    fun padded_agent_names(arg0: &vector<vector<u8>>) : vector<0x1::string::String> {
        let v0 = active_agent_names_from_raw(arg0);
        while (0x1::vector::length<0x1::string::String>(&v0) < (6 as u64)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"inactive"));
        };
        v0
    }

    fun post_blind(arg0: &mut Match, arg1: u8, arg2: u32) {
        let v0 = min(arg2, *0x1::vector::borrow<u32>(&arg0.stacks, (arg1 as u64)));
        *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, (arg1 as u64)) = *0x1::vector::borrow<u32>(&arg0.stacks, (arg1 as u64)) - v0;
        *0x1::vector::borrow_mut<u32>(&mut arg0.round_bet, (arg1 as u64)) = *0x1::vector::borrow<u32>(&arg0.round_bet, (arg1 as u64)) + v0;
        *0x1::vector::borrow_mut<u32>(&mut arg0.commitments, (arg1 as u64)) = *0x1::vector::borrow<u32>(&arg0.commitments, (arg1 as u64)) + v0;
        arg0.pot = arg0.pot + v0;
    }

    public(friend) fun pot(arg0: &Match) : u32 {
        arg0.pot
    }

    fun reopen_action(arg0: &mut Match) {
        let v0 = 0;
        while (v0 < 6) {
            let v1 = if (!is_active(arg0, v0)) {
                true
            } else if (*0x1::vector::borrow<bool>(&arg0.folded, (v0 as u64))) {
                true
            } else {
                *0x1::vector::borrow<u32>(&arg0.stacks, (v0 as u64)) == 0
            };
            *0x1::vector::borrow_mut<bool>(&mut arg0.acted_since_full_raise, (v0 as u64)) = v1;
            v0 = v0 + 1;
        };
    }

    fun resolve_fold(arg0: &mut Match, arg1: &0x2::tx_context::TxContext, arg2: u8) {
        let v0 = first_live_seat(arg0);
        let v1 = arg0.pot;
        *0x1::vector::borrow_mut<u32>(&mut arg0.stacks, (v0 as u64)) = *0x1::vector::borrow<u32>(&arg0.stacks, (v0 as u64)) + v1;
        arg0.pot = 0;
        finish_hand(arg0, v0, v1, arg1, arg2);
    }

    fun reveal_remaining_board(arg0: &mut Match, arg1: &0x2::tx_context::TxContext) {
        while (0x1::vector::length<u8>(&arg0.community_cards) < 5) {
            advance_street(arg0, arg1);
        };
        arg0.street = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::river();
    }

    public(friend) fun round_bet_seat(arg0: &Match, arg1: u8) : u32 {
        *0x1::vector::borrow<u32>(&arg0.round_bet, (arg1 as u64))
    }

    fun round_closed(arg0: &Match) : bool {
        let v0 = 0;
        while (v0 < 6) {
            let v1 = if (is_active(arg0, v0)) {
                if (!*0x1::vector::borrow<bool>(&arg0.folded, (v0 as u64))) {
                    if (*0x1::vector::borrow<u32>(&arg0.stacks, (v0 as u64)) > 0) {
                        !*0x1::vector::borrow<bool>(&arg0.acted_since_full_raise, (v0 as u64)) || *0x1::vector::borrow<u32>(&arg0.round_bet, (v0 as u64)) != current_bet(arg0)
                    } else {
                        false
                    }
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
        let v0 = arg0.pot;
        let v1 = commitment_levels(arg0);
        let v2 = 0;
        let v3 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::no_seat();
        while (v2 < 0x1::vector::length<u32>(&v1)) {
            let v4 = *0x1::vector::borrow<u32>(&v1, v2);
            let v5 = contributors_at(arg0, v4);
            let v6 = (v4 - 0) * (0x1::vector::length<u8>(&v5) as u32);
            let v7 = eligible_at(arg0, v4);
            if (v6 > 0 && 0x1::vector::length<u8>(&v7) > 0) {
                let v8 = winners_for_pot(arg0, &v7);
                if (v3 == 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::no_seat()) {
                    v3 = *0x1::vector::borrow<u8>(&v8, 0);
                };
                award_to_winners(arg0, v6, &v8);
            };
            v2 = v2 + 1;
        };
        arg0.pot = 0;
        finish_hand(arg0, v3, v0, arg1, arg2);
    }

    fun seat_seven_cards(arg0: &Match, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.hole_cards, (arg1 as u64) * 2));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.hole_cards, (arg1 as u64) * 2 + 1));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.community_cards, 0));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.community_cards, 1));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.community_cards, 2));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.community_cards, 3));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0.community_cards, 4));
        v0
    }

    public(friend) fun small_blind(arg0: &Match) : u32 {
        arg0.small_blind
    }

    public(friend) fun small_blind_seat(arg0: &Match) : u8 {
        arg0.small_blind_seat
    }

    public(friend) fun stack(arg0: &Match, arg1: u8) : u32 {
        *0x1::vector::borrow<u32>(&arg0.stacks, (arg1 as u64))
    }

    fun start_hand(arg0: &mut Match, arg1: &0x2::tx_context::TxContext, arg2: u8) {
        assert!(arg2 < 100, 105);
        arg0.hand_index = arg0.hand_index + 1;
        let (v0, v1) = blinds_for_hand(arg0.opening_big_blind, arg0.hands_per_level, arg0.growth_numerator, arg0.growth_denominator, arg0.hand_index);
        arg0.street = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::preflop();
        arg0.small_blind = v0;
        arg0.big_blind = v1;
        arg0.pot = 0;
        arg0.round_bet = zeros();
        arg0.commitments = zeros();
        arg0.community_cards = b"";
        arg0.deck = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::deck::standard_deck();
        arg0.hole_cards = x"000000000000000000000000";
        arg0.acted_since_full_raise = bools(false);
        arg0.last_full_raise_size = max(v1, 1);
        arg0.folded = bools(false);
        arg0.action_log = 0x1::vector::empty<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::ActionLogEntry>();
        if (arg0.hand_index == 1) {
            arg0.button = 0;
        } else {
            arg0.button = next_active_after(arg0, arg0.button);
        };
        if (active_count(arg0) == 2) {
            arg0.small_blind_seat = arg0.button;
            arg0.big_blind_seat = next_active_after(arg0, arg0.button);
            arg0.to_act = arg0.button;
        } else {
            arg0.small_blind_seat = next_active_after(arg0, arg0.button);
            arg0.big_blind_seat = next_active_after(arg0, arg0.small_blind_seat);
            arg0.to_act = next_active_after(arg0, arg0.big_blind_seat);
        };
        deal_hole_cards(arg0, arg1);
        let v2 = arg0.small_blind_seat;
        let v3 = arg0.big_blind_seat;
        post_blind(arg0, v2, v0);
        post_blind(arg0, v3, v1);
        emit_engine_action(arg0, 0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::no_seat());
        advance_forced_progress(arg0, arg1, arg2 + 1);
    }

    fun starting_stacks_for(arg0: u8, arg1: u32) : vector<u32> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 6) {
            let v2 = if (v1 < arg0) {
                arg1
            } else {
                0
            };
            0x1::vector::push_back<u32>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun street(arg0: &Match) : u8 {
        arg0.street
    }

    public(friend) fun to_act(arg0: &Match) : u8 {
        arg0.to_act
    }

    fun to_call(arg0: &Match, arg1: u8) : u32 {
        let v0 = current_bet(arg0);
        if (v0 > *0x1::vector::borrow<u32>(&arg0.round_bet, (arg1 as u64))) {
            v0 - *0x1::vector::borrow<u32>(&arg0.round_bet, (arg1 as u64))
        } else {
            0
        }
    }

    public(friend) fun winner(arg0: &Match) : u8 {
        arg0.winner
    }

    fun winners_for_pot(arg0: &Match, arg1: &vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = false;
        let v2 = seat_seven_cards(arg0, *0x1::vector::borrow<u8>(arg1, 0));
        let v3 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::eval::best_of_seven(&v2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(arg1)) {
            let v5 = *0x1::vector::borrow<u8>(arg1, v4);
            let v6 = seat_seven_cards(arg0, v5);
            v3 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::eval::best_of_seven(&v6);
            let v7 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::eval::hand_rank_cmp(&v3, &v3);
            if (!v1 || v7 == 2) {
                let v8 = 0x1::vector::empty<u8>();
                0x1::vector::push_back<u8>(&mut v8, v5);
                v0 = v8;
                v1 = true;
            } else if (v7 == 1) {
                0x1::vector::push_back<u8>(&mut v0, v5);
            };
            v4 = v4 + 1;
        };
        v0
    }

    fun zeros() : vector<u32> {
        vector[0, 0, 0, 0, 0, 0]
    }

    // decompiled from Move bytecode v7
}

