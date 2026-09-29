module 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::terminal_gate {
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
        binding: 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::PredictBindingV1,
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

    fun binding_bytes_from_terminal(arg0: &vector<u8>) : vector<u8> {
        let v0 = 2;
        let v1 = b"";
        while (v0 < v0 + 283) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v0));
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun decision_cancel() : u8 {
        1
    }

    public(friend) fun decision_lock() : u8 {
        0
    }

    public(friend) fun decode_terminal(arg0: vector<u8>) : PredictTerminalV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_u16(&mut v0);
        assert!(v1 == 1, 13906835355459911689);
        let v2 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v2 == 0 || v2 == 1, 13906835376934879243);
        let v3 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::peel_option_id32(&mut v0);
        if (v2 == 0) {
            assert!(0x1::option::is_some<vector<u8>>(&v3), 13906835389819912205);
        } else {
            assert!(0x1::option::is_none<vector<u8>>(&v3), 13906835398409846797);
        };
        0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::assert_consumed(v0);
        PredictTerminalV1{
            version                : v1,
            binding                : 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::peel_binding(&mut v0),
            llm_ownership_epoch    : 0x2::bcs::peel_u64(&mut v0),
            decision_sequence      : 0x2::bcs::peel_u64(&mut v0),
            decision               : v2,
            frontier_digest        : v3,
            cutoff_evidence_digest : 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::peel_id32(&mut v0),
            reason                 : 0x2::bcs::peel_u16(&mut v0),
        }
    }

    fun install_terminal(arg0: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: PredictTerminalV1, arg2: vector<u8>) {
        let v0 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::record_digest(b"predict_attested_execution_v1", binding_bytes_from_terminal(&arg2));
        let v1 = if (0x1::option::is_some<vector<u8>>(&arg1.frontier_digest)) {
            *0x1::option::borrow<vector<u8>>(&arg1.frontier_digest)
        } else {
            b""
        };
        let v2 = DecisionSeqKey{
            execution_id      : 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::binding_execution_id(&arg1.binding),
            llm_epoch         : arg1.llm_ownership_epoch,
            decision_sequence : arg1.decision_sequence,
        };
        let v3 = TerminalKey{binding_digest: v0};
        let v4 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid_mut(arg0);
        if (0x2::dynamic_field::exists_with_type<TerminalKey, PredictTerminalRowV1>(v4, v3)) {
            assert!(0x2::dynamic_field::borrow<TerminalKey, PredictTerminalRowV1>(v4, v3).terminal_bytes == arg2, 13906834960323837975);
            return
        };
        if (0x2::dynamic_field::exists_with_type<DecisionSeqKey, vector<u8>>(v4, v2)) {
            assert!(*0x2::dynamic_field::borrow<DecisionSeqKey, vector<u8>>(v4, v2) == v0, 13906834981798674455);
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

    public fun is_cancelled(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) : bool {
        let v0 = TerminalKey{binding_digest: arg1};
        if (!0x2::dynamic_field::exists_with_type<TerminalKey, PredictTerminalRowV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid(arg0), v0)) {
            return false
        };
        0x2::dynamic_field::borrow<TerminalKey, PredictTerminalRowV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid(arg0), v0).decision == 1
    }

    public fun publish_terminal(arg0: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = decode_terminal(arg2);
        0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::assert_deployment_identity(arg0, 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::binding_chain_id(&v0.binding), 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::binding_environment_id(&v0.binding), 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::binding_package_id(&v0.binding));
        let v1 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::binding_execution_id(&v0.binding);
        assert!(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::has_llm_fence(arg0, v1), 13906834651085668367);
        let v2 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::llm_fence_epoch(arg0, v1);
        assert!(v0.llm_ownership_epoch == v2, 13906834659675734033);
        let v3 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::llm_fresh_key(arg0, v1);
        let v4 = b"dopan180/predict-llm-terminal-v1";
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_nitro_registration(arg1, &v3, &v4, 0x2::clock::timestamp_ms(arg5)), 13906834702625669141);
        verify_llm_envelope(arg3, arg4, 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::record_digest(b"dopa_predict::llm_terminal_v1", arg2), v1, v2, v3);
        install_terminal(arg0, v0, arg2);
    }

    public fun require_cancelled(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) {
        assert!(is_cancelled(arg0, arg1), 13906835329691287579);
    }

    public fun require_endorsement(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = TerminalKey{binding_digest: arg1};
        assert!(0x2::dynamic_field::exists_with_type<TerminalKey, PredictTerminalRowV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid(arg0), v0), 13906835200842137625);
        let v1 = 0x2::dynamic_field::borrow<TerminalKey, PredictTerminalRowV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid(arg0), v0);
        assert!(v1.decision == 0, 13906835226611941401);
        assert!(v1.frontier_digest == arg2, 13906835230906908697);
    }

    public(friend) fun terminal_binding_execution_id(arg0: &PredictTerminalV1) : vector<u8> {
        0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::binding_execution_id(&arg0.binding)
    }

    public(friend) fun terminal_binding_window_id(arg0: &PredictTerminalV1) : u64 {
        0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::binding_window_id(&arg0.binding)
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
        let (v1, v2, v3, _, v5, v6) = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::peel_signature_envelope(&mut v0);
        0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::assert_consumed(v0);
        assert!(v1 == arg2, 13906834784230572061);
        assert!(v2 == 2, 13906834788525539357);
        assert!(v3 == arg3, 13906834792820506653);
        assert!(v5 == arg4, 13906834797114687505);
        assert!(v6 == arg5, 13906834801410441245);
        let v7 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership::record_digest(b"dopa_predict::runtime_signature_v1", arg0);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(0, &arg5, &v7, &arg1), 13906834818589655059);
    }

    // decompiled from Move bytecode v7
}

