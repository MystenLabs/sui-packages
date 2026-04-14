module 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::create_match_tool {
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

    public fun configure_leader_stamp(arg0: &CreateMatchAdminCap, arg1: &mut CreateMatchState, arg2: 0x2::object::ID) {
        arg1.leader_stamp_id = arg2;
    }

    public fun execute(arg0: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::ProofOfUID, arg1: &mut CreateMatchState, arg2: &mut 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::game_caps::GameCapStore, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        if (arg1.leader_stamp_id != 0x2::object::id_from_address(@0x0)) {
            assert!(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::has_stamp(arg0, arg1.leader_stamp_id), 13906834612430045183);
        };
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::stamp_with_data(arg0, &witness(arg1).id, b"texas_holdem_match_created");
        let (v0, v1) = 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::game::new_match((arg3 as u32), (arg4 as u32), (arg5 as u32), (arg6 as u32), (arg7 as u32), arg8, arg9);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::game::game_cap_game_id(&v3);
        0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::game_caps::store_cap(arg2, 0x2::object::id_to_address(&v4), v3, 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::game_caps::execution_id_from_worksheet(arg0));
        0x2::transfer::public_share_object<0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::game::Match>(v2);
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"ok"), b"match_id", 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::utils::addr_payload(0x2::object::id_to_address(&v4))), b"state", 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::utils::raw_json_payload(0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::play_hand_tool::build_state_json(&v2, 0x924425100857c3afc9cb997bebd0d58c4c5092cb90220241af027834721cf241::game::to_act(&v2))))
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

