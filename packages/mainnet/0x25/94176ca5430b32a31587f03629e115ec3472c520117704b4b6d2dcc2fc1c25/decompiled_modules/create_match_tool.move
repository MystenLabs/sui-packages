module 0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::create_match_tool {
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

    public fun execute(arg0: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::ProofOfUID, arg1: &mut CreateMatchState, arg2: &mut 0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::game_caps::GameCapStore, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: u64, arg13: &0x2::clock::Clock, arg14: u64, arg15: u8, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        if (arg1.leader_stamp_id != 0x2::object::id_from_address(@0x0)) {
            assert!(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::has_stamp(arg0, arg1.leader_stamp_id), 13906834784228737025);
        };
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::stamp_with_data(arg0, &witness(arg1).id, b"texas_holdem_match_created");
        let (v0, v1) = if (arg14 == 0) {
            let v2 = if (arg15 == 0) {
                if (arg16 == 0) {
                    arg17 == 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v2, 13906834840063442947);
            0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::game::new_match((arg3 as u32), (arg4 as u32), (arg5 as u32), (arg6 as u32), (arg7 as u32), arg8, (arg9 as u32), (arg12 as u32), arg10, arg11, arg13, arg18)
        } else {
            let v3 = 0x1::vector::empty<u32>();
            let v4 = &mut v3;
            0x1::vector::push_back<u32>(v4, (arg16 as u32));
            0x1::vector::push_back<u32>(v4, (arg17 as u32));
            0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::game::new_match_from_snapshot((arg3 as u32), (arg4 as u32), (arg5 as u32), (arg6 as u32), (arg7 as u32), arg8, (arg9 as u32), (arg12 as u32), arg10, arg11, v3, arg15, (arg14 as u32), arg13, arg18)
        };
        let v5 = v1;
        let v6 = v0;
        let v7 = 0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::game::game_cap_game_id(&v6);
        0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::game_caps::store_cap(arg2, 0x2::object::id_to_address(&v7), v6, 0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::game_caps::execution_id_from_worksheet(arg0));
        0x2::transfer::public_share_object<0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::game::Match>(v5);
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"ok"), b"match_id", 0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::utils::addr_payload(0x2::object::id_to_address(&v7))), b"state", 0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::utils::raw_json_payload(0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::play_hand_tool::build_state_json(&v5, 0x2594176ca5430b32a31587f03629e115ec3472c520117704b4b6d2dcc2fc1c25::game::to_act(&v5))))
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

