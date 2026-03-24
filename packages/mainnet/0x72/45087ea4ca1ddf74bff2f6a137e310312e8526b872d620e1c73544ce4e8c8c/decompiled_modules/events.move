module 0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events {
    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        name: 0x1::string::String,
        members: vector<address>,
        weights: vector<u64>,
        threshold: u64,
        created_by: address,
    }

    struct CoinDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        amount: u64,
        depositor: address,
    }

    struct ObjectDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
        depositor: address,
    }

    struct ProposalCreated has copy, drop {
        vault_id: 0x2::object::ID,
        proposal_id: u64,
        action_type: u8,
        proposer: address,
        description: 0x1::string::String,
        expiration_epoch: u64,
    }

    struct ProposalApproved has copy, drop {
        vault_id: 0x2::object::ID,
        proposal_id: u64,
        approver: address,
        approver_weight: u64,
        total_weight: u64,
        threshold: u64,
    }

    struct ProposalExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        proposal_id: u64,
        executor: address,
        action_type: u8,
    }

    struct ProposalCancelled has copy, drop {
        vault_id: 0x2::object::ID,
        proposal_id: u64,
        cancelled_by: address,
    }

    struct MembersChanged has copy, drop {
        vault_id: 0x2::object::ID,
        proposal_id: u64,
        added: vector<address>,
        removed: vector<address>,
        new_threshold: u64,
    }

    public(friend) fun emit_coin_deposited(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: address) {
        let v0 = CoinDeposited{
            vault_id  : arg0,
            coin_type : arg1,
            amount    : arg2,
            depositor : arg3,
        };
        0x2::event::emit<CoinDeposited>(v0);
    }

    public(friend) fun emit_members_changed(arg0: 0x2::object::ID, arg1: u64, arg2: vector<address>, arg3: vector<address>, arg4: u64) {
        let v0 = MembersChanged{
            vault_id      : arg0,
            proposal_id   : arg1,
            added         : arg2,
            removed       : arg3,
            new_threshold : arg4,
        };
        0x2::event::emit<MembersChanged>(v0);
    }

    public(friend) fun emit_object_deposited(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = ObjectDeposited{
            vault_id  : arg0,
            object_id : arg1,
            depositor : arg2,
        };
        0x2::event::emit<ObjectDeposited>(v0);
    }

    public(friend) fun emit_proposal_approved(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = ProposalApproved{
            vault_id        : arg0,
            proposal_id     : arg1,
            approver        : arg2,
            approver_weight : arg3,
            total_weight    : arg4,
            threshold       : arg5,
        };
        0x2::event::emit<ProposalApproved>(v0);
    }

    public(friend) fun emit_proposal_cancelled(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = ProposalCancelled{
            vault_id     : arg0,
            proposal_id  : arg1,
            cancelled_by : arg2,
        };
        0x2::event::emit<ProposalCancelled>(v0);
    }

    public(friend) fun emit_proposal_created(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: address, arg4: 0x1::string::String, arg5: u64) {
        let v0 = ProposalCreated{
            vault_id         : arg0,
            proposal_id      : arg1,
            action_type      : arg2,
            proposer         : arg3,
            description      : arg4,
            expiration_epoch : arg5,
        };
        0x2::event::emit<ProposalCreated>(v0);
    }

    public(friend) fun emit_proposal_executed(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u8) {
        let v0 = ProposalExecuted{
            vault_id    : arg0,
            proposal_id : arg1,
            executor    : arg2,
            action_type : arg3,
        };
        0x2::event::emit<ProposalExecuted>(v0);
    }

    public(friend) fun emit_vault_created(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: address) {
        let v0 = VaultCreated{
            vault_id   : arg0,
            name       : arg1,
            members    : arg2,
            weights    : arg3,
            threshold  : arg4,
            created_by : arg5,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    // decompiled from Move bytecode v6
}

