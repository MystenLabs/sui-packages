module 0x811ac113fb1b4a5c7bd36ed7ce8aba572f03c1a1c3437643dcbbb936e66ffe7b::token_pool {
    struct LockedOrBurned has copy, drop {
        remote_chain_selector: u64,
        local_token: address,
        amount: u64,
    }

    struct ReleasedOrMinted has copy, drop {
        remote_chain_selector: u64,
        local_token: address,
        recipient: address,
        amount: u64,
    }

    struct RemotePoolAdded has copy, drop {
        remote_chain_selector: u64,
        remote_pool_address: vector<u8>,
    }

    struct RemotePoolRemoved has copy, drop {
        remote_chain_selector: u64,
        remote_pool_address: vector<u8>,
    }

    struct ChainAdded has copy, drop {
        remote_chain_selector: u64,
        remote_token_address: vector<u8>,
    }

    struct LiquidityAdded has copy, drop {
        local_token: address,
        provider: address,
        amount: u64,
    }

    struct LiquidityRemoved has copy, drop {
        local_token: address,
        provider: address,
        amount: u64,
    }

    struct RebalancerSet has copy, drop {
        local_token: address,
        previous_rebalancer: address,
        rebalancer: address,
    }

    struct TokenPoolState has store {
        allowlist_state: AllowlistState,
        coin_metadata: address,
        local_decimals: u8,
        remote_chain_configs: 0x2::vec_map::VecMap<u64, RemoteChainConfig>,
        rate_limiter_config: RateLimitState,
    }

    struct RemoteChainConfig has copy, drop, store {
        remote_token_address: vector<u8>,
        remote_pools: vector<vector<u8>>,
    }

    struct AllowlistState has store, key {
        id: 0x2::object::UID,
        enabled: bool,
        allowlist: vector<address>,
    }

    struct RateLimitState has store, key {
        id: 0x2::object::UID,
        chain_rate_limiters: 0x2::vec_map::VecMap<u64, ChainRateLimiter>,
    }

    struct ChainRateLimiter has drop, store {
        outbound_is_enabled: bool,
        outbound_capacity: u64,
        outbound_rate: u64,
        outbound_current: u64,
        outbound_last_reset: u64,
        inbound_is_enabled: bool,
        inbound_capacity: u64,
        inbound_rate: u64,
        inbound_current: u64,
        inbound_last_reset: u64,
    }

    public fun create_default_test_chain_rate_limiter() : ChainRateLimiter {
        create_test_chain_rate_limiter(true, 1000000, 1000, true, 1000000, 1000)
    }

    public fun create_default_test_remote_chain_config() : RemoteChainConfig {
        create_test_remote_chain_config(x"1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef", vector[x"2234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdea", x"3234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdeb"])
    }

    public fun create_test_allowlist() : vector<address> {
        vector[@0x1, @0x2, @0x3, @0x4]
    }

    public fun create_test_amounts() : vector<u64> {
        vector[1000, 5000, 10000, 50000]
    }

    public fun create_test_chain_rate_limiter(arg0: bool, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64) : ChainRateLimiter {
        ChainRateLimiter{
            outbound_is_enabled : arg0,
            outbound_capacity   : arg1,
            outbound_rate       : arg2,
            outbound_current    : 0,
            outbound_last_reset : 0,
            inbound_is_enabled  : arg3,
            inbound_capacity    : arg4,
            inbound_rate        : arg5,
            inbound_current     : 0,
            inbound_last_reset  : 0,
        }
    }

    public fun create_test_chain_selectors() : vector<u64> {
        vector[1, 137, 42161, 10]
    }

    public fun create_test_providers() : vector<address> {
        vector[@0x5, @0x6, @0x7, @0x8]
    }

    public fun create_test_rebalancers() : vector<address> {
        vector[@0x9, @0xa, @0xb, @0xc]
    }

    public fun create_test_remote_chain_config(arg0: vector<u8>, arg1: vector<vector<u8>>) : RemoteChainConfig {
        RemoteChainConfig{
            remote_token_address : arg0,
            remote_pools         : arg1,
        }
    }

    public fun create_test_remote_pool_addresses() : vector<vector<u8>> {
        vector[x"1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef", x"2234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdea"]
    }

    public fun create_test_remote_token_address() : vector<u8> {
        x"3234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdeb"
    }

    public fun emit_chain_added_event(arg0: u64, arg1: vector<u8>) {
        let v0 = ChainAdded{
            remote_chain_selector : arg0,
            remote_token_address  : arg1,
        };
        0x2::event::emit<ChainAdded>(v0);
    }

    public fun emit_liquidity_added_event(arg0: address, arg1: address, arg2: u64) {
        let v0 = LiquidityAdded{
            local_token : arg0,
            provider    : arg1,
            amount      : arg2,
        };
        0x2::event::emit<LiquidityAdded>(v0);
    }

    public fun emit_liquidity_removed_event(arg0: address, arg1: address, arg2: u64) {
        let v0 = LiquidityRemoved{
            local_token : arg0,
            provider    : arg1,
            amount      : arg2,
        };
        0x2::event::emit<LiquidityRemoved>(v0);
    }

    public fun emit_locked_or_burned_event(arg0: u64, arg1: address, arg2: u64) {
        let v0 = LockedOrBurned{
            remote_chain_selector : arg0,
            local_token           : arg1,
            amount                : arg2,
        };
        0x2::event::emit<LockedOrBurned>(v0);
    }

    public fun emit_rebalancer_set_event(arg0: address, arg1: address, arg2: address) {
        let v0 = RebalancerSet{
            local_token         : arg0,
            previous_rebalancer : arg1,
            rebalancer          : arg2,
        };
        0x2::event::emit<RebalancerSet>(v0);
    }

    public fun emit_released_or_minted_event(arg0: u64, arg1: address, arg2: address, arg3: u64) {
        let v0 = ReleasedOrMinted{
            remote_chain_selector : arg0,
            local_token           : arg1,
            recipient             : arg2,
            amount                : arg3,
        };
        0x2::event::emit<ReleasedOrMinted>(v0);
    }

    public fun emit_remote_pool_added_event(arg0: u64, arg1: vector<u8>) {
        let v0 = RemotePoolAdded{
            remote_chain_selector : arg0,
            remote_pool_address   : arg1,
        };
        0x2::event::emit<RemotePoolAdded>(v0);
    }

    public fun emit_remote_pool_removed_event(arg0: u64, arg1: vector<u8>) {
        let v0 = RemotePoolRemoved{
            remote_chain_selector : arg0,
            remote_pool_address   : arg1,
        };
        0x2::event::emit<RemotePoolRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

