module 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config {
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
        default_min_funding_amount: u64,
        duration_config: DurationConfig,
        allowed_quotes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        default_creator_fee_share_bps: u64,
        funding_tiers: 0x2::vec_map::VecMap<u8, FundingTier>,
        min_funding_amount: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct FundingTier has copy, drop, store {
        min_funding: u64,
        max_funding: 0x1::option::Option<u64>,
        fee_share_bps: u64,
    }

    struct DurationConfig has copy, drop, store {
        min_duration_ms: u64,
        max_duration_ms: 0x1::option::Option<u64>,
    }

    public fun add_allowed_quote(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: 0x1::type_name::TypeName) {
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &arg2), 1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, arg2);
    }

    public fun default_creator_fee_share_bps(arg0: &ProtocolConfig) : u64 {
        arg0.default_creator_fee_share_bps
    }

    public fun default_min_funding_amount(arg0: &ProtocolConfig) : u64 {
        arg0.default_min_funding_amount
    }

    public fun duration_config(arg0: &ProtocolConfig) : &DurationConfig {
        &arg0.duration_config
    }

    public fun funding_tier(arg0: &ProtocolConfig, arg1: u8) : FundingTier {
        *0x2::vec_map::get<u8, FundingTier>(&arg0.funding_tiers, &arg1)
    }

    public fun funding_tier_fee_share_bps(arg0: &FundingTier) : u64 {
        arg0.fee_share_bps
    }

    public fun funding_tier_max(arg0: &FundingTier) : 0x1::option::Option<u64> {
        arg0.max_funding
    }

    public fun funding_tier_min(arg0: &FundingTier) : u64 {
        arg0.min_funding
    }

    public fun funding_tiers(arg0: &ProtocolConfig) : &0x2::vec_map::VecMap<u8, FundingTier> {
        &arg0.funding_tiers
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DurationConfig{
            min_duration_ms : 300000,
            max_duration_ms : 0x1::option::none<u64>(),
        };
        let v1 = ProtocolConfig{
            id                            : 0x2::object::new(arg1),
            vig_bps                       : 1000,
            trading_fee_bps               : 150,
            default_min_funding_amount    : 5000000,
            duration_config               : v0,
            allowed_quotes                : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            default_creator_fee_share_bps : 3000,
            funding_tiers                 : 0x2::vec_map::empty<u8, FundingTier>(),
            min_funding_amount            : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::transfer::share_object<ProtocolConfig>(v1);
        0x2::package::claim_and_keep<CONFIG>(arg0, arg1);
        let v2 = ProtocolCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ProtocolCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun is_quote_allowed(arg0: &ProtocolConfig, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &arg1)
    }

    public fun max_duration_ms(arg0: &DurationConfig) : 0x1::option::Option<u64> {
        arg0.max_duration_ms
    }

    public fun min_duration_ms(arg0: &DurationConfig) : u64 {
        arg0.min_duration_ms
    }

    public fun min_funding_amount(arg0: &ProtocolConfig, arg1: 0x1::type_name::TypeName) : u64 {
        0x1::option::destroy_with_default<u64>(0x2::vec_map::try_get<0x1::type_name::TypeName, u64>(&arg0.min_funding_amount, &arg1), arg0.default_min_funding_amount)
    }

    public fun new_duration_config(arg0: u64, arg1: 0x1::option::Option<u64>) : DurationConfig {
        let v0 = DurationConfig{
            min_duration_ms : arg0,
            max_duration_ms : arg1,
        };
        validate_duration_config(&v0);
        v0
    }

    public fun remove_allowed_quote(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: 0x1::type_name::TypeName) {
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &arg2), 3);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, &arg2);
    }

    public fun remove_funding_tier(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, FundingTier>(&arg0.funding_tiers, &arg2), 5);
        let (_, _) = 0x2::vec_map::remove<u8, FundingTier>(&mut arg0.funding_tiers, &arg2);
    }

    public fun remove_min_funding_for_quote(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: 0x1::type_name::TypeName) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.min_funding_amount, &arg2), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.min_funding_amount, &arg2);
    }

    public fun resolve_tier_for_funding(arg0: &ProtocolConfig, arg1: u64) : 0x1::option::Option<FundingTier> {
        let v0 = 0;
        let v1 = 0x1::option::none<FundingTier>();
        let v2 = 0x2::vec_map::keys<u8, FundingTier>(&arg0.funding_tiers);
        0x1::vector::reverse<u8>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v4 = 0x1::vector::pop_back<u8>(&mut v2);
            let v5 = *0x2::vec_map::get<u8, FundingTier>(&arg0.funding_tiers, &v4);
            if (arg1 < v5.min_funding) {
            } else {
                let v6 = true;
                let v7 = v5.max_funding;
                if (0x1::option::is_some<u64>(&v7)) {
                    v6 = arg1 <= 0x1::option::destroy_some<u64>(v7);
                } else {
                    0x1::option::destroy_none<u64>(v7);
                };
                if (!v6) {
                } else if (0x1::option::is_none<FundingTier>(&v1) || v5.min_funding >= v0) {
                    v0 = v5.min_funding;
                    v1 = 0x1::option::some<FundingTier>(v5);
                };
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u8>(v2);
        v1
    }

    public fun set_funding_tier(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u8, arg3: FundingTier) {
        validate_funding_tier_config(&arg3);
        if (0x2::vec_map::contains<u8, FundingTier>(&arg0.funding_tiers, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<u8, FundingTier>(&mut arg0.funding_tiers, &arg2);
        };
        0x2::vec_map::insert<u8, FundingTier>(&mut arg0.funding_tiers, arg2, arg3);
    }

    public fun set_min_funding_for_quote(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: 0x1::type_name::TypeName, arg3: u64) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.min_funding_amount, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.min_funding_amount, &arg2);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.min_funding_amount, arg2, arg3);
    }

    public fun trading_fee_bps(arg0: &ProtocolConfig) : u64 {
        arg0.trading_fee_bps
    }

    public fun update_default_creator_fee_share(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u64) {
        assert!(arg2 <= 10000, 6);
        arg0.default_creator_fee_share_bps = arg2;
    }

    public fun update_default_min_funding(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u64) {
        arg0.default_min_funding_amount = arg2;
    }

    public fun update_duration_config(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: DurationConfig) {
        validate_duration_config(&arg2);
        arg0.duration_config = arg2;
    }

    public fun update_trading_fee(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u64) {
        assert!(arg2 <= 2000, 6);
        arg0.trading_fee_bps = arg2;
    }

    public fun update_vig_bps(arg0: &mut ProtocolConfig, arg1: &ProtocolCap, arg2: u64) {
        assert!(arg2 > 0 && arg2 <= 10000, 4);
        arg0.vig_bps = arg2;
    }

    fun validate_duration_config(arg0: &DurationConfig) {
        assert!(arg0.min_duration_ms > 0, 0);
        let v0 = arg0.max_duration_ms;
        if (0x1::option::is_some<u64>(&v0)) {
            assert!(0x1::option::destroy_some<u64>(v0) > arg0.min_duration_ms, 0);
        } else {
            0x1::option::destroy_none<u64>(v0);
        };
    }

    fun validate_funding_tier_config(arg0: &FundingTier) {
        assert!(arg0.min_funding > 0, 5);
        let v0 = arg0.max_funding;
        if (0x1::option::is_some<u64>(&v0)) {
            assert!(0x1::option::destroy_some<u64>(v0) > arg0.min_funding, 5);
        } else {
            0x1::option::destroy_none<u64>(v0);
        };
        assert!(arg0.fee_share_bps <= 10000, 5);
    }

    public fun vig_bps(arg0: &ProtocolConfig) : u64 {
        arg0.vig_bps
    }

    // decompiled from Move bytecode v6
}

