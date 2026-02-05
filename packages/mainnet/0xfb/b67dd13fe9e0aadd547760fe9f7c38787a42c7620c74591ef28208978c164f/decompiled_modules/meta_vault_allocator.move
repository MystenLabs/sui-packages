module 0xfbb67dd13fe9e0aadd547760fe9f7c38787a42c7620c74591ef28208978c164f::meta_vault_allocator {
    struct AllocatorState has store {
        last_rebalance: u64,
        min_rebalance_interval: u64,
    }

    public fun assert_rebalance_interval(arg0: &AllocatorState, arg1: u64) {
        if (arg0.min_rebalance_interval > 0 && arg0.last_rebalance > 0) {
            assert!(arg1 - arg0.last_rebalance >= arg0.min_rebalance_interval, 1);
        };
    }

    public fun check_rebalance_interval(arg0: &AllocatorState, arg1: u64) : bool {
        if (arg0.min_rebalance_interval == 0) {
            return true
        };
        if (arg0.last_rebalance == 0) {
            return true
        };
        arg1 - arg0.last_rebalance >= arg0.min_rebalance_interval
    }

    public fun get_last_rebalance(arg0: &AllocatorState) : u64 {
        arg0.last_rebalance
    }

    public fun get_min_interval(arg0: &AllocatorState) : u64 {
        arg0.min_rebalance_interval
    }

    public fun get_rebalance_config(arg0: &AllocatorState) : (u64, u64) {
        (arg0.min_rebalance_interval, arg0.last_rebalance)
    }

    public fun new() : AllocatorState {
        AllocatorState{
            last_rebalance         : 0,
            min_rebalance_interval : 3600,
        }
    }

    public(friend) fun set_min_rebalance_interval(arg0: &mut AllocatorState, arg1: &0xfbb67dd13fe9e0aadd547760fe9f7c38787a42c7620c74591ef28208978c164f::meta_vault_governance::Governance, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xfbb67dd13fe9e0aadd547760fe9f7c38787a42c7620c74591ef28208978c164f::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg4));
        arg0.min_rebalance_interval = arg2;
        0xfbb67dd13fe9e0aadd547760fe9f7c38787a42c7620c74591ef28208978c164f::meta_vault_events::emit_set_min_rebalance_interval(arg3, arg2, arg4);
    }

    public(friend) fun update_last_rebalance(arg0: &mut AllocatorState, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        arg0.last_rebalance = arg1;
        0xfbb67dd13fe9e0aadd547760fe9f7c38787a42c7620c74591ef28208978c164f::meta_vault_events::emit_update_last_rebalance(arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

