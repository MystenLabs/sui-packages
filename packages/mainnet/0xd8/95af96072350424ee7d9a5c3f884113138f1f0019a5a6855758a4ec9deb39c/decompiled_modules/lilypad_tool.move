module 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::lilypad_tool {
    struct LILYPAD_TOOL has drop {
        dummy_field: bool,
    }

    struct LilypadToolAdminCap has key {
        id: 0x2::object::UID,
    }

    struct LilypadToolWitness has store, key {
        id: 0x2::object::UID,
    }

    struct LilypadToolState has key {
        id: 0x2::object::UID,
        witness: 0x2::bag::Bag,
        leader_stamp_id: 0x2::object::ID,
    }

    fun build_state_json(arg0: &0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::Match, arg1: u8, arg2: u8) : vector<u8> {
        let v0 = b"{\"own\":[";
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_hp_max(arg0, arg1));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_hp(arg0, arg1));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_attack(arg0, arg1));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_defense(arg0, arg1));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_speed(arg0, arg1));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_fp_left(arg0, arg1) as u64));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_miss_count(arg0, arg1) as u64));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_crit_hit_count(arg0, arg1) as u64));
        0x1::vector::append<u8>(&mut v0, b",");
        let v1 = if (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_charging(arg0, arg1)) {
            1
        } else {
            0
        };
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, v1);
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::emotion_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_emotional_state(arg0, arg1)) as u64));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_nft_id(arg0, arg1) as u64));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::signal_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_last_signal(arg0, arg1)) as u64));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_last_actual_action(arg0, arg1)) as u64));
        0x1::vector::append<u8>(&mut v0, b"],\"opp\":[");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::hp_tier_to_u64(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::hp_tier(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_hp(arg0, arg2), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_hp_max(arg0, arg2))));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_fp_left(arg0, arg2) as u64));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::signal_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_last_signal(arg0, arg2)) as u64));
        0x1::vector::append<u8>(&mut v0, b",");
        let v2 = if (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::is_preparing_action(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_last_actual_action(arg0, arg2))) {
            1
        } else {
            0
        };
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, v2);
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::stat_cmp(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_attack(arg0, arg2), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_attack(arg0, arg1)));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::stat_cmp(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_defense(arg0, arg2), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_defense(arg0, arg1)));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::stat_cmp(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_speed(arg0, arg2), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_speed(arg0, arg1)));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_to_u64(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_last_call_guess(arg0, arg2)));
        0x1::vector::append<u8>(&mut v0, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::call_success_to_u64(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_last_call_success(arg0, arg2)));
        0x1::vector::append<u8>(&mut v0, b"],\"round\":");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::round(arg0) as u64));
        0x1::vector::append<u8>(&mut v0, b",\"fighter_id\":");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (arg1 as u64));
        0x1::vector::append<u8>(&mut v0, b",\"history\":[");
        let v3 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::round_history(arg0);
        let v4 = 0x1::vector::length<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::CompactRound>(v3);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = 0x1::vector::borrow<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::CompactRound>(v3, v5);
            let v7 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_action(v6, 0);
            let v8 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_action(v6, 1);
            let (v9, v10, v11, v12, v13, v14, v15, v16) = if (arg1 == 0) {
                let v17 = if (v8 == 1 || v8 == 2) {
                    3
                } else {
                    v8
                };
                ((v17 as u64), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_damage(v6, 0), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_hp_after(v6, 0), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::hp_tier_to_u64(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::hp_tier(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_hp_after(v6, 1), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_hp_max(arg0, arg2))), (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_attack_result(v6, 0) as u64), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_bluff_caught(v6, 0), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_bluff_caught(v6, 1), (v7 as u64))
            } else {
                let v18 = if (v7 == 1 || v7 == 2) {
                    3
                } else {
                    v7
                };
                ((v18 as u64), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_damage(v6, 1), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_hp_after(v6, 1), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::hp_tier_to_u64(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::hp_tier(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_hp_after(v6, 0), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_hp_max(arg0, arg2))), (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_attack_result(v6, 1) as u64), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_bluff_caught(v6, 1), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_bluff_caught(v6, 0), (v8 as u64))
            };
            0x1::vector::append<u8>(&mut v0, b"[");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_round(v6) as u64));
            0x1::vector::append<u8>(&mut v0, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, v16);
            0x1::vector::append<u8>(&mut v0, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, v9);
            0x1::vector::append<u8>(&mut v0, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, v10);
            0x1::vector::append<u8>(&mut v0, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0);
            0x1::vector::append<u8>(&mut v0, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, v11);
            0x1::vector::append<u8>(&mut v0, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, v12);
            0x1::vector::append<u8>(&mut v0, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, v13);
            0x1::vector::append<u8>(&mut v0, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, 0);
            0x1::vector::append<u8>(&mut v0, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_first_actor(v6) as u64));
            0x1::vector::append<u8>(&mut v0, b",");
            let v19 = if (v14) {
                1
            } else {
                0
            };
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, v19);
            0x1::vector::append<u8>(&mut v0, b",");
            let v20 = if (v15) {
                1
            } else {
                0
            };
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v0, v20);
            0x1::vector::append<u8>(&mut v0, b"]");
            if (v5 + 1 < v4) {
                0x1::vector::append<u8>(&mut v0, b",");
            };
            v5 = v5 + 1;
        };
        0x1::vector::append<u8>(&mut v0, b"]}");
        v0
    }

    public fun configure_leader_stamp(arg0: &LilypadToolAdminCap, arg1: &mut LilypadToolState, arg2: 0x2::object::ID) {
        arg1.leader_stamp_id = arg2;
    }

    fun derive_rng_bytes(arg0: &0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::Match, arg1: &0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::id<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::Match>(arg0);
        let v1 = 0x2::address::to_bytes(0x2::object::id_to_address(&v0));
        let v2 = *0x2::tx_context::digest(arg1);
        let v3 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::round(arg0);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = &mut v4;
        0x1::vector::push_back<u8>(v5, ((v3 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(v5, ((v3 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(v5, ((v3 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(v5, ((v3 & 255) as u8));
        0x1::vector::append<u8>(&mut v2, v1);
        0x1::vector::append<u8>(&mut v2, v4);
        0x1::vector::push_back<u8>(&mut v2, 1);
        0x1::vector::append<u8>(&mut v2, v1);
        0x1::vector::append<u8>(&mut v2, v4);
        0x1::vector::push_back<u8>(&mut v2, 2);
        0x1::vector::append<u8>(&mut v2, v1);
        0x1::vector::append<u8>(&mut v2, v4);
        0x1::vector::push_back<u8>(&mut v2, 3);
        let v6 = 0x2::hash::blake2b256(&v2);
        0x1::vector::append<u8>(&mut v6, 0x2::hash::blake2b256(&v2));
        0x1::vector::append<u8>(&mut v6, 0x2::hash::blake2b256(&v2));
        v6
    }

    public fun execute(arg0: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::ProofOfUID, arg1: &mut LilypadToolState, arg2: &0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::game_caps::GameCapStore, arg3: &mut 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::Match, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: u8, arg9: u8, arg10: u8, arg11: u8, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        if (arg1.leader_stamp_id != 0x2::object::id_from_address(@0x0)) {
            assert!(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::has_stamp(arg0, arg1.leader_stamp_id), 13906834771343835135);
        };
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::stamp_with_data(arg0, &witness(arg1).id, b"lilypad_round_played");
        let v0 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::match_id(arg3);
        let v1 = 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::game_caps::borrow_cap(arg2, 0x2::object::id_to_address(&v0));
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::game_caps::assert_execution(arg2, 0x2::object::id_to_address(&v0), 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::game_caps::execution_id_from_worksheet(arg0));
        if (!0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::active(arg3)) {
            return make_finished_output(arg3)
        };
        if ((0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::round(arg3) as u64) != arg12) {
            if (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::active(arg3)) {
                return make_continue_output(arg3)
            };
            return make_finished_output(arg3)
        };
        let (v2, v3, v4) = normalize_agent_input(arg3, 0, 1, arg4, arg6, arg7);
        let (v5, v6, v7) = normalize_agent_input(arg3, 1, 0, arg8, arg10, arg11);
        let v8 = derive_rng_bytes(arg3, arg14);
        0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::submit_action_seeded(arg3, v1, 0, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_from_u8(v2), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::emotion_from_u8(arg5), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::signal_from_u8(v3), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_from_u8(v4), b"", 0, &v8, arg13);
        0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::submit_action_seeded(arg3, v1, 1, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::action_from_u8(v5), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::emotion_from_u8(arg9), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::signal_from_u8(v6), 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::guess_from_u8(v7), b"", 0, &v8, arg13);
        if (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::active(arg3)) {
            make_continue_output(arg3)
        } else {
            make_finished_output(arg3)
        }
    }

    fun init(arg0: LILYPAD_TOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg1);
        let v1 = LilypadToolWitness{id: 0x2::object::new(arg1)};
        0x2::bag::add<vector<u8>, LilypadToolWitness>(&mut v0, b"witness", v1);
        let v2 = LilypadToolState{
            id              : 0x2::object::new(arg1),
            witness         : v0,
            leader_stamp_id : 0x2::object::id_from_address(@0x0),
        };
        0x2::transfer::share_object<LilypadToolState>(v2);
        let v3 = LilypadToolAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<LilypadToolAdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    fun make_continue_output(arg0: &0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::Match) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"continue"), b"state_0", 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::raw_json_payload(build_state_json(arg0, 0, 1))), b"state_1", 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::raw_json_payload(build_state_json(arg0, 1, 0)))
    }

    fun make_finished_output(arg0: &0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::Match) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        let v0 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::round_history(arg0);
        let v1 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extras(arg0);
        let v2 = 0x1::vector::length<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::CompactRound>(v0);
        let v3 = b"[";
        let v4 = 0;
        while (v4 < v2) {
            let v5 = 0x1::vector::borrow<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::CompactRound>(v0, v4);
            let v6 = 0x1::vector::borrow<0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::ReplayExtra>(v1, v4);
            0x1::vector::append<u8>(&mut v3, b"[");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_round(v5) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_action(v5, 0) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_action(v5, 1) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_emotion(v6, 0) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_emotion(v6, 1) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_focus_score(v6, 0) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_focus_score(v6, 1) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_signal(v6, 0) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_signal(v6, 1) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_guess(v6, 0) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_guess(v6, 1) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_damage(v5, 0));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_damage(v5, 1));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_hp_after(v5, 0));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_hp_after(v5, 1));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_attack_result(v5, 0) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_attack_result(v5, 1) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_defend_result(v6, 0) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_defend_result(v6, 1) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_block_pct(v6, 0));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_block_pct(v6, 1));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_first_actor(v5) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_call_success(v6, 0) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_call_success(v6, 1) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            let v7 = if (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_bluff_caught(v5, 0)) {
                1
            } else {
                0
            };
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, v7);
            0x1::vector::append<u8>(&mut v3, b",");
            let v8 = if (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::compact_round_bluff_caught(v5, 1)) {
                1
            } else {
                0
            };
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, v8);
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_reward_applied(v6, 0) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_reward_applied(v6, 1) as u64));
            0x1::vector::append<u8>(&mut v3, b",");
            let v9 = if (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_charge_vulnerable(v6, 0)) {
                1
            } else {
                0
            };
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, v9);
            0x1::vector::append<u8>(&mut v3, b",");
            let v10 = if (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::replay_extra_charge_vulnerable(v6, 1)) {
                1
            } else {
                0
            };
            0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v3, v10);
            0x1::vector::append<u8>(&mut v3, b"]");
            if (v4 + 1 < v2) {
                0x1::vector::append<u8>(&mut v3, b",");
            };
            v4 = v4 + 1;
        };
        0x1::vector::append<u8>(&mut v3, b"]");
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"finished"), b"winner", 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::num_payload((0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::winner(arg0) as u64))), b"final_hp_0", 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::num_payload(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_hp(arg0, 0))), b"final_hp_1", 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::num_payload(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_hp(arg0, 1))), b"total_rounds", 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::num_payload(((0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::round(arg0) - 1) as u64))), b"replay", 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::raw_json_payload(v3))
    }

    fun normalize_agent_input(arg0: &0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::Match, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) : (u8, u8, u8) {
        let v0 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_fp_left(arg0, arg1);
        let v1 = arg3;
        let v2 = arg4;
        let v3 = arg5;
        if (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_charging(arg0, arg1)) {
            v1 = 255;
            v2 = 0;
        } else {
            let v4 = if (arg3 == 255) {
                true
            } else if (arg3 != 0) {
                if (arg3 != 1) {
                    arg3 != 2
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                v1 = 0;
            };
            let v5 = if (v1 == 1 || v1 == 2) {
                1
            } else {
                0
            };
            let v6 = if (arg5 != 0) {
                1
            } else {
                0
            };
            if ((v1 == 1 || v1 == 2) && v0 < v5 + v6) {
                if (v0 < 1) {
                    v1 = 0;
                    v2 = 0;
                } else if (arg5 != 0 && v0 < 2) {
                    v3 = 0;
                };
            };
            if (v1 == 0) {
                v2 = 0;
            };
            if ((v1 == 1 || v1 == 2) && v2 == 0) {
                let v7 = if (v1 == 1) {
                    2
                } else {
                    1
                };
                v2 = v7;
            };
        };
        if (v3 != 0) {
            let v8 = if (v1 == 1 || v1 == 2) {
                1
            } else {
                0
            };
            if (v0 < v8 + 1) {
                v3 = 0;
            };
            if (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::types::signal_to_u8(0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::fighter_last_signal(arg0, arg2)) == 0) {
                v3 = 0;
            };
        };
        (v1, v2, v3)
    }

    fun witness(arg0: &LilypadToolState) : &LilypadToolWitness {
        0x2::bag::borrow<vector<u8>, LilypadToolWitness>(&arg0.witness, b"witness")
    }

    public fun witness_id(arg0: &LilypadToolState) : 0x2::object::ID {
        0x2::object::uid_to_inner(&witness(arg0).id)
    }

    // decompiled from Move bytecode v7
}

