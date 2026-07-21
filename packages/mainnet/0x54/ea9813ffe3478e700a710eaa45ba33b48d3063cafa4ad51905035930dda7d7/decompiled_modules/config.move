module 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct QuoteParams has copy, drop, store {
        enabled: bool,
        decimals: u8,
        default_threshold: u64,
        min_threshold: u64,
        creation_fee: u64,
        min_buy_amount: u64,
        min_tvl_target: u64,
    }

    struct LaunchpadConfig has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        treasury: address,
        base_decimals: u8,
        initial_virtual_base: u64,
        remain_base: u64,
        curve_fee_bps: u64,
        curve_fee_platform_bps: u64,
        referral_bps: u64,
        lp_fee_platform_bps: u64,
        migration_fee_bps: u64,
        tick_spacing: u32,
        min_lock_duration_ms: u64,
        tvl_target_multiplier: u64,
        first_buy_time_cap_bps: u64,
        first_buy_tvl_cap_bps: u64,
        tvl_vesting_duration_ms: u64,
        quotes: 0x2::table::Table<0x1::type_name::TypeName, QuoteParams>,
        pools: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct QuoteListedEvent has copy, drop {
        quote: 0x1::type_name::TypeName,
        params: QuoteParams,
    }

    struct QuoteUpdatedEvent has copy, drop {
        quote: 0x1::type_name::TypeName,
        params: QuoteParams,
    }

    struct FeeParamsUpdatedEvent has copy, drop {
        curve_fee_bps: u64,
        curve_fee_platform_bps: u64,
        referral_bps: u64,
        lp_fee_platform_bps: u64,
        migration_fee_bps: u64,
    }

    struct LaunchParamsUpdatedEvent has copy, drop {
        base_decimals: u8,
        initial_virtual_base: u64,
        remain_base: u64,
        tick_spacing: u32,
        min_lock_duration_ms: u64,
        tvl_target_multiplier: u64,
        first_buy_time_cap_bps: u64,
        first_buy_tvl_cap_bps: u64,
    }

    struct TvlVestingParamsUpdatedEvent has copy, drop {
        tvl_vesting_duration_ms: u64,
    }

    struct TreasuryUpdatedEvent has copy, drop {
        treasury: address,
    }

    struct PausedEvent has copy, drop {
        paused: bool,
    }

    struct AdminTransferredEvent has copy, drop {
        from: address,
        to: address,
    }

    public fun add_quote<T0>(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, QuoteParams>(&arg1.quotes, v0), 3);
        let v1 = new_quote_params(arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::table::add<0x1::type_name::TypeName, QuoteParams>(&mut arg1.quotes, v0, v1);
        let v2 = QuoteListedEvent{
            quote  : v0,
            params : v1,
        };
        0x2::event::emit<QuoteListedEvent>(v2);
    }

    public fun assert_not_paused(arg0: &LaunchpadConfig) {
        assert!(!arg0.paused, 2);
    }

    public fun assert_version(arg0: &LaunchpadConfig) {
        assert!(arg0.version <= 1, 1);
    }

    public fun base_decimals(arg0: &LaunchpadConfig) : u8 {
        arg0.base_decimals
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun bump_config_version(arg0: &AdminCap, arg1: &mut LaunchpadConfig) {
        assert!(1 > arg1.version, 9);
        arg1.version = 1;
    }

    public fun curve_fee_bps(arg0: &LaunchpadConfig) : u64 {
        arg0.curve_fee_bps
    }

    public fun curve_fee_platform_bps(arg0: &LaunchpadConfig) : u64 {
        arg0.curve_fee_platform_bps
    }

    public(friend) fun enabled_quote_params(arg0: &LaunchpadConfig, arg1: 0x1::type_name::TypeName) : QuoteParams {
        assert!(0x2::table::contains<0x1::type_name::TypeName, QuoteParams>(&arg0.quotes, arg1), 4);
        let v0 = *0x2::table::borrow<0x1::type_name::TypeName, QuoteParams>(&arg0.quotes, arg1);
        assert!(v0.enabled, 4);
        v0
    }

    public fun first_buy_time_cap_bps(arg0: &LaunchpadConfig) : u64 {
        arg0.first_buy_time_cap_bps
    }

    public fun first_buy_tvl_cap_bps(arg0: &LaunchpadConfig) : u64 {
        arg0.first_buy_tvl_cap_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = LaunchpadConfig{
            id                      : 0x2::object::new(arg0),
            version                 : 1,
            paused                  : false,
            treasury                : 0x2::tx_context::sender(arg0),
            base_decimals           : 9,
            initial_virtual_base    : 800000000000000000,
            remain_base             : 200000000000000000,
            curve_fee_bps           : 100,
            curve_fee_platform_bps  : 6000,
            referral_bps            : 1000,
            lp_fee_platform_bps     : 5000,
            migration_fee_bps       : 100,
            tick_spacing            : 200,
            min_lock_duration_ms    : 86400000,
            tvl_target_multiplier   : 3,
            first_buy_time_cap_bps  : 300,
            first_buy_tvl_cap_bps   : 500,
            tvl_vesting_duration_ms : 864000000,
            quotes                  : 0x2::table::new<0x1::type_name::TypeName, QuoteParams>(arg0),
            pools                   : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<LaunchpadConfig>(v1);
    }

    public fun initial_virtual_base(arg0: &LaunchpadConfig) : u64 {
        arg0.initial_virtual_base
    }

    public fun is_paused(arg0: &LaunchpadConfig) : bool {
        arg0.paused
    }

    public fun is_quote_listed(arg0: &LaunchpadConfig, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, QuoteParams>(&arg0.quotes, arg1)
    }

    public fun lp_fee_platform_bps(arg0: &LaunchpadConfig) : u64 {
        arg0.lp_fee_platform_bps
    }

    public fun migration_fee_bps(arg0: &LaunchpadConfig) : u64 {
        arg0.migration_fee_bps
    }

    public fun min_lock_duration_ms(arg0: &LaunchpadConfig) : u64 {
        arg0.min_lock_duration_ms
    }

    fun new_quote_params(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : QuoteParams {
        assert!(arg1 >= arg2, 8);
        assert!(arg2 >= 1000, 8);
        QuoteParams{
            enabled           : true,
            decimals          : arg0,
            default_threshold : arg1,
            min_threshold     : arg2,
            creation_fee      : arg3,
            min_buy_amount    : arg4,
            min_tvl_target    : arg5,
        }
    }

    public fun pool_id(arg0: &LaunchpadConfig, arg1: 0x1::type_name::TypeName) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun quote_creation_fee(arg0: &QuoteParams) : u64 {
        arg0.creation_fee
    }

    public fun quote_decimals(arg0: &QuoteParams) : u8 {
        arg0.decimals
    }

    public fun quote_default_threshold(arg0: &QuoteParams) : u64 {
        arg0.default_threshold
    }

    public fun quote_enabled(arg0: &QuoteParams) : bool {
        arg0.enabled
    }

    public fun quote_min_buy_amount(arg0: &QuoteParams) : u64 {
        arg0.min_buy_amount
    }

    public fun quote_min_threshold(arg0: &QuoteParams) : u64 {
        arg0.min_threshold
    }

    public fun quote_min_tvl_target(arg0: &QuoteParams) : u64 {
        arg0.min_tvl_target
    }

    public fun referral_bps(arg0: &LaunchpadConfig) : u64 {
        arg0.referral_bps
    }

    public(friend) fun register_pool(arg0: &mut LaunchpadConfig, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, arg1), 7);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pools, arg1, arg2);
    }

    public fun remain_base(arg0: &LaunchpadConfig) : u64 {
        arg0.remain_base
    }

    public(friend) fun resolve_threshold(arg0: &QuoteParams, arg1: 0x1::option::Option<u64>) : u64 {
        if (0x1::option::is_some<u64>(&arg1)) {
            let v1 = 0x1::option::destroy_some<u64>(arg1);
            assert!(v1 >= arg0.min_threshold, 8);
            v1
        } else {
            arg0.default_threshold
        }
    }

    public fun set_fee_params(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_version(arg1);
        assert!(arg2 <= 1000, 5);
        assert!(arg3 <= 10000, 5);
        assert!(arg5 <= 10000, 5);
        assert!(arg6 <= 1000, 5);
        assert!(arg4 <= 1000, 5);
        assert!(arg4 <= arg3, 5);
        arg1.curve_fee_bps = arg2;
        arg1.curve_fee_platform_bps = arg3;
        arg1.referral_bps = arg4;
        arg1.lp_fee_platform_bps = arg5;
        arg1.migration_fee_bps = arg6;
        let v0 = FeeParamsUpdatedEvent{
            curve_fee_bps          : arg2,
            curve_fee_platform_bps : arg3,
            referral_bps           : arg4,
            lp_fee_platform_bps    : arg5,
            migration_fee_bps      : arg6,
        };
        0x2::event::emit<FeeParamsUpdatedEvent>(v0);
    }

    public fun set_launch_params(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u8, arg3: u64, arg4: u64, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert_version(arg1);
        assert!(arg4 >= 1000000000, 6);
        assert!(arg3 > arg4, 6);
        assert!(arg7 >= 2, 6);
        assert!(arg7 <= 1000, 6);
        assert!(arg6 >= 3600000, 6);
        assert!(arg6 <= 315360000000, 6);
        assert!((arg3 as u128) * (arg3 as u128) / ((arg3 - arg4) as u128) <= 18446744073709551615, 6);
        assert!(arg8 > 0 && arg8 <= 500, 6);
        assert!(arg9 > 0 && arg9 <= 500, 6);
        assert!(arg2 == 9, 6);
        assert!(arg5 == 200, 6);
        assert!(arg3 / arg4 <= 1000, 6);
        arg1.base_decimals = arg2;
        arg1.initial_virtual_base = arg3;
        arg1.remain_base = arg4;
        arg1.tick_spacing = arg5;
        arg1.min_lock_duration_ms = arg6;
        arg1.tvl_target_multiplier = arg7;
        arg1.first_buy_time_cap_bps = arg8;
        arg1.first_buy_tvl_cap_bps = arg9;
        let v0 = LaunchParamsUpdatedEvent{
            base_decimals          : arg2,
            initial_virtual_base   : arg3,
            remain_base            : arg4,
            tick_spacing           : arg5,
            min_lock_duration_ms   : arg6,
            tvl_target_multiplier  : arg7,
            first_buy_time_cap_bps : arg8,
            first_buy_tvl_cap_bps  : arg9,
        };
        0x2::event::emit<LaunchParamsUpdatedEvent>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: bool) {
        assert_version(arg1);
        arg1.paused = arg2;
        let v0 = PausedEvent{paused: arg2};
        0x2::event::emit<PausedEvent>(v0);
    }

    public fun set_quote_enabled<T0>(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: bool) {
        assert_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, QuoteParams>(&arg1.quotes, v0), 4);
        0x2::table::borrow_mut<0x1::type_name::TypeName, QuoteParams>(&mut arg1.quotes, v0).enabled = arg2;
        let v1 = QuoteUpdatedEvent{
            quote  : v0,
            params : *0x2::table::borrow<0x1::type_name::TypeName, QuoteParams>(&arg1.quotes, v0),
        };
        0x2::event::emit<QuoteUpdatedEvent>(v1);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: address) {
        assert_version(arg1);
        assert!(arg2 != @0x0, 10);
        arg1.treasury = arg2;
        let v0 = TreasuryUpdatedEvent{treasury: arg2};
        0x2::event::emit<TreasuryUpdatedEvent>(v0);
    }

    public fun set_tvl_vesting_params(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 > 0, 6);
        assert!(arg2 <= 315360000000, 6);
        arg1.tvl_vesting_duration_ms = arg2;
        let v0 = TvlVestingParamsUpdatedEvent{tvl_vesting_duration_ms: arg2};
        0x2::event::emit<TvlVestingParamsUpdatedEvent>(v0);
    }

    public fun tick_spacing(arg0: &LaunchpadConfig) : u32 {
        arg0.tick_spacing
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = AdminTransferredEvent{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<AdminTransferredEvent>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun treasury(arg0: &LaunchpadConfig) : address {
        arg0.treasury
    }

    public fun tvl_target_multiplier(arg0: &LaunchpadConfig) : u64 {
        arg0.tvl_target_multiplier
    }

    public fun tvl_vesting_duration_ms(arg0: &LaunchpadConfig) : u64 {
        arg0.tvl_vesting_duration_ms
    }

    public fun update_quote<T0>(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, QuoteParams>(&arg1.quotes, v0), 4);
        let v1 = new_quote_params(arg2, arg3, arg4, arg5, arg6, arg7);
        v1.enabled = 0x2::table::borrow<0x1::type_name::TypeName, QuoteParams>(&arg1.quotes, v0).enabled;
        *0x2::table::borrow_mut<0x1::type_name::TypeName, QuoteParams>(&mut arg1.quotes, v0) = v1;
        let v2 = QuoteUpdatedEvent{
            quote  : v0,
            params : v1,
        };
        0x2::event::emit<QuoteUpdatedEvent>(v2);
    }

    // decompiled from Move bytecode v7
}

