module 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result {
    struct OnchainToolResult has key {
        id: 0x2::object::UID,
    }

    struct OnchainToolResultInnerV1 has store {
        execution_id: 0x2::object::ID,
        finalized: bool,
        stamps: 0x1::option::Option<0x2::vec_map::VecMap<0x2::object::ID, vector<u8>>>,
        tag: 0x1::option::Option<vector<u8>>,
        named_payload: 0x1::option::Option<0x2::vec_map::VecMap<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>>,
        finalize_tx_digest: 0x1::option::Option<vector<u8>>,
        finalize_recipient: 0x1::option::Option<address>,
    }

    struct InputCommitmentKey has copy, drop, store {
        dummy_field: bool,
    }

    struct InputCommitment has store {
        bytes: vector<u8>,
    }

    public fun id(arg0: &OnchainToolResult) : 0x2::object::ID {
        0x2::object::id<OnchainToolResult>(arg0)
    }

    public fun new(arg0: &0x2::object::UID, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg2: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorizationStamp, arg3: &mut 0x2::tx_context::TxContext) : OnchainToolResult {
        let v0 = 0x2::object::uid_to_inner(arg0);
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(arg1) == v0, 13906834513645797377);
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::has_stamp(arg1, v0), 13906834517940895747);
        let v1 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::worksheet_input_commitment(arg1, arg2);
        assert!(0x1::vector::length<u8>(&v1) == 32, 13906834526531354635);
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::stamps_len(arg1) == 2, 13906834539415863301);
        let v2 = OnchainToolResult{id: 0x2::object::new(arg3)};
        let v3 = OnchainToolResultInnerV1{
            execution_id       : v0,
            finalized          : false,
            stamps             : 0x1::option::none<0x2::vec_map::VecMap<0x2::object::ID, vector<u8>>>(),
            tag                : 0x1::option::none<vector<u8>>(),
            named_payload      : 0x1::option::none<0x2::vec_map::VecMap<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>>(),
            finalize_tx_digest : 0x1::option::none<vector<u8>>(),
            finalize_recipient : 0x1::option::none<address>(),
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::add<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1, OnchainToolResultInnerV1>(&mut v2.id, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::v1(), v3);
        let v4 = InputCommitmentKey{dummy_field: false};
        let v5 = InputCommitment{bytes: v1};
        0x2::dynamic_field::add<InputCommitmentKey, InputCommitment>(&mut v2.id, v4, v5);
        v2
    }

    public fun consume(arg0: OnchainToolResult, arg1: &0x2::object::UID) : (0x2::vec_map::VecMap<0x2::object::ID, vector<u8>>, vector<u8>, 0x2::vec_map::VecMap<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>, vector<u8>, address) {
        let OnchainToolResult { id: v0 } = arg0;
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::assert_witness<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1>(&v0);
        let v1 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner<OnchainToolResultInnerV1>(&v0);
        assert!(0x2::object::uid_to_inner(arg1) == v1.execution_id, 13906834784228737025);
        assert!(v1.finalized, 13906834788524228617);
        let v2 = InputCommitmentKey{dummy_field: false};
        let InputCommitment {  } = 0x2::dynamic_field::remove<InputCommitmentKey, InputCommitment>(&mut v0, v2);
        let OnchainToolResultInnerV1 {
            execution_id       : _,
            finalized          : _,
            stamps             : v5,
            tag                : v6,
            named_payload      : v7,
            finalize_tx_digest : v8,
            finalize_recipient : v9,
        } = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::destroy<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1, OnchainToolResultInnerV1>(v0);
        (0x1::option::destroy_some<0x2::vec_map::VecMap<0x2::object::ID, vector<u8>>>(v5), 0x1::option::destroy_some<vector<u8>>(v6), 0x1::option::destroy_some<0x2::vec_map::VecMap<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>>(v7), 0x1::option::destroy_some<vector<u8>>(v8), 0x1::option::destroy_some<address>(v9))
    }

    public fun execution_id(arg0: &OnchainToolResult) : 0x2::object::ID {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner<OnchainToolResultInnerV1>(&arg0.id).execution_id
    }

    public fun finalize_and_share(arg0: OnchainToolResult, arg1: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::UIDRequirements, arg2: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::TaggedOutput, arg3: &mut 0x2::tx_context::TxContext) {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::assert_witness<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1>(&arg0.id);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::satisfy(&mut arg1, &arg0.id);
        let (v0, v1) = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::into_parts(arg2);
        let v2 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1, OnchainToolResultInnerV1>(&mut arg0.id);
        assert!(!v2.finalized, 13906834706919718919);
        v2.stamps = 0x1::option::some<0x2::vec_map::VecMap<0x2::object::ID, vector<u8>>>(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::complete(arg1));
        v2.tag = 0x1::option::some<vector<u8>>(v0);
        v2.named_payload = 0x1::option::some<0x2::vec_map::VecMap<vector<u8>, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>>(v1);
        v2.finalize_tx_digest = 0x1::option::some<vector<u8>>(*0x2::tx_context::digest(arg3));
        v2.finalize_recipient = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        v2.finalized = true;
        0x2::transfer::share_object<OnchainToolResult>(arg0);
    }

    public fun input_commitment(arg0: &OnchainToolResult) : vector<u8> {
        let v0 = InputCommitmentKey{dummy_field: false};
        0x2::dynamic_field::borrow<InputCommitmentKey, InputCommitment>(&arg0.id, v0).bytes
    }

    public fun is_finalized(arg0: &OnchainToolResult) : bool {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner<OnchainToolResultInnerV1>(&arg0.id).finalized
    }

    // decompiled from Move bytecode v7
}

