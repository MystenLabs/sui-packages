module 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events {
    struct AgentCreated has copy, drop {
        agent_id: 0x2::object::ID,
        owner: address,
    }

    struct KeyIssued has copy, drop {
        agent_id: 0x2::object::ID,
        key_id: vector<u8>,
    }

    struct KeyActivated has copy, drop {
        agent_id: 0x2::object::ID,
        key_id: vector<u8>,
        activated_at_epoch: u64,
    }

    struct KeyCharged has copy, drop {
        agent_id: 0x2::object::ID,
        amount_usdc_micro: u64,
        solana_tx: vector<u8>,
    }

    struct WalkRecorded has copy, drop {
        agent_id: 0x2::object::ID,
        vertex: vector<u8>,
        cost_usdc_micro: u64,
    }

    struct AgentRetired has copy, drop {
        agent_id: 0x2::object::ID,
    }

    struct TicketMinted has copy, drop {
        agent_id: 0x2::object::ID,
        seq: u64,
        max_cost: u64,
        kind: u8,
        commitment: 0x1::option::Option<vector<u8>>,
        minted_ms: u64,
        expires_ms: u64,
    }

    struct TicketSettled has copy, drop {
        agent_id: 0x2::object::ID,
        seq: u64,
        escrow: u64,
        actual: u64,
        commitment: 0x1::option::Option<vector<u8>>,
        treasury: address,
    }

    struct TicketReclaimed has copy, drop {
        agent_id: 0x2::object::ID,
        seq: u64,
        amount: u64,
        caller: address,
    }

    struct LlmPolicySet has copy, drop {
        agent_id: 0x2::object::ID,
        max_open_micro: u64,
        model_allow_hash: 0x1::option::Option<vector<u8>>,
    }

    struct AllowanceCreated has copy, drop {
        agent_id: 0x2::object::ID,
        id: u64,
        budget: u64,
        max_per_call: u64,
        expires_ms: u64,
        spend_pk: vector<u8>,
        model_allow_hash: 0x1::option::Option<vector<u8>>,
        allowance: 0x2::object::ID,
        provider: 0x2::object::ID,
        spender: 0x1::option::Option<0x2::object::ID>,
    }

    struct VoucherSettled has copy, drop {
        agent_id: 0x2::object::ID,
        id: u64,
        voucher_id: u64,
        max_cost: u64,
        actual: u64,
        issued_ms: u64,
        expiry_ms: u64,
        remaining: u64,
        treasury: address,
    }

    struct AllowanceRevoking has copy, drop {
        agent_id: 0x2::object::ID,
        id: u64,
        release_after_ms: u64,
    }

    struct AllowanceClosed has copy, drop {
        agent_id: 0x2::object::ID,
        id: u64,
        returned: u64,
        reason: u8,
    }

    struct GrantReserved has copy, drop {
        agent_id: 0x2::object::ID,
        id: u64,
        allowance: 0x2::object::ID,
        nonce: vector<u8>,
        spender: 0x2::object::ID,
        context: 0x2::object::ID,
        operation: vector<u8>,
        input_hash: vector<u8>,
        max_cost: u64,
        settle_by_ms: u64,
        provider: 0x2::object::ID,
        remaining: u64,
        ext: vector<u8>,
    }

    struct GrantSettled has copy, drop {
        agent_id: 0x2::object::ID,
        id: u64,
        nonce: vector<u8>,
        max_cost: u64,
        actual: u64,
        remaining: u64,
        treasury: address,
        provider: 0x2::object::ID,
        memo: vector<u8>,
    }

    struct GrantReaped has copy, drop {
        agent_id: 0x2::object::ID,
        id: u64,
        nonce: vector<u8>,
        returned: u64,
        to_account: bool,
        caller: address,
    }

    public(friend) fun emit_agent_created(arg0: 0x2::object::ID, arg1: address) {
        let v0 = AgentCreated{
            agent_id : arg0,
            owner    : arg1,
        };
        0x2::event::emit<AgentCreated>(v0);
    }

    public(friend) fun emit_agent_retired(arg0: 0x2::object::ID) {
        let v0 = AgentRetired{agent_id: arg0};
        0x2::event::emit<AgentRetired>(v0);
    }

    public(friend) fun emit_allowance_closed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u8) {
        let v0 = AllowanceClosed{
            agent_id : arg0,
            id       : arg1,
            returned : arg2,
            reason   : arg3,
        };
        0x2::event::emit<AllowanceClosed>(v0);
    }

    public(friend) fun emit_allowance_created(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: 0x1::option::Option<vector<u8>>, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x1::option::Option<0x2::object::ID>) {
        let v0 = AllowanceCreated{
            agent_id         : arg0,
            id               : arg1,
            budget           : arg2,
            max_per_call     : arg3,
            expires_ms       : arg4,
            spend_pk         : arg5,
            model_allow_hash : arg6,
            allowance        : arg7,
            provider         : arg8,
            spender          : arg9,
        };
        0x2::event::emit<AllowanceCreated>(v0);
    }

    public(friend) fun emit_allowance_revoking(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = AllowanceRevoking{
            agent_id         : arg0,
            id               : arg1,
            release_after_ms : arg2,
        };
        0x2::event::emit<AllowanceRevoking>(v0);
    }

    public(friend) fun emit_grant_reaped(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: address) {
        let v0 = GrantReaped{
            agent_id   : arg0,
            id         : arg1,
            nonce      : arg2,
            returned   : arg3,
            to_account : arg4,
            caller     : arg5,
        };
        0x2::event::emit<GrantReaped>(v0);
    }

    public(friend) fun emit_grant_reserved(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: 0x2::object::ID, arg11: u64, arg12: vector<u8>) {
        let v0 = GrantReserved{
            agent_id     : arg0,
            id           : arg1,
            allowance    : arg2,
            nonce        : arg3,
            spender      : arg4,
            context      : arg5,
            operation    : arg6,
            input_hash   : arg7,
            max_cost     : arg8,
            settle_by_ms : arg9,
            provider     : arg10,
            remaining    : arg11,
            ext          : arg12,
        };
        0x2::event::emit<GrantReserved>(v0);
    }

    public(friend) fun emit_grant_settled(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: 0x2::object::ID, arg8: vector<u8>) {
        let v0 = GrantSettled{
            agent_id  : arg0,
            id        : arg1,
            nonce     : arg2,
            max_cost  : arg3,
            actual    : arg4,
            remaining : arg5,
            treasury  : arg6,
            provider  : arg7,
            memo      : arg8,
        };
        0x2::event::emit<GrantSettled>(v0);
    }

    public(friend) fun emit_key_activated(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = KeyActivated{
            agent_id           : arg0,
            key_id             : arg1,
            activated_at_epoch : arg2,
        };
        0x2::event::emit<KeyActivated>(v0);
    }

    public(friend) fun emit_key_charged(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>) {
        let v0 = KeyCharged{
            agent_id          : arg0,
            amount_usdc_micro : arg1,
            solana_tx         : arg2,
        };
        0x2::event::emit<KeyCharged>(v0);
    }

    public(friend) fun emit_key_issued(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = KeyIssued{
            agent_id : arg0,
            key_id   : arg1,
        };
        0x2::event::emit<KeyIssued>(v0);
    }

    public(friend) fun emit_llm_policy_set(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::option::Option<vector<u8>>) {
        let v0 = LlmPolicySet{
            agent_id         : arg0,
            max_open_micro   : arg1,
            model_allow_hash : arg2,
        };
        0x2::event::emit<LlmPolicySet>(v0);
    }

    public(friend) fun emit_ticket_minted(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u8, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: u64) {
        let v0 = TicketMinted{
            agent_id   : arg0,
            seq        : arg1,
            max_cost   : arg2,
            kind       : arg3,
            commitment : arg4,
            minted_ms  : arg5,
            expires_ms : arg6,
        };
        0x2::event::emit<TicketMinted>(v0);
    }

    public(friend) fun emit_ticket_reclaimed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = TicketReclaimed{
            agent_id : arg0,
            seq      : arg1,
            amount   : arg2,
            caller   : arg3,
        };
        0x2::event::emit<TicketReclaimed>(v0);
    }

    public(friend) fun emit_ticket_settled(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::option::Option<vector<u8>>, arg5: address) {
        let v0 = TicketSettled{
            agent_id   : arg0,
            seq        : arg1,
            escrow     : arg2,
            actual     : arg3,
            commitment : arg4,
            treasury   : arg5,
        };
        0x2::event::emit<TicketSettled>(v0);
    }

    public(friend) fun emit_voucher_settled(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: address) {
        let v0 = VoucherSettled{
            agent_id   : arg0,
            id         : arg1,
            voucher_id : arg2,
            max_cost   : arg3,
            actual     : arg4,
            issued_ms  : arg5,
            expiry_ms  : arg6,
            remaining  : arg7,
            treasury   : arg8,
        };
        0x2::event::emit<VoucherSettled>(v0);
    }

    public(friend) fun emit_walk_recorded(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = WalkRecorded{
            agent_id        : arg0,
            vertex          : arg1,
            cost_usdc_micro : arg2,
        };
        0x2::event::emit<WalkRecorded>(v0);
    }

    // decompiled from Move bytecode v7
}

