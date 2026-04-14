module 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::create_match_tool {
    struct CREATE_MATCH_TOOL has drop {
        dummy_field: bool,
    }

    struct CreateMatchAdminCap has key {
        id: 0x2::object::UID,
    }

    struct CreateMatchWitness has store, key {
        id: 0x2::object::UID,
    }

    struct CreateMatchState has key {
        id: 0x2::object::UID,
        witness: 0x2::bag::Bag,
        leader_stamp_id: 0x2::object::ID,
    }

    fun build_initial_state_json(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u32, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8) : vector<u8> {
        let v0 = arg0 * arg9;
        let v1 = b"{\"own\":[";
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, v0);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, v0);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, arg1 * arg9);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, arg2 * arg9);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, arg3 * arg9);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, arg10);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, (arg5 as u64));
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, (arg4 as u64));
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 255);
        0x1::vector::append<u8>(&mut v1, b"],\"opp\":[");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, arg10);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::stat_cmp(arg6, arg1));
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::stat_cmp(arg7, arg2));
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::stat_cmp(arg8, arg3));
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, b",");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, b"],\"round\":1,\"fighter_id\":");
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::append_num(&mut v1, (arg11 as u64));
        0x1::vector::append<u8>(&mut v1, b",\"history\":[]}");
        v1
    }

    public fun configure_leader_stamp(arg0: &CreateMatchAdminCap, arg1: &mut CreateMatchState, arg2: 0x2::object::ID) {
        arg1.leader_stamp_id = arg2;
    }

    public fun execute(arg0: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::ProofOfUID, arg1: &mut CreateMatchState, arg2: &mut 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::game_caps::GameCapStore, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: u8, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u32, arg15: u8, arg16: u8, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        if (arg1.leader_stamp_id != 0x2::object::id_from_address(@0x0)) {
            assert!(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::has_stamp(arg0, arg1.leader_stamp_id), 13906834754163965951);
        };
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::stamp_with_data(arg0, &witness(arg1).id, b"lilypad_match_created");
        let v0 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::create_match_with_cap(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v1 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::game::game_cap_game_id(&v0);
        0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::game_caps::store_cap(arg2, 0x2::object::id_to_address(&v1), v0, 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::game_caps::execution_id_from_worksheet(arg0));
        let v2 = 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math::scale();
        let v3 = (0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::combat::max_fp() as u64);
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"ok"), b"match_id", 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::as_address(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::inline_one(0x1::string::into_bytes(0x2::address::to_string(0x2::object::id_to_address(&v1)))))), b"state_0", 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::raw_json_payload(build_initial_state_json(arg3, arg4, arg5, arg6, arg7, arg9, arg11, arg12, arg13, v2, v3, 0))), b"state_1", 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils::raw_json_payload(build_initial_state_json(arg10, arg11, arg12, arg13, arg14, arg16, arg4, arg5, arg6, v2, v3, 1)))
    }

    fun init(arg0: CREATE_MATCH_TOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg1);
        let v1 = CreateMatchWitness{id: 0x2::object::new(arg1)};
        0x2::bag::add<vector<u8>, CreateMatchWitness>(&mut v0, b"witness", v1);
        let v2 = CreateMatchState{
            id              : 0x2::object::new(arg1),
            witness         : v0,
            leader_stamp_id : 0x2::object::id_from_address(@0x0),
        };
        0x2::transfer::share_object<CreateMatchState>(v2);
        let v3 = CreateMatchAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CreateMatchAdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    fun witness(arg0: &CreateMatchState) : &CreateMatchWitness {
        0x2::bag::borrow<vector<u8>, CreateMatchWitness>(&arg0.witness, b"witness")
    }

    public fun witness_id(arg0: &CreateMatchState) : 0x2::object::ID {
        0x2::object::uid_to_inner(&witness(arg0).id)
    }

    // decompiled from Move bytecode v7
}

