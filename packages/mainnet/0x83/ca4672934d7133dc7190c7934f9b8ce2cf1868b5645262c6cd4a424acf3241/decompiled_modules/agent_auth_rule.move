module 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::agent_auth_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct AgentSession has copy, drop, store {
        public_key: vector<u8>,
        access_level: u8,
        expires_at: u64,
        nonce: u64,
    }

    struct Config has store {
        vault_id: 0x2::object::ID,
        agents: 0x2::table::Table<address, AgentSession>,
        next_nonce: u64,
    }

    public fun add(arg0: &mut 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy, arg1: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicyCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            vault_id   : arg2,
            agents     : 0x2::table::new<address, AgentSession>(arg3),
            next_nonce : 0,
        };
        0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::add_main_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun access_level_full() : u8 {
        2
    }

    public fun access_level_read() : u8 {
        0
    }

    public fun access_level_read_write() : u8 {
        1
    }

    public fun authorize_agent(arg0: &mut 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy, arg1: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicyCap, arg2: address, arg3: vector<u8>, arg4: u8, arg5: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert!(!0x2::table::contains<address, AgentSession>(&v1.agents, arg2), 3);
        v1.next_nonce = v1.next_nonce + 1;
        let v2 = AgentSession{
            public_key   : arg3,
            access_level : arg4,
            expires_at   : arg5,
            nonce        : v1.next_nonce,
        };
        0x2::table::add<address, AgentSession>(&mut v1.agents, arg2, v2);
        0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::events::agent_authorized(v1.vault_id, 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::policy_id(arg0), arg2, arg3, arg5);
    }

    public fun deauthorize_agent(arg0: &mut 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy, arg1: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicyCap, arg2: address) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert!(0x2::table::contains<address, AgentSession>(&v1.agents, arg2), 4);
        0x2::table::remove<address, AgentSession>(&mut v1.agents, arg2);
        0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::events::agent_deauthorized(v1.vault_id, 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::policy_id(arg0), arg2);
    }

    public fun get_agent_session(arg0: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy, arg1: address) : (vector<u8>, u8, u64, u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::get_rule<Rule, Config>(v0, arg0);
        assert!(0x2::table::contains<address, AgentSession>(&v1.agents, arg1), 4);
        let v2 = 0x2::table::borrow<address, AgentSession>(&v1.agents, arg1);
        (v2.public_key, v2.access_level, v2.expires_at, v2.nonce)
    }

    public fun is_authorized(arg0: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy, arg1: address) : bool {
        let v0 = Rule{dummy_field: false};
        0x2::table::contains<address, AgentSession>(&0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::get_rule<Rule, Config>(v0, arg0).agents, arg1)
    }

    public fun is_configured(arg0: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy) : bool {
        0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::has_rule<Rule>(arg0)
    }

    public fun prove(arg0: &mut 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessRequest, arg1: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy, arg2: address, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::get_rule<Rule, Config>(v0, arg1);
        assert!(0x2::table::contains<address, AgentSession>(&v1.agents, arg2), 0);
        let v2 = 0x2::table::borrow<address, AgentSession>(&v1.agents, arg2);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg4) < v2.expires_at, 1);
        let v3 = 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::access_type(arg0);
        let v4 = if (v3 == 0 && v2.access_level >= 0) {
            true
        } else if (v3 == 1 && v2.access_level >= 1) {
            true
        } else {
            v3 == 2 && v2.access_level >= 2
        };
        assert!(v4, 0);
        let v5 = b"";
        let v6 = 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::vault_id(arg0);
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<0x2::object::ID>(&v6));
        0x1::vector::push_back<u8>(&mut v5, v3);
        0x1::vector::push_back<u8>(&mut v5, 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::memory_type(arg0));
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<u64>(&v2.nonce));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v2.public_key, &v5), 2);
        let v7 = Rule{dummy_field: false};
        0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::add_receipt<Rule>(v7, arg0);
    }

    public fun prove_by_address(arg0: &mut 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessRequest, arg1: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy, arg2: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::get_rule<Rule, Config>(v0, arg1);
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, AgentSession>(&v1.agents, v2), 0);
        let v3 = 0x2::table::borrow<address, AgentSession>(&v1.agents, v2);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg2) < v3.expires_at, 1);
        let v4 = 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::access_type(arg0);
        let v5 = if (v4 == 0 && v3.access_level >= 0) {
            true
        } else if (v4 == 1 && v3.access_level >= 1) {
            true
        } else {
            v4 == 2 && v3.access_level >= 2
        };
        assert!(v5, 0);
        let v6 = Rule{dummy_field: false};
        0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::add_receipt<Rule>(v6, arg0);
    }

    public fun update_agent(arg0: &mut 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicy, arg1: &0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::AccessPolicyCap, arg2: address, arg3: vector<u8>, arg4: u8, arg5: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x83ca4672934d7133dc7190c7934f9b8ce2cf1868b5645262c6cd4a424acf3241::access_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert!(0x2::table::contains<address, AgentSession>(&v1.agents, arg2), 4);
        v1.next_nonce = v1.next_nonce + 1;
        let v2 = 0x2::table::borrow_mut<address, AgentSession>(&mut v1.agents, arg2);
        v2.public_key = arg3;
        v2.access_level = arg4;
        v2.expires_at = arg5;
        v2.nonce = v1.next_nonce;
    }

    // decompiled from Move bytecode v6
}

