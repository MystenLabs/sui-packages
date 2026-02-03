module 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events {
    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        agent_id: vector<u8>,
        policy_id: 0x2::object::ID,
    }

    struct VaultDestroyed has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct ShortTermMemoryStored has copy, drop {
        vault_id: 0x2::object::ID,
        memory_id: u64,
        content_hash: vector<u8>,
        is_encrypted: bool,
    }

    struct ShortTermMemoryDeleted has copy, drop {
        vault_id: 0x2::object::ID,
        memory_id: u64,
    }

    struct LongTermMemoryStored has copy, drop {
        vault_id: 0x2::object::ID,
        memory_key: vector<u8>,
        memory_type: u8,
        content_hash: vector<u8>,
        is_encrypted: bool,
    }

    struct LongTermMemoryUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        memory_key: vector<u8>,
        content_hash: vector<u8>,
    }

    struct LongTermMemoryDeleted has copy, drop {
        vault_id: 0x2::object::ID,
        memory_key: vector<u8>,
    }

    struct EpisodicMemoryStored has copy, drop {
        vault_id: 0x2::object::ID,
        episode_id: u64,
        walrus_blob_id: vector<u8>,
        summary_hash: vector<u8>,
        turn_count: u64,
        is_encrypted: bool,
    }

    struct EpisodicMemoryDeleted has copy, drop {
        vault_id: 0x2::object::ID,
        episode_id: u64,
    }

    struct SemanticIndexUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        embedding_hash: u256,
        walrus_embedding_id: vector<u8>,
        source_memory_key: vector<u8>,
    }

    struct AccessGranted has copy, drop {
        vault_id: 0x2::object::ID,
        accessor: address,
        access_type: u8,
        memory_type: u8,
    }

    struct AccessDenied has copy, drop {
        vault_id: 0x2::object::ID,
        accessor: address,
        reason: u8,
    }

    struct SealSessionCreated has copy, drop {
        vault_id: 0x2::object::ID,
        session_id: 0x2::object::ID,
        agent: address,
        expires_at: u64,
    }

    struct SealSessionRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        session_id: 0x2::object::ID,
    }

    struct AgentAuthorized has copy, drop {
        vault_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        agent: address,
        session_key: vector<u8>,
        expires_at: u64,
    }

    struct AgentDeauthorized has copy, drop {
        vault_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        agent: address,
    }

    struct DelegationCreated has copy, drop {
        vault_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        delegatee: address,
        access_level: u8,
        expires_at: u64,
    }

    struct DelegationRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        delegatee: address,
    }

    public(friend) fun access_denied(arg0: 0x2::object::ID, arg1: address, arg2: u8) {
        let v0 = AccessDenied{
            vault_id : arg0,
            accessor : arg1,
            reason   : arg2,
        };
        0x2::event::emit<AccessDenied>(v0);
    }

    public(friend) fun access_granted(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u8) {
        let v0 = AccessGranted{
            vault_id    : arg0,
            accessor    : arg1,
            access_type : arg2,
            memory_type : arg3,
        };
        0x2::event::emit<AccessGranted>(v0);
    }

    public(friend) fun agent_authorized(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>, arg4: u64) {
        let v0 = AgentAuthorized{
            vault_id    : arg0,
            policy_id   : arg1,
            agent       : arg2,
            session_key : arg3,
            expires_at  : arg4,
        };
        0x2::event::emit<AgentAuthorized>(v0);
    }

    public(friend) fun agent_deauthorized(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = AgentDeauthorized{
            vault_id  : arg0,
            policy_id : arg1,
            agent     : arg2,
        };
        0x2::event::emit<AgentDeauthorized>(v0);
    }

    public(friend) fun delegation_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: u64) {
        let v0 = DelegationCreated{
            vault_id     : arg0,
            policy_id    : arg1,
            delegatee    : arg2,
            access_level : arg3,
            expires_at   : arg4,
        };
        0x2::event::emit<DelegationCreated>(v0);
    }

    public(friend) fun delegation_revoked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = DelegationRevoked{
            vault_id  : arg0,
            policy_id : arg1,
            delegatee : arg2,
        };
        0x2::event::emit<DelegationRevoked>(v0);
    }

    public(friend) fun episodic_memory_deleted(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = EpisodicMemoryDeleted{
            vault_id   : arg0,
            episode_id : arg1,
        };
        0x2::event::emit<EpisodicMemoryDeleted>(v0);
    }

    public(friend) fun episodic_memory_stored(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: bool) {
        let v0 = EpisodicMemoryStored{
            vault_id       : arg0,
            episode_id     : arg1,
            walrus_blob_id : arg2,
            summary_hash   : arg3,
            turn_count     : arg4,
            is_encrypted   : arg5,
        };
        0x2::event::emit<EpisodicMemoryStored>(v0);
    }

    public(friend) fun long_term_memory_deleted(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = LongTermMemoryDeleted{
            vault_id   : arg0,
            memory_key : arg1,
        };
        0x2::event::emit<LongTermMemoryDeleted>(v0);
    }

    public(friend) fun long_term_memory_stored(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u8, arg3: vector<u8>, arg4: bool) {
        let v0 = LongTermMemoryStored{
            vault_id     : arg0,
            memory_key   : arg1,
            memory_type  : arg2,
            content_hash : arg3,
            is_encrypted : arg4,
        };
        0x2::event::emit<LongTermMemoryStored>(v0);
    }

    public(friend) fun long_term_memory_updated(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = LongTermMemoryUpdated{
            vault_id     : arg0,
            memory_key   : arg1,
            content_hash : arg2,
        };
        0x2::event::emit<LongTermMemoryUpdated>(v0);
    }

    public(friend) fun seal_session_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = SealSessionCreated{
            vault_id   : arg0,
            session_id : arg1,
            agent      : arg2,
            expires_at : arg3,
        };
        0x2::event::emit<SealSessionCreated>(v0);
    }

    public(friend) fun seal_session_revoked(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = SealSessionRevoked{
            vault_id   : arg0,
            session_id : arg1,
        };
        0x2::event::emit<SealSessionRevoked>(v0);
    }

    public(friend) fun semantic_index_updated(arg0: 0x2::object::ID, arg1: u256, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = SemanticIndexUpdated{
            vault_id            : arg0,
            embedding_hash      : arg1,
            walrus_embedding_id : arg2,
            source_memory_key   : arg3,
        };
        0x2::event::emit<SemanticIndexUpdated>(v0);
    }

    public(friend) fun short_term_memory_deleted(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ShortTermMemoryDeleted{
            vault_id  : arg0,
            memory_id : arg1,
        };
        0x2::event::emit<ShortTermMemoryDeleted>(v0);
    }

    public(friend) fun short_term_memory_stored(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: bool) {
        let v0 = ShortTermMemoryStored{
            vault_id     : arg0,
            memory_id    : arg1,
            content_hash : arg2,
            is_encrypted : arg3,
        };
        0x2::event::emit<ShortTermMemoryStored>(v0);
    }

    public(friend) fun vault_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: 0x2::object::ID) {
        let v0 = VaultCreated{
            vault_id  : arg0,
            owner     : arg1,
            agent_id  : arg2,
            policy_id : arg3,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    public(friend) fun vault_destroyed(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VaultDestroyed{
            vault_id : arg0,
            owner    : arg1,
        };
        0x2::event::emit<VaultDestroyed>(v0);
    }

    // decompiled from Move bytecode v6
}

