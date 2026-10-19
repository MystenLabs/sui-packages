module 0xe0685f2b876c6a35ff5cd395799ee05f7bb8d93abc48e34c28c0a4870f6bc7af::authorize {
    public(friend) fun authorized_output(arg0: 0x2::object::ID, arg1: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg2: vector<u8>) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::TaggedOutput {
        let v0 = b"{\"allowance_id\":";
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(0x1::option::destroy_some<u64>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::llm_allowance::allowance_by_id(arg1, arg0)))));
        0x1::vector::append<u8>(&mut v0, b",\"kind\":\"grant\",\"operation\":\"");
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, b"\"}");
        let v1 = b"\"0x";
        let v2 = 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg1);
        0x1::vector::append<u8>(&mut v1, 0x1::ascii::into_bytes(0x2::address::to_ascii_string(0x2::object::id_to_address(&v2))));
        0x1::vector::append<u8>(&mut v1, b"\"");
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::new(b"authorized"), b"auth", 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(v0)), b"identity_id", 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(v1))
    }

    public fun execute(arg0: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::ProvenValue<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorization>, arg1: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::UIDRequirements, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::OnchainToolResult, arg3: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg4: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: &0xe0685f2b876c6a35ff5cd395799ee05f7bb8d93abc48e34c28c0a4870f6bc7af::adapter::Registry, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        run<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun fqn() : 0x1::ascii::String {
        0x1::ascii::string(b"tech.daimon.authorize@1")
    }

    fun is_label_byte(arg0: u8) : bool {
        if (arg0 >= 97 && arg0 <= 122) {
            true
        } else if (arg0 >= 48 && arg0 <= 57) {
            true
        } else {
            arg0 == 95
        }
    }

    public(friend) fun run<T0>(arg0: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::ProvenValue<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorization>, arg1: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::UIDRequirements, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::OnchainToolResult, arg3: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg4: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: &0xe0685f2b876c6a35ff5cd395799ee05f7bb8d93abc48e34c28c0a4870f6bc7af::adapter::Registry, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg9;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            assert!(is_label_byte(*0x1::vector::borrow<u8>(v0, v1)), 404);
            v1 = v1 + 1;
        };
        0xe0685f2b876c6a35ff5cd395799ee05f7bb8d93abc48e34c28c0a4870f6bc7af::adapter::reserve_verified<T0>(arg0, &arg1, &arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::satisfy(&mut arg1, 0xe0685f2b876c6a35ff5cd395799ee05f7bb8d93abc48e34c28c0a4870f6bc7af::adapter::witness_uid(arg12));
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::finalize_and_share(arg2, arg1, authorized_output(arg5, arg3, arg9), arg14);
    }

    // decompiled from Move bytecode v7
}

