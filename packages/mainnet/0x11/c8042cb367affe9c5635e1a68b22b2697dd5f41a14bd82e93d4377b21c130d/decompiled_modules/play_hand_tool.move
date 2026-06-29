module 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::play_hand_tool {
    struct PLAY_HAND_TOOL has drop {
        dummy_field: bool,
    }

    struct PlayHandAdminCap has key {
        id: 0x2::object::UID,
    }

    struct PlayHandWitness has store, key {
        id: 0x2::object::UID,
    }

    struct PlayHandState has key {
        id: 0x2::object::UID,
        witness: 0x2::bag::Bag,
        leader_stamp_id: 0x2::object::ID,
    }

    public(friend) fun build_state_json(arg0: &0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::Match, arg1: u8) : vector<u8> {
        let v0 = b"{\"hand_index\":";
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::hand_index(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"blind_schedule\":{\"type\":\"");
        if (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::blind_schedule_type(arg0) == 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::blind_schedule_linear()) {
            0x1::vector::append<u8>(&mut v0, b"linear");
        } else {
            0x1::vector::append<u8>(&mut v0, b"geometric");
        };
        0x1::vector::append<u8>(&mut v0, b"\",\"opening_big_blind\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::opening_big_blind(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"hands_per_level\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::hands_per_level(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"growth_numerator\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::growth_numerator(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"growth_denominator\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::growth_denominator(arg0));
        0x1::vector::append<u8>(&mut v0, b"}");
        0x1::vector::append<u8>(&mut v0, b",\"bias\":{\"start_hand\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::bias_start_hand(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"preflop_pressure_beta_milli\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::preflop_pressure_beta_milli(arg0));
        0x1::vector::append<u8>(&mut v0, b"}");
        0x1::vector::append<u8>(&mut v0, b",\"button\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::button(arg0) as u64));
        0x1::vector::append<u8>(&mut v0, b",\"street\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::street(arg0) as u64));
        0x1::vector::append<u8>(&mut v0, b",\"small_blind\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::small_blind(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"big_blind\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::big_blind(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"pot\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::pot(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"current_bet\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::current_bet(arg0));
        0x1::vector::append<u8>(&mut v0, b",\"stacks\":[");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::stack(arg0, 0));
        0x1::vector::append<u8>(&mut v0, b",");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::stack(arg0, 1));
        0x1::vector::append<u8>(&mut v0, b"]");
        0x1::vector::append<u8>(&mut v0, b",\"my_seat\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (arg1 as u64));
        0x1::vector::append<u8>(&mut v0, b",\"to_act\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::to_act(arg0) as u64));
        0x1::vector::append<u8>(&mut v0, b",\"my_name\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_json_string(&mut v0, 0x1::string::as_bytes(0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::agent_name(arg0, arg1)));
        0x1::vector::append<u8>(&mut v0, b",\"opponent_name\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_json_string(&mut v0, 0x1::string::as_bytes(0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::agent_name(arg0, 1 - arg1)));
        0x1::vector::append<u8>(&mut v0, b",\"my_hole_cards\":[");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::hole_card(arg0, arg1, 0) as u64));
        0x1::vector::append<u8>(&mut v0, b",");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::hole_card(arg0, arg1, 1) as u64));
        0x1::vector::append<u8>(&mut v0, b"]");
        0x1::vector::append<u8>(&mut v0, b",\"my_hole_names\":[\"");
        0x1::vector::append<u8>(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::card_name(0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::hole_card(arg0, arg1, 0)));
        0x1::vector::append<u8>(&mut v0, b"\",\"");
        0x1::vector::append<u8>(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::card_name(0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::hole_card(arg0, arg1, 1)));
        0x1::vector::append<u8>(&mut v0, b"\"]");
        let v1 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::community_cards(arg0);
        0x1::vector::append<u8>(&mut v0, b",\"community_cards\":[");
        let v2 = 0x1::vector::length<u8>(v1);
        let v3 = 0;
        while (v3 < v2) {
            if (v3 > 0) {
                0x1::vector::append<u8>(&mut v0, b",");
            };
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (*0x1::vector::borrow<u8>(v1, v3) as u64));
            v3 = v3 + 1;
        };
        0x1::vector::append<u8>(&mut v0, b"]");
        0x1::vector::append<u8>(&mut v0, b",\"community_names\":[");
        v3 = 0;
        while (v3 < v2) {
            if (v3 > 0) {
                0x1::vector::append<u8>(&mut v0, b",");
            };
            0x1::vector::append<u8>(&mut v0, b"\"");
            0x1::vector::append<u8>(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::card_name(*0x1::vector::borrow<u8>(v1, v3)));
            0x1::vector::append<u8>(&mut v0, b"\"");
            v3 = v3 + 1;
        };
        0x1::vector::append<u8>(&mut v0, b"]");
        0x1::vector::append<u8>(&mut v0, b",\"round_bet\":[");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::round_bet_seat(arg0, 0));
        0x1::vector::append<u8>(&mut v0, b",");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::round_bet_seat(arg0, 1));
        0x1::vector::append<u8>(&mut v0, b"]");
        0x1::vector::append<u8>(&mut v0, b",\"last_full_raise_size\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::last_full_raise_size(arg0));
        let (v4, v5, v6, v7, v8, v9, v10) = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::legal_action_bounds(arg0);
        0x1::vector::append<u8>(&mut v0, b",\"legal\":{\"fold\":");
        let v11 = if (v4) {
            b"true"
        } else {
            b"false"
        };
        0x1::vector::append<u8>(&mut v0, v11);
        0x1::vector::append<u8>(&mut v0, b",\"check\":");
        let v12 = if (v5) {
            b"true"
        } else {
            b"false"
        };
        0x1::vector::append<u8>(&mut v0, v12);
        0x1::vector::append<u8>(&mut v0, b",\"call\":");
        let v13 = if (v6) {
            b"true"
        } else {
            b"false"
        };
        0x1::vector::append<u8>(&mut v0, v13);
        0x1::vector::append<u8>(&mut v0, b",\"bet_min\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, v7);
        0x1::vector::append<u8>(&mut v0, b",\"bet_max\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, v8);
        0x1::vector::append<u8>(&mut v0, b",\"raise_min\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, v9);
        0x1::vector::append<u8>(&mut v0, b",\"raise_max\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, v10);
        0x1::vector::append<u8>(&mut v0, b"}");
        let v14 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::action_log(arg0);
        0x1::vector::append<u8>(&mut v0, b",\"action_log\":[");
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::ActionLogEntry>(v14)) {
            let v16 = 0x1::vector::borrow<0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::ActionLogEntry>(v14, v15);
            if (v15 > 0) {
                0x1::vector::append<u8>(&mut v0, b",");
            };
            0x1::vector::append<u8>(&mut v0, b"[");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::ale_street(v16) as u64));
            0x1::vector::append<u8>(&mut v0, b",");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::ale_seat(v16) as u64));
            0x1::vector::append<u8>(&mut v0, b",");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::ale_action_type(v16) as u64));
            0x1::vector::append<u8>(&mut v0, b",");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::ale_amount(v16));
            0x1::vector::append<u8>(&mut v0, b"]");
            v15 = v15 + 1;
        };
        0x1::vector::append<u8>(&mut v0, b"]");
        let v17 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::hand_summaries(arg0);
        let v18 = 0x1::vector::length<0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::HandSummary>(v17);
        if (v18 > 0) {
            let v19 = 0x1::vector::borrow<0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::HandSummary>(v17, v18 - 1);
            0x1::vector::append<u8>(&mut v0, b",\"last_hand\":{\"hand\":");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_hand_index(v19));
            0x1::vector::append<u8>(&mut v0, b",\"pot\":");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_pot(v19));
            0x1::vector::append<u8>(&mut v0, b",\"ended_by\":");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_ended_by(v19) as u64));
            0x1::vector::append<u8>(&mut v0, b",\"w0\":");
            let v20 = if (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_winner_0(v19)) {
                1
            } else {
                0
            };
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, v20);
            0x1::vector::append<u8>(&mut v0, b",\"w1\":");
            let v21 = if (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_winner_1(v19)) {
                1
            } else {
                0
            };
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v0, v21);
            0x1::vector::append<u8>(&mut v0, b"}");
        } else {
            0x1::vector::append<u8>(&mut v0, b",\"last_hand\":null");
        };
        0x1::vector::append<u8>(&mut v0, b",\"match_over\":");
        let v22 = if (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::active(arg0)) {
            b"false"
        } else {
            b"true"
        };
        0x1::vector::append<u8>(&mut v0, v22);
        0x1::vector::append<u8>(&mut v0, b"}");
        v0
    }

    public fun configure_leader_stamp(arg0: &PlayHandAdminCap, arg1: &mut PlayHandState, arg2: 0x2::object::ID) {
        arg1.leader_stamp_id = arg2;
    }

    public fun execute(arg0: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::ProofOfUID, arg1: &mut PlayHandState, arg2: &0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game_caps::GameCapStore, arg3: &mut 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::Match, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        if (arg1.leader_stamp_id != 0x2::object::id_from_address(@0x0)) {
            assert!(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::has_stamp(arg0, arg1.leader_stamp_id), 13906834702624358401);
        };
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::stamp_with_data(arg0, &witness(arg1).id, b"texas_holdem_hand_played");
        let v0 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::match_id(arg3);
        let v1 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game_caps::borrow_cap(arg2, 0x2::object::id_to_address(&v0));
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game_caps::assert_execution(arg2, 0x2::object::id_to_address(&v0), 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game_caps::execution_id_from_worksheet(arg0));
        if (!0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::active(arg3)) {
            return make_finished_output(arg3)
        };
        if ((0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::hand_index(arg3) as u64) != arg6) {
            if (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::active(arg3)) {
                return make_continue_output(arg3)
            };
            return make_finished_output(arg3)
        };
        let (v2, v3) = normalize_action(arg3, arg4, (arg5 as u32));
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::apply_move(arg3, v1, v2, v3, arg7, arg8, arg9);
        if (!0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::active(arg3)) {
            make_finished_output(arg3)
        } else if (should_handoff(0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::increment_action_count(arg3))) {
            make_handoff_output(arg3)
        } else {
            make_continue_output(arg3)
        }
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

    fun make_continue_output(arg0: &0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::Match) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"continue"), b"state", 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::raw_json_payload(build_state_json(arg0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::to_act(arg0))))
    }

    fun make_finished_output(arg0: &0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::Match) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        let v0 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::winner(arg0);
        let v1 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::stack(arg0, 0);
        let v2 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::stack(arg0, 1);
        let v3 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::hand_index(arg0);
        let v4 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::action_count(arg0);
        let v5 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::hand_summaries(arg0);
        let v6 = b"[";
        let v7 = 0x1::vector::length<0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::HandSummary>(v5);
        let v8 = 0;
        while (v8 < v7) {
            let v9 = 0x1::vector::borrow<0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::HandSummary>(v5, v8);
            0x1::vector::append<u8>(&mut v6, b"[");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v6, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_hand_index(v9));
            0x1::vector::append<u8>(&mut v6, b",");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v6, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_button(v9) as u64));
            0x1::vector::append<u8>(&mut v6, b",");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v6, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_pot(v9));
            0x1::vector::append<u8>(&mut v6, b",");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v6, (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_ended_by(v9) as u64));
            0x1::vector::append<u8>(&mut v6, b",");
            let v10 = if (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_winner_0(v9)) {
                1
            } else {
                0
            };
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v6, v10);
            0x1::vector::append<u8>(&mut v6, b",");
            let v11 = if (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_winner_1(v9)) {
                1
            } else {
                0
            };
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v6, v11);
            0x1::vector::append<u8>(&mut v6, b",");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v6, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_stacks_after_0(v9));
            0x1::vector::append<u8>(&mut v6, b",");
            0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v6, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::hs_stacks_after_1(v9));
            0x1::vector::append<u8>(&mut v6, b"]");
            if (v8 + 1 < v7) {
                0x1::vector::append<u8>(&mut v6, b",");
            };
            v8 = v8 + 1;
        };
        0x1::vector::append<u8>(&mut v6, b"]");
        let v12 = b"{\"winner\":";
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num(&mut v12, (v0 as u64));
        0x1::vector::append<u8>(&mut v12, b",\"final_stacks\":[");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v12, v1);
        0x1::vector::append<u8>(&mut v12, b",");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v12, v2);
        0x1::vector::append<u8>(&mut v12, b"],\"total_hands\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v12, v3);
        0x1::vector::append<u8>(&mut v12, b",\"total_actions\":");
        0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::append_num32(&mut v12, v4);
        0x1::vector::append<u8>(&mut v12, b",\"hands\":");
        0x1::vector::append<u8>(&mut v12, v6);
        0x1::vector::append<u8>(&mut v12, b"}");
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"finished"), b"winner", 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::num_payload((v0 as u64))), b"final_stacks_0", 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::num_payload((v1 as u64))), b"final_stacks_1", 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::num_payload((v2 as u64))), b"total_hands", 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::num_payload((v3 as u64))), b"total_actions", 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::num_payload((v4 as u64))), b"summary", 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::raw_json_payload(v6)), b"result_json", 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::raw_json_payload(to_json_string(v12)))
    }

    fun make_handoff_output(arg0: &0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::Match) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        let v0 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::match_id(arg0);
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"handoff"), b"match_id", 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::addr_payload(0x2::object::id_to_address(&v0))), b"state", 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::utils::raw_json_payload(build_state_json(arg0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::to_act(arg0))))
    }

    fun min_u32(arg0: u32, arg1: u32) : u32 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun normalize_action(arg0: &0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::Match, arg1: u8, arg2: u32) : (u8, u32) {
        if (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::is_legal(arg0, arg1, arg2)) {
            return (arg1, arg2)
        };
        if (arg1 == 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::action_commit_to()) {
            let v0 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::to_act(arg0);
            let v1 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::max_total_for(arg0, v0);
            let v2 = 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::current_bet(arg0);
            let v3 = min_u32(v2, v1);
            if (v2 > 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::round_bet_seat(arg0, v0) && 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::is_legal(arg0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::action_commit_to(), v3)) {
                return (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::action_commit_to(), v3)
            };
            if (v1 > v2) {
                let v4 = if (v2 == 0) {
                    min_u32(0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::big_blind(arg0), v1)
                } else {
                    let v5 = v2 + 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::last_full_raise_size(arg0);
                    if (v1 >= v5) {
                        v5
                    } else {
                        v1
                    }
                };
                if (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::is_legal(arg0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::action_commit_to(), v4)) {
                    return (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::action_commit_to(), v4)
                };
            };
        };
        if (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::game::is_legal(arg0, 0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::action_check(), 0)) {
            return (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::action_check(), 0)
        };
        (0x11c8042cb367affe9c5635e1a68b22b2697dd5f41a14bd82e93d4377b21c130d::types::action_fold(), 0)
    }

    fun should_handoff(arg0: u32) : bool {
        arg0 > 0 && arg0 % 240 == 0
    }

    fun to_json_string(arg0: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, 34);
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

