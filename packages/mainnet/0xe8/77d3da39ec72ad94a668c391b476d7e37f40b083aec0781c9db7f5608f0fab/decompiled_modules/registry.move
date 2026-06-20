module 0xe877d3da39ec72ad94a668c391b476d7e37f40b083aec0781c9db7f5608f0fab::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        registered_agents: 0x2::table::Table<vector<u8>, address>,
        bound_wallets: 0x2::table::Table<vector<u8>, address>,
        consumed_authorizations: 0x2::table::Table<vector<u8>, bool>,
    }

    struct RegisterAgentAuthorization has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        agent_id: vector<u8>,
        owner: address,
        wallet: address,
        metadata_hash: vector<u8>,
        nonce: vector<u8>,
    }

    struct RuntimeCredentialRotationAuthorization has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        agent_id: vector<u8>,
        owner: address,
        previous_version: u64,
        next_version: u64,
        rotation_hash: vector<u8>,
        nonce: vector<u8>,
    }

    struct AgentRegistered has copy, drop {
        agent_id: vector<u8>,
        owner: address,
        metadata_hash: vector<u8>,
        version: u64,
    }

    struct TradingWalletBound has copy, drop {
        agent_id: vector<u8>,
        owner: address,
        wallet: address,
        version: u64,
    }

    struct RuntimeCredentialRotated has copy, drop {
        agent_id: vector<u8>,
        owner: address,
        previous_version: u64,
        next_version: u64,
        rotation_hash: vector<u8>,
        version: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Registry>(new_registry(arg0));
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : Registry {
        Registry{
            id                      : 0x2::object::new(arg0),
            version                 : 0,
            registered_agents       : 0x2::table::new<vector<u8>, address>(arg0),
            bound_wallets           : 0x2::table::new<vector<u8>, address>(arg0),
            consumed_authorizations : 0x2::table::new<vector<u8>, bool>(arg0),
        }
    }

    public fun record_runtime_credential_rotation(arg0: &mut Registry, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg2, 7);
        verify_runtime_credential_rotation_authorization(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &arg7);
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.registered_agents, arg1), 1);
        assert!(*0x2::table::borrow<vector<u8>, address>(&arg0.registered_agents, arg1) == arg2, 2);
        assert!(arg4 == arg3 + 1, 4);
        arg0.version = arg0.version + 1;
        let v0 = RuntimeCredentialRotated{
            agent_id         : arg1,
            owner            : arg2,
            previous_version : arg3,
            next_version     : arg4,
            rotation_hash    : arg5,
            version          : arg0.version,
        };
        0x2::event::emit<RuntimeCredentialRotated>(v0);
    }

    public fun register_agent(arg0: &mut Registry, arg1: vector<u8>, arg2: address, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg2, 7);
        verify_register_agent_authorization(arg0, arg1, arg2, arg3, arg4, arg5, &arg6);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.registered_agents, arg1), 0);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.bound_wallets, arg1), 3);
        arg0.version = arg0.version + 1;
        0x2::table::add<vector<u8>, address>(&mut arg0.registered_agents, arg1, arg2);
        let v0 = AgentRegistered{
            agent_id      : arg1,
            owner         : arg2,
            metadata_hash : arg4,
            version       : arg0.version,
        };
        0x2::event::emit<AgentRegistered>(v0);
        arg0.version = arg0.version + 1;
        0x2::table::add<vector<u8>, address>(&mut arg0.bound_wallets, arg1, arg3);
        let v1 = TradingWalletBound{
            agent_id : arg1,
            owner    : arg2,
            wallet   : arg3,
            version  : arg0.version,
        };
        0x2::event::emit<TradingWalletBound>(v1);
    }

    public fun registered_owner(arg0: &Registry, arg1: vector<u8>) : address {
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.registered_agents, arg1), 1);
        *0x2::table::borrow<vector<u8>, address>(&arg0.registered_agents, arg1)
    }

    fun verify_authorization<T0: drop>(arg0: &mut Registry, arg1: T0, arg2: &vector<u8>) {
        let v0 = 0x2::bcs::to_bytes<T0>(&arg1);
        let v1 = 0x2::hash::keccak256(&v0);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.consumed_authorizations, v1), 6);
        let v2 = x"e42886d3b827b8513424b660300d0dfbfba98d3e3a1cb11d382c2d47eafceced";
        assert!(0x2::ed25519::ed25519_verify(arg2, &v2, &v1) == true, 5);
        0x2::table::add<vector<u8>, bool>(&mut arg0.consumed_authorizations, v1, true);
    }

    fun verify_register_agent_authorization(arg0: &mut Registry, arg1: vector<u8>, arg2: address, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: &vector<u8>) {
        let v0 = RegisterAgentAuthorization{
            domain        : b"agent-arena-registry:v1:testnet",
            registry      : 0x2::object::id<Registry>(arg0),
            agent_id      : arg1,
            owner         : arg2,
            wallet        : arg3,
            metadata_hash : arg4,
            nonce         : arg5,
        };
        verify_authorization<RegisterAgentAuthorization>(arg0, v0, arg6);
    }

    fun verify_runtime_credential_rotation_authorization(arg0: &mut Registry, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &vector<u8>) {
        let v0 = RuntimeCredentialRotationAuthorization{
            domain           : b"agent-arena-registry:v1:testnet",
            registry         : 0x2::object::id<Registry>(arg0),
            agent_id         : arg1,
            owner            : arg2,
            previous_version : arg3,
            next_version     : arg4,
            rotation_hash    : arg5,
            nonce            : arg6,
        };
        verify_authorization<RuntimeCredentialRotationAuthorization>(arg0, v0, arg7);
    }

    public fun version(arg0: &Registry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

