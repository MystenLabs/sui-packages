module 0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::events {
    struct AgentCreated has copy, drop {
        agent_id: 0x2::object::ID,
        owner: address,
        metadata_uri: 0x1::string::String,
        created_at: u64,
    }

    struct AgentUpdated has copy, drop {
        agent_id: 0x2::object::ID,
        metadata_uri: 0x1::string::String,
        updated_at: u64,
    }

    struct AgentTransferred has copy, drop {
        agent_id: 0x2::object::ID,
        from: address,
        to: address,
        transferred_at: u64,
    }

    struct SkillPublished has copy, drop {
        skill_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        name: 0x1::string::String,
        version: 0x1::string::String,
        verification_type: u8,
        base_price_usdc: u64,
        worker_bond_usdc: u64,
        published_at: u64,
    }

    struct SkillDeprecated has copy, drop {
        skill_id: 0x2::object::ID,
        deprecated_at: u64,
    }

    struct TaskCreated has copy, drop {
        task_id: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        skill_id: 0x2::object::ID,
        skill_version: 0x1::string::String,
        payment_amount: u64,
        priority_tier: u8,
        verification_type: u8,
        expires_at: u64,
        created_at: u64,
    }

    struct TaskReserved has copy, drop {
        task_id: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        reserved_at: u64,
        reservation_expires_at: u64,
    }

    struct TaskAccepted has copy, drop {
        task_id: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        skill_id: 0x2::object::ID,
        bond_amount: u64,
        accepted_at: u64,
    }

    struct TaskSubmitted has copy, drop {
        task_id: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        output_ref: 0x1::string::String,
        output_hash: 0x1::string::String,
        submitted_at: u64,
    }

    struct TaskVerified has copy, drop {
        task_id: 0x2::object::ID,
        verification_type: u8,
        verification_method: 0x1::string::String,
        verified_at: u64,
    }

    struct TaskSettled has copy, drop {
        task_id: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        payment_amount: u64,
        protocol_fee: u64,
        worker_received: u64,
        bond_returned: u64,
        settled_at: u64,
    }

    struct TaskCancelled has copy, drop {
        task_id: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        refund_amount: u64,
        cancelled_at: u64,
    }

    struct TaskExpired has copy, drop {
        task_id: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        refund_amount: u64,
        bond_slashed: u64,
        expired_at: u64,
    }

    struct TaskFailed has copy, drop {
        task_id: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        failure_reason: 0x1::string::String,
        refund_amount: u64,
        bond_returned: u64,
        failed_at: u64,
    }

    struct ClaimGenerated has copy, drop {
        claim_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        verification_code: 0x1::string::String,
        created_at: u64,
    }

    struct ClaimVerified has copy, drop {
        claim_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        claim_type: u8,
        claimed_by: 0x1::string::String,
        verified_at: u64,
    }

    struct ClaimRevoked has copy, drop {
        claim_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        revoked_at: u64,
    }

    struct BadgeEarned has copy, drop {
        badge_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        badge_type: 0x1::string::String,
        tier: u8,
        earned_at: u64,
    }

    struct CertificationIssued has copy, drop {
        certification_id: 0x2::object::ID,
        skill_id: 0x2::object::ID,
        skill_version: 0x1::string::String,
        certifier_agent: 0x2::object::ID,
        certification_type: 0x1::string::String,
        certified_at: u64,
    }

    struct CertificationRevoked has copy, drop {
        certification_id: 0x2::object::ID,
        revoked_at: u64,
    }

    struct TreasuryCreated has copy, drop {
        treasury_id: 0x2::object::ID,
        admin: address,
        fee_bps: u64,
        created_at: u64,
    }

    struct TreasuryDeposit has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
        total_collected: u64,
    }

    struct TreasuryWithdrawal has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        total_withdrawn: u64,
    }

    struct TreasuryFeeProposed has copy, drop {
        treasury_id: 0x2::object::ID,
        current_fee_bps: u64,
        proposed_fee_bps: u64,
        effective_at: u64,
    }

    struct TreasuryFeeUpdated has copy, drop {
        treasury_id: 0x2::object::ID,
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct TreasuryAdminProposed has copy, drop {
        treasury_id: 0x2::object::ID,
        current_admin: address,
        proposed_admin: address,
    }

    struct TreasuryAdminTransferred has copy, drop {
        treasury_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
    }

    struct AdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        created_at: u64,
    }

    struct ProtocolPaused has copy, drop {
        paused_at: u64,
        reason: 0x1::string::String,
    }

    struct ProtocolUnpaused has copy, drop {
        unpaused_at: u64,
    }

    public fun admin_cap_created(arg0: 0x2::object::ID, arg1: u64) : AdminCapCreated {
        AdminCapCreated{
            admin_cap_id : arg0,
            created_at   : arg1,
        }
    }

    public fun agent_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64) : AgentCreated {
        AgentCreated{
            agent_id     : arg0,
            owner        : arg1,
            metadata_uri : arg2,
            created_at   : arg3,
        }
    }

    public fun agent_transferred(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) : AgentTransferred {
        AgentTransferred{
            agent_id       : arg0,
            from           : arg1,
            to             : arg2,
            transferred_at : arg3,
        }
    }

    public fun agent_updated(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64) : AgentUpdated {
        AgentUpdated{
            agent_id     : arg0,
            metadata_uri : arg1,
            updated_at   : arg2,
        }
    }

    public fun badge_earned(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u8, arg4: u64) : BadgeEarned {
        BadgeEarned{
            badge_id   : arg0,
            agent_id   : arg1,
            badge_type : arg2,
            tier       : arg3,
            earned_at  : arg4,
        }
    }

    public fun certification_issued(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: u64) : CertificationIssued {
        CertificationIssued{
            certification_id   : arg0,
            skill_id           : arg1,
            skill_version      : arg2,
            certifier_agent    : arg3,
            certification_type : arg4,
            certified_at       : arg5,
        }
    }

    public fun certification_revoked(arg0: 0x2::object::ID, arg1: u64) : CertificationRevoked {
        CertificationRevoked{
            certification_id : arg0,
            revoked_at       : arg1,
        }
    }

    public fun claim_generated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64) : ClaimGenerated {
        ClaimGenerated{
            claim_id          : arg0,
            agent_id          : arg1,
            verification_code : arg2,
            created_at        : arg3,
        }
    }

    public fun claim_revoked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) : ClaimRevoked {
        ClaimRevoked{
            claim_id   : arg0,
            agent_id   : arg1,
            revoked_at : arg2,
        }
    }

    public fun claim_verified(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: 0x1::string::String, arg4: u64) : ClaimVerified {
        ClaimVerified{
            claim_id    : arg0,
            agent_id    : arg1,
            claim_type  : arg2,
            claimed_by  : arg3,
            verified_at : arg4,
        }
    }

    public fun protocol_paused(arg0: u64, arg1: 0x1::string::String) : ProtocolPaused {
        ProtocolPaused{
            paused_at : arg0,
            reason    : arg1,
        }
    }

    public fun protocol_unpaused(arg0: u64) : ProtocolUnpaused {
        ProtocolUnpaused{unpaused_at: arg0}
    }

    public fun skill_deprecated(arg0: 0x2::object::ID, arg1: u64) : SkillDeprecated {
        SkillDeprecated{
            skill_id      : arg0,
            deprecated_at : arg1,
        }
    }

    public fun skill_published(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: u64, arg7: u64) : SkillPublished {
        SkillPublished{
            skill_id          : arg0,
            agent_id          : arg1,
            name              : arg2,
            version           : arg3,
            verification_type : arg4,
            base_price_usdc   : arg5,
            worker_bond_usdc  : arg6,
            published_at      : arg7,
        }
    }

    public fun task_accepted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64) : TaskAccepted {
        TaskAccepted{
            task_id         : arg0,
            worker_agent    : arg1,
            requester_agent : arg2,
            skill_id        : arg3,
            bond_amount     : arg4,
            accepted_at     : arg5,
        }
    }

    public fun task_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : TaskCancelled {
        TaskCancelled{
            task_id         : arg0,
            requester_agent : arg1,
            refund_amount   : arg2,
            cancelled_at    : arg3,
        }
    }

    public fun task_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: u64) : TaskCreated {
        TaskCreated{
            task_id           : arg0,
            requester_agent   : arg1,
            skill_id          : arg2,
            skill_version     : arg3,
            payment_amount    : arg4,
            priority_tier     : arg5,
            verification_type : arg6,
            expires_at        : arg7,
            created_at        : arg8,
        }
    }

    public fun task_expired(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) : TaskExpired {
        TaskExpired{
            task_id         : arg0,
            requester_agent : arg1,
            worker_agent    : arg2,
            refund_amount   : arg3,
            bond_slashed    : arg4,
            expired_at      : arg5,
        }
    }

    public fun task_failed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64) : TaskFailed {
        TaskFailed{
            task_id         : arg0,
            requester_agent : arg1,
            worker_agent    : arg2,
            failure_reason  : arg3,
            refund_amount   : arg4,
            bond_returned   : arg5,
            failed_at       : arg6,
        }
    }

    public fun task_reserved(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : TaskReserved {
        TaskReserved{
            task_id                : arg0,
            worker_agent           : arg1,
            reserved_at            : arg2,
            reservation_expires_at : arg3,
        }
    }

    public fun task_settled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : TaskSettled {
        TaskSettled{
            task_id         : arg0,
            worker_agent    : arg1,
            requester_agent : arg2,
            payment_amount  : arg3,
            protocol_fee    : arg4,
            worker_received : arg5,
            bond_returned   : arg6,
            settled_at      : arg7,
        }
    }

    public fun task_submitted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64) : TaskSubmitted {
        TaskSubmitted{
            task_id      : arg0,
            worker_agent : arg1,
            output_ref   : arg2,
            output_hash  : arg3,
            submitted_at : arg4,
        }
    }

    public fun task_verified(arg0: 0x2::object::ID, arg1: u8, arg2: 0x1::string::String, arg3: u64) : TaskVerified {
        TaskVerified{
            task_id             : arg0,
            verification_type   : arg1,
            verification_method : arg2,
            verified_at         : arg3,
        }
    }

    public fun treasury_admin_proposed(arg0: 0x2::object::ID, arg1: address, arg2: address) : TreasuryAdminProposed {
        TreasuryAdminProposed{
            treasury_id    : arg0,
            current_admin  : arg1,
            proposed_admin : arg2,
        }
    }

    public fun treasury_admin_transferred(arg0: 0x2::object::ID, arg1: address, arg2: address) : TreasuryAdminTransferred {
        TreasuryAdminTransferred{
            treasury_id : arg0,
            old_admin   : arg1,
            new_admin   : arg2,
        }
    }

    public fun treasury_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) : TreasuryCreated {
        TreasuryCreated{
            treasury_id : arg0,
            admin       : arg1,
            fee_bps     : arg2,
            created_at  : arg3,
        }
    }

    public fun treasury_deposit(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : TreasuryDeposit {
        TreasuryDeposit{
            treasury_id     : arg0,
            amount          : arg1,
            total_collected : arg2,
        }
    }

    public fun treasury_fee_proposed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) : TreasuryFeeProposed {
        TreasuryFeeProposed{
            treasury_id      : arg0,
            current_fee_bps  : arg1,
            proposed_fee_bps : arg2,
            effective_at     : arg3,
        }
    }

    public fun treasury_fee_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : TreasuryFeeUpdated {
        TreasuryFeeUpdated{
            treasury_id : arg0,
            old_fee_bps : arg1,
            new_fee_bps : arg2,
        }
    }

    public fun treasury_withdrawal(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) : TreasuryWithdrawal {
        TreasuryWithdrawal{
            treasury_id     : arg0,
            amount          : arg1,
            recipient       : arg2,
            total_withdrawn : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

