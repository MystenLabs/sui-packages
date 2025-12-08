module 0xb3aed6cae5afa34d74da7e3e8de627bfdf54009563f38cc244d9c1cefc22068f::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct ProtocolCap has key {
        id: 0x2::object::UID,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        vig_bps: u64,
        trading_fee_bps: u64,
        min_duration_ms: u64,
        max_outcomes_count: u64,
        locker_fee_share_bps: u64,
        creator_fee_share_bps: u64,
        fallback_creation_fee: u64,
        allowed_quotes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        allowed_resolvers: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        creation_fee: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        extra_fields: 0x2::bag::Bag,
    }

    struct QuoteAllowedAdded has copy, drop {
        quote: 0x1::type_name::TypeName,
    }

    struct QuoteAllowedRemoved has copy, drop {
        quote: 0x1::type_name::TypeName,
    }

    struct ResolverAllowedAdded has copy, drop {
        resolver: 0x1::type_name::TypeName,
    }

    struct ResolverAllowedRemoved has copy, drop {
        resolver: 0x1::type_name::TypeName,
    }

    struct CreationFeeSet has copy, drop {
        quote: 0x1::type_name::TypeName,
        min_funding: u64,
    }

    struct CreationFeeRemoved has copy, drop {
        quote: 0x1::type_name::TypeName,
    }

    struct FallbackCreationFeeUpdated has copy, drop {
        fallback_creation_fee: u64,
    }

    struct TradingFeeUpdated has copy, drop {
        trading_fee_bps: u64,
    }

    struct VigUpdated has copy, drop {
        vig_bps: u64,
    }

    struct MinDurationUpdated has copy, drop {
        min_duration_ms: u64,
    }

    struct CreatorFeeShareUpdated has copy, drop {
        creator_fee_share_bps: u64,
    }

    struct LockerFeeShareUpdated has copy, drop {
        locker_fee_share_bps: u64,
    }

    public fun add_allowed_quote(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: 0x1::type_name::TypeName) {
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &arg2), 1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, arg2);
        let v0 = QuoteAllowedAdded{quote: arg2};
        0x2::event::emit<QuoteAllowedAdded>(v0);
    }

    public fun add_allowed_resolver(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: 0x1::type_name::TypeName) {
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_resolvers, &arg2), 2);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_resolvers, arg2);
        let v0 = ResolverAllowedAdded{resolver: arg2};
        0x2::event::emit<ResolverAllowedAdded>(v0);
    }

    public fun creation_fee(arg0: &ProtocolConfig, arg1: 0x1::type_name::TypeName) : u64 {
        0x1::option::destroy_with_default<u64>(0x2::vec_map::try_get<0x1::type_name::TypeName, u64>(&arg0.creation_fee, &arg1), arg0.fallback_creation_fee)
    }

    public fun creator_fee_share_bps(arg0: &ProtocolConfig) : u64 {
        arg0.creator_fee_share_bps
    }

    public fun fallback_creation_fee(arg0: &ProtocolConfig) : u64 {
        arg0.fallback_creation_fee
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id                    : 0x2::object::new(arg1),
            vig_bps               : 500,
            trading_fee_bps       : 200,
            min_duration_ms       : 300000,
            max_outcomes_count    : 16,
            locker_fee_share_bps  : 3000,
            creator_fee_share_bps : 2000,
            fallback_creation_fee : 10000000,
            allowed_quotes        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            allowed_resolvers     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            creation_fee          : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            extra_fields          : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<ProtocolConfig>(v0);
        0x2::package::claim_and_keep<CONFIG>(arg0, arg1);
        let v1 = ProtocolCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ProtocolCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_quote_allowed(arg0: &ProtocolConfig, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &arg1)
    }

    public fun is_resolver_allowed(arg0: &ProtocolConfig, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_resolvers, &arg1)
    }

    public fun locker_fee_share_bps(arg0: &ProtocolConfig) : u64 {
        arg0.locker_fee_share_bps
    }

    public fun max_outcomes_count(arg0: &ProtocolConfig) : u64 {
        arg0.max_outcomes_count
    }

    public fun min_duration_ms(arg0: &ProtocolConfig) : u64 {
        arg0.min_duration_ms
    }

    public fun remove_allowed_quote(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: 0x1::type_name::TypeName) {
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &arg2), 4);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, &arg2);
        let v0 = QuoteAllowedRemoved{quote: arg2};
        0x2::event::emit<QuoteAllowedRemoved>(v0);
    }

    public fun remove_allowed_resolver(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: 0x1::type_name::TypeName) {
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_resolvers, &arg2), 5);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_resolvers, &arg2);
        let v0 = ResolverAllowedRemoved{resolver: arg2};
        0x2::event::emit<ResolverAllowedRemoved>(v0);
    }

    public fun remove_min_funding_for_quote(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: 0x1::type_name::TypeName) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.creation_fee, &arg2), 3);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.creation_fee, &arg2);
        let v2 = CreationFeeRemoved{quote: arg2};
        0x2::event::emit<CreationFeeRemoved>(v2);
    }

    public fun set_min_duration_ms(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u64) {
        assert!(arg2 > 0, 0);
        arg0.min_duration_ms = arg2;
        let v0 = MinDurationUpdated{min_duration_ms: arg2};
        0x2::event::emit<MinDurationUpdated>(v0);
    }

    public fun set_min_funding_for_quote(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: 0x1::type_name::TypeName, arg3: u64) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.creation_fee, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.creation_fee, &arg2);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.creation_fee, arg2, arg3);
        let v2 = CreationFeeSet{
            quote       : arg2,
            min_funding : arg3,
        };
        0x2::event::emit<CreationFeeSet>(v2);
    }

    public fun trading_fee_bps(arg0: &ProtocolConfig) : u64 {
        arg0.trading_fee_bps
    }

    public fun update_creator_fee_share(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u64) {
        assert!(arg2 <= 10000, 7);
        arg0.creator_fee_share_bps = arg2;
        let v0 = CreatorFeeShareUpdated{creator_fee_share_bps: arg2};
        0x2::event::emit<CreatorFeeShareUpdated>(v0);
    }

    public fun update_default_locker_fee_share(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u64) {
        assert!(arg2 <= 10000, 7);
        arg0.locker_fee_share_bps = arg2;
        let v0 = LockerFeeShareUpdated{locker_fee_share_bps: arg2};
        0x2::event::emit<LockerFeeShareUpdated>(v0);
    }

    public fun update_default_min_funding(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u64) {
        arg0.fallback_creation_fee = arg2;
        let v0 = FallbackCreationFeeUpdated{fallback_creation_fee: arg2};
        0x2::event::emit<FallbackCreationFeeUpdated>(v0);
    }

    public fun update_trading_fee(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u64) {
        assert!(arg2 <= 5000, 7);
        arg0.trading_fee_bps = arg2;
        let v0 = TradingFeeUpdated{trading_fee_bps: arg2};
        0x2::event::emit<TradingFeeUpdated>(v0);
    }

    public fun update_vig_bps(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u64) {
        assert!(arg2 > 0 && arg2 <= 10000, 6);
        arg0.vig_bps = arg2;
        let v0 = VigUpdated{vig_bps: arg2};
        0x2::event::emit<VigUpdated>(v0);
    }

    public fun vig_bps(arg0: &ProtocolConfig) : u64 {
        arg0.vig_bps
    }

    // decompiled from Move bytecode v6
}

