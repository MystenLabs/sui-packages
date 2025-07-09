module 0x2c1df9916e65fc3623a5cf0d528dc92f928b2d6e0ad6f587f85b2ecd95ffab1::reflection_token_factory {
    struct REFLECTION_TOKEN_FACTORY has drop {
        dummy_field: bool,
    }

    struct ReflectionTokenRegistry has key {
        id: 0x2::object::UID,
        tokens: 0x2::table::Table<0x1::string::String, TokenRegistryEntry>,
        total_tokens_created: u64,
    }

    struct TokenRegistryEntry has store {
        token_id: 0x2::object::ID,
        creator: address,
        authority: address,
        reflection_rate: u64,
        treasury_cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
        reflection_state_id: 0x2::object::ID,
    }

    struct ReflectionState has key {
        id: 0x2::object::UID,
        token_symbol: 0x1::string::String,
        token_name: 0x1::string::String,
        total_supply: u64,
        total_reflections: u64,
        accumulated_fees: u64,
        reflection_rate: u64,
        authority: address,
        fee_sources: vector<0x1::string::String>,
        is_active: bool,
    }

    struct UserReflectionInfo has key {
        id: 0x2::object::UID,
        token_symbol: 0x1::string::String,
        balance: u64,
        last_reflection_point: u64,
        pending_rewards: u64,
        total_claimed: u64,
    }

    struct ReflectionTreasuryCap has store, key {
        id: 0x2::object::UID,
        token_symbol: 0x1::string::String,
        reflection_state_id: 0x2::object::ID,
        can_mint: bool,
    }

    struct ReflectionTokenCreated has copy, drop {
        token_symbol: 0x1::string::String,
        token_name: 0x1::string::String,
        creator: address,
        authority: address,
        reflection_rate: u64,
        total_supply: u64,
        treasury_cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
        reflection_state_id: 0x2::object::ID,
    }

    struct ReflectionDistributed has copy, drop {
        token_symbol: 0x1::string::String,
        total_amount: u64,
        reflection_rate: u64,
        holders_count: u64,
    }

    struct FeesCollected has copy, drop {
        token_symbol: 0x1::string::String,
        amount: u64,
        source: 0x1::string::String,
        authority: address,
    }

    struct ReflectionClaimed has copy, drop {
        token_symbol: 0x1::string::String,
        user: address,
        amount: u64,
        total_claimed: u64,
    }

    struct TokenMetadata has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        decimals: u8,
        total_supply: u64,
        reflection_rate: u64,
        authority: address,
    }

    public fun calculate_pending_rewards(arg0: &ReflectionState, arg1: &UserReflectionInfo) : u64 {
        arg1.balance * (arg0.total_reflections - arg1.last_reflection_point) / 1000000000 + arg1.pending_rewards
    }

    public fun collect_fees(arg0: &mut ReflectionState, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.authority, 0);
        arg0.accumulated_fees = arg0.accumulated_fees + arg1;
        if (!0x1::vector::contains<0x1::string::String>(&arg0.fee_sources, &arg2)) {
            0x1::vector::push_back<0x1::string::String>(&mut arg0.fee_sources, arg2);
        };
        let v1 = FeesCollected{
            token_symbol : arg0.token_symbol,
            amount       : arg1,
            source       : arg2,
            authority    : v0,
        };
        0x2::event::emit<FeesCollected>(v1);
    }

    public fun create_reflection_token(arg0: &mut ReflectionTokenRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x1::string::utf8(arg2);
        assert!(arg7 <= 5000, 1);
        assert!(!0x2::table::contains<0x1::string::String, TokenRegistryEntry>(&arg0.tokens, v0), 2);
        let v2 = ReflectionState{
            id                : 0x2::object::new(arg9),
            token_symbol      : v0,
            token_name        : v1,
            total_supply      : arg6,
            total_reflections : 0,
            accumulated_fees  : 0,
            reflection_rate   : arg7,
            authority         : arg8,
            fee_sources       : 0x1::vector::empty<0x1::string::String>(),
            is_active         : true,
        };
        let v3 = if (0x1::vector::length<u8>(&arg4) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg4))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v4 = TokenMetadata{
            id              : 0x2::object::new(arg9),
            symbol          : v0,
            name            : v1,
            description     : 0x1::string::utf8(arg3),
            icon_url        : v3,
            decimals        : arg5,
            total_supply    : arg6,
            reflection_rate : arg7,
            authority       : arg8,
        };
        let v5 = ReflectionTreasuryCap{
            id                  : 0x2::object::new(arg9),
            token_symbol        : v0,
            reflection_state_id : 0x2::object::id<ReflectionState>(&v2),
            can_mint            : true,
        };
        let v6 = 0x2::object::id<ReflectionTreasuryCap>(&v5);
        let v7 = 0x2::object::id<TokenMetadata>(&v4);
        let v8 = 0x2::object::id<ReflectionState>(&v2);
        let v9 = TokenRegistryEntry{
            token_id            : v8,
            creator             : 0x2::tx_context::sender(arg9),
            authority           : arg8,
            reflection_rate     : arg7,
            treasury_cap_id     : v6,
            metadata_id         : v7,
            reflection_state_id : v8,
        };
        0x2::table::add<0x1::string::String, TokenRegistryEntry>(&mut arg0.tokens, v0, v9);
        arg0.total_tokens_created = arg0.total_tokens_created + 1;
        0x2::transfer::share_object<ReflectionState>(v2);
        0x2::transfer::public_transfer<ReflectionTreasuryCap>(v5, 0x2::tx_context::sender(arg9));
        0x2::transfer::public_freeze_object<TokenMetadata>(v4);
        let v10 = ReflectionTokenCreated{
            token_symbol        : v0,
            token_name          : v1,
            creator             : 0x2::tx_context::sender(arg9),
            authority           : arg8,
            reflection_rate     : arg7,
            total_supply        : arg6,
            treasury_cap_id     : v6,
            metadata_id         : v7,
            reflection_state_id : v8,
        };
        0x2::event::emit<ReflectionTokenCreated>(v10);
    }

    public fun distribute_reflections(arg0: &mut ReflectionState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 0);
        assert!(arg0.accumulated_fees >= arg1, 3);
        let v0 = arg1 * arg0.reflection_rate / 10000;
        if (v0 > 0 && arg0.total_supply > 0) {
            arg0.total_reflections = arg0.total_reflections + v0 * 1000000000 / arg0.total_supply;
            arg0.accumulated_fees = arg0.accumulated_fees - v0;
            let v1 = ReflectionDistributed{
                token_symbol    : arg0.token_symbol,
                total_amount    : v0,
                reflection_rate : arg0.reflection_rate,
                holders_count   : 0,
            };
            0x2::event::emit<ReflectionDistributed>(v1);
        };
    }

    public fun get_reflection_info(arg0: &ReflectionState) : (0x1::string::String, u64, u64, u64, u64, address, bool) {
        (arg0.token_symbol, arg0.total_supply, arg0.total_reflections, arg0.accumulated_fees, arg0.reflection_rate, arg0.authority, arg0.is_active)
    }

    public fun get_registry_stats(arg0: &ReflectionTokenRegistry) : u64 {
        arg0.total_tokens_created
    }

    public fun get_token_info(arg0: &ReflectionTokenRegistry, arg1: 0x1::string::String) : (address, address, u64, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        let v0 = 0x2::table::borrow<0x1::string::String, TokenRegistryEntry>(&arg0.tokens, arg1);
        (v0.creator, v0.authority, v0.reflection_rate, v0.treasury_cap_id, v0.metadata_id, v0.reflection_state_id)
    }

    public fun get_token_metadata(arg0: &TokenMetadata) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u8, u64, u64, address) {
        (arg0.symbol, arg0.name, arg0.description, arg0.decimals, arg0.total_supply, arg0.reflection_rate, arg0.authority)
    }

    fun init(arg0: REFLECTION_TOKEN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReflectionTokenRegistry{
            id                   : 0x2::object::new(arg1),
            tokens               : 0x2::table::new<0x1::string::String, TokenRegistryEntry>(arg1),
            total_tokens_created : 0,
        };
        0x2::transfer::share_object<ReflectionTokenRegistry>(v0);
        0x2::package::claim_and_keep<REFLECTION_TOKEN_FACTORY>(arg0, arg1);
    }

    public fun register_for_reflections(arg0: &ReflectionState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = UserReflectionInfo{
            id                    : 0x2::object::new(arg2),
            token_symbol          : arg0.token_symbol,
            balance               : arg1,
            last_reflection_point : arg0.total_reflections,
            pending_rewards       : 0,
            total_claimed         : 0,
        };
        0x2::transfer::transfer<UserReflectionInfo>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun update_user_balance(arg0: &mut UserReflectionInfo, arg1: u64, arg2: &ReflectionState) {
        arg0.pending_rewards = calculate_pending_rewards(arg2, arg0);
        arg0.balance = arg1;
        arg0.last_reflection_point = arg2.total_reflections;
    }

    // decompiled from Move bytecode v6
}

