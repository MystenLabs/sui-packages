module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::pool_token {
    struct POOL_TOKEN has drop {
        dummy_field: bool,
    }

    struct SeniorToken has drop {
        dummy_field: bool,
    }

    struct JuniorToken has drop {
        dummy_field: bool,
    }

    struct EquityToken has drop {
        dummy_field: bool,
    }

    struct PoolTokenMetadata has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        token_name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        tranche_priority: u8,
        total_supply: u64,
        decimals: u8,
        icon_url: 0x1::string::String,
        kyc_required: bool,
    }

    struct TokenHolder has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        holder: address,
        senior_balance: u64,
        junior_balance: u64,
        equity_balance: u64,
        total_yield_claimed: u64,
        last_claim_timestamp: u64,
    }

    struct YieldAccumulator has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        senior_yield_per_token: u64,
        junior_yield_per_token: u64,
        equity_yield_per_token: u64,
        last_distribution_timestamp: u64,
    }

    struct PoolTokenTreasury has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        senior_cap: 0x1::option::Option<0x2::coin::TreasuryCap<SeniorToken>>,
        junior_cap: 0x1::option::Option<0x2::coin::TreasuryCap<JuniorToken>>,
        equity_cap: 0x1::option::Option<0x2::coin::TreasuryCap<EquityToken>>,
        minting_enabled: bool,
        burning_enabled: bool,
    }

    struct TokensMinted has copy, drop {
        pool_id: 0x2::object::ID,
        tranche: u8,
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct TokensBurned has copy, drop {
        pool_id: 0x2::object::ID,
        tranche: u8,
        amount: u64,
        burner: address,
        timestamp: u64,
    }

    struct TokensTransferred has copy, drop {
        pool_id: 0x2::object::ID,
        tranche: u8,
        from: address,
        to: address,
        amount: u64,
        timestamp: u64,
    }

    struct YieldClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        holder: address,
        senior_yield: u64,
        junior_yield: u64,
        equity_yield: u64,
        total_yield: u64,
        timestamp: u64,
    }

    struct YieldDistributed has copy, drop {
        pool_id: 0x2::object::ID,
        senior_amount: u64,
        junior_amount: u64,
        equity_amount: u64,
        total_distributed: u64,
        timestamp: u64,
    }

    public entry fun burn_tokens_at_maturity(arg0: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::VaultPool, arg1: &mut PoolTokenMetadata, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::get_pool_status(arg0) == 2, 5);
        arg1.total_supply = arg1.total_supply - arg2;
        let v0 = TokensBurned{
            pool_id   : arg1.pool_id,
            tranche   : arg1.tranche_priority,
            amount    : arg2,
            burner    : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokensBurned>(v0);
    }

    public entry fun claim_yield(arg0: &mut TokenHolder, arg1: &YieldAccumulator, arg2: &PoolTokenMetadata, arg3: &PoolTokenMetadata, arg4: &PoolTokenMetadata, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.senior_balance * arg1.senior_yield_per_token;
        let v1 = arg0.junior_balance * arg1.junior_yield_per_token;
        let v2 = arg0.equity_balance * arg1.equity_yield_per_token;
        let v3 = v0 + v1 + v2;
        arg0.total_yield_claimed = arg0.total_yield_claimed + v3;
        arg0.last_claim_timestamp = 0x2::clock::timestamp_ms(arg5);
        let v4 = YieldClaimed{
            pool_id      : arg0.pool_id,
            holder       : arg0.holder,
            senior_yield : v0,
            junior_yield : v1,
            equity_yield : v2,
            total_yield  : v3,
            timestamp    : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<YieldClaimed>(v4);
    }

    public fun distribute_yield_to_tokens(arg0: &mut YieldAccumulator, arg1: &PoolTokenMetadata, arg2: &PoolTokenMetadata, arg3: &PoolTokenMetadata, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        if (arg1.total_supply > 0) {
            arg0.senior_yield_per_token = arg0.senior_yield_per_token + arg4 / arg1.total_supply;
        };
        if (arg2.total_supply > 0) {
            arg0.junior_yield_per_token = arg0.junior_yield_per_token + arg5 / arg2.total_supply;
        };
        if (arg3.total_supply > 0) {
            arg0.equity_yield_per_token = arg0.equity_yield_per_token + arg6 / arg3.total_supply;
        };
        arg0.last_distribution_timestamp = 0x2::clock::timestamp_ms(arg7);
        let v0 = YieldDistributed{
            pool_id           : arg0.pool_id,
            senior_amount     : arg4,
            junior_amount     : arg5,
            equity_amount     : arg6,
            total_distributed : arg4 + arg5 + arg6,
            timestamp         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<YieldDistributed>(v0);
    }

    public fun get_decimals(arg0: &PoolTokenMetadata) : u8 {
        arg0.decimals
    }

    public fun get_equity_yield_per_token(arg0: &YieldAccumulator) : u64 {
        arg0.equity_yield_per_token
    }

    public fun get_holder_equity_balance(arg0: &TokenHolder) : u64 {
        arg0.equity_balance
    }

    public fun get_holder_junior_balance(arg0: &TokenHolder) : u64 {
        arg0.junior_balance
    }

    public fun get_holder_senior_balance(arg0: &TokenHolder) : u64 {
        arg0.senior_balance
    }

    public fun get_junior_yield_per_token(arg0: &YieldAccumulator) : u64 {
        arg0.junior_yield_per_token
    }

    public fun get_senior_yield_per_token(arg0: &YieldAccumulator) : u64 {
        arg0.senior_yield_per_token
    }

    public fun get_token_name(arg0: &PoolTokenMetadata) : 0x1::string::String {
        arg0.token_name
    }

    public fun get_token_symbol(arg0: &PoolTokenMetadata) : 0x1::string::String {
        arg0.token_symbol
    }

    public fun get_total_supply(arg0: &PoolTokenMetadata) : u64 {
        arg0.total_supply
    }

    public fun get_total_yield_claimed(arg0: &TokenHolder) : u64 {
        arg0.total_yield_claimed
    }

    public entry fun initialize_pool_tokens(arg0: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::VaultPool, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::VaultPool>(arg0);
        0x1::string::utf8(arg1);
        let v1 = 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::is_kyc_required(arg0);
        let v2 = PoolTokenMetadata{
            id               : 0x2::object::new(arg4),
            pool_id          : v0,
            token_name       : 0x1::string::utf8(b"AFRIMBI-Senior"),
            token_symbol     : 0x1::string::utf8(b"AFRI-SR"),
            tranche_priority : 1,
            total_supply     : 0,
            decimals         : 6,
            icon_url         : 0x1::string::utf8(arg2),
            kyc_required     : v1,
        };
        let v3 = PoolTokenMetadata{
            id               : 0x2::object::new(arg4),
            pool_id          : v0,
            token_name       : 0x1::string::utf8(b"AFRIMBI-Junior"),
            token_symbol     : 0x1::string::utf8(b"AFRI-JR"),
            tranche_priority : 2,
            total_supply     : 0,
            decimals         : 6,
            icon_url         : 0x1::string::utf8(arg2),
            kyc_required     : v1,
        };
        let v4 = PoolTokenMetadata{
            id               : 0x2::object::new(arg4),
            pool_id          : v0,
            token_name       : 0x1::string::utf8(b"AFRIMBI-Equity"),
            token_symbol     : 0x1::string::utf8(b"AFRI-EQ"),
            tranche_priority : 3,
            total_supply     : 0,
            decimals         : 6,
            icon_url         : 0x1::string::utf8(arg2),
            kyc_required     : v1,
        };
        let v5 = YieldAccumulator{
            id                          : 0x2::object::new(arg4),
            pool_id                     : v0,
            senior_yield_per_token      : 0,
            junior_yield_per_token      : 0,
            equity_yield_per_token      : 0,
            last_distribution_timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::share_object<PoolTokenMetadata>(v2);
        0x2::transfer::share_object<PoolTokenMetadata>(v3);
        0x2::transfer::share_object<PoolTokenMetadata>(v4);
        0x2::transfer::share_object<YieldAccumulator>(v5);
    }

    public entry fun mint_equity_tokens(arg0: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::VaultPool, arg1: &mut PoolTokenMetadata, arg2: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::PoolWhitelist, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::get_pool_status(arg0) == 1, 5);
        if (arg1.kyc_required) {
            assert!(0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::is_whitelisted(arg2, arg4), 1);
        };
        arg1.total_supply = arg1.total_supply + arg3;
        let v0 = TokensMinted{
            pool_id   : arg1.pool_id,
            tranche   : 3,
            amount    : arg3,
            recipient : arg4,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TokensMinted>(v0);
    }

    public entry fun mint_junior_tokens(arg0: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::VaultPool, arg1: &mut PoolTokenMetadata, arg2: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::PoolWhitelist, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::get_pool_status(arg0) == 1, 5);
        if (arg1.kyc_required) {
            assert!(0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::is_whitelisted(arg2, arg4), 1);
        };
        arg1.total_supply = arg1.total_supply + arg3;
        let v0 = TokensMinted{
            pool_id   : arg1.pool_id,
            tranche   : 2,
            amount    : arg3,
            recipient : arg4,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TokensMinted>(v0);
    }

    public entry fun mint_senior_tokens(arg0: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::VaultPool, arg1: &mut PoolTokenMetadata, arg2: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::PoolWhitelist, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::get_pool_status(arg0) == 1, 5);
        if (arg1.kyc_required) {
            assert!(0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::is_whitelisted(arg2, arg4), 1);
        };
        arg1.total_supply = arg1.total_supply + arg3;
        let v0 = TokensMinted{
            pool_id   : arg1.pool_id,
            tranche   : 1,
            amount    : arg3,
            recipient : arg4,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TokensMinted>(v0);
    }

    // decompiled from Move bytecode v6
}

