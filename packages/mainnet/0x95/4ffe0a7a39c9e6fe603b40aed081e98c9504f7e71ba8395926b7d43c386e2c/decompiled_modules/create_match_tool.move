module 0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::create_match_tool {
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

    fun build_initial_state_json(arg0: u32, arg1: u32, arg2: u8) : vector<u8> {
        let v0 = if (arg1 / 2 > 0) {
            arg1 / 2
        } else {
            1
        };
        let v1 = if (v0 <= arg0) {
            v0
        } else {
            arg0
        };
        let v2 = arg0 - v1;
        let v3 = if (arg1 <= arg0) {
            arg1
        } else {
            arg0
        };
        let v4 = arg0 - v3;
        let v5 = b"{\"hand_index\":1,\"button\":0,\"street\":0";
        0x1::vector::append<u8>(&mut v5, b",\"small_blind\":");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, v0);
        0x1::vector::append<u8>(&mut v5, b",\"big_blind\":");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, arg1);
        0x1::vector::append<u8>(&mut v5, b",\"pot\":");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, arg0 - v2 + arg0 - v4);
        0x1::vector::append<u8>(&mut v5, b",\"current_bet\":");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, arg1);
        0x1::vector::append<u8>(&mut v5, b",\"stacks\":[");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, v2);
        0x1::vector::append<u8>(&mut v5, b",");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, v4);
        0x1::vector::append<u8>(&mut v5, b"],\"my_seat\":");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num(&mut v5, (arg2 as u64));
        0x1::vector::append<u8>(&mut v5, b",\"to_act\":0");
        0x1::vector::append<u8>(&mut v5, b",\"my_hole_cards\":[],\"my_hole_names\":[],\"community_cards\":[],\"community_names\":[]");
        0x1::vector::append<u8>(&mut v5, b",\"round_bet\":[");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, arg0 - v2);
        0x1::vector::append<u8>(&mut v5, b",");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, arg0 - v4);
        0x1::vector::append<u8>(&mut v5, b"]");
        0x1::vector::append<u8>(&mut v5, b",\"last_full_raise_size\":");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, arg1);
        let v6 = arg1 + arg1;
        let (v7, v8) = if (arg0 >= v6) {
            (v6, arg0)
        } else if (arg0 > arg1) {
            (arg0, arg0)
        } else {
            (0, 0)
        };
        0x1::vector::append<u8>(&mut v5, b",\"legal\":{\"fold\":true,\"check\":false,\"call\":true,\"bet_min\":0,\"bet_max\":0,\"raise_min\":");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, v7);
        0x1::vector::append<u8>(&mut v5, b",\"raise_max\":");
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::append_num32(&mut v5, v8);
        0x1::vector::append<u8>(&mut v5, b"}");
        0x1::vector::append<u8>(&mut v5, b",\"action_log\":[],\"last_hand\":null,\"match_over\":false}");
        v5
    }

    public fun configure_leader_stamp(arg0: &CreateMatchAdminCap, arg1: &mut CreateMatchState, arg2: 0x2::object::ID) {
        arg1.leader_stamp_id = arg2;
    }

    public fun execute(arg0: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::ProofOfUID, arg1: &mut CreateMatchState, arg2: &mut 0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::game_caps::GameCapStore, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::TaggedOutput {
        if (arg1.leader_stamp_id != 0x2::object::id_from_address(@0x0)) {
            assert!(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::has_stamp(arg0, arg1.leader_stamp_id), 13906834608135077887);
        };
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::stamp_with_data(arg0, &witness(arg1).id, b"texas_holdem_match_created");
        let v0 = 0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::game::create_match((arg3 as u32), (arg4 as u32), (arg5 as u32), (arg6 as u32), (arg7 as u32), arg8, arg9);
        let v1 = 0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::game::game_cap_game_id(&v0);
        0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::game_caps::store_cap(arg2, 0x2::object::id_to_address(&v1), v0, 0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::game_caps::execution_id_from_worksheet(arg0));
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::with_named_payload(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output::new(b"ok"), b"match_id", 0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::addr_payload(0x2::object::id_to_address(&v1))), b"state", 0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils::raw_json_payload(build_initial_state_json((arg3 as u32), (arg4 as u32), 0)))
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

