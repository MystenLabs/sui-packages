module 0x3aa029e3754556b242bcf3e8411e5e84ecfc2a29ac3e99c207ffbca1bf63825::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        registered_agents: 0x2::table::Table<vector<u8>, address>,
        bound_wallets: 0x2::table::Table<vector<u8>, address>,
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

    public fun bind_trading_wallet(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, address>(&arg1.registered_agents, arg2), 1);
        assert!(*0x2::table::borrow<vector<u8>, address>(&arg1.registered_agents, arg2) == arg3, 2);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg1.bound_wallets, arg2), 3);
        arg1.version = arg1.version + 1;
        0x2::table::add<vector<u8>, address>(&mut arg1.bound_wallets, arg2, arg4);
        let v0 = TradingWalletBound{
            agent_id : arg2,
            owner    : arg3,
            wallet   : arg4,
            version  : arg1.version,
        };
        0x2::event::emit<TradingWalletBound>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_registry(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : Registry {
        Registry{
            id                : 0x2::object::new(arg0),
            version           : 0,
            registered_agents : 0x2::table::new<vector<u8>, address>(arg0),
            bound_wallets     : 0x2::table::new<vector<u8>, address>(arg0),
        }
    }

    public fun record_runtime_credential_rotation(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, address>(&arg1.registered_agents, arg2), 1);
        assert!(*0x2::table::borrow<vector<u8>, address>(&arg1.registered_agents, arg2) == arg3, 2);
        assert!(arg5 == arg4 + 1, 4);
        arg1.version = arg1.version + 1;
        let v0 = RuntimeCredentialRotated{
            agent_id         : arg2,
            owner            : arg3,
            previous_version : arg4,
            next_version     : arg5,
            rotation_hash    : arg6,
            version          : arg1.version,
        };
        0x2::event::emit<RuntimeCredentialRotated>(v0);
    }

    public fun register_agent(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<vector<u8>, address>(&arg1.registered_agents, arg2), 0);
        arg1.version = arg1.version + 1;
        0x2::table::add<vector<u8>, address>(&mut arg1.registered_agents, arg2, arg3);
        let v0 = AgentRegistered{
            agent_id      : arg2,
            owner         : arg3,
            metadata_hash : arg4,
            version       : arg1.version,
        };
        0x2::event::emit<AgentRegistered>(v0);
    }

    public fun registered_owner(arg0: &Registry, arg1: vector<u8>) : address {
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.registered_agents, arg1), 1);
        *0x2::table::borrow<vector<u8>, address>(&arg0.registered_agents, arg1)
    }

    public fun version(arg0: &Registry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

