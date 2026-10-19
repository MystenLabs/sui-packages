module 0xe0685f2b876c6a35ff5cd395799ee05f7bb8d93abc48e34c28c0a4870f6bc7af::adapter {
    struct Charger has drop {
        dummy_field: bool,
    }

    struct ChargerV2 has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
    }

    fun bytes_many(arg0: &vector<u8>) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment {
        let v0 = 0x1::vector::empty<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue>(&mut v0, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u64::to_string((*0x1::vector::borrow<u8>(arg0, v1) as u64)))));
            v1 = v1 + 1;
        };
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_many(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v0);
    }

    fun input_commitment_of(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &vector<u8>, arg4: u64, arg5: u64, arg6: &vector<u8>, arg7: &vector<u8>, arg8: u64, arg9: 0x2::object::ID, arg10: 0x2::object::ID) : vector<u8> {
        let v0 = 0x1::vector::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, obj(arg0));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, obj(arg1));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, obj(arg2));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, bytes_many(arg3));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, num(arg4));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, num(arg5));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, bytes_many(arg6));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, bytes_many(arg7));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, num(arg8));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, obj(arg9));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v1, obj(arg10));
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::input_hash(port_names(), v0)
    }

    fun num(arg0: u64) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment {
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u64::to_string(arg0)));
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v0)
    }

    fun obj(arg0: 0x2::object::ID) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment {
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::object_value(arg0);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v0)
    }

    fun port_names() : vector<vector<u8>> {
        vector[b"0", b"1", b"2", b"3", b"4", b"5", b"6", b"7", b"8", b"9", b"10"]
    }

    public(friend) fun reserve_verified<T0>(arg0: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::ProvenValue<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorization>, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::UIDRequirements, arg2: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::OnchainToolResult, arg3: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg4: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: &Registry, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::type_name(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::proof(arg1)) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>()), 401);
        let v0 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::execution_id(arg2);
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::proof(arg1)) == v0, 402);
        assert!(!0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::is_finalized(arg2), 405);
        let v1 = input_commitment_of(0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg3), 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config>(arg4), arg5, &arg6, arg7, arg8, &arg9, &arg10, arg11, 0x2::object::id<Registry>(arg12), 0x2::object::id<0x2::clock::Clock>(arg13));
        assert!(v1 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::input_commitment(arg2), 406);
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::consume_verified_for_worksheet_as_recipient(arg0, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::proof(arg1), 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::identity(arg3), v1), 403);
        let v2 = ChargerV2{dummy_field: false};
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::llm_allowance::reserve_grant<T0, ChargerV2>(v2, arg4, arg3, arg5, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::by<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorization>(&arg0), v0, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::tool_invocation_nonce(v0, arg7, arg6, arg8), arg9, arg10, arg11, b"", arg13, arg14);
    }

    public(friend) fun witness_uid(arg0: &Registry) : &0x2::object::UID {
        &arg0.id
    }

    // decompiled from Move bytecode v7
}

