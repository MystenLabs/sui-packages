module 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::seal_policy {
    struct StrategyVault has key {
        id: 0x2::object::UID,
        owner: address,
        agent_address: address,
        encrypted_blob_id: vector<u8>,
        description: vector<u8>,
        created_at_ms: u64,
        expiry_ms: u64,
        revoked: bool,
    }

    struct StrategyStored has copy, drop {
        vault_id: address,
        agent_address: address,
        blob_id: vector<u8>,
        timestamp_ms: u64,
    }

    struct StrategyAccessed has copy, drop {
        vault_id: address,
        accessor: address,
        timestamp_ms: u64,
    }

    struct StrategyRevoked has copy, drop {
        vault_id: address,
        timestamp_ms: u64,
    }

    public fun create_strategy_vault(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyVault{
            id                : 0x2::object::new(arg6),
            owner             : 0x2::tx_context::sender(arg6),
            agent_address     : arg1,
            encrypted_blob_id : arg2,
            description       : arg3,
            created_at_ms     : 0x2::clock::timestamp_ms(arg5),
            expiry_ms         : arg4,
            revoked           : false,
        };
        let v1 = StrategyStored{
            vault_id      : 0x2::object::uid_to_address(&v0.id),
            agent_address : arg1,
            blob_id       : arg2,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<StrategyStored>(v1);
        0x2::transfer::share_object<StrategyVault>(v0);
    }

    public fun revoke_strategy(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: &mut StrategyVault, arg2: &0x2::clock::Clock) {
        arg1.revoked = true;
        let v0 = StrategyRevoked{
            vault_id     : 0x2::object::uid_to_address(&arg1.id),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<StrategyRevoked>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &StrategyVault, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.owner || v0 == arg1.agent_address, 400);
        assert!(!arg1.revoked, 400);
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.expiry_ms, 401);
        let v1 = StrategyAccessed{
            vault_id     : 0x2::object::uid_to_address(&arg1.id),
            accessor     : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<StrategyAccessed>(v1);
    }

    public fun update_blob_id(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: &mut StrategyVault, arg2: vector<u8>) {
        arg1.encrypted_blob_id = arg2;
    }

    public fun vault_agent(arg0: &StrategyVault) : address {
        arg0.agent_address
    }

    public fun vault_blob_id(arg0: &StrategyVault) : vector<u8> {
        arg0.encrypted_blob_id
    }

    public fun vault_expiry(arg0: &StrategyVault) : u64 {
        arg0.expiry_ms
    }

    public fun vault_owner(arg0: &StrategyVault) : address {
        arg0.owner
    }

    public fun vault_revoked(arg0: &StrategyVault) : bool {
        arg0.revoked
    }

    // decompiled from Move bytecode v7
}

