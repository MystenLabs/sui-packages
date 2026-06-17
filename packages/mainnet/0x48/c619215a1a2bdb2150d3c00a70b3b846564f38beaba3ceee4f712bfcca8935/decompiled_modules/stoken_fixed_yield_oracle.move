module 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_fixed_yield_oracle {
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
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<PendingCooldown>(&arg0.pending_cooldown), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::no_pending_cooldown_change());
        let v0 = 0x1::option::extract<PendingCooldown>(&mut arg0.pending_cooldown);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldown_change_cooldown_secs, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::cooldown_change_timelock_active());
        arg0.cooldown_secs = v0.cooldown_secs;
        arg0.cooldown_change_cooldown_secs = v0.cooldown_secs;
        let v1 = FixedYieldCooldownUpdatedEvent{
            oracle_id     : 0x2::object::id<FixedYieldOracle<T0>>(arg0),
            cooldown_secs : v0.cooldown_secs,
        };
        0x2::event::emit<FixedYieldCooldownUpdatedEvent>(v1);
    }

    public fun accept_yield_parameters<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<PendingYieldParams>(&arg0.pending_yield_params), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::no_pending_fees_change());
        let v0 = 0x1::option::extract<PendingYieldParams>(&mut arg0.pending_yield_params);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldown_secs, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::fee_change_timelock_active());
        arg0.annual_rate_bps = v0.annual_rate_bps;
        let v1 = FixedYieldParamsUpdatedEvent{
            oracle_id       : 0x2::object::id<FixedYieldOracle<T0>>(arg0),
            annual_rate_bps : v0.annual_rate_bps,
        };
        0x2::event::emit<FixedYieldParamsUpdatedEvent>(v1);
    }

    fun assert_version<T0>(arg0: &FixedYieldOracle<T0>) {
        assert!(arg0.version == 1, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::wrong_version());
    }

    public fun calculate_current_price<T0>(arg0: &FixedYieldOracle<T0>, arg1: u64) : u64 {
        if (arg1 <= arg0.start_timestamp) {
            return arg0.initial_price
        };
        arg0.initial_price + 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_math::mul_div((arg0.initial_price as u64) * arg0.annual_rate_bps, arg1 - arg0.start_timestamp, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_math::seconds_per_year() * 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_math::bps_precision())
    }

    public fun cancel_cooldown<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        arg0.pending_cooldown = 0x1::option::none<PendingCooldown>();
    }

    public fun cancel_yield_parameters<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<PendingYieldParams>(&arg0.pending_yield_params), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::no_pending_fees_change());
        let v0 = 0x1::option::extract<PendingYieldParams>(&mut arg0.pending_yield_params);
        let v1 = FixedYieldParamsCancelledEvent{
            oracle_id       : 0x2::object::id<FixedYieldOracle<T0>>(arg0),
            annual_rate_bps : v0.annual_rate_bps,
        };
        0x2::event::emit<FixedYieldParamsCancelledEvent>(v1);
    }

    public fun create_fixed_yield_oracle<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (FixedYieldOracleAdminCap, FixedYieldOracleManagerCap) {
        assert!(arg1 != @0x0, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::invalid_argument());
        assert!(arg2 > 0, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::invalid_price());
        assert!(arg3 <= 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_math::bps_precision(), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::invalid_argument());
        assert!(arg4 >= 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_math::min_cooldown_secs() && arg4 <= 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_math::max_cooldown_secs(), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::invalid_argument());
        let v0 = FixedYieldOracle<T0>{
            id                            : 0x2::object::new(arg6),
            version                       : 1,
            vault_id                      : arg0,
            manager                       : arg1,
            initial_price                 : arg2,
            annual_rate_bps               : arg3,
            start_timestamp               : now_secs(arg5),
            cooldown_secs                 : arg4,
            cooldown_change_cooldown_secs : arg4,
            last_update_timestamp         : 0,
            update_count                  : 0,
            pending_yield_params          : 0x1::option::none<PendingYieldParams>(),
            pending_cooldown              : 0x1::option::none<PendingCooldown>(),
        };
        let v1 = 0x2::object::id<FixedYieldOracle<T0>>(&v0);
        let v2 = FixedYieldOracleInitializedEvent{
            oracle_id       : v1,
            vault_id        : arg0,
            initial_price   : arg2,
            annual_rate_bps : arg3,
        };
        0x2::event::emit<FixedYieldOracleInitializedEvent>(v2);
        0x2::transfer::share_object<FixedYieldOracle<T0>>(v0);
        let v3 = FixedYieldOracleAdminCap{
            id        : 0x2::object::new(arg6),
            oracle_id : v1,
        };
        let v4 = FixedYieldOracleManagerCap{
            id        : 0x2::object::new(arg6),
            oracle_id : v1,
        };
        (v3, v4)
    }

    public fun current_module_version() : u64 {
        1
    }

    public fun migrate<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleAdminCap) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert!(arg0.version < 1, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::not_upgrade());
        arg0.version = 1;
    }

    fun now_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun propose_cooldown<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert!(arg2 >= 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_math::min_cooldown_secs() && arg2 <= 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_math::max_cooldown_secs(), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::invalid_argument());
        let v0 = PendingCooldown{
            cooldown_secs : arg2,
            proposed_at   : now_secs(arg3),
        };
        arg0.pending_cooldown = 0x1::option::some<PendingCooldown>(v0);
    }

    public fun propose_yield_parameters<T0>(arg0: &mut FixedYieldOracle<T0>, arg1: &FixedYieldOracleManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert!(arg2 <= 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_math::bps_precision(), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::invalid_argument());
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

    public fun update_vault_price_from_yield<T0, T1>(arg0: &mut FixedYieldOracle<T0>, arg1: &mut 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_vault::Vault<T0, T1>, arg2: &FixedYieldOracleManagerCap, arg3: &0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_vault::OracleCap, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg2.oracle_id == 0x2::object::id<FixedYieldOracle<T0>>(arg0), 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::unauthorized());
        assert!(0x2::object::id<0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_vault::Vault<T0, T1>>(arg1) == arg0.vault_id, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::invalid_argument());
        let v0 = calculate_current_price<T0>(arg0, now_secs(arg4));
        assert!(v0 > 0, 0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_errors::invalid_price());
        0x48c619215a1a2bdb2150d3c00a70b3b846564f38beaba3ceee4f712bfcca8935::stoken_vault::update_price<T0, T1>(arg1, arg3, v0, arg4, arg5);
        arg0.last_update_timestamp = now_secs(arg4);
        arg0.update_count = arg0.update_count + 1;
        let v1 = FixedYieldPriceUpdatedEvent{
            oracle_id    : 0x2::object::id<FixedYieldOracle<T0>>(arg0),
            new_price    : v0,
            update_count : arg0.update_count,
        };
        0x2::event::emit<FixedYieldPriceUpdatedEvent>(v1);
    }

    // decompiled from Move bytecode v7
}

