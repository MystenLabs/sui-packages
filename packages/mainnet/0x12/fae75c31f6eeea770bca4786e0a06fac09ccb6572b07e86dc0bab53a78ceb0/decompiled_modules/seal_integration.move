module 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::seal_integration {
    struct EncryptionMeta has copy, drop, store {
        seal_key_id: 0x2::object::ID,
        algorithm: vector<u8>,
        nonce: vector<u8>,
        aad_hash: vector<u8>,
    }

    struct DecryptionRequest has copy, drop {
        memory_id: vector<u8>,
        vault_id: 0x2::object::ID,
        session_id: 0x2::object::ID,
        created_at: u64,
    }

    struct EncryptionEnabled has copy, drop {
        vault_id: 0x2::object::ID,
        seal_key_id: 0x2::object::ID,
    }

    struct DecryptionAuthorized has copy, drop {
        vault_id: 0x2::object::ID,
        memory_id: vector<u8>,
        session_id: 0x2::object::ID,
    }

    public fun enable_encryption(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVaultOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::enable_encryption(arg0, arg1, arg2, arg3);
        let v0 = EncryptionEnabled{
            vault_id    : 0x2::object::id<0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault>(arg0),
            seal_key_id : arg2,
        };
        0x2::event::emit<EncryptionEnabled>(v0);
    }

    public fun decryption_request_created_at(arg0: &DecryptionRequest) : u64 {
        arg0.created_at
    }

    public fun decryption_request_memory_id(arg0: &DecryptionRequest) : vector<u8> {
        arg0.memory_id
    }

    public fun decryption_request_session_id(arg0: &DecryptionRequest) : 0x2::object::ID {
        arg0.session_id
    }

    public fun decryption_request_vault_id(arg0: &DecryptionRequest) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun encryption_meta_aad_hash(arg0: &EncryptionMeta) : vector<u8> {
        arg0.aad_hash
    }

    public fun encryption_meta_algorithm(arg0: &EncryptionMeta) : vector<u8> {
        arg0.algorithm
    }

    public fun encryption_meta_nonce(arg0: &EncryptionMeta) : vector<u8> {
        arg0.nonce
    }

    public fun encryption_meta_seal_key_id(arg0: &EncryptionMeta) : 0x2::object::ID {
        arg0.seal_key_id
    }

    public fun new_decryption_request(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : DecryptionRequest {
        DecryptionRequest{
            memory_id  : arg0,
            vault_id   : arg1,
            session_id : arg2,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        }
    }

    public fun new_encryption_meta(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : EncryptionMeta {
        EncryptionMeta{
            seal_key_id : arg0,
            algorithm   : arg1,
            nonce       : arg2,
            aad_hash    : arg3,
        }
    }

    entry fun seal_approve_episodic(arg0: u64, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault, arg2: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::is_encrypted(arg1), 0);
        assert!(arg3 == 0x2::object::id<0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault>(arg1), 2);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg5) < arg4, 1);
        assert!(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::has_episodic(arg1, arg0), 3);
    }

    entry fun seal_approve_long_term(arg0: vector<u8>, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault, arg2: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::is_encrypted(arg1), 0);
        assert!(arg3 == 0x2::object::id<0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault>(arg1), 2);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg5) < arg4, 1);
        assert!(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::has_long_term(arg1, arg0), 3);
    }

    entry fun seal_approve_short_term(arg0: u64, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault, arg2: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::is_encrypted(arg1), 0);
        assert!(arg3 == 0x2::object::id<0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault>(arg1), 2);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg5) < arg4, 1);
        assert!(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::has_short_term(arg1, arg0), 3);
    }

    // decompiled from Move bytecode v6
}

