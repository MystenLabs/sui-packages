module 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::agent_cap {
    struct AgentCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        agent: address,
        spend_limit_per_tx: u64,
        spend_limit_daily: u64,
        spent_today: u64,
        last_reset_epoch: u64,
        cooldown_count: u64,
        last_action_epoch: u64,
        revoked: bool,
    }

    public fun agent(arg0: &AgentCap) : address {
        arg0.agent
    }

    public(friend) fun create_cap(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : AgentCap {
        AgentCap{
            id                 : 0x2::object::new(arg4),
            vault_id           : arg0,
            agent              : arg1,
            spend_limit_per_tx : arg2,
            spend_limit_daily  : arg3,
            spent_today        : 0,
            last_reset_epoch   : 0x2::tx_context::epoch(arg4),
            cooldown_count     : 0,
            last_action_epoch  : 0x2::tx_context::epoch(arg4),
            revoked            : false,
        }
    }

    public fun last_reset_epoch(arg0: &AgentCap) : u64 {
        arg0.last_reset_epoch
    }

    public fun revoked(arg0: &AgentCap) : bool {
        arg0.revoked
    }

    public(friend) fun set_limits(arg0: &mut AgentCap, arg1: u64, arg2: u64) {
        arg0.spend_limit_per_tx = arg1;
        arg0.spend_limit_daily = arg2;
    }

    public(friend) fun set_revoked(arg0: &mut AgentCap, arg1: bool) {
        arg0.revoked = arg1;
    }

    public fun spend_limit_daily(arg0: &AgentCap) : u64 {
        arg0.spend_limit_daily
    }

    public fun spend_limit_per_tx(arg0: &AgentCap) : u64 {
        arg0.spend_limit_per_tx
    }

    public fun spent_today(arg0: &AgentCap) : u64 {
        arg0.spent_today
    }

    public fun vault_id(arg0: &AgentCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun verify_and_update_limits(arg0: &mut AgentCap, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.revoked, 1);
        assert!(arg0.vault_id == arg1, 2);
        assert!(arg0.agent == 0x2::tx_context::sender(arg3), 3);
        assert!(arg2 <= arg0.spend_limit_per_tx, 4);
        let v0 = 0x2::tx_context::epoch(arg3);
        if (arg0.last_action_epoch < v0) {
            arg0.cooldown_count = 0;
            arg0.last_action_epoch = v0;
        };
        assert!(arg0.cooldown_count < 10, 5);
        arg0.cooldown_count = arg0.cooldown_count + 1;
        if (arg0.last_reset_epoch < v0) {
            arg0.spent_today = 0;
            arg0.last_reset_epoch = v0;
        };
        assert!(arg0.spent_today + arg2 <= arg0.spend_limit_daily, 6);
        arg0.spent_today = arg0.spent_today + arg2;
    }

    // decompiled from Move bytecode v7
}

