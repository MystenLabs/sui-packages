module 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EmergencyCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuybackCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardsCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeParams has copy, drop, store {
        creation_fee_mist: u64,
        creator_lp_fee_share_bps: u64,
        max_creator_allocation_bps: u64,
        timelock_ms: u64,
    }

    struct PendingChange has copy, drop, store {
        params: FeeParams,
        treasury: address,
        executable_at_ms: u64,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        version: u64,
        treasury: address,
        fees: FeeParams,
        quotes: 0x2::table::Table<0x1::type_name::TypeName, u8>,
        open_quotes: bool,
        tick_spacings: 0x2::vec_set::VecSet<u32>,
        launches_paused: bool,
        pending: 0x1::option::Option<PendingChange>,
    }

    public(friend) fun assert_launch_allowed<T0>(arg0: &PlatformConfig, arg1: u32) {
        assert_version(arg0);
        assert!(!arg0.launches_paused, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::protocol_paused());
        assert!(is_quote_allowed<T0>(arg0), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::quote_not_allowed());
        assert!(0x2::vec_set::contains<u32>(&arg0.tick_spacings, &arg1), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::tick_spacing_not_allowed());
    }

    fun assert_valid_fee_params(arg0: &FeeParams) {
        assert!(arg0.creation_fee_mist <= 1000000000000, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::fee_too_high());
        assert!(arg0.creator_lp_fee_share_bps <= 10000, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::fee_too_high());
        assert!(arg0.max_creator_allocation_bps <= 2000, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_config());
        assert!(arg0.timelock_ms <= 2592000000, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_config());
    }

    public(friend) fun assert_version(arg0: &PlatformConfig) {
        assert!(arg0.version == 1, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_version());
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun cancel_change(arg0: &AdminCap, arg1: &mut PlatformConfig) {
        assert_version(arg1);
        arg1.pending = 0x1::option::none<PendingChange>();
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_config_change_cancelled(0x2::object::id<PlatformConfig>(arg1));
    }

    public fun creation_fee_mist(arg0: &FeeParams) : u64 {
        arg0.creation_fee_mist
    }

    public fun creator_lp_fee_share_bps(arg0: &FeeParams) : u64 {
        arg0.creator_lp_fee_share_bps
    }

    public fun execute_change(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: &0x2::clock::Clock) {
        assert_version(arg1);
        assert!(0x1::option::is_some<PendingChange>(&arg1.pending), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_config());
        let PendingChange {
            params           : v0,
            treasury         : v1,
            executable_at_ms : v2,
        } = 0x1::option::extract<PendingChange>(&mut arg1.pending);
        let v3 = v0;
        assert!(0x2::clock::timestamp_ms(arg2) >= v2, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_config());
        arg1.fees = v3;
        arg1.treasury = v1;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_config_updated(0x2::object::id<PlatformConfig>(arg1), v1, v3.creation_fee_mist, v3.creator_lp_fee_share_bps, v3.max_creator_allocation_bps, v3.timelock_ms);
    }

    public fun fees(arg0: &PlatformConfig) : FeeParams {
        arg0.fees
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeParams{
            creation_fee_mist          : 0,
            creator_lp_fee_share_bps   : 8000,
            max_creator_allocation_bps : 1000,
            timelock_ms                : 0,
        };
        let v1 = PlatformConfig{
            id              : 0x2::object::new(arg0),
            version         : 1,
            treasury        : 0x2::tx_context::sender(arg0),
            fees            : v0,
            quotes          : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
            open_quotes     : true,
            tick_spacings   : 0x2::vec_set::from_keys<u32>(vector[200, 220]),
            launches_paused : false,
            pending         : 0x1::option::none<PendingChange>(),
        };
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_platform_initialized(0x2::object::id<PlatformConfig>(&v1), 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PlatformConfig>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = EmergencyCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<EmergencyCap>(v3, 0x2::tx_context::sender(arg0));
        let v4 = RewardsCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RewardsCap>(v4, 0x2::tx_context::sender(arg0));
        let v5 = BuybackCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<BuybackCap>(v5, 0x2::tx_context::sender(arg0));
    }

    public fun is_quote_allowed<T0>(arg0: &PlatformConfig) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::table::contains<0x1::type_name::TypeName, u8>(&arg0.quotes, v0) && *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.quotes, v0) == 1 || arg0.open_quotes
    }

    public fun is_tick_spacing_allowed(arg0: &PlatformConfig, arg1: u32) : bool {
        0x2::vec_set::contains<u32>(&arg0.tick_spacings, &arg1)
    }

    public fun launches_paused(arg0: &PlatformConfig) : bool {
        arg0.launches_paused
    }

    public fun max_creation_fee_mist() : u64 {
        1000000000000
    }

    public fun max_creator_allocation_bps(arg0: &FeeParams) : u64 {
        arg0.max_creator_allocation_bps
    }

    public fun max_creator_allocation_cap_bps() : u64 {
        2000
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut PlatformConfig) {
        assert!(arg1.version < 1, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_version());
        arg1.version = 1;
    }

    public fun mint_buyback_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : BuybackCap {
        BuybackCap{id: 0x2::object::new(arg1)}
    }

    public fun mint_emergency_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : EmergencyCap {
        EmergencyCap{id: 0x2::object::new(arg1)}
    }

    public fun mint_rewards_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : RewardsCap {
        RewardsCap{id: 0x2::object::new(arg1)}
    }

    public fun new_fee_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : FeeParams {
        let v0 = FeeParams{
            creation_fee_mist          : arg0,
            creator_lp_fee_share_bps   : arg1,
            max_creator_allocation_bps : arg2,
            timelock_ms                : arg3,
        };
        assert_valid_fee_params(&v0);
        v0
    }

    public fun open_quotes(arg0: &PlatformConfig) : bool {
        arg0.open_quotes
    }

    public fun propose_change(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: FeeParams, arg3: address, arg4: &0x2::clock::Clock) {
        assert_version(arg1);
        assert_valid_fee_params(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg1.fees.timelock_ms;
        let v1 = PendingChange{
            params           : arg2,
            treasury         : arg3,
            executable_at_ms : v0,
        };
        arg1.pending = 0x1::option::some<PendingChange>(v1);
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_config_change_proposed(0x2::object::id<PlatformConfig>(arg1), arg3, arg2.creation_fee_mist, arg2.creator_lp_fee_share_bps, v0);
    }

    public fun quote_allow() : u8 {
        1
    }

    public fun quote_deny() : u8 {
        2
    }

    public fun set_launches_paused(arg0: &EmergencyCap, arg1: &mut PlatformConfig, arg2: bool) {
        assert_version(arg1);
        arg1.launches_paused = arg2;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_launches_paused(0x2::object::id<PlatformConfig>(arg1), arg2);
    }

    public fun set_open_quotes(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: bool) {
        assert_version(arg1);
        arg1.open_quotes = arg2;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_open_quotes_updated(0x2::object::id<PlatformConfig>(arg1), arg2);
    }

    public fun set_quote_decision<T0>(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u8) {
        assert_version(arg1);
        assert!(arg2 <= 2, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_config());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u8>(&arg1.quotes, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u8>(&mut arg1.quotes, v0);
        };
        if (arg2 != 0) {
            0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg1.quotes, v0, arg2);
        };
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_quote_decision_updated(0x2::object::id<PlatformConfig>(arg1), 0x1::type_name::into_string(v0), arg2);
    }

    public fun set_tick_spacing_allowed(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u32, arg3: bool) {
        assert_version(arg1);
        assert!(arg2 > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_config());
        if (arg3 && !0x2::vec_set::contains<u32>(&arg1.tick_spacings, &arg2)) {
            0x2::vec_set::insert<u32>(&mut arg1.tick_spacings, arg2);
        };
        if (!arg3 && 0x2::vec_set::contains<u32>(&arg1.tick_spacings, &arg2)) {
            0x2::vec_set::remove<u32>(&mut arg1.tick_spacings, &arg2);
        };
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_tick_spacing_updated(0x2::object::id<PlatformConfig>(arg1), arg2, arg3);
    }

    public fun timelock_ms(arg0: &FeeParams) : u64 {
        arg0.timelock_ms
    }

    public fun treasury(arg0: &PlatformConfig) : address {
        arg0.treasury
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

