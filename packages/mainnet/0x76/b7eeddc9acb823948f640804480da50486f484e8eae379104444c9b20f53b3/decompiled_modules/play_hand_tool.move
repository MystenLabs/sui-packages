module 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::play_hand_tool {
    struct PLAY_HAND_TOOL has drop {
        dummy_field: bool,
    }

    struct PlayHandAdminCap has key {
        id: 0x2::object::UID,
    }

    struct PlayHandWitness has store, key {
        id: 0x2::object::UID,
    }

    struct SegmentCounterKey has copy, drop, store {
        pos0: address,
    }

    struct PlayHandState has key {
        id: 0x2::object::UID,
        witness: 0x2::bag::Bag,
        leader_stamp_id: 0x2::object::ID,
    }

    fun append_action_log(arg0: &mut vector<u8>, arg1: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match) {
        let v0 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::action_log(arg1);
        0x1::vector::append<u8>(arg0, b",\"action_log\":[");
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::ActionLogEntry>(v0)) {
            let v2 = 0x1::vector::borrow<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::ActionLogEntry>(v0, v1);
            if (v1 > 0) {
                0x1::vector::append<u8>(arg0, b",");
            };
            0x1::vector::append<u8>(arg0, b"[");
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(arg0, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::street(v2) as u64));
            0x1::vector::append<u8>(arg0, b",");
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(arg0, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::seat(v2) as u64));
            0x1::vector::append<u8>(arg0, b",");
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(arg0, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_type(v2) as u64));
            0x1::vector::append<u8>(arg0, b",");
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(arg0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::amount(v2));
            0x1::vector::append<u8>(arg0, b"]");
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(arg0, b"]");
    }

    fun append_bool_array(arg0: &mut vector<u8>, arg1: vector<u8>, arg2: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match, arg3: bool) {
        0x1::vector::append<u8>(arg0, arg1);
        let v0 = 0;
        while (v0 < 6) {
            if (v0 > 0) {
                0x1::vector::append<u8>(arg0, b",");
            };
            let v1 = if (arg3 && 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::active_seat(arg2, v0) || 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::folded(arg2, v0)) {
                b"true"
            } else {
                b"false"
            };
            0x1::vector::append<u8>(arg0, v1);
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(arg0, b"]");
    }

    fun append_cards(arg0: &mut vector<u8>, arg1: vector<u8>, arg2: &vector<u8>) {
        0x1::vector::append<u8>(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg2)) {
            if (v0 > 0) {
                0x1::vector::append<u8>(arg0, b",");
            };
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(arg0, (*0x1::vector::borrow<u8>(arg2, v0) as u64));
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(arg0, b"]");
    }

    fun append_final_stacks(arg0: &mut vector<u8>, arg1: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match) {
        0x1::vector::append<u8>(arg0, b",\"final_stacks\":[");
        let v0 = 0;
        while (v0 < 6) {
            if (v0 > 0) {
                0x1::vector::append<u8>(arg0, b",");
            };
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(arg0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::stack(arg1, v0));
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(arg0, b"]");
    }

    fun append_legal(arg0: &mut vector<u8>, arg1: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match) {
        let (v0, v1, v2, v3, v4, v5, v6) = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::legal_action_bounds(arg1);
        0x1::vector::append<u8>(arg0, b",\"legal\":{\"fold\":");
        let v7 = if (v0) {
            b"true"
        } else {
            b"false"
        };
        0x1::vector::append<u8>(arg0, v7);
        0x1::vector::append<u8>(arg0, b",\"check\":");
        let v8 = if (v1) {
            b"true"
        } else {
            b"false"
        };
        0x1::vector::append<u8>(arg0, v8);
        0x1::vector::append<u8>(arg0, b",\"call\":");
        let v9 = if (v2) {
            b"true"
        } else {
            b"false"
        };
        0x1::vector::append<u8>(arg0, v9);
        0x1::vector::append<u8>(arg0, b",\"bet_min\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(arg0, v3);
        0x1::vector::append<u8>(arg0, b",\"bet_max\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(arg0, v4);
        0x1::vector::append<u8>(arg0, b",\"raise_min\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(arg0, v5);
        0x1::vector::append<u8>(arg0, b",\"raise_max\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(arg0, v6);
        0x1::vector::append<u8>(arg0, b"}");
    }

    fun append_names(arg0: &mut vector<u8>, arg1: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match) {
        0x1::vector::append<u8>(arg0, b",\"agent_names\":[");
        let v0 = 0;
        while (v0 < 6) {
            if (v0 > 0) {
                0x1::vector::append<u8>(arg0, b",");
            };
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_json_string(arg0, 0x1::string::as_bytes(0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::agent_name(arg1, v0)));
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(arg0, b"]");
    }

    fun append_round_bets(arg0: &mut vector<u8>, arg1: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match) {
        0x1::vector::append<u8>(arg0, b",\"round_bet\":[");
        let v0 = 0;
        while (v0 < 6) {
            if (v0 > 0) {
                0x1::vector::append<u8>(arg0, b",");
            };
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(arg0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::round_bet_seat(arg1, v0));
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(arg0, b"]");
    }

    fun append_stack_array(arg0: &mut vector<u8>, arg1: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match) {
        0x1::vector::append<u8>(arg0, b",\"stacks\":[");
        let v0 = 0;
        while (v0 < 6) {
            if (v0 > 0) {
                0x1::vector::append<u8>(arg0, b",");
            };
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(arg0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::stack(arg1, v0));
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(arg0, b"]");
    }

    public(friend) fun build_state_json(arg0: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match, arg1: u8) : vector<u8> {
        let v0 = b"{\"hand_index\":";
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::hand_index(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"blind_schedule\":{\"type\":\"linear\",\"opening_big_blind\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::opening_big_blind(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"hands_per_level\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::hands_per_level(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"growth_numerator\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::growth_numerator(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"growth_denominator\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::growth_denominator(arg0));
        0x1::vector::append<u8>(&mut v0, b"}");
        0x1::vector::append<u8>(&mut v0, b",\"button\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v0, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::button(arg0) as u64));
        0x1::vector::append<u8>(&mut v0, b",\"small_blind_seat\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v0, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::small_blind_seat(arg0) as u64));
        0x1::vector::append<u8>(&mut v0, b",\"big_blind_seat\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v0, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::big_blind_seat(arg0) as u64));
        0x1::vector::append<u8>(&mut v0, b",\"street\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v0, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::street(arg0) as u64));
        0x1::vector::append<u8>(&mut v0, b",\"small_blind\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::small_blind(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"big_blind\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::big_blind(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"pot\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::pot(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"current_bet\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::current_bet(arg0));
        let v1 = &mut v0;
        append_stack_array(v1, arg0);
        let v2 = &mut v0;
        append_bool_array(v2, b",\"active\":[", arg0, true);
        let v3 = &mut v0;
        append_bool_array(v3, b",\"folded\":[", arg0, false);
        0x1::vector::append<u8>(&mut v0, b",\"my_seat\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v0, (arg1 as u64));
        0x1::vector::append<u8>(&mut v0, b",\"to_act\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v0, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::to_act(arg0) as u64));
        let v4 = &mut v0;
        append_names(v4, arg0);
        0x1::vector::append<u8>(&mut v0, b",\"my_hole_cards\":[");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v0, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::hole_card(arg0, arg1, 0) as u64));
        0x1::vector::append<u8>(&mut v0, b",");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v0, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::hole_card(arg0, arg1, 1) as u64));
        0x1::vector::append<u8>(&mut v0, b"]");
        let v5 = &mut v0;
        append_cards(v5, b",\"community_cards\":[", 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::community_cards(arg0));
        let v6 = &mut v0;
        append_round_bets(v6, arg0);
        0x1::vector::append<u8>(&mut v0, b",\"last_full_raise_size\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::last_full_raise_size(arg0));
        let v7 = &mut v0;
        append_legal(v7, arg0);
        let v8 = &mut v0;
        append_action_log(v8, arg0);
        0x1::vector::append<u8>(&mut v0, b",\"last_hand\":null");
        0x1::vector::append<u8>(&mut v0, b",\"match_over\":");
        let v9 = if (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::active(arg0)) {
            b"false"
        } else {
            b"true"
        };
        0x1::vector::append<u8>(&mut v0, v9);
        0x1::vector::append<u8>(&mut v0, b"}");
        v0
    }

    fun build_summary_json(arg0: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match) : vector<u8> {
        let v0 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::hand_summaries(arg0);
        let v1 = b"[";
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::HandSummary>(v0)) {
            let v3 = 0x1::vector::borrow<0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::HandSummary>(v0, v2);
            if (v2 > 0) {
                0x1::vector::append<u8>(&mut v1, b",");
            };
            0x1::vector::append<u8>(&mut v1, b"[");
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v1, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::hand_index(v3));
            0x1::vector::append<u8>(&mut v1, b",");
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v1, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::button(v3) as u64));
            0x1::vector::append<u8>(&mut v1, b",");
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v1, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::pot(v3));
            0x1::vector::append<u8>(&mut v1, b",");
            0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v1, (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::winner(v3) as u64));
            0x1::vector::append<u8>(&mut v1, b"]");
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v1, b"]");
        v1
    }

    public fun configure_leader_stamp(arg0: &mut PlayHandState, arg1: &PlayHandAdminCap, arg2: 0x2::object::ID) {
        arg0.leader_stamp_id = arg2;
    }

    public fun execute(arg0: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::ProofOfUID, arg1: &mut PlayHandState, arg2: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game_caps::GameCapStore, arg3: &mut 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        if (arg1.leader_stamp_id != 0x2::object::id_from_address(@0x0)) {
            assert!(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::has_stamp(arg0, arg1.leader_stamp_id), 13906834582365274111);
        };
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::stamp_with_data(arg0, &witness(arg1).id, b"nlhe_hand_played");
        let v0 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::match_id(arg3);
        let v1 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game_caps::borrow_cap(arg2, 0x2::object::id_to_address(&v0));
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game_caps::assert_execution(arg2, 0x2::object::id_to_address(&v0), 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game_caps::execution_id_from_worksheet(arg0));
        if (!0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::active(arg3)) {
            return make_finished_output(arg3)
        };
        if ((0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::hand_index(arg3) as u64) != arg6) {
            if (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::active(arg3)) {
                return make_continue_output(arg3)
            };
            return make_finished_output(arg3)
        };
        let (v2, v3) = normalize_action(arg3, arg4, (arg5 as u32));
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::apply_move(arg3, v1, v2, v3, arg7, arg8, arg9);
        if (!0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::active(arg3)) {
            make_finished_output(arg3)
        } else if (should_handoff(increment_segment_action_count(arg1, 0x2::object::id_to_address(&v0)))) {
            make_handoff_output(arg3)
        } else {
            make_continue_output(arg3)
        }
    }

    fun increment_segment_action_count(arg0: &mut PlayHandState, arg1: address) : u32 {
        let v0 = SegmentCounterKey{pos0: arg1};
        if (!0x2::dynamic_field::exists_<SegmentCounterKey>(&arg0.id, v0)) {
            let v1 = SegmentCounterKey{pos0: arg1};
            0x2::dynamic_field::add<SegmentCounterKey, u32>(&mut arg0.id, v1, 0);
        };
        let v2 = SegmentCounterKey{pos0: arg1};
        let v3 = 0x2::dynamic_field::borrow_mut<SegmentCounterKey, u32>(&mut arg0.id, v2);
        *v3 = *v3 + 1;
        *v3
    }

    fun init(arg0: PLAY_HAND_TOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg1);
        let v1 = PlayHandWitness{id: 0x2::object::new(arg1)};
        0x2::bag::add<vector<u8>, PlayHandWitness>(&mut v0, b"witness", v1);
        let v2 = PlayHandState{
            id              : 0x2::object::new(arg1),
            witness         : v0,
            leader_stamp_id : 0x2::object::id_from_address(@0x0),
        };
        0x2::transfer::share_object<PlayHandState>(v2);
        let v3 = PlayHandAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PlayHandAdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    fun make_continue_output(arg0: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"continue"), b"state", 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::raw_json_payload(build_state_json(arg0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::to_act(arg0))))
    }

    fun make_finished_output(arg0: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        let v0 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::winner(arg0);
        let v1 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::hand_index(arg0);
        let v2 = build_summary_json(arg0);
        let v3 = b"{\"winner\":";
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num(&mut v3, (v0 as u64));
        let v4 = &mut v3;
        append_final_stacks(v4, arg0);
        0x1::vector::append<u8>(&mut v3, b",\"total_hands\":");
        0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::append_num32(&mut v3, v1);
        0x1::vector::append<u8>(&mut v3, b",\"hands\":");
        0x1::vector::append<u8>(&mut v3, v2);
        0x1::vector::append<u8>(&mut v3, b"}");
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"finished"), b"winner", 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::num_payload((v0 as u64))), b"total_hands", 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::num_payload((v1 as u64))), b"summary", 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::raw_json_payload(v2)), b"result_json", 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::raw_json_payload(to_json_string(v3)))
    }

    fun make_handoff_output(arg0: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        let v0 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::match_id(arg0);
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"handoff"), b"match_id", 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::addr_payload(0x2::object::id_to_address(&v0))), b"state", 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::utils::raw_json_payload(build_state_json(arg0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::to_act(arg0))))
    }

    fun min_u32(arg0: u32, arg1: u32) : u32 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun normalize_action(arg0: &0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::Match, arg1: u8, arg2: u32) : (u8, u32) {
        if (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::is_legal(arg0, arg1, arg2)) {
            return (arg1, arg2)
        };
        if (arg1 == 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_commit_to()) {
            let v0 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::to_act(arg0);
            let v1 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::max_total_for(arg0, v0);
            let v2 = 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::current_bet(arg0);
            let v3 = min_u32(v2, v1);
            if (v2 > 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::round_bet_seat(arg0, v0) && 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::is_legal(arg0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_commit_to(), v3)) {
                return (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_commit_to(), v3)
            };
            if (v1 > v2) {
                let v4 = if (v2 == 0) {
                    min_u32(0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::big_blind(arg0), v1)
                } else {
                    let v5 = v2 + 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::last_full_raise_size(arg0);
                    if (v1 >= v5) {
                        v5
                    } else {
                        v1
                    }
                };
                if (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::is_legal(arg0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_commit_to(), v4)) {
                    return (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_commit_to(), v4)
                };
            };
        };
        if (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::game::is_legal(arg0, 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_check(), 0)) {
            return (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_check(), 0)
        };
        (0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types::action_fold(), 0)
    }

    fun should_handoff(arg0: u32) : bool {
        arg0 > 0 && arg0 % 240 == 0
    }

    fun to_json_string(arg0: vector<u8>) : vector<u8> {
        let v0 = b"\"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            if (v2 == 34) {
                0x1::vector::push_back<u8>(&mut v0, 92);
            };
            0x1::vector::push_back<u8>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::push_back<u8>(&mut v0, 34);
        v0
    }

    fun witness(arg0: &PlayHandState) : &PlayHandWitness {
        0x2::bag::borrow<vector<u8>, PlayHandWitness>(&arg0.witness, b"witness")
    }

    public fun witness_id(arg0: &PlayHandState) : 0x2::object::ID {
        0x2::object::uid_to_inner(&witness(arg0).id)
    }

    // decompiled from Move bytecode v7
}

