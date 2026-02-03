module 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::seal_encryption_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct SealSessionKey has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        user: address,
        expires_at: u64,
        seal_key_id: 0x2::object::ID,
    }

    struct Config has store {
        vault_id: 0x2::object::ID,
        active_sessions: 0x2::table::Table<address, 0x2::object::ID>,
    }

    public fun add(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            vault_id        : arg2,
            active_sessions : 0x2::table::new<address, 0x2::object::ID>(arg3),
        };
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::add_stackable_rule<Rule, Config>(v0, arg0, arg1, v1);
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::set_requires_encryption(arg0, arg1, true);
    }

    public fun create_session(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap, arg2: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : SealSessionKey {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        let v2 = 0x2::object::id<0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault>(arg2);
        assert!(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::is_encrypted(arg2), 3);
        let v3 = SealSessionKey{
            id          : 0x2::object::new(arg5),
            vault_id    : v2,
            user        : arg3,
            expires_at  : arg4,
            seal_key_id : 0x1::option::destroy_some<0x2::object::ID>(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::seal_key_id(arg2)),
        };
        let v4 = 0x2::object::id<SealSessionKey>(&v3);
        if (0x2::table::contains<address, 0x2::object::ID>(&v1.active_sessions, arg3)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut v1.active_sessions, arg3);
        };
        0x2::table::add<address, 0x2::object::ID>(&mut v1.active_sessions, arg3, v4);
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::events::seal_session_created(v2, v4, arg3, arg4);
        v3
    }

    public fun has_active_session(arg0: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: address) : bool {
        let v0 = Rule{dummy_field: false};
        0x2::table::contains<address, 0x2::object::ID>(&0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule<Rule, Config>(v0, arg0).active_sessions, arg1)
    }

    public fun is_configured(arg0: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy) : bool {
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::has_rule<Rule>(arg0)
    }

    public fun is_session_expired(arg0: &SealSessionKey, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch_timestamp_ms(arg1) >= arg0.expires_at
    }

    public fun prove(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessRequest, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg2: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault, arg3: &SealSessionKey, arg4: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule<Rule, Config>(v0, arg1);
        let v2 = 0x2::tx_context::sender(arg4);
        assert!(arg3.user == v2, 2);
        assert!(arg3.vault_id == 0x2::object::id<0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault>(arg2), 2);
        assert!(v1.vault_id == 0x2::object::id<0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault>(arg2), 2);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg4) < arg3.expires_at, 1);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&v1.active_sessions, v2), 0);
        assert!(*0x2::table::borrow<address, 0x2::object::ID>(&v1.active_sessions, v2) == 0x2::object::id<SealSessionKey>(arg3), 0);
        let v3 = Rule{dummy_field: false};
        0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::add_receipt<Rule>(v3, arg0);
    }

    public fun revoke_session(arg0: &mut 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicyCap, arg2: SealSessionKey) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        let SealSessionKey {
            id          : v2,
            vault_id    : v3,
            user        : v4,
            expires_at  : _,
            seal_key_id : _,
        } = arg2;
        let v7 = v2;
        let v8 = 0x2::object::uid_to_inner(&v7);
        if (0x2::table::contains<address, 0x2::object::ID>(&v1.active_sessions, v4)) {
            if (0x2::table::remove<address, 0x2::object::ID>(&mut v1.active_sessions, v4) == v8) {
                0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::events::seal_session_revoked(v3, v8);
            };
        };
        0x2::object::delete(v7);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault, arg2: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::AccessPolicy, arg3: &SealSessionKey, arg4: &0x2::tx_context::TxContext) {
        assert!(arg3.vault_id == 0x2::object::id<0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault>(arg1), 2);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg4) < arg3.expires_at, 1);
        assert!(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy::has_rule<Rule>(arg2), 0);
    }

    public fun session_info(arg0: &SealSessionKey) : (0x2::object::ID, address, u64, 0x2::object::ID) {
        (arg0.vault_id, arg0.user, arg0.expires_at, arg0.seal_key_id)
    }

    // decompiled from Move bytecode v6
}

