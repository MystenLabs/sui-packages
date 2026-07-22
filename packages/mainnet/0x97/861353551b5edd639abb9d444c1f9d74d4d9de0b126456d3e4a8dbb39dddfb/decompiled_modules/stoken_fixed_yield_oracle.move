module 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_fixed_yield_oracle {
    struct FixedYieldOracleAdminCap has store, key {
        id: 0x2::object::UID,
        oracle_id: 0x2::object::ID,
    }

    struct FixedYieldOracleManagerCap has store, key {
        id: 0x2::object::UID,
        oracle_id: 0x2::object::ID,
    }

    struct PendingYieldParams has copy, drop, store {
        annual_rate_bps: u64,
        proposed_at: u64,
    }

    struct PendingCooldown has copy, drop, store {
        cooldown_secs: u64,
        proposed_at: u64,
    }

    struct FixedYieldOracle<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        vault_id: 0x2::object::ID,
        manager: address,
        authority: address,
        initial_price: u64,
        annual_rate_bps: u64,
        start_timestamp: u64,
        cooldown_secs: u64,
        cooldown_change_cooldown_secs: u64,
        last_update_timestamp: u64,
        update_count: u64,
        pending_yield_params: 0x1::option::Option<PendingYieldParams>,
        pending_cooldown: 0x1::option::Option<PendingCooldown>,
    }

    struct GlobalYieldStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingGlobalYieldParams has copy, drop, store {
        annual_rate_bps: u64,
        initial_price: u64,
        epoch: u64,
        proposed_at: u64,
    }

    struct GlobalYieldState has store {
        oracle_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        initial_price: u64,
        annual_rate_bps: u64,
        epoch: u64,
        tolerance_bps: u64,
        max_snapshot_age_secs: u64,
        max_future_skew_secs: u64,
        last_round_id: u64,
        pending_params: 0x1::option::Option<PendingGlobalYieldParams>,
    }

    struct FixedYieldOracleInitializedEvent has copy, drop {
        oracle_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        initial_price: u64,
        annual_rate_bps: u64,
    }

    struct FixedYieldPriceUpdatedEvent has copy, drop {
        oracle_id: 0x2::object::ID,
        new_price: u64,
        update_count: u64,
    }

    struct FixedYieldParamsProposedEvent has copy, drop {
        oracle_id: 0x2::object::ID,
        annual_rate_bps: u64,
    }

    struct FixedYieldParamsUpdatedEvent has copy, drop {
        oracle_id: 0x2::object::ID,
        annual_rate_bps: u64,
    }

    struct FixedYieldParamsCancelledEvent has copy, drop {
        oracle_id: 0x2::object::ID,
        annual_rate_bps: u64,
    }

    struct FixedYieldCooldownUpdatedEvent has copy, drop {
        oracle_id: 0x2::object::ID,
        cooldown_secs: u64,
    }

    public fun accept_cooldown<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        assert!(0x1::option::is_some<PendingCooldown>(&arg0.pending_cooldown), 332);
        let v0 = 0x1::option::extract<PendingCooldown>(&mut arg0.pending_cooldown);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldown_change_cooldown_secs, 330);
        arg0.cooldown_secs = v0.cooldown_secs;
        arg0.cooldown_change_cooldown_secs = v0.cooldown_secs;
        let v1 = FixedYieldCooldownUpdatedEvent{
            oracle_id     : 0x2::object::id<FixedYieldOracle<T0>>(arg0),
            cooldown_secs : v0.cooldown_secs,
        };
        0x2::event::emit<FixedYieldCooldownUpdatedEvent>(v1);
    }

    public fun accept_global_yield_parameters<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        let v0 = arg0.cooldown_secs;
        let v1 = global_state_mut<T0>(arg0);
        assert!(0x1::option::is_some<PendingGlobalYieldParams>(&v1.pending_params), 322);
        let v2 = 0x1::option::extract<PendingGlobalYieldParams>(&mut v1.pending_params);
        assert!(now_secs(arg2) >= v2.proposed_at + v0, 320);
        v1.initial_price = v2.initial_price;
        v1.annual_rate_bps = v2.annual_rate_bps;
        v1.epoch = v2.epoch;
    }

    public fun accept_yield_parameters<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        assert!(0x1::option::is_some<PendingYieldParams>(&arg0.pending_yield_params), 322);
        let v0 = 0x1::option::extract<PendingYieldParams>(&mut arg0.pending_yield_params);
        let v1 = now_secs(arg2);
        assert!(v1 >= v0.proposed_at + arg0.cooldown_secs, 320);
        arg0.initial_price = calculate_current_price<T0>(arg0, v1);
        arg0.start_timestamp = v1;
        arg0.annual_rate_bps = v0.annual_rate_bps;
        let v2 = FixedYieldParamsUpdatedEvent{
            oracle_id       : 0x2::object::id<FixedYieldOracle<T0>>(arg0),
            annual_rate_bps : v0.annual_rate_bps,
        };
        0x2::event::emit<FixedYieldParamsUpdatedEvent>(v2);
    }

    fun assert_version<T0>(arg0: &FixedYieldOracle<T0>) {
        assert!(arg0.version == 1, 9);
    }

    public fun calculate_current_price<T0>(arg0: &FixedYieldOracle<T0>, arg1: u64) : u64 {
        if (arg1 <= arg0.start_timestamp) {
            return arg0.initial_price
        };
        arg0.initial_price + 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::mul_div((arg0.initial_price as u64) * arg0.annual_rate_bps, arg1 - arg0.start_timestamp, 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::seconds_per_year() * 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::bps_precision())
    }

    fun calculate_price_from_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 <= arg2) {
            return arg0
        };
        arg0 + 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::mul_div(arg0 * arg1, arg3 - arg2, 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::seconds_per_year() * 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::bps_precision())
    }

    public fun cancel_cooldown<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        arg0.pending_cooldown = 0x1::option::none<PendingCooldown>();
    }

    public fun cancel_global_yield_parameters<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        let v0 = global_state_mut<T0>(arg0);
        assert!(0x1::option::is_some<PendingGlobalYieldParams>(&v0.pending_params), 322);
        v0.pending_params = 0x1::option::none<PendingGlobalYieldParams>();
    }

    public fun cancel_yield_parameters<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        assert!(0x1::option::is_some<PendingYieldParams>(&arg0.pending_yield_params), 322);
        let v0 = 0x1::option::extract<PendingYieldParams>(&mut arg0.pending_yield_params);
        let v1 = FixedYieldParamsCancelledEvent{
            oracle_id       : 0x2::object::id<FixedYieldOracle<T0>>(arg0),
            annual_rate_bps : v0.annual_rate_bps,
        };
        0x2::event::emit<FixedYieldParamsCancelledEvent>(v1);
    }

    public fun create_fixed_yield_oracle<T0>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (FixedYieldOracleAdminCap, FixedYieldOracleManagerCap) {
        assert!(arg1 != @0x0 && arg2 != @0x0, 5);
        assert!(arg3 > 0, 3);
        assert!(arg4 <= 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::bps_precision(), 5);
        assert!(arg5 >= 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::min_cooldown_secs() && arg5 <= 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::max_cooldown_secs(), 5);
        let v0 = FixedYieldOracle<T0>{
            id                            : 0x2::object::new(arg7),
            version                       : 1,
            vault_id                      : arg0,
            manager                       : arg1,
            authority                     : arg2,
            initial_price                 : arg3,
            annual_rate_bps               : arg4,
            start_timestamp               : now_secs(arg6),
            cooldown_secs                 : arg5,
            cooldown_change_cooldown_secs : arg5,
            last_update_timestamp         : 0,
            update_count                  : 0,
            pending_yield_params          : 0x1::option::none<PendingYieldParams>(),
            pending_cooldown              : 0x1::option::none<PendingCooldown>(),
        };
        let v1 = 0x2::object::id<FixedYieldOracle<T0>>(&v0);
        let v2 = FixedYieldOracleInitializedEvent{
            oracle_id       : v1,
            vault_id        : arg0,
            initial_price   : arg3,
            annual_rate_bps : arg4,
        };
        0x2::event::emit<FixedYieldOracleInitializedEvent>(v2);
        0x2::transfer::share_object<FixedYieldOracle<T0>>(v0);
        let v3 = FixedYieldOracleAdminCap{
            id        : 0x2::object::new(arg7),
            oracle_id : v1,
        };
        let v4 = FixedYieldOracleManagerCap{
            id        : 0x2::object::new(arg7),
            oracle_id : v1,
        };
        (v3, v4)
    }

    public fun create_global_yield_state<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert!(!has_global_state<T0>(arg0), 5);
        assert!(arg6 > 0 && arg7 > 0, 5);
        assert!(arg2 > 0, 3);
        assert!(arg3 <= 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::bps_precision() && arg5 <= 1, 5);
        let v0 = GlobalYieldStateKey{dummy_field: false};
        let v1 = GlobalYieldState{
            oracle_id             : 0x2::object::id<FixedYieldOracle<T0>>(arg0),
            vault_id              : arg0.vault_id,
            initial_price         : arg2,
            annual_rate_bps       : arg3,
            epoch                 : arg4,
            tolerance_bps         : arg5,
            max_snapshot_age_secs : arg6,
            max_future_skew_secs  : arg7,
            last_round_id         : 0,
            pending_params        : 0x1::option::none<PendingGlobalYieldParams>(),
        };
        0x2::dynamic_field::add<GlobalYieldStateKey, GlobalYieldState>(&mut arg0.id, v0, v1);
    }

    public fun current_module_version() : u64 {
        1
    }

    fun global_state_mut<T0>(arg0: &mut FixedYieldOracle<T0>) : &mut GlobalYieldState {
        let v0 = GlobalYieldStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<GlobalYieldStateKey, GlobalYieldState>(&mut arg0.id, v0)
    }

    fun has_global_state<T0>(arg0: &FixedYieldOracle<T0>) : bool {
        let v0 = GlobalYieldStateKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<GlobalYieldStateKey, GlobalYieldState>(&arg0.id, v0)
    }

    public fun migrate<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleAdminCap) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert!(arg0.version < 1, 10);
        arg0.version = 1;
    }

    fun now_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun propose_cooldown<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 1);
        assert!(arg2 >= 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::min_cooldown_secs() && arg2 <= 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::max_cooldown_secs(), 5);
        let v0 = PendingCooldown{
            cooldown_secs : arg2,
            proposed_at   : now_secs(arg3),
        };
        arg0.pending_cooldown = 0x1::option::some<PendingCooldown>(v0);
    }

    public fun propose_global_yield_parameters<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg6) == arg0.manager, 1);
        assert!(arg3 > 0 && arg2 <= 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::bps_precision(), 5);
        let v0 = PendingGlobalYieldParams{
            annual_rate_bps : arg2,
            initial_price   : arg3,
            epoch           : arg4,
            proposed_at     : now_secs(arg5),
        };
        global_state_mut<T0>(arg0).pending_params = 0x1::option::some<PendingGlobalYieldParams>(v0);
    }

    public fun propose_yield_parameters<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 1);
        assert!(arg2 <= 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::bps_precision(), 5);
        let v0 = PendingYieldParams{
            annual_rate_bps : arg2,
            proposed_at     : now_secs(arg3),
        };
        arg0.pending_yield_params = 0x1::option::some<PendingYieldParams>(v0);
        let v1 = FixedYieldParamsProposedEvent{
            oracle_id       : 0x2::object::id<FixedYieldOracle<T0>>(arg0),
            annual_rate_bps : arg2,
        };
        0x2::event::emit<FixedYieldParamsProposedEvent>(v1);
    }

    public fun update_price_from_global_yield<T0, T1>(arg0: &mut FixedYieldOracle<T0>, arg1: &mut 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_vault::Vault<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg6) == arg0.authority, 1);
        assert!(0x2::object::id<0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_vault::Vault<T0, T1>>(arg1) == arg0.vault_id, 5);
        let v0 = 0x2::object::id<FixedYieldOracle<T0>>(arg0);
        let v1 = global_state_mut<T0>(arg0);
        assert!(v1.oracle_id == v0 && v1.vault_id == 0x2::object::id<0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_vault::Vault<T0, T1>>(arg1), 5);
        assert!(arg2 > 0 && arg3 > v1.last_round_id, 5);
        validate_observed_at(arg4, v1.max_snapshot_age_secs, v1.max_future_skew_secs, arg5);
        let v2 = calculate_price_from_params(v1.initial_price, v1.annual_rate_bps, v1.epoch, arg4);
        assert!(arg2 >= 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::mul_div(v2, 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::bps_precision() - v1.tolerance_bps, 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::bps_precision()) && arg2 <= 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::mul_div(v2, 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::bps_precision() + v1.tolerance_bps, 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math::bps_precision()), 3);
        v1.last_round_id = arg3;
        0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_vault::update_price_from_oracle_service<T0, T1>(arg1, arg2, arg5);
        arg0.last_update_timestamp = now_secs(arg5);
        arg0.update_count = arg0.update_count + 1;
        let v3 = FixedYieldPriceUpdatedEvent{
            oracle_id    : v0,
            new_price    : arg2,
            update_count : arg0.update_count,
        };
        0x2::event::emit<FixedYieldPriceUpdatedEvent>(v3);
    }

    public fun update_vault_price_from_yield<T0, T1>(arg0: &mut FixedYieldOracle<T0>, arg1: &mut 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_vault::Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(!has_global_state<T0>(arg0), 5);
        assert!(0x2::tx_context::sender(arg3) == arg0.authority, 1);
        assert!(0x2::object::id<0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_vault::Vault<T0, T1>>(arg1) == arg0.vault_id, 5);
        let v0 = calculate_current_price<T0>(arg0, now_secs(arg2));
        assert!(v0 > 0, 3);
        0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_vault::update_price_from_oracle_service<T0, T1>(arg1, v0, arg2);
        arg0.last_update_timestamp = now_secs(arg2);
        arg0.update_count = arg0.update_count + 1;
        let v1 = FixedYieldPriceUpdatedEvent{
            oracle_id    : 0x2::object::id<FixedYieldOracle<T0>>(arg0),
            new_price    : v0,
            update_count : arg0.update_count,
        };
        0x2::event::emit<FixedYieldPriceUpdatedEvent>(v1);
    }

    fun validate_observed_at(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = now_secs(arg3);
        assert!(arg0 <= v0 + arg2, 5);
        let v1 = if (v0 < arg1) {
            v0
        } else {
            arg1
        };
        assert!(arg0 >= v0 - v1, 5);
    }

    // decompiled from Move bytecode v7
}

