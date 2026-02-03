module 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_vault {
    struct MemoryVaultOwnerCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct AccessReceipt {
        vault_id: 0x2::object::ID,
        access_type: u8,
        memory_type: u8,
        memory_key: vector<u8>,
    }

    struct MemoryVault has store, key {
        id: 0x2::object::UID,
        owner: address,
        policy_id: 0x2::object::ID,
        agent_id: vector<u8>,
        short_term_count: u64,
        long_term_count: u64,
        episodic_count: u64,
        semantic_count: u64,
        next_short_term_id: u64,
        next_episode_id: u64,
        short_term_limit: u64,
        first_short_term_id: u64,
        last_access_ts: u64,
        last_owner_activity_ts: u64,
        seal_key_id: 0x1::option::Option<0x2::object::ID>,
        is_encrypted: bool,
    }

    struct VaultShare has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        agent: address,
        access_level: u8,
        expires_at: u64,
    }

    public fun agent_id(arg0: &MemoryVault) : vector<u8> {
        arg0.agent_id
    }

    public fun close(arg0: MemoryVault, arg1: MemoryVaultOwnerCap) {
        let MemoryVault {
            id                     : v0,
            owner                  : v1,
            policy_id              : _,
            agent_id               : _,
            short_term_count       : v4,
            long_term_count        : v5,
            episodic_count         : v6,
            semantic_count         : v7,
            next_short_term_id     : _,
            next_episode_id        : _,
            short_term_limit       : _,
            first_short_term_id    : _,
            last_access_ts         : _,
            last_owner_activity_ts : _,
            seal_key_id            : _,
            is_encrypted           : _,
        } = arg0;
        let v16 = v0;
        let MemoryVaultOwnerCap {
            id  : v17,
            for : v18,
        } = arg1;
        assert!(0x2::object::uid_to_inner(&v16) == v18, 0);
        let v19 = if (v4 == 0) {
            if (v5 == 0) {
                if (v6 == 0) {
                    v7 == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v19, 80);
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::vault_destroyed(0x2::object::uid_to_inner(&v16), v1);
        0x2::object::delete(v17);
        0x2::object::delete(v16);
    }

    public fun consume_receipt(arg0: AccessReceipt) {
        let AccessReceipt {
            vault_id    : _,
            access_type : _,
            memory_type : _,
            memory_key  : _,
        } = arg0;
    }

    public fun create_share(arg0: &MemoryVault, arg1: &MemoryVaultOwnerCap, arg2: address, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : VaultShare {
        assert!(has_access(arg0, arg1), 0);
        VaultShare{
            id           : 0x2::object::new(arg5),
            vault_id     : 0x2::object::id<MemoryVault>(arg0),
            agent        : arg2,
            access_level : arg3,
            expires_at   : arg4,
        }
    }

    entry fun default(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2, v3, v4) = new_with_policy(v0, arg0, arg1);
        0x2::transfer::share_object<MemoryVault>(v1);
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::share(v3);
        0x2::transfer::transfer<MemoryVaultOwnerCap>(v2, v0);
        0x2::transfer::public_transfer<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicyCap>(v4, v0);
    }

    public fun delete_episodic(arg0: &mut MemoryVault, arg1: &AccessReceipt, arg2: u64) {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_delete(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_episodic(), 12);
        assert!(0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::EpisodicKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_episodic_key(arg2)), 10);
        0x2::dynamic_field::remove<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::EpisodicKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::EpisodicMemory>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_episodic_key(arg2));
        arg0.episodic_count = arg0.episodic_count - 1;
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::episodic_memory_deleted(0x2::object::id<MemoryVault>(arg0), arg2);
    }

    public fun delete_long_term(arg0: &mut MemoryVault, arg1: &AccessReceipt, arg2: vector<u8>) {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_delete(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_long_term(), 12);
        assert!(0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_key(arg2)), 10);
        0x2::dynamic_field::remove<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermMemory>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_key(arg2));
        arg0.long_term_count = arg0.long_term_count - 1;
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::long_term_memory_deleted(0x2::object::id<MemoryVault>(arg0), arg2);
    }

    public fun delete_semantic_index(arg0: &mut MemoryVault, arg1: &AccessReceipt, arg2: u256) {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_delete(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_semantic(), 12);
        assert!(0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_semantic_index_key(arg2)), 10);
        0x2::dynamic_field::remove<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexEntry>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_semantic_index_key(arg2));
        arg0.semantic_count = arg0.semantic_count - 1;
    }

    public fun delete_short_term(arg0: &mut MemoryVault, arg1: &AccessReceipt, arg2: u64) {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_delete(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_short_term(), 12);
        assert!(0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_short_term_key(arg2)), 10);
        0x2::dynamic_field::remove<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermMemory>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_short_term_key(arg2));
        arg0.short_term_count = arg0.short_term_count - 1;
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::short_term_memory_deleted(0x2::object::id<MemoryVault>(arg0), arg2);
    }

    public fun enable_encryption(arg0: &mut MemoryVault, arg1: &MemoryVaultOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        arg0.is_encrypted = true;
        arg0.seal_key_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    public fun episodic_count(arg0: &MemoryVault) : u64 {
        arg0.episodic_count
    }

    public fun has_access(arg0: &MemoryVault, arg1: &MemoryVaultOwnerCap) : bool {
        0x2::object::id<MemoryVault>(arg0) == arg1.for
    }

    public fun has_episodic(arg0: &MemoryVault, arg1: u64) : bool {
        0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::EpisodicKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_episodic_key(arg1))
    }

    public fun has_long_term(arg0: &MemoryVault, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_key(arg1))
    }

    public fun has_semantic(arg0: &MemoryVault, arg1: u256) : bool {
        0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_semantic_index_key(arg1))
    }

    public fun has_short_term(arg0: &MemoryVault, arg1: u64) : bool {
        0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_short_term_key(arg1))
    }

    public fun is_encrypted(arg0: &MemoryVault) : bool {
        arg0.is_encrypted
    }

    public fun last_access_ts(arg0: &MemoryVault) : u64 {
        arg0.last_access_ts
    }

    public fun last_owner_activity_ts(arg0: &MemoryVault) : u64 {
        arg0.last_owner_activity_ts
    }

    public fun long_term_count(arg0: &MemoryVault) : u64 {
        arg0.long_term_count
    }

    public fun new_with_policy(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : (MemoryVault, MemoryVaultOwnerCap, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicyCap) {
        let (v0, v1) = 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::new(arg2);
        let v2 = v0;
        let v3 = 0x2::object::id<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy>(&v2);
        let v4 = MemoryVault{
            id                     : 0x2::object::new(arg2),
            owner                  : arg0,
            policy_id              : v3,
            agent_id               : arg1,
            short_term_count       : 0,
            long_term_count        : 0,
            episodic_count         : 0,
            semantic_count         : 0,
            next_short_term_id     : 0,
            next_episode_id        : 0,
            short_term_limit       : 100,
            first_short_term_id    : 0,
            last_access_ts         : 0x2::tx_context::epoch_timestamp_ms(arg2),
            last_owner_activity_ts : 0x2::tx_context::epoch_timestamp_ms(arg2),
            seal_key_id            : 0x1::option::none<0x2::object::ID>(),
            is_encrypted           : false,
        };
        let v5 = MemoryVaultOwnerCap{
            id  : 0x2::object::new(arg2),
            for : 0x2::object::id<MemoryVault>(&v4),
        };
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::vault_created(0x2::object::id<MemoryVault>(&v4), arg0, arg1, v3);
        (v4, v5, v2, v1)
    }

    public fun owner(arg0: &MemoryVault) : address {
        arg0.owner
    }

    public fun policy_id(arg0: &MemoryVault) : 0x2::object::ID {
        arg0.policy_id
    }

    fun prune_oldest_short_term(arg0: &mut MemoryVault) {
        while (arg0.short_term_count > arg0.short_term_limit) {
            let v0 = arg0.first_short_term_id;
            if (0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_short_term_key(v0))) {
                0x2::dynamic_field::remove<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermMemory>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_short_term_key(v0));
                arg0.short_term_count = arg0.short_term_count - 1;
                0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::short_term_memory_deleted(0x2::object::id<MemoryVault>(arg0), v0);
            };
            arg0.first_short_term_id = arg0.first_short_term_id + 1;
        };
    }

    public fun read_episodic(arg0: &MemoryVault, arg1: &AccessReceipt, arg2: u64) : &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::EpisodicMemory {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_read(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_episodic(), 12);
        assert!(0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::EpisodicKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_episodic_key(arg2)), 10);
        0x2::dynamic_field::borrow<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::EpisodicKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::EpisodicMemory>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_episodic_key(arg2))
    }

    public fun read_long_term(arg0: &mut MemoryVault, arg1: &AccessReceipt, arg2: vector<u8>) : &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermMemory {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_read(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_long_term(), 12);
        assert!(0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_key(arg2)), 10);
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::increment_access_count(0x2::dynamic_field::borrow_mut<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermMemory>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_key(arg2)));
        0x2::dynamic_field::borrow<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermMemory>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_key(arg2))
    }

    public fun read_semantic_index(arg0: &MemoryVault, arg1: &AccessReceipt, arg2: u256) : &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexEntry {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_read(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_semantic(), 12);
        assert!(0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_semantic_index_key(arg2)), 10);
        0x2::dynamic_field::borrow<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexEntry>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_semantic_index_key(arg2))
    }

    public fun read_short_term(arg0: &MemoryVault, arg1: &AccessReceipt, arg2: u64) : &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermMemory {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_read(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_short_term(), 12);
        assert!(0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_short_term_key(arg2)), 10);
        0x2::dynamic_field::borrow<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermMemory>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_short_term_key(arg2))
    }

    public fun request_access(arg0: &MemoryVault, arg1: u8, arg2: u8, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) : 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessRequest {
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::new_request(0x2::object::id<MemoryVault>(arg0), arg1, arg2, arg3, arg4)
    }

    public fun revoke_share(arg0: VaultShare) {
        let VaultShare {
            id           : v0,
            vault_id     : _,
            agent        : _,
            access_level : _,
            expires_at   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun seal_key_id(arg0: &MemoryVault) : 0x1::option::Option<0x2::object::ID> {
        arg0.seal_key_id
    }

    public fun semantic_count(arg0: &MemoryVault) : u64 {
        arg0.semantic_count
    }

    public fun set_owner(arg0: &mut MemoryVault, arg1: &MemoryVaultOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        arg0.owner = 0x2::tx_context::sender(arg2);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    public fun set_short_term_limit(arg0: &mut MemoryVault, arg1: &MemoryVaultOwnerCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        arg0.short_term_limit = arg2;
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    public fun share_access_level(arg0: &VaultShare) : u8 {
        arg0.access_level
    }

    public fun share_agent(arg0: &VaultShare) : address {
        arg0.agent
    }

    public fun share_expires_at(arg0: &VaultShare) : u64 {
        arg0.expires_at
    }

    public fun share_vault_id(arg0: &VaultShare) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun short_term_count(arg0: &MemoryVault) : u64 {
        arg0.short_term_count
    }

    public fun short_term_limit(arg0: &MemoryVault) : u64 {
        arg0.short_term_limit
    }

    public fun store_episodic(arg0: &mut MemoryVault, arg1: &AccessReceipt, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: bool, arg10: 0x1::option::Option<0x2::object::ID>) : u64 {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_write(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_episodic(), 12);
        let v0 = arg0.next_episode_id;
        arg0.next_episode_id = arg0.next_episode_id + 1;
        0x2::dynamic_field::add<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::EpisodicKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::EpisodicMemory>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_episodic_key(v0), 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_episodic_memory(v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
        arg0.episodic_count = arg0.episodic_count + 1;
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::episodic_memory_stored(0x2::object::id<MemoryVault>(arg0), v0, arg2, 0x2::hash::blake2b256(&arg3), arg5, arg9);
        v0
    }

    public fun store_long_term(arg0: &mut MemoryVault, arg1: &AccessReceipt, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: bool, arg9: 0x1::option::Option<0x2::object::ID>, arg10: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_write(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_long_term(), 12);
        assert!(!0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_key(arg2)), 11);
        0x2::dynamic_field::add<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermMemory>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_key(arg2), 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_memory(arg2, arg3, arg4, arg5, arg6, 0x2::tx_context::epoch_timestamp_ms(arg10), arg7, arg8, arg9));
        arg0.long_term_count = arg0.long_term_count + 1;
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::long_term_memory_stored(0x2::object::id<MemoryVault>(arg0), arg2, arg3, 0x2::hash::blake2b256(&arg4), arg8);
    }

    public fun store_semantic_index(arg0: &mut MemoryVault, arg1: &AccessReceipt, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u64>, arg7: u32, arg8: vector<u8>, arg9: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_write(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_semantic(), 12);
        assert!(!0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_semantic_index_key(arg2)), 11);
        0x2::dynamic_field::add<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::SemanticIndexEntry>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_semantic_index_key(arg2), 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_semantic_index_entry(arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::tx_context::epoch_timestamp_ms(arg9)));
        arg0.semantic_count = arg0.semantic_count + 1;
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::semantic_index_updated(0x2::object::id<MemoryVault>(arg0), arg2, arg3, arg4);
    }

    public fun store_short_term(arg0: &mut MemoryVault, arg1: &AccessReceipt, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: bool, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::tx_context::TxContext) : u64 {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_write(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_short_term(), 12);
        let v0 = arg0.next_short_term_id;
        arg0.next_short_term_id = arg0.next_short_term_id + 1;
        0x2::dynamic_field::add<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::ShortTermMemory>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_short_term_key(v0), 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_short_term_memory(v0, arg2, arg3, 0x2::tx_context::epoch_timestamp_ms(arg7), arg4, arg5, arg6));
        arg0.short_term_count = arg0.short_term_count + 1;
        if (arg0.short_term_count > arg0.short_term_limit) {
            prune_oldest_short_term(arg0);
        };
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::short_term_memory_stored(0x2::object::id<MemoryVault>(arg0), v0, 0x2::hash::blake2b256(&arg3), arg5);
        v0
    }

    public fun touch(arg0: &mut MemoryVault, arg1: &MemoryVaultOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        arg0.last_owner_activity_ts = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    public fun uid(arg0: &MemoryVault) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut MemoryVault) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun uid_mut_as_owner(arg0: &mut MemoryVault, arg1: &MemoryVaultOwnerCap) : &mut 0x2::object::UID {
        assert!(has_access(arg0, arg1), 0);
        &mut arg0.id
    }

    public fun update_long_term(arg0: &mut MemoryVault, arg1: &AccessReceipt, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<MemoryVault>(arg0), 1);
        assert!(arg1.access_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::access_type_write(), 3);
        assert!(arg1.memory_type == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::memory_type_long_term(), 12);
        assert!(0x2::dynamic_field::exists_<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermKey>(&arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_key(arg2)), 10);
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::update_long_term_content(0x2::dynamic_field::borrow_mut<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermKey, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::LongTermMemory>(&mut arg0.id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::memory_types::new_long_term_key(arg2)), arg3, 0x2::tx_context::epoch_timestamp_ms(arg4));
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::long_term_memory_updated(0x2::object::id<MemoryVault>(arg0), arg2, 0x2::hash::blake2b256(&arg3));
    }

    public fun vault_owner_cap_for(arg0: &MemoryVaultOwnerCap) : 0x2::object::ID {
        arg0.for
    }

    public fun verify_access(arg0: &mut MemoryVault, arg1: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, arg2: 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessRequest, arg3: &0x2::tx_context::TxContext) : AccessReceipt {
        assert!(0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::vault_id(&arg2) == 0x2::object::id<MemoryVault>(arg0), 4);
        assert!(0x2::object::id<0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy>(arg1) == arg0.policy_id, 2);
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::enforce_request(arg1, &arg2);
        let (v0, v1, v2, v3) = 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::destroy_request(arg2);
        arg0.last_access_ts = 0x2::tx_context::epoch_timestamp_ms(arg3);
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::access_granted(v0, 0x2::tx_context::sender(arg3), v1, v2);
        AccessReceipt{
            vault_id    : v0,
            access_type : v1,
            memory_type : v2,
            memory_key  : v3,
        }
    }

    // decompiled from Move bytecode v6
}

