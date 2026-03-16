module 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::token_factory {
    struct TokenRegistry has key {
        id: 0x2::object::UID,
        total_launched: u64,
        tokens: 0x2::table::Table<0x2::object::ID, TokenInfo>,
    }

    struct TokenInfo has store {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        creator: address,
        staking_pool_id: 0x2::object::ID,
        launched_at: u64,
    }

    struct TokenLaunched has copy, drop {
        vault_id: 0x2::object::ID,
        staking_pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        creator: address,
    }

    public fun create_token<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>) {
        0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRegistry{
            id             : 0x2::object::new(arg0),
            total_launched : 0,
            tokens         : 0x2::table::new<0x2::object::ID, TokenInfo>(arg0),
        };
        0x2::transfer::share_object<TokenRegistry>(v0);
    }

    public fun partner_default_bps() : u64 {
        500
    }

    public(friend) fun register_token(arg0: &mut TokenRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenInfo{
            name            : arg3,
            symbol          : arg4,
            creator         : arg5,
            staking_pool_id : arg2,
            launched_at     : 0x2::tx_context::epoch(arg6),
        };
        0x2::table::add<0x2::object::ID, TokenInfo>(&mut arg0.tokens, arg1, v0);
        arg0.total_launched = arg0.total_launched + 1;
        let v1 = TokenLaunched{
            vault_id        : arg1,
            staking_pool_id : arg2,
            name            : arg3,
            symbol          : arg4,
            creator         : arg5,
        };
        0x2::event::emit<TokenLaunched>(v1);
    }

    public fun staker_bps() : u64 {
        3500
    }

    public fun toastr_bps() : u64 {
        2000
    }

    public fun total_bps() : u64 {
        10000
    }

    public fun total_launched(arg0: &TokenRegistry) : u64 {
        arg0.total_launched
    }

    // decompiled from Move bytecode v6
}

