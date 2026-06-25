module 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_rate {
    struct FundingConfig has copy, drop, store {
        cap_rate_scaled: u64,
        k_base_scaled: u64,
        tier_1_threshold: u64,
        tier_2_threshold: u64,
    }

    struct FundingRateResult has copy, drop, store {
        premium_rate: u64,
        premium_is_negative: bool,
        inventory_rate: u64,
        inventory_is_negative: bool,
        total_rate: u64,
        total_is_negative: bool,
    }

    struct FundingRateRegistry has key {
        id: 0x2::object::UID,
        configs: 0x2::table::Table<vector<u8>, FundingConfig>,
    }

    struct FundingConfigRegistered has copy, drop {
        symbol: vector<u8>,
        cap_rate_scaled: u64,
        k_base_scaled: u64,
    }

    struct FundingConfigUpdated has copy, drop {
        symbol: vector<u8>,
        cap_rate_scaled: u64,
        k_base_scaled: u64,
        tier_1_threshold: u64,
        tier_2_threshold: u64,
    }

    struct FundingRateComputed has copy, drop {
        symbol: vector<u8>,
        premium_rate: u64,
        premium_is_negative: bool,
        inventory_rate: u64,
        inventory_is_negative: bool,
        total_rate: u64,
        total_is_negative: bool,
    }

    struct FundingRateComputedV2 has copy, drop {
        symbol: vector<u8>,
        premium_rate: u64,
        premium_is_negative: bool,
        inventory_rate: u64,
        inventory_is_negative: bool,
        total_rate: u64,
        total_is_negative: bool,
        market_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    fun add_signed(arg0: u64, arg1: bool, arg2: u64, arg3: bool) : (u64, bool) {
        if (arg1 == arg3) {
            (arg0 + arg2, arg1)
        } else if (arg0 >= arg2) {
            (arg0 - arg2, arg1)
        } else {
            (arg2 - arg0, arg3)
        }
    }

    public fun borrow_config(arg0: &FundingRateRegistry, arg1: vector<u8>) : &FundingConfig {
        assert!(0x2::table::contains<vector<u8>, FundingConfig>(&arg0.configs, arg1), 0);
        0x2::table::borrow<vector<u8>, FundingConfig>(&arg0.configs, arg1)
    }

    public fun compute_funding_rate(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &FundingConfig) : FundingRateResult {
        let (v0, v1) = compute_premium(arg0, arg1, 0, arg2, arg6.cap_rate_scaled);
        let (v2, v3) = compute_inventory(compute_tiered_k(arg6.k_base_scaled, arg3, arg4, arg5, arg6.tier_1_threshold, arg6.tier_2_threshold), arg3, arg4);
        let (v4, v5) = add_signed(v0, v1, v2, v3);
        FundingRateResult{
            premium_rate          : v0,
            premium_is_negative   : v1,
            inventory_rate        : v2,
            inventory_is_negative : v3,
            total_rate            : v4,
            total_is_negative     : v5,
        }
    }

    public fun compute_funding_rate_with_registry(arg0: &FundingRateRegistry, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64) : FundingRateResult {
        assert!(0x2::table::contains<vector<u8>, FundingConfig>(&arg0.configs, arg1), 0);
        let v0 = compute_funding_rate(arg2, arg3, arg4, arg5, arg6, arg7, 0x2::table::borrow<vector<u8>, FundingConfig>(&arg0.configs, arg1));
        let v1 = FundingRateComputed{
            symbol                : arg1,
            premium_rate          : v0.premium_rate,
            premium_is_negative   : v0.premium_is_negative,
            inventory_rate        : v0.inventory_rate,
            inventory_is_negative : v0.inventory_is_negative,
            total_rate            : v0.total_rate,
            total_is_negative     : v0.total_is_negative,
        };
        0x2::event::emit<FundingRateComputed>(v1);
        v0
    }

    public fun compute_funding_rate_with_registry_v3(arg0: &FundingRateRegistry, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) : FundingRateResult {
        assert!(0x2::table::contains<vector<u8>, FundingConfig>(&arg0.configs, arg1), 0);
        let v0 = compute_funding_rate(arg3, arg4, arg5, arg6, arg7, arg8, 0x2::table::borrow<vector<u8>, FundingConfig>(&arg0.configs, arg1));
        let v1 = FundingRateComputedV2{
            symbol                : arg1,
            premium_rate          : v0.premium_rate,
            premium_is_negative   : v0.premium_is_negative,
            inventory_rate        : v0.inventory_rate,
            inventory_is_negative : v0.inventory_is_negative,
            total_rate            : v0.total_rate,
            total_is_negative     : v0.total_is_negative,
            market_id             : arg2,
            timestamp_ms          : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<FundingRateComputedV2>(v1);
        v0
    }

    public fun compute_inventory(arg0: u64, arg1: u64, arg2: u64) : (u64, bool) {
        let v0 = (arg1 as u128) + (arg2 as u128);
        if (v0 == 0) {
            return (0, false)
        };
        let (v1, v2) = if (arg1 >= arg2) {
            (arg1 - arg2, false)
        } else {
            (arg2 - arg1, true)
        };
        ((((arg0 as u128) * (v1 as u128) / v0) as u64), v2)
    }

    public fun compute_premium(arg0: u64, arg1: u64, arg2: u8, arg3: u8, arg4: u64) : (u64, bool) {
        assert!(arg2 != 2, 42001);
        assert!(arg1 > 0, 5);
        if (arg3 != 1) {
            return (0, false)
        };
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0 - arg1, false)
        } else {
            (arg1 - arg0, true)
        };
        let v2 = (((v0 as u128) * (1000000000 as u128) / (arg1 as u128)) as u64);
        let v3 = if (v2 > arg4) {
            arg4
        } else {
            v2
        };
        (v3, v1)
    }

    public fun compute_tiered_k(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = (arg1 as u128) + (arg2 as u128);
        if (arg3 == 0 || v0 == 0) {
            return arg0
        };
        let v1 = ((v0 * (1000000000 as u128) / (arg3 as u128)) as u64);
        if (v1 >= arg5) {
            arg0 * 4
        } else if (v1 >= arg4) {
            arg0 * 2
        } else {
            arg0
        }
    }

    public fun config_cap_rate(arg0: &FundingConfig) : u64 {
        arg0.cap_rate_scaled
    }

    public fun config_k_base(arg0: &FundingConfig) : u64 {
        arg0.k_base_scaled
    }

    public fun config_tier_1_threshold(arg0: &FundingConfig) : u64 {
        arg0.tier_1_threshold
    }

    public fun config_tier_2_threshold(arg0: &FundingConfig) : u64 {
        arg0.tier_2_threshold
    }

    public fun default_cap_rate() : u64 {
        2000000
    }

    public fun default_k_base() : u64 {
        100000
    }

    public fun has_config(arg0: &FundingRateRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, FundingConfig>(&arg0.configs, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FundingRateRegistry{
            id      : 0x2::object::new(arg0),
            configs : 0x2::table::new<vector<u8>, FundingConfig>(arg0),
        };
        0x2::transfer::share_object<FundingRateRegistry>(v0);
    }

    public fun register_config(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut FundingRateRegistry, arg2: vector<u8>, arg3: u64, arg4: u64) {
        assert!(!0x2::table::contains<vector<u8>, FundingConfig>(&arg1.configs, arg2), 1);
        assert!(arg3 > 0, 2);
        assert!(arg4 > 0, 3);
        assert!(arg4 <= 4611686018427387903, 6);
        let v0 = FundingConfig{
            cap_rate_scaled  : arg3,
            k_base_scaled    : arg4,
            tier_1_threshold : 333333333,
            tier_2_threshold : 666666667,
        };
        0x2::table::add<vector<u8>, FundingConfig>(&mut arg1.configs, arg2, v0);
        let v1 = FundingConfigRegistered{
            symbol          : arg2,
            cap_rate_scaled : arg3,
            k_base_scaled   : arg4,
        };
        0x2::event::emit<FundingConfigRegistered>(v1);
    }

    public fun result_inventory_is_negative(arg0: &FundingRateResult) : bool {
        arg0.inventory_is_negative
    }

    public fun result_inventory_rate(arg0: &FundingRateResult) : u64 {
        arg0.inventory_rate
    }

    public fun result_premium_is_negative(arg0: &FundingRateResult) : bool {
        arg0.premium_is_negative
    }

    public fun result_premium_rate(arg0: &FundingRateResult) : u64 {
        arg0.premium_rate
    }

    public fun result_total_is_negative(arg0: &FundingRateResult) : bool {
        arg0.total_is_negative
    }

    public fun result_total_rate(arg0: &FundingRateResult) : u64 {
        arg0.total_rate
    }

    public fun scale() : u64 {
        1000000000
    }

    public fun update_config(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut FundingRateRegistry, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(0x2::table::contains<vector<u8>, FundingConfig>(&arg1.configs, arg2), 0);
        assert!(arg3 > 0, 2);
        assert!(arg4 > 0, 3);
        assert!(arg4 <= 4611686018427387903, 6);
        assert!(arg5 < arg6, 4);
        assert!(arg6 <= 1000000000, 4);
        let v0 = 0x2::table::borrow_mut<vector<u8>, FundingConfig>(&mut arg1.configs, arg2);
        v0.cap_rate_scaled = arg3;
        v0.k_base_scaled = arg4;
        v0.tier_1_threshold = arg5;
        v0.tier_2_threshold = arg6;
        let v1 = FundingConfigUpdated{
            symbol           : arg2,
            cap_rate_scaled  : arg3,
            k_base_scaled    : arg4,
            tier_1_threshold : arg5,
            tier_2_threshold : arg6,
        };
        0x2::event::emit<FundingConfigUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

