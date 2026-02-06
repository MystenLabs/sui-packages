module 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events {
    struct HiveCreated has copy, drop {
        hive_id: 0x2::object::ID,
        name: vector<u8>,
        creator: address,
        initial_threshold: u16,
        created_at: u64,
    }

    struct HiveParametersUpdated has copy, drop {
        hive_id: 0x2::object::ID,
        new_threshold: u16,
        updated_by: address,
        updated_at: u64,
    }

    struct MemberJoined has copy, drop {
        hive_id: 0x2::object::ID,
        member: address,
        agent_id: 0x1::option::Option<0x2::object::ID>,
        weight: u64,
        joined_at: u64,
    }

    struct MemberWeightUpdated has copy, drop {
        hive_id: 0x2::object::ID,
        member: address,
        old_weight: u64,
        new_weight: u64,
        updated_at: u64,
    }

    struct MemberSuspended has copy, drop {
        hive_id: 0x2::object::ID,
        member: address,
        reason: vector<u8>,
        suspended_at: u64,
    }

    struct MemberReinstated has copy, drop {
        hive_id: 0x2::object::ID,
        member: address,
        reinstated_at: u64,
    }

    struct MemberLeft has copy, drop {
        hive_id: 0x2::object::ID,
        member: address,
        voluntary: bool,
        stake_returned: u64,
        left_at: u64,
    }

    struct BlsKeyRegistered has copy, drop {
        hive_id: 0x2::object::ID,
        member: address,
        share_index: u64,
        registered_at: u64,
    }

    struct ProposalCreated has copy, drop {
        hive_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        proposer: address,
        proposal_type: u8,
        voting_ends_at: u64,
        created_at: u64,
    }

    struct VoteCast has copy, drop {
        hive_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        voter: address,
        support: bool,
        weight: u64,
        voted_at: u64,
    }

    struct ProposalPassed has copy, drop {
        hive_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        votes_for: u64,
        votes_against: u64,
        passed_at: u64,
    }

    struct ProposalFailed has copy, drop {
        hive_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        votes_for: u64,
        votes_against: u64,
        failed_at: u64,
    }

    struct ProposalExecuted has copy, drop {
        hive_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        executed_by: address,
        executed_at: u64,
    }

    struct TreasuryDeposit has copy, drop {
        hive_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        new_balance: u64,
        deposited_at: u64,
    }

    struct TreasurySpend has copy, drop {
        hive_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        proposal_id: 0x2::object::ID,
        spent_at: u64,
    }

    struct RevenueDistributed has copy, drop {
        hive_id: 0x2::object::ID,
        total_amount: u64,
        num_recipients: u64,
        distributed_at: u64,
    }

    struct SignatureRequestCreated has copy, drop {
        hive_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        message_hash: vector<u8>,
        required_weight: u64,
        created_at: u64,
    }

    struct PartialSignatureSubmitted has copy, drop {
        hive_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        signer: address,
        weight: u64,
        accumulated_weight: u64,
        submitted_at: u64,
    }

    struct SignatureAggregated has copy, drop {
        hive_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        total_weight: u64,
        num_signers: u64,
        aggregated_at: u64,
    }

    public fun emit_bls_key_registered(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = BlsKeyRegistered{
            hive_id       : arg0,
            member        : arg1,
            share_index   : arg2,
            registered_at : arg3,
        };
        0x2::event::emit<BlsKeyRegistered>(v0);
    }

    public fun emit_hive_created(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: address, arg3: u16, arg4: u64) {
        let v0 = HiveCreated{
            hive_id           : arg0,
            name              : arg1,
            creator           : arg2,
            initial_threshold : arg3,
            created_at        : arg4,
        };
        0x2::event::emit<HiveCreated>(v0);
    }

    public fun emit_hive_parameters_updated(arg0: 0x2::object::ID, arg1: u16, arg2: address, arg3: u64) {
        let v0 = HiveParametersUpdated{
            hive_id       : arg0,
            new_threshold : arg1,
            updated_by    : arg2,
            updated_at    : arg3,
        };
        0x2::event::emit<HiveParametersUpdated>(v0);
    }

    public fun emit_member_joined(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64, arg4: u64) {
        let v0 = MemberJoined{
            hive_id   : arg0,
            member    : arg1,
            agent_id  : arg2,
            weight    : arg3,
            joined_at : arg4,
        };
        0x2::event::emit<MemberJoined>(v0);
    }

    public fun emit_member_left(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64, arg4: u64) {
        let v0 = MemberLeft{
            hive_id        : arg0,
            member         : arg1,
            voluntary      : arg2,
            stake_returned : arg3,
            left_at        : arg4,
        };
        0x2::event::emit<MemberLeft>(v0);
    }

    public fun emit_member_reinstated(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = MemberReinstated{
            hive_id       : arg0,
            member        : arg1,
            reinstated_at : arg2,
        };
        0x2::event::emit<MemberReinstated>(v0);
    }

    public fun emit_member_suspended(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = MemberSuspended{
            hive_id      : arg0,
            member       : arg1,
            reason       : arg2,
            suspended_at : arg3,
        };
        0x2::event::emit<MemberSuspended>(v0);
    }

    public fun emit_member_weight_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = MemberWeightUpdated{
            hive_id    : arg0,
            member     : arg1,
            old_weight : arg2,
            new_weight : arg3,
            updated_at : arg4,
        };
        0x2::event::emit<MemberWeightUpdated>(v0);
    }

    public fun emit_partial_signature_submitted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = PartialSignatureSubmitted{
            hive_id            : arg0,
            request_id         : arg1,
            signer             : arg2,
            weight             : arg3,
            accumulated_weight : arg4,
            submitted_at       : arg5,
        };
        0x2::event::emit<PartialSignatureSubmitted>(v0);
    }

    public fun emit_proposal_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: u64, arg5: u64) {
        let v0 = ProposalCreated{
            hive_id        : arg0,
            proposal_id    : arg1,
            proposer       : arg2,
            proposal_type  : arg3,
            voting_ends_at : arg4,
            created_at     : arg5,
        };
        0x2::event::emit<ProposalCreated>(v0);
    }

    public fun emit_proposal_executed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = ProposalExecuted{
            hive_id     : arg0,
            proposal_id : arg1,
            executed_by : arg2,
            executed_at : arg3,
        };
        0x2::event::emit<ProposalExecuted>(v0);
    }

    public fun emit_proposal_failed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ProposalFailed{
            hive_id       : arg0,
            proposal_id   : arg1,
            votes_for     : arg2,
            votes_against : arg3,
            failed_at     : arg4,
        };
        0x2::event::emit<ProposalFailed>(v0);
    }

    public fun emit_proposal_passed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ProposalPassed{
            hive_id       : arg0,
            proposal_id   : arg1,
            votes_for     : arg2,
            votes_against : arg3,
            passed_at     : arg4,
        };
        0x2::event::emit<ProposalPassed>(v0);
    }

    public fun emit_revenue_distributed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = RevenueDistributed{
            hive_id        : arg0,
            total_amount   : arg1,
            num_recipients : arg2,
            distributed_at : arg3,
        };
        0x2::event::emit<RevenueDistributed>(v0);
    }

    public fun emit_signature_aggregated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = SignatureAggregated{
            hive_id       : arg0,
            request_id    : arg1,
            total_weight  : arg2,
            num_signers   : arg3,
            aggregated_at : arg4,
        };
        0x2::event::emit<SignatureAggregated>(v0);
    }

    public fun emit_signature_request_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u64, arg4: u64) {
        let v0 = SignatureRequestCreated{
            hive_id         : arg0,
            request_id      : arg1,
            message_hash    : arg2,
            required_weight : arg3,
            created_at      : arg4,
        };
        0x2::event::emit<SignatureRequestCreated>(v0);
    }

    public fun emit_treasury_deposit(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = TreasuryDeposit{
            hive_id      : arg0,
            depositor    : arg1,
            amount       : arg2,
            new_balance  : arg3,
            deposited_at : arg4,
        };
        0x2::event::emit<TreasuryDeposit>(v0);
    }

    public fun emit_treasury_spend(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: u64) {
        let v0 = TreasurySpend{
            hive_id     : arg0,
            recipient   : arg1,
            amount      : arg2,
            proposal_id : arg3,
            spent_at    : arg4,
        };
        0x2::event::emit<TreasurySpend>(v0);
    }

    public fun emit_vote_cast(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: u64, arg5: u64) {
        let v0 = VoteCast{
            hive_id     : arg0,
            proposal_id : arg1,
            voter       : arg2,
            support     : arg3,
            weight      : arg4,
            voted_at    : arg5,
        };
        0x2::event::emit<VoteCast>(v0);
    }

    // decompiled from Move bytecode v6
}

