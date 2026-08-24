module 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport {
    struct AgentPassport has store, key {
        id: 0x2::object::UID,
        owner: address,
        suins_name: vector<u8>,
        runtime_wallet: address,
        policy_root: address,
        skill_root: address,
        memory_namespace: vector<u8>,
        is_active: bool,
        exec_count: u64,
        attestation_count: u64,
        reputation_score_sum: u64,
    }

    struct AgentCreated has copy, drop {
        passport: 0x2::object::ID,
        owner: address,
        suins_name: vector<u8>,
        runtime_wallet: address,
    }

    struct AgentRevoked has copy, drop {
        passport: 0x2::object::ID,
        owner: address,
    }

    struct ExecutionRecorded has copy, drop {
        passport: 0x2::object::ID,
        exec_count: u64,
    }

    struct AttestationRecorded has copy, drop {
        passport: 0x2::object::ID,
        attestation_count: u64,
        reputation_score_sum: u64,
    }

    public fun attestation_count(arg0: &AgentPassport) : u64 {
        arg0.attestation_count
    }

    public fun create(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : AgentPassport {
        let v0 = AgentPassport{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            suins_name           : arg0,
            runtime_wallet       : arg1,
            policy_root          : @0x0,
            skill_root           : @0x0,
            memory_namespace     : arg0,
            is_active            : true,
            exec_count           : 0,
            attestation_count    : 0,
            reputation_score_sum : 0,
        };
        let v1 = AgentCreated{
            passport       : 0x2::object::id<AgentPassport>(&v0),
            owner          : 0x2::tx_context::sender(arg2),
            suins_name     : arg0,
            runtime_wallet : arg1,
        };
        0x2::event::emit<AgentCreated>(v1);
        v0
    }

    public fun exec_count(arg0: &AgentPassport) : u64 {
        arg0.exec_count
    }

    public fun is_active(arg0: &AgentPassport) : bool {
        arg0.is_active
    }

    public fun memory_namespace(arg0: &AgentPassport) : vector<u8> {
        arg0.memory_namespace
    }

    public fun owner(arg0: &AgentPassport) : address {
        arg0.owner
    }

    public(friend) fun record_attestation_internal(arg0: &mut AgentPassport, arg1: u8) {
        arg0.attestation_count = arg0.attestation_count + 1;
        arg0.reputation_score_sum = arg0.reputation_score_sum + (arg1 as u64);
        let v0 = AttestationRecorded{
            passport             : 0x2::object::id<AgentPassport>(arg0),
            attestation_count    : arg0.attestation_count,
            reputation_score_sum : arg0.reputation_score_sum,
        };
        0x2::event::emit<AttestationRecorded>(v0);
    }

    public fun record_execution(arg0: &mut AgentPassport, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner || v0 == arg0.runtime_wallet, 2);
        record_execution_internal(arg0);
    }

    public(friend) fun record_execution_internal(arg0: &mut AgentPassport) {
        arg0.exec_count = arg0.exec_count + 1;
        let v0 = ExecutionRecorded{
            passport   : 0x2::object::id<AgentPassport>(arg0),
            exec_count : arg0.exec_count,
        };
        0x2::event::emit<ExecutionRecorded>(v0);
    }

    public fun reputation_score_sum(arg0: &AgentPassport) : u64 {
        arg0.reputation_score_sum
    }

    public fun revoke(arg0: &mut AgentPassport, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.is_active = false;
        let v0 = AgentRevoked{
            passport : 0x2::object::id<AgentPassport>(arg0),
            owner    : arg0.owner,
        };
        0x2::event::emit<AgentRevoked>(v0);
    }

    public fun runtime_wallet(arg0: &AgentPassport) : address {
        arg0.runtime_wallet
    }

    public fun set_memory_namespace(arg0: &mut AgentPassport, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.memory_namespace = arg1;
    }

    public fun suins_name(arg0: &AgentPassport) : vector<u8> {
        arg0.suins_name
    }

    // decompiled from Move bytecode v7
}

