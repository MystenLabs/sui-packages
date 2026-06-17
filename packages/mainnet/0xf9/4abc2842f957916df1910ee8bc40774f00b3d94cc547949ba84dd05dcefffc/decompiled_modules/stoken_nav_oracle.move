module 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_nav_oracle {
    struct NavOracleAdminCap has store, key {
        id: 0x2::object::UID,
        nav_oracle_id: 0x2::object::ID,
    }

    struct NavOracleManagerCap has store, key {
        id: 0x2::object::UID,
        nav_oracle_id: 0x2::object::ID,
    }

    struct NavOracleProviderCap has store, key {
        id: 0x2::object::UID,
        nav_oracle_id: 0x2::object::ID,
    }

    struct PendingNavProvider has copy, drop, store {
        nav_provider: address,
        proposed_at: u64,
    }

    struct PendingCooldown has copy, drop, store {
        cooldown_secs: u64,
        proposed_at: u64,
    }

    struct NavOracle<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        vault_id: 0x2::object::ID,
        manager: address,
        nav_provider: address,
        nav_provider_change_cooldown_secs: u64,
        cooldown_change_cooldown_secs: u64,
        last_nav_value: u64,
        last_nav_timestamp: u64,
        nav_update_count: u64,
        pending_nav_provider: 0x1::option::Option<PendingNavProvider>,
        pending_cooldown: 0x1::option::Option<PendingCooldown>,
    }

    struct NavOracleUpdatedEvent has copy, drop {
        nav_oracle_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        nav_value: u64,
        calculated_price: u64,
    }

    struct NavProviderProposedEvent has copy, drop {
        nav_oracle_id: 0x2::object::ID,
        nav_provider: address,
        valid_after: u64,
    }

    struct NavProviderUpdatedEvent has copy, drop {
        nav_oracle_id: 0x2::object::ID,
        old_provider: address,
        new_provider: address,
    }

    struct NavProviderChangeCancelledEvent has copy, drop {
        nav_oracle_id: 0x2::object::ID,
        cancelled_provider: address,
    }

    struct NavOracleCooldownUpdatedEvent has copy, drop {
        nav_oracle_id: 0x2::object::ID,
        cooldown_secs: u64,
    }

    public fun accept_cooldown<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<PendingCooldown>(&arg0.pending_cooldown), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::no_pending_cooldown_change());
        let v0 = 0x1::option::extract<PendingCooldown>(&mut arg0.pending_cooldown);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldown_change_cooldown_secs, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::cooldown_change_timelock_active());
        arg0.nav_provider_change_cooldown_secs = v0.cooldown_secs;
        arg0.cooldown_change_cooldown_secs = v0.cooldown_secs;
        let v1 = NavOracleCooldownUpdatedEvent{
            nav_oracle_id : 0x2::object::id<NavOracle<T0>>(arg0),
            cooldown_secs : v0.cooldown_secs,
        };
        0x2::event::emit<NavOracleCooldownUpdatedEvent>(v1);
    }

    public fun accept_nav_provider<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<PendingNavProvider>(&arg0.pending_nav_provider), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::no_pending_roles_change());
        let v0 = 0x1::option::extract<PendingNavProvider>(&mut arg0.pending_nav_provider);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.nav_provider_change_cooldown_secs, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::role_change_timelock_active());
        arg0.nav_provider = v0.nav_provider;
        let v1 = NavProviderUpdatedEvent{
            nav_oracle_id : 0x2::object::id<NavOracle<T0>>(arg0),
            old_provider  : arg0.nav_provider,
            new_provider  : v0.nav_provider,
        };
        0x2::event::emit<NavProviderUpdatedEvent>(v1);
    }

    fun assert_version<T0>(arg0: &NavOracle<T0>) {
        assert!(arg0.version == 1, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::wrong_version());
    }

    public fun cancel_cooldown<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        arg0.pending_cooldown = 0x1::option::none<PendingCooldown>();
    }

    public fun cancel_nav_provider<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<PendingNavProvider>(&arg0.pending_nav_provider), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::no_pending_roles_change());
        let v0 = 0x1::option::extract<PendingNavProvider>(&mut arg0.pending_nav_provider);
        let v1 = NavProviderChangeCancelledEvent{
            nav_oracle_id      : 0x2::object::id<NavOracle<T0>>(arg0),
            cancelled_provider : v0.nav_provider,
        };
        0x2::event::emit<NavProviderChangeCancelledEvent>(v1);
    }

    public fun create_nav_oracle<T0>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (NavOracleAdminCap, NavOracleManagerCap, NavOracleProviderCap) {
        assert!(arg1 != @0x0 && arg2 != @0x0, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_argument());
        assert!(arg3 >= 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_math::min_cooldown_secs() && arg3 <= 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_math::max_cooldown_secs(), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_argument());
        let v0 = NavOracle<T0>{
            id                                : 0x2::object::new(arg5),
            version                           : 1,
            vault_id                          : arg0,
            manager                           : arg1,
            nav_provider                      : arg2,
            nav_provider_change_cooldown_secs : arg3,
            cooldown_change_cooldown_secs     : arg3,
            last_nav_value                    : 0,
            last_nav_timestamp                : 0,
            nav_update_count                  : 0,
            pending_nav_provider              : 0x1::option::none<PendingNavProvider>(),
            pending_cooldown                  : 0x1::option::none<PendingCooldown>(),
        };
        let v1 = 0x2::object::id<NavOracle<T0>>(&v0);
        0x2::transfer::share_object<NavOracle<T0>>(v0);
        let v2 = NavOracleAdminCap{
            id            : 0x2::object::new(arg5),
            nav_oracle_id : v1,
        };
        let v3 = NavOracleManagerCap{
            id            : 0x2::object::new(arg5),
            nav_oracle_id : v1,
        };
        let v4 = NavOracleProviderCap{
            id            : 0x2::object::new(arg5),
            nav_oracle_id : v1,
        };
        (v2, v3, v4)
    }

    public fun current_module_version() : u64 {
        1
    }

    public fun migrate<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleAdminCap) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert!(arg0.version < 1, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::not_upgrade());
        arg0.version = 1;
    }

    fun now_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun propose_cooldown<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert!(arg2 >= 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_math::min_cooldown_secs() && arg2 <= 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_math::max_cooldown_secs(), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_argument());
        let v0 = PendingCooldown{
            cooldown_secs : arg2,
            proposed_at   : now_secs(arg3),
        };
        arg0.pending_cooldown = 0x1::option::some<PendingCooldown>(v0);
    }

    public fun propose_nav_provider<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert!(arg2 != @0x0, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_argument());
        let v0 = 0x2::object::id<NavOracle<T0>>(arg0);
        assert!(arg2 != 0x2::object::id_to_address(&v0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_argument());
        assert!(arg2 != 0x2::object::id_to_address(&arg0.vault_id), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_argument());
        assert!(arg2 != arg0.nav_provider, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::governance_no_op());
        assert!(0x1::option::is_none<PendingNavProvider>(&arg0.pending_nav_provider), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::governance_no_op());
        let v1 = now_secs(arg3);
        let v2 = PendingNavProvider{
            nav_provider : arg2,
            proposed_at  : v1,
        };
        arg0.pending_nav_provider = 0x1::option::some<PendingNavProvider>(v2);
        let v3 = NavProviderProposedEvent{
            nav_oracle_id : 0x2::object::id<NavOracle<T0>>(arg0),
            nav_provider  : arg2,
            valid_after   : v1 + arg0.nav_provider_change_cooldown_secs,
        };
        0x2::event::emit<NavProviderProposedEvent>(v3);
    }

    public fun update_vault_price_from_nav<T0, T1>(arg0: &mut NavOracle<T0>, arg1: &mut 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_vault::Vault<T0, T1>, arg2: &NavOracleProviderCap, arg3: &0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_vault::OracleCap, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(0x2::object::id<0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_vault::Vault<T0, T1>>(arg1) == arg0.vault_id, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_argument());
        assert!(arg2.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert!(arg4 > 0, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_argument());
        let v0 = 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_vault::total_shares<T0, T1>(arg1);
        assert!(v0 == arg5, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_argument());
        assert!(v0 > 0, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_argument());
        let v1 = 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_math::mul_div(arg4 + 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_vault::underlying_balance<T0, T1>(arg1), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_math::price_precision(), v0);
        assert!(v1 > 0, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::invalid_price());
        0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_vault::update_price<T0, T1>(arg1, arg3, v1, arg6, arg7);
        arg0.last_nav_value = arg4;
        arg0.last_nav_timestamp = now_secs(arg6);
        arg0.nav_update_count = arg0.nav_update_count + 1;
        let v2 = NavOracleUpdatedEvent{
            nav_oracle_id    : 0x2::object::id<NavOracle<T0>>(arg0),
            vault_id         : arg0.vault_id,
            nav_value        : arg4,
            calculated_price : v1,
        };
        0x2::event::emit<NavOracleUpdatedEvent>(v2);
    }

    // decompiled from Move bytecode v7
}

