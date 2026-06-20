module 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::agent_auth {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        max_trade_size: u64,
        max_deployment_bps: u64,
        active: bool,
        last_trade_timestamp_ms: u64,
        total_trades: u64,
        total_volume: u64,
    }

    struct TradeRecordEvent has copy, drop {
        vault_id: 0x2::object::ID,
        agent: address,
        trade_type: u8,
        amount: u64,
        price: u64,
        walrus_blob_id: vector<u8>,
        reasoning_hash: vector<u8>,
        timestamp_ms: u64,
        guardian_approved: bool,
        confidence: u8,
    }

    struct AgentAuthorizedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        agent_cap_id: 0x2::object::ID,
        agent: address,
        max_trade_size: u64,
        max_deployment_bps: u64,
    }

    struct AgentRevokedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        agent_cap_id: 0x2::object::ID,
    }

    struct CooldownViolationEvent has copy, drop {
        vault_id: 0x2::object::ID,
        agent: address,
        time_since_last_ms: u64,
        required_interval_ms: u64,
    }

    public fun admin_cap_vault_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun agent_cap_active(arg0: &AgentCap) : bool {
        arg0.active
    }

    public fun agent_cap_last_trade_ms(arg0: &AgentCap) : u64 {
        arg0.last_trade_timestamp_ms
    }

    public fun agent_cap_max_trade_size(arg0: &AgentCap) : u64 {
        arg0.max_trade_size
    }

    public fun agent_cap_total_trades(arg0: &AgentCap) : u64 {
        arg0.total_trades
    }

    public fun agent_cap_total_volume(arg0: &AgentCap) : u64 {
        arg0.total_volume
    }

    public fun agent_cap_vault_id(arg0: &AgentCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun authorize_agent(arg0: &AdminCap, arg1: &0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg1), 100);
        let v0 = AgentCap{
            id                      : 0x2::object::new(arg5),
            vault_id                : 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg1),
            max_trade_size          : arg3,
            max_deployment_bps      : arg4,
            active                  : true,
            last_trade_timestamp_ms : 0,
            total_trades            : 0,
            total_volume            : 0,
        };
        0x2::transfer::transfer<AgentCap>(v0, arg2);
        let v1 = AgentAuthorizedEvent{
            vault_id           : 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg1),
            agent_cap_id       : 0x2::object::id<AgentCap>(&v0),
            agent              : arg2,
            max_trade_size     : arg3,
            max_deployment_bps : arg4,
        };
        0x2::event::emit<AgentAuthorizedEvent>(v1);
    }

    public fun create_admin_cap(arg0: &0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::vault_creator(arg0), 102);
        let v0 = AdminCap{
            id       : 0x2::object::new(arg1),
            vault_id : 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_admin_cap_returning(arg0: &0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::tx_context::sender(arg1) == 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::vault_creator(arg0), 102);
        AdminCap{
            id       : 0x2::object::new(arg1),
            vault_id : 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg0),
        }
    }

    public fun pause_vault(arg0: &AdminCap, arg1: &mut 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault) {
        assert!(arg0.vault_id == 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg1), 100);
        0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::set_paused(arg1, true);
    }

    public fun record_trade(arg0: &mut AgentCap, arg1: &0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault, arg2: u8, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: bool, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 107);
        assert!(arg0.vault_id == 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg1), 100);
        assert!(arg3 <= arg0.max_trade_size, 101);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        arg0.total_trades = arg0.total_trades + 1;
        arg0.total_volume = arg0.total_volume + arg3;
        arg0.last_trade_timestamp_ms = v0;
        let v1 = TradeRecordEvent{
            vault_id          : arg0.vault_id,
            agent             : 0x2::tx_context::sender(arg10),
            trade_type        : arg2,
            amount            : arg3,
            price             : arg4,
            walrus_blob_id    : arg5,
            reasoning_hash    : arg6,
            timestamp_ms      : v0,
            guardian_approved : arg7,
            confidence        : arg8,
        };
        0x2::event::emit<TradeRecordEvent>(v1);
    }

    public fun return_from_trading(arg0: &AgentCap, arg1: &mut 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.active, 107);
        assert!(arg0.vault_id == 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg1), 100);
        0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::return_from_deployment(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun revoke_agent(arg0: &AdminCap, arg1: AgentCap) {
        assert!(arg0.vault_id == arg1.vault_id, 100);
        let AgentCap {
            id                      : v0,
            vault_id                : _,
            max_trade_size          : _,
            max_deployment_bps      : _,
            active                  : _,
            last_trade_timestamp_ms : _,
            total_trades            : _,
            total_volume            : _,
        } = arg1;
        0x2::object::delete(v0);
        let v8 = AgentRevokedEvent{
            vault_id     : arg1.vault_id,
            agent_cap_id : 0x2::object::id<AgentCap>(&arg1),
        };
        0x2::event::emit<AgentRevokedEvent>(v8);
    }

    public fun set_performance_fee(arg0: &AdminCap, arg1: &mut 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault, arg2: u64) {
        assert!(arg0.vault_id == 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg1), 100);
        0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::set_performance_fee(arg1, arg2);
    }

    public fun unpause_vault(arg0: &AdminCap, arg1: &mut 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault) {
        assert!(arg0.vault_id == 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg1), 100);
        0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::set_paused(arg1, false);
    }

    public fun validate_trade_size(arg0: &AgentCap, arg1: u64) : bool {
        arg0.active && arg1 <= arg0.max_trade_size
    }

    public fun withdraw_fees(arg0: &AdminCap, arg1: &mut 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg1), 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::withdraw_fees(arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_for_trading(arg0: &mut AgentCap, arg1: &mut 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault, arg2: &0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::strategy::StrategyConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.active, 107);
        assert!(arg0.vault_id == 0x2::object::id<0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::Vault>(arg1), 100);
        assert!(!0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::vault_paused(arg1), 109);
        assert!(0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::strategy::is_active(arg2), 108);
        assert!(arg3 <= arg0.max_trade_size, 101);
        let v0 = 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::vault_balance(arg1) + 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::vault_deployed_amount(arg1);
        assert!(0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::vault_deployed_amount(arg1) + arg3 <= (((v0 as u128) * (arg0.max_deployment_bps as u128) / 10000) as u64), 103);
        assert!(arg3 <= (((v0 as u128) * (0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::strategy::max_position_bps(arg2) as u128) / 10000) as u64), 105);
        let v1 = 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::strategy::min_trade_interval_sec(arg2) * 1000;
        if (arg0.last_trade_timestamp_ms > 0 && v1 > 0) {
            let v2 = 0x2::clock::timestamp_ms(arg4) - arg0.last_trade_timestamp_ms;
            if (v2 < v1) {
                let v3 = CooldownViolationEvent{
                    vault_id             : arg0.vault_id,
                    agent                : 0x2::tx_context::sender(arg5),
                    time_since_last_ms   : v2,
                    required_interval_ms : v1,
                };
                0x2::event::emit<CooldownViolationEvent>(v3);
                abort 104
            };
        };
        0x2::coin::from_balance<0x2::sui::SUI>(0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault::withdraw_for_deployment(arg1, arg3), arg5)
    }

    // decompiled from Move bytecode v6
}

