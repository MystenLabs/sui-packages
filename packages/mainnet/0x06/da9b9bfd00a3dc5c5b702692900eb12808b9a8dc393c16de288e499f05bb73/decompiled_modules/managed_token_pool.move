module 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::managed_token_pool {
    struct TokenLockedOrBurned has copy, drop {
        amount: u64,
        remote_chain_selector: u64,
        token: address,
    }

    struct TokenReleasedOrMinted has copy, drop {
        receiver: address,
        amount: u64,
        remote_chain_selector: u64,
    }

    struct ManagedTokenPoolState<phantom T0> has key {
        id: 0x2::object::UID,
        token_pool_state: TokenPoolState,
        mint_cap: MintCap<T0>,
        ownable_state: OwnableState,
    }

    struct TokenPoolState has store, key {
        id: 0x2::object::UID,
        token: address,
        local_decimals: u8,
        remote_chain_selectors: vector<u64>,
        remote_pools: 0x2::table::Table<u64, vector<vector<u8>>>,
        remote_tokens: 0x2::table::Table<u64, vector<u8>>,
        allowlist_enabled: bool,
        allowlist: vector<address>,
        rate_limiters: 0x2::table::Table<u64, RateLimiter>,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct OwnableState has store {
        owner: address,
        pending_owner: 0x1::option::Option<address>,
        pending_transfer: 0x1::option::Option<TransferRequest>,
    }

    struct TransferRequest has drop, store {
        from: address,
        to: address,
        accepted: 0x1::option::Option<bool>,
    }

    struct RateLimiter has drop, store {
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

    public fun create_accepted_transfer_request(arg0: address, arg1: address) : TransferRequest {
        create_test_transfer_request(arg0, arg1, 0x1::option::some<bool>(true))
    }

    public fun create_default_test_rate_limiter() : RateLimiter {
        create_test_rate_limiter(true, 1000000, 1000, true, 1000000, 1000)
    }

    public fun create_pending_transfer_request(arg0: address, arg1: address) : TransferRequest {
        create_test_transfer_request(arg0, arg1, 0x1::option::none<bool>())
    }

    public fun create_rejected_transfer_request(arg0: address, arg1: address) : TransferRequest {
        create_test_transfer_request(arg0, arg1, 0x1::option::some<bool>(false))
    }

    public fun create_test_allowlist() : vector<address> {
        vector[@0x1, @0x2, @0x3, @0x4]
    }

    public fun create_test_chain_selectors() : vector<u64> {
        vector[1, 137, 42161, 10]
    }

    public fun create_test_lock_or_burn_params() : vector<address> {
        vector[@0x6, @0x403, @0x1, @0x2]
    }

    public fun create_test_rate_limiter(arg0: bool, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64) : RateLimiter {
        RateLimiter{
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

    public fun create_test_release_or_mint_params() : vector<address> {
        vector[@0x6, @0x403, @0x1, @0x2]
    }

    public fun create_test_remote_pool_addresses() : vector<vector<u8>> {
        vector[x"1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef", x"2234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdea"]
    }

    public fun create_test_remote_token_address() : vector<u8> {
        x"3234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdeb"
    }

    public fun create_test_transfer_request(arg0: address, arg1: address, arg2: 0x1::option::Option<bool>) : TransferRequest {
        TransferRequest{
            from     : arg0,
            to       : arg1,
            accepted : arg2,
        }
    }

    public fun emit_token_locked_or_burned_event(arg0: u64, arg1: u64, arg2: address) {
        let v0 = TokenLockedOrBurned{
            amount                : arg0,
            remote_chain_selector : arg1,
            token                 : arg2,
        };
        0x2::event::emit<TokenLockedOrBurned>(v0);
    }

    public fun emit_token_released_or_minted_event(arg0: address, arg1: u64, arg2: u64) {
        let v0 = TokenReleasedOrMinted{
            receiver              : arg0,
            amount                : arg1,
            remote_chain_selector : arg2,
        };
        0x2::event::emit<TokenReleasedOrMinted>(v0);
    }

    // decompiled from Move bytecode v6
}

