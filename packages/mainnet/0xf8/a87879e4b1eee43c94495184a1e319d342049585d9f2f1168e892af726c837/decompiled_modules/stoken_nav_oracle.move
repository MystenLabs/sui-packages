module 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_nav_oracle {
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

    struct GlobalNavStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ChainNavReport has copy, drop, store {
        chain_id: u64,
        nav: u64,
        shares: u64,
        observed_at: u64,
    }

    struct GlobalNavState has store {
        nav_oracle_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        max_snapshot_age_secs: u64,
        max_future_skew_secs: u64,
        last_round_id: u64,
        active_chain_ids: vector<u64>,
        pending_round_id: 0x1::option::Option<u64>,
        pending_required_chain_ids: vector<u64>,
        pending_reports: vector<ChainNavReport>,
    }

    struct NavOracleUpdatedEvent has copy, drop {
        nav_oracle_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        nav_value: u64,
        calculated_price: u64,
    }

    struct GlobalNavRoundFinalizedEvent has copy, drop {
        nav_oracle_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        round_id: u64,
        global_nav: u64,
        global_shares: u64,
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
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        assert!(0x1::option::is_some<PendingCooldown>(&arg0.pending_cooldown), 332);
        let v0 = 0x1::option::extract<PendingCooldown>(&mut arg0.pending_cooldown);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldown_change_cooldown_secs, 330);
        arg0.nav_provider_change_cooldown_secs = v0.cooldown_secs;
        arg0.cooldown_change_cooldown_secs = v0.cooldown_secs;
        let v1 = NavOracleCooldownUpdatedEvent{
            nav_oracle_id : 0x2::object::id<NavOracle<T0>>(arg0),
            cooldown_secs : v0.cooldown_secs,
        };
        0x2::event::emit<NavOracleCooldownUpdatedEvent>(v1);
    }

    public fun accept_nav_provider<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        assert!(0x1::option::is_some<PendingNavProvider>(&arg0.pending_nav_provider), 313);
        let v0 = 0x1::option::extract<PendingNavProvider>(&mut arg0.pending_nav_provider);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.nav_provider_change_cooldown_secs, 310);
        arg0.nav_provider = v0.nav_provider;
        let v1 = NavProviderUpdatedEvent{
            nav_oracle_id : 0x2::object::id<NavOracle<T0>>(arg0),
            old_provider  : arg0.nav_provider,
            new_provider  : v0.nav_provider,
        };
        0x2::event::emit<NavProviderUpdatedEvent>(v1);
    }

    public fun add_global_chain<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        let v0 = global_state_mut<T0>(arg0);
        assert!(arg2 != 0 && !contains_chain(&v0.active_chain_ids, arg2), 5);
        assert!(0x1::vector::length<u64>(&v0.active_chain_ids) < 16, 5);
        0x1::vector::push_back<u64>(&mut v0.active_chain_ids, arg2);
    }

    fun assert_provider<T0>(arg0: &NavOracle<T0>, arg1: &NavOracleProviderCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg2) == arg0.nav_provider, 1);
    }

    fun assert_version<T0>(arg0: &NavOracle<T0>) {
        assert!(arg0.version == 1, 9);
    }

    public fun cancel_cooldown<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        arg0.pending_cooldown = 0x1::option::none<PendingCooldown>();
    }

    public fun cancel_nav_provider<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        assert!(0x1::option::is_some<PendingNavProvider>(&arg0.pending_nav_provider), 313);
        let v0 = 0x1::option::extract<PendingNavProvider>(&mut arg0.pending_nav_provider);
        let v1 = NavProviderChangeCancelledEvent{
            nav_oracle_id      : 0x2::object::id<NavOracle<T0>>(arg0),
            cancelled_provider : v0.nav_provider,
        };
        0x2::event::emit<NavProviderChangeCancelledEvent>(v1);
    }

    public fun cancel_pending_global_round<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 1);
        let v0 = global_state_mut<T0>(arg0);
        assert!(0x1::option::is_some<u64>(&v0.pending_round_id), 5);
        v0.pending_round_id = 0x1::option::none<u64>();
        v0.pending_required_chain_ids = vector[];
        v0.pending_reports = 0x1::vector::empty<ChainNavReport>();
    }

    fun contains_chain(arg0: &vector<u64>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create_global_nav_state<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleAdminCap, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert!(!has_global_state<T0>(arg0), 5);
        assert!(arg2 > 0 && arg3 > 0, 5);
        assert!(0x1::vector::length<u64>(&arg4) > 0 && 0x1::vector::length<u64>(&arg4) <= 16, 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg4)) {
            let v1 = *0x1::vector::borrow<u64>(&arg4, v0);
            assert!(v1 != 0, 5);
            let v2 = v0 + 1;
            while (v2 < 0x1::vector::length<u64>(&arg4)) {
                assert!(v1 != *0x1::vector::borrow<u64>(&arg4, v2), 5);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        let v3 = GlobalNavStateKey{dummy_field: false};
        let v4 = GlobalNavState{
            nav_oracle_id              : 0x2::object::id<NavOracle<T0>>(arg0),
            vault_id                   : arg0.vault_id,
            max_snapshot_age_secs      : arg2,
            max_future_skew_secs       : arg3,
            last_round_id              : 0,
            active_chain_ids           : arg4,
            pending_round_id           : 0x1::option::none<u64>(),
            pending_required_chain_ids : vector[],
            pending_reports            : 0x1::vector::empty<ChainNavReport>(),
        };
        0x2::dynamic_field::add<GlobalNavStateKey, GlobalNavState>(&mut arg0.id, v3, v4);
    }

    public fun create_nav_oracle<T0>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (NavOracleAdminCap, NavOracleManagerCap, NavOracleProviderCap) {
        assert!(arg1 != @0x0 && arg2 != @0x0, 5);
        assert!(arg3 >= 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::min_cooldown_secs() && arg3 <= 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::max_cooldown_secs(), 5);
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

    public fun finalize_global_round<T0, T1>(arg0: &mut NavOracle<T0>, arg1: &mut 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::Vault<T0, T1>, arg2: &NavOracleProviderCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_provider<T0>(arg0, arg2, arg5);
        assert!(0x2::object::id<0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::Vault<T0, T1>>(arg1) == arg0.vault_id, 5);
        let v0 = 0x2::object::id<NavOracle<T0>>(arg0);
        let v1 = global_state_mut<T0>(arg0);
        assert!(v1.nav_oracle_id == v0 && v1.vault_id == 0x2::object::id<0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::Vault<T0, T1>>(arg1), 5);
        assert!(0x1::option::is_some<u64>(&v1.pending_round_id) && *0x1::option::borrow<u64>(&v1.pending_round_id) == arg3, 5);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&v1.pending_required_chain_ids)) {
            let v5 = 0;
            while (v5 < 0x1::vector::length<ChainNavReport>(&v1.pending_reports)) {
                let v6 = *0x1::vector::borrow<ChainNavReport>(&v1.pending_reports, v5);
                if (v6.chain_id == *0x1::vector::borrow<u64>(&v1.pending_required_chain_ids, v4)) {
                    validate_observed_at(v6.observed_at, v1.max_snapshot_age_secs, v1.max_future_skew_secs, arg4);
                    v2 = v2 + v6.nav;
                    v3 = v3 + v6.shares;
                    break
                };
                v5 = v5 + 1;
            };
            assert!(v5 < 0x1::vector::length<ChainNavReport>(&v1.pending_reports), 5);
            v4 = v4 + 1;
        };
        assert!(v2 > 0 && v3 > 0, 5);
        let v7 = 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::mul_div(v2, 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::price_precision(), v3);
        assert!(v7 > 0, 5);
        v1.last_round_id = arg3;
        v1.pending_round_id = 0x1::option::none<u64>();
        v1.pending_required_chain_ids = vector[];
        v1.pending_reports = 0x1::vector::empty<ChainNavReport>();
        0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::update_price_from_oracle_service<T0, T1>(arg1, v7, arg4);
        arg0.last_nav_value = v2;
        arg0.last_nav_timestamp = now_secs(arg4);
        arg0.nav_update_count = arg0.nav_update_count + 1;
        let v8 = GlobalNavRoundFinalizedEvent{
            nav_oracle_id    : 0x2::object::id<NavOracle<T0>>(arg0),
            vault_id         : 0x2::object::id<0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::Vault<T0, T1>>(arg1),
            round_id         : arg3,
            global_nav       : v2,
            global_shares    : v3,
            calculated_price : v7,
        };
        0x2::event::emit<GlobalNavRoundFinalizedEvent>(v8);
    }

    fun global_state_mut<T0>(arg0: &mut NavOracle<T0>) : &mut GlobalNavState {
        let v0 = GlobalNavStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<GlobalNavStateKey, GlobalNavState>(&mut arg0.id, v0)
    }

    fun has_global_state<T0>(arg0: &NavOracle<T0>) : bool {
        let v0 = GlobalNavStateKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<GlobalNavStateKey, GlobalNavState>(&arg0.id, v0)
    }

    public fun migrate<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleAdminCap) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert!(arg0.version < 1, 10);
        arg0.version = 1;
    }

    public fun new_chain_nav_report(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : ChainNavReport {
        ChainNavReport{
            chain_id    : arg0,
            nav         : arg1,
            shares      : arg2,
            observed_at : arg3,
        }
    }

    fun now_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun propose_cooldown<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 1);
        assert!(arg2 >= 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::min_cooldown_secs() && arg2 <= 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::max_cooldown_secs(), 5);
        let v0 = PendingCooldown{
            cooldown_secs : arg2,
            proposed_at   : now_secs(arg3),
        };
        arg0.pending_cooldown = 0x1::option::some<PendingCooldown>(v0);
    }

    public fun propose_nav_provider<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 1);
        assert!(arg2 != @0x0, 5);
        let v0 = 0x2::object::id<NavOracle<T0>>(arg0);
        assert!(arg2 != 0x2::object::id_to_address(&v0), 5);
        assert!(arg2 != 0x2::object::id_to_address(&arg0.vault_id), 5);
        assert!(arg2 != arg0.nav_provider, 343);
        assert!(0x1::option::is_none<PendingNavProvider>(&arg0.pending_nav_provider), 343);
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

    public fun remove_global_chain<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleManagerCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.nav_oracle_id == 0x2::object::id<NavOracle<T0>>(arg0), 1);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        let v0 = global_state_mut<T0>(arg0);
        assert!(0x1::vector::length<u64>(&v0.active_chain_ids) > 1, 5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0.active_chain_ids)) {
            if (*0x1::vector::borrow<u64>(&v0.active_chain_ids, v1) == arg2) {
                0x1::vector::remove<u64>(&mut v0.active_chain_ids, v1);
                return
            };
            v1 = v1 + 1;
        };
        abort 5
    }

    public fun submit_global_chain_reports<T0>(arg0: &mut NavOracle<T0>, arg1: &NavOracleProviderCap, arg2: u64, arg3: vector<ChainNavReport>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_provider<T0>(arg0, arg1, arg5);
        assert!(0x1::vector::length<ChainNavReport>(&arg3) > 0, 5);
        let v0 = 0x2::object::id<NavOracle<T0>>(arg0);
        let v1 = arg0.vault_id;
        let v2 = global_state_mut<T0>(arg0);
        assert!(v2.nav_oracle_id == v0 && v2.vault_id == v1, 5);
        assert!(arg2 > v2.last_round_id, 5);
        if (0x1::option::is_none<u64>(&v2.pending_round_id)) {
            v2.pending_round_id = 0x1::option::some<u64>(arg2);
            v2.pending_required_chain_ids = v2.active_chain_ids;
        } else {
            assert!(*0x1::option::borrow<u64>(&v2.pending_round_id) == arg2, 5);
        };
        assert!(0x1::vector::length<ChainNavReport>(&arg3) <= 0x1::vector::length<u64>(&v2.pending_required_chain_ids), 5);
        let v3 = 0;
        while (v3 < 0x1::vector::length<ChainNavReport>(&arg3)) {
            let v4 = *0x1::vector::borrow<ChainNavReport>(&arg3, v3);
            let v5 = if (v4.chain_id != 0) {
                if (v4.nav > 0) {
                    v4.shares > 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v5, 5);
            assert!(contains_chain(&v2.pending_required_chain_ids, v4.chain_id), 5);
            validate_observed_at(v4.observed_at, v2.max_snapshot_age_secs, v2.max_future_skew_secs, arg4);
            let v6 = v3 + 1;
            while (v6 < 0x1::vector::length<ChainNavReport>(&arg3)) {
                let v7 = *0x1::vector::borrow<ChainNavReport>(&arg3, v6);
                assert!(v4.chain_id != v7.chain_id, 5);
                v6 = v6 + 1;
            };
            let v8 = 0;
            while (v8 < 0x1::vector::length<ChainNavReport>(&v2.pending_reports)) {
                let v9 = *0x1::vector::borrow<ChainNavReport>(&v2.pending_reports, v8);
                if (v9.chain_id == v4.chain_id) {
                    break
                };
                v8 = v8 + 1;
            };
            if (v8 == 0x1::vector::length<ChainNavReport>(&v2.pending_reports)) {
                0x1::vector::push_back<ChainNavReport>(&mut v2.pending_reports, v4);
            } else {
                *0x1::vector::borrow_mut<ChainNavReport>(&mut v2.pending_reports, v8) = v4;
            };
            v3 = v3 + 1;
        };
    }

    public fun update_vault_price_from_nav<T0, T1>(arg0: &mut NavOracle<T0>, arg1: &mut 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::Vault<T0, T1>, arg2: &NavOracleProviderCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(!has_global_state<T0>(arg0), 5);
        assert!(0x2::object::id<0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::Vault<T0, T1>>(arg1) == arg0.vault_id, 5);
        assert_provider<T0>(arg0, arg2, arg5);
        let v0 = 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::total_shares<T0, T1>(arg1);
        assert!(v0 > 0, 5);
        let v1 = 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::mul_div(0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::scale_nav_for_price(arg3 + 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::total_idle<T0, T1>(arg1), 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::get_share_decimals<T0, T1>(arg1), 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::get_underlying_decimals<T0, T1>(arg1)), 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::price_precision(), v0);
        arg0.last_nav_value = arg3;
        arg0.last_nav_timestamp = now_secs(arg4);
        arg0.nav_update_count = arg0.nav_update_count + 1;
        let v2 = NavOracleUpdatedEvent{
            nav_oracle_id    : 0x2::object::id<NavOracle<T0>>(arg0),
            vault_id         : arg0.vault_id,
            nav_value        : arg3,
            calculated_price : v1,
        };
        0x2::event::emit<NavOracleUpdatedEvent>(v2);
        if (v1 == 0) {
            return
        };
        0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_vault::update_price_from_oracle_service<T0, T1>(arg1, v1, arg4);
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

