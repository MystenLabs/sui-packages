module 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::terminal_gate {
    struct TerminalKey has copy, drop, store {
        binding_digest: vector<u8>,
    }

    struct DecisionSeqKey has copy, drop, store {
        execution_id: vector<u8>,
        llm_epoch: u64,
        decision_sequence: u64,
    }

    struct PredictTerminalRowV1 has store {
        decision: u8,
        frontier_digest: vector<u8>,
        llm_epoch: u64,
        decision_sequence: u64,
        profile_digest: vector<u8>,
        terminal_bytes: vector<u8>,
    }

    struct PredictTerminalV1 has copy, drop {
        version: u16,
        binding: 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::PredictBindingV1,
        llm_ownership_epoch: u64,
        decision_sequence: u64,
        decision: u8,
        frontier_digest: 0x1::option::Option<vector<u8>>,
        cutoff_evidence_digest: vector<u8>,
        reason: u16,
    }

    struct TerminalPublished has copy, drop {
        binding_digest: vector<u8>,
        decision: u8,
        frontier_digest: vector<u8>,
        llm_epoch: u64,
        decision_sequence: u64,
    }

    fun assert_canonical_store(arg0: 0x2::object::ID, arg1: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore) {
        assert!(arg0 == 0x2::object::id<0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore>(arg1), 13906835321101615135);
    }

    fun binding_bytes_from_terminal(arg0: &vector<u8>) : vector<u8> {
        let v0 = 2;
        let v1 = b"";
        while (v0 < v0 + 283) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v0));
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun decision_lock() : u8 {
        0
    }

    public(friend) fun decode_terminal(arg0: vector<u8>) : PredictTerminalV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_u16(&mut v0);
        assert!(v1 == 1, 13906835583093178377);
        let v2 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v2 == 0 || v2 == 1, 13906835604568145931);
        let v3 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::peel_option_id32(&mut v0);
        if (v2 == 0) {
            assert!(0x1::option::is_some<vector<u8>>(&v3), 13906835617453178893);
        } else {
            assert!(0x1::option::is_none<vector<u8>>(&v3), 13906835626043113485);
        };
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::assert_consumed(v0);
        PredictTerminalV1{
            version                : v1,
            binding                : 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::peel_binding(&mut v0),
            llm_ownership_epoch    : 0x2::bcs::peel_u64(&mut v0),
            decision_sequence      : 0x2::bcs::peel_u64(&mut v0),
            decision               : v2,
            frontier_digest        : v3,
            cutoff_evidence_digest : 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::peel_id32(&mut v0),
            reason                 : 0x2::bcs::peel_u16(&mut v0),
        }
    }

    fun install_terminal(arg0: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: PredictTerminalV1, arg2: vector<u8>) {
        let v0 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::record_digest(b"predict_attested_execution_v1", binding_bytes_from_terminal(&arg2));
        let v1 = if (0x1::option::is_some<vector<u8>>(&arg1.frontier_digest)) {
            *0x1::option::borrow<vector<u8>>(&arg1.frontier_digest)
        } else {
            b""
        };
        let v2 = DecisionSeqKey{
            execution_id      : 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_execution_id(&arg1.binding),
            llm_epoch         : arg1.llm_ownership_epoch,
            decision_sequence : arg1.decision_sequence,
        };
        let v3 = TerminalKey{binding_digest: v0};
        let v4 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::uid_mut(arg0);
        if (0x2::dynamic_field::exists_with_type<TerminalKey, PredictTerminalRowV1>(v4, v3)) {
            assert!(0x2::dynamic_field::borrow<TerminalKey, PredictTerminalRowV1>(v4, v3).terminal_bytes == arg2, 13906835102057758743);
            return
        };
        if (0x2::dynamic_field::exists_with_type<DecisionSeqKey, vector<u8>>(v4, v2)) {
            assert!(*0x2::dynamic_field::borrow<DecisionSeqKey, vector<u8>>(v4, v2) == v0, 13906835123532595223);
            return
        };
        0x2::dynamic_field::add<DecisionSeqKey, vector<u8>>(v4, v2, v0);
        let v5 = PredictTerminalRowV1{
            decision          : arg1.decision,
            frontier_digest   : v1,
            llm_epoch         : arg1.llm_ownership_epoch,
            decision_sequence : arg1.decision_sequence,
            profile_digest    : b"",
            terminal_bytes    : arg2,
        };
        0x2::dynamic_field::add<TerminalKey, PredictTerminalRowV1>(v4, v3, v5);
        let v6 = TerminalPublished{
            binding_digest    : v0,
            decision          : arg1.decision,
            frontier_digest   : v1,
            llm_epoch         : arg1.llm_ownership_epoch,
            decision_sequence : arg1.decision_sequence,
        };
        0x2::event::emit<TerminalPublished>(v6);
    }

    public fun is_cancelled(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: 0x2::object::ID, arg2: vector<u8>) : bool {
        assert_canonical_store(arg1, arg0);
        let v0 = TerminalKey{binding_digest: arg2};
        if (!0x2::dynamic_field::exists_with_type<TerminalKey, PredictTerminalRowV1>(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::uid(arg0), v0)) {
            return false
        };
        0x2::dynamic_field::borrow<TerminalKey, PredictTerminalRowV1>(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::uid(arg0), v0).decision == 1
    }

    public fun publish_terminal(arg0: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg2: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_admitted_version(arg0);
        assert_canonical_store(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::frontier_store_id(arg2), arg0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::assert_terminal_registry_is_canonical(arg0, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>>(arg1));
        let v0 = decode_terminal(arg3);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::assert_deployment_identity(arg0, 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_chain_id(&v0.binding), 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_environment_id(&v0.binding), 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_package_id(&v0.binding));
        let v1 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_execution_id(&v0.binding);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::has_llm_fence(arg0, v1), 13906834792819589135);
        let v2 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::llm_fence_epoch(arg0, v1);
        assert!(v0.llm_ownership_epoch == v2, 13906834801409654801);
        let v3 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::llm_fresh_key(arg0, v1);
        let v4 = b"dopan180/predict-llm-terminal-v1";
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_nitro_registration(arg1, &v3, &v4, 0x2::clock::timestamp_ms(arg6)), 13906834844359589909);
        verify_llm_envelope(arg4, arg5, 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::record_digest(b"dopa_predict::llm_terminal_v1", arg3), v1, v2, v3);
        install_terminal(arg0, v0, arg3);
    }

    public fun require_cancelled(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: 0x2::object::ID, arg2: vector<u8>) {
        assert!(is_cancelled(arg0, arg1, arg2), 13906835557324554267);
    }

    public fun require_endorsement(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::FrontierCommitmentStore, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>) {
        assert_canonical_store(arg1, arg0);
        let v0 = TerminalKey{binding_digest: arg2};
        assert!(0x2::dynamic_field::exists_with_type<TerminalKey, PredictTerminalRowV1>(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::uid(arg0), v0), 13906835389820698649);
        let v1 = 0x2::dynamic_field::borrow<TerminalKey, PredictTerminalRowV1>(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment::uid(arg0), v0);
        assert!(v1.decision == 0, 13906835415590502425);
        assert!(v1.frontier_digest == arg3, 13906835419885469721);
    }

    public(friend) fun terminal_binding_execution_id(arg0: &PredictTerminalV1) : vector<u8> {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_execution_id(&arg0.binding)
    }

    public(friend) fun terminal_binding_window_id(arg0: &PredictTerminalV1) : u64 {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::binding_window_id(&arg0.binding)
    }

    public(friend) fun terminal_cutoff_digest(arg0: &PredictTerminalV1) : vector<u8> {
        arg0.cutoff_evidence_digest
    }

    public(friend) fun terminal_decision(arg0: &PredictTerminalV1) : u8 {
        arg0.decision
    }

    public(friend) fun terminal_frontier(arg0: &PredictTerminalV1) : 0x1::option::Option<vector<u8>> {
        arg0.frontier_digest
    }

    public(friend) fun terminal_llm_epoch(arg0: &PredictTerminalV1) : u64 {
        arg0.llm_ownership_epoch
    }

    public(friend) fun terminal_reason(arg0: &PredictTerminalV1) : u16 {
        arg0.reason
    }

    public(friend) fun terminal_sequence(arg0: &PredictTerminalV1) : u64 {
        arg0.decision_sequence
    }

    public(friend) fun terminal_version(arg0: &PredictTerminalV1) : u16 {
        arg0.version
    }

    fun verify_llm_envelope(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) {
        let v0 = 0x2::bcs::new(arg0);
        let (v1, v2, v3, _, v5, v6) = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::peel_signature_envelope(&mut v0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::assert_consumed(v0);
        assert!(v1 == arg2, 13906834925964492829);
        assert!(v2 == 2, 13906834930259460125);
        assert!(v3 == arg3, 13906834934554427421);
        assert!(v5 == arg4, 13906834938848608273);
        assert!(v6 == arg5, 13906834943144362013);
        let v7 = 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::ownership::record_digest(b"dopa_predict::runtime_signature_v1", arg0);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(0, &arg5, &v7, &arg1), 13906834960323575827);
    }

    // decompiled from Move bytecode v7
}

