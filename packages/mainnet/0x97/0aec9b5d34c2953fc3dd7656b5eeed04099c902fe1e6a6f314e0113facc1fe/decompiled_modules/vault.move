module 0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuiX5Vault has key {
        id: 0x2::object::UID,
        token_stores: 0x2::bag::Bag,
        token_balances: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        discovered_tokens: vector<0x1::type_name::TypeName>,
        usdc_reserve: u64,
        suix5_treasury: 0x2::coin::TreasuryCap<0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::suix5::SUIX5>,
        suix5_supply: u64,
        oracle: 0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::oracle::OracleConfig,
        composition: 0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::composition::Composition,
        max_slippage_bps: u64,
        adapter_cache: 0x2::object::ID,
        pending_adapter: vector<0x2::object::ID>,
        pending_adapter_ms: u64,
        adapter_timelock_ms: u64,
        cached_nav_per_suix5: u64,
        cached_portfolio_usdc: u64,
        cached_nav_ms: u64,
        max_nav_age_ms: u64,
        deposit_fee_bps: u64,
        withdrawal_fee_bps: u64,
        fee_collector: address,
        total_fees_collected_usdc: u64,
        target_reserve_bps: u64,
        last_rebalance_ms: u64,
        rebalance_interval_ms: u64,
        admin: address,
        authorized_operators: vector<address>,
        open_crank_grace_ms: u64,
        require_admin_for_feeds: bool,
        require_admin_for_pools: bool,
        paused: bool,
        creation_ms: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        timestamp_ms: u64,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct OperatorAdded has copy, drop {
        operator: address,
    }

    struct OperatorRemoved has copy, drop {
        operator: address,
    }

    struct PausedToggled has copy, drop {
        paused: bool,
        by: address,
    }

    struct FeesUpdated has copy, drop {
        deposit_fee_bps: u64,
        withdrawal_fee_bps: u64,
    }

    struct GatingUpdated has copy, drop {
        require_admin_for_feeds: bool,
        require_admin_for_pools: bool,
    }

    struct MaxSlippageUpdated has copy, drop {
        max_slippage_bps: u64,
    }

    struct AdapterProposed has copy, drop {
        new_cache: 0x2::object::ID,
        effective_ms: u64,
        proposed_by: address,
    }

    struct AdapterExecuted has copy, drop {
        new_cache: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AdapterCancelled has copy, drop {
        cancelled_by: address,
    }

    struct AdapterEmergencySet has copy, drop {
        new_cache: 0x2::object::ID,
        by: address,
    }

    struct AdapterTimelockUpdated has copy, drop {
        adapter_timelock_ms: u64,
    }

    entry fun register_feed<T0>(arg0: &mut SuiX5Vault, arg1: vector<u8>, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        if (arg0.require_admin_for_feeds) {
            assert_admin(arg0, arg3);
        } else {
            assert_authorized(arg0, arg3);
        };
        ensure_registered<T0>(arg0);
        0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::oracle::register_feed<T0>(&mut arg0.oracle, arg1, arg2);
    }

    entry fun remove_feed<T0>(arg0: &mut SuiX5Vault, arg1: &0x2::tx_context::TxContext) {
        if (arg0.require_admin_for_feeds) {
            assert_admin(arg0, arg1);
        } else {
            assert_authorized(arg0, arg1);
        };
        0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::oracle::remove_feed<T0>(&mut arg0.oracle);
    }

    entry fun reset_breaker<T0>(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::oracle::reset_breaker<T0>(&mut arg0.oracle, arg2);
    }

    public fun adapter_cache(arg0: &SuiX5Vault) : 0x2::object::ID {
        arg0.adapter_cache
    }

    entry fun add_operator(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg2 != @0x0, 103);
        0x1::vector::push_back<address>(&mut arg0.authorized_operators, arg2);
        let v0 = OperatorAdded{operator: arg2};
        0x2::event::emit<OperatorAdded>(v0);
    }

    public(friend) fun add_reserve(arg0: &mut SuiX5Vault, arg1: u64) {
        arg0.usdc_reserve = arg0.usdc_reserve + arg1;
    }

    public fun admin(arg0: &SuiX5Vault) : address {
        arg0.admin
    }

    public(friend) fun assert_adapter(arg0: &SuiX5Vault, arg1: 0x2::object::ID) {
        assert!(arg0.adapter_cache == arg1, 109);
    }

    fun assert_admin(arg0: &SuiX5Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 100);
    }

    public(friend) fun assert_authorized(arg0: &SuiX5Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(is_authorized(arg0, 0x2::tx_context::sender(arg1)), 100);
    }

    public(friend) fun assert_can_crank(arg0: &SuiX5Vault, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.last_rebalance_ms + arg0.rebalance_interval_ms;
        assert!(v0 >= v1, 100);
        if (v0 < v1 + arg0.open_crank_grace_ms) {
            assert!(is_authorized(arg0, 0x2::tx_context::sender(arg2)), 100);
        };
    }

    public(friend) fun assert_nav_fresh(arg0: &SuiX5Vault, arg1: &0x2::clock::Clock) {
        assert!(arg0.cached_nav_ms > 0, 106);
        assert!(arg0.cached_nav_ms + arg0.max_nav_age_ms >= 0x2::clock::timestamp_ms(arg1), 106);
    }

    public(friend) fun assert_not_paused(arg0: &SuiX5Vault) {
        assert!(!arg0.paused, 101);
    }

    public(friend) fun balance_of<T0>(arg0: &SuiX5Vault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.token_stores, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.token_stores, v0))
    }

    public(friend) fun burn_suix5(arg0: &mut SuiX5Vault, arg1: 0x2::coin::Coin<0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::suix5::SUIX5>) : u64 {
        let v0 = 0x2::coin::value<0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::suix5::SUIX5>(&arg1);
        assert!(v0 > 0, 105);
        assert!(arg0.suix5_supply >= v0, 104);
        arg0.suix5_supply = arg0.suix5_supply - v0;
        0x2::coin::burn<0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::suix5::SUIX5>(&mut arg0.suix5_treasury, arg1);
        v0
    }

    public(friend) fun cached_nav(arg0: &SuiX5Vault) : u64 {
        arg0.cached_nav_per_suix5
    }

    public(friend) fun cached_portfolio(arg0: &SuiX5Vault) : u64 {
        arg0.cached_portfolio_usdc
    }

    public(friend) fun calc_deposit_fee(arg0: &SuiX5Vault, arg1: u64) : u64 {
        arg1 * arg0.deposit_fee_bps / 10000
    }

    public(friend) fun calc_withdrawal_fee(arg0: &SuiX5Vault, arg1: u64) : u64 {
        arg1 * arg0.withdrawal_fee_bps / 10000
    }

    entry fun cancel_adapter(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg0.pending_adapter), 111);
        0x1::vector::pop_back<0x2::object::ID>(&mut arg0.pending_adapter);
        arg0.pending_adapter_ms = 0;
        let v0 = AdapterCancelled{cancelled_by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<AdapterCancelled>(v0);
    }

    entry fun cancel_composition(arg0: &mut SuiX5Vault, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_authorized(arg0, arg2);
        0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::composition::cancel_pending(&mut arg0.composition, arg1, arg2);
    }

    entry fun clear_operators(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        while (!0x1::vector::is_empty<address>(&arg0.authorized_operators)) {
            let v0 = OperatorRemoved{operator: 0x1::vector::pop_back<address>(&mut arg0.authorized_operators)};
            0x2::event::emit<OperatorRemoved>(v0);
        };
    }

    public(friend) fun composition_mut(arg0: &mut SuiX5Vault) : &mut 0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::composition::Composition {
        &mut arg0.composition
    }

    public(friend) fun composition_ref(arg0: &SuiX5Vault) : &0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::composition::Composition {
        &arg0.composition
    }

    entry fun create_vault(arg0: 0x2::coin::TreasuryCap<0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::suix5::SUIX5>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = SuiX5Vault{
            id                        : 0x2::object::new(arg2),
            token_stores              : 0x2::bag::new(arg2),
            token_balances            : 0x2::table::new<0x1::type_name::TypeName, u64>(arg2),
            discovered_tokens         : 0x1::vector::empty<0x1::type_name::TypeName>(),
            usdc_reserve              : 0,
            suix5_treasury            : arg0,
            suix5_supply              : 0,
            oracle                    : 0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::oracle::new(arg2),
            composition               : 0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::composition::new(arg2),
            max_slippage_bps          : 100,
            adapter_cache             : arg1,
            pending_adapter           : 0x1::vector::empty<0x2::object::ID>(),
            pending_adapter_ms        : 0,
            adapter_timelock_ms       : 172800000,
            cached_nav_per_suix5      : 1000000,
            cached_portfolio_usdc     : 0,
            cached_nav_ms             : 0,
            max_nav_age_ms            : 120000,
            deposit_fee_bps           : 50,
            withdrawal_fee_bps        : 50,
            fee_collector             : v0,
            total_fees_collected_usdc : 0,
            target_reserve_bps        : 500,
            last_rebalance_ms         : 0,
            rebalance_interval_ms     : 43200000,
            admin                     : v0,
            authorized_operators      : 0x1::vector::empty<address>(),
            open_crank_grace_ms       : 43200000,
            require_admin_for_feeds   : false,
            require_admin_for_pools   : false,
            paused                    : false,
            creation_ms               : 0,
        };
        let v3 = VaultCreated{
            vault_id     : 0x2::object::id<SuiX5Vault>(&v2),
            admin        : v0,
            timestamp_ms : 0,
        };
        0x2::event::emit<VaultCreated>(v3);
        0x2::transfer::share_object<SuiX5Vault>(v2);
    }

    public(friend) fun discovered(arg0: &SuiX5Vault) : vector<0x1::type_name::TypeName> {
        arg0.discovered_tokens
    }

    public(friend) fun discovered_count(arg0: &SuiX5Vault) : u64 {
        0x1::vector::length<0x1::type_name::TypeName>(&arg0.discovered_tokens)
    }

    entry fun emergency_set_adapter(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg0.paused, 113);
        if (!0x1::vector::is_empty<0x2::object::ID>(&arg0.pending_adapter)) {
            0x1::vector::pop_back<0x2::object::ID>(&mut arg0.pending_adapter);
            arg0.pending_adapter_ms = 0;
        };
        arg0.adapter_cache = arg2;
        let v0 = AdapterEmergencySet{
            new_cache : arg2,
            by        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AdapterEmergencySet>(v0);
    }

    public(friend) fun ensure_registered<T0>(arg0: &mut SuiX5Vault) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.token_stores, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v0, 0x2::balance::zero<T0>());
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v0, 0);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.discovered_tokens, v0);
        };
    }

    entry fun execute_adapter(arg0: &mut SuiX5Vault, arg1: &0x2::clock::Clock) {
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg0.pending_adapter), 111);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.pending_adapter_ms, 112);
        let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.pending_adapter);
        arg0.pending_adapter_ms = 0;
        arg0.adapter_cache = v1;
        let v2 = AdapterExecuted{
            new_cache    : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<AdapterExecuted>(v2);
    }

    entry fun execute_composition(arg0: &mut SuiX5Vault, arg1: &0x2::clock::Clock) {
        0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::composition::execute_pending(&mut arg0.composition, &arg0.oracle, arg1);
    }

    public(friend) fun fee_collector(arg0: &SuiX5Vault) : address {
        arg0.fee_collector
    }

    public fun fees(arg0: &SuiX5Vault) : (u64, u64) {
        (arg0.deposit_fee_bps, arg0.withdrawal_fee_bps)
    }

    public fun gating(arg0: &SuiX5Vault) : (bool, bool) {
        (arg0.require_admin_for_feeds, arg0.require_admin_for_pools)
    }

    public(friend) fun held_count(arg0: &SuiX5Vault) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.discovered_tokens)) {
            if (tracked_balance(arg0, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.discovered_tokens, v1)) > 0) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun holdings(arg0: &SuiX5Vault) : (vector<0x1::type_name::TypeName>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.discovered_tokens)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.discovered_tokens, v2);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, tracked_balance(arg0, v3));
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public(friend) fun is_authorized(arg0: &SuiX5Vault, arg1: address) : bool {
        if (arg1 == arg0.admin) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.authorized_operators)) {
            if (*0x1::vector::borrow<address>(&arg0.authorized_operators, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_paused(arg0: &SuiX5Vault) : bool {
        arg0.paused
    }

    public(friend) fun join_balance<T0>(arg0: &mut SuiX5Vault, arg1: 0x2::balance::Balance<T0>) {
        ensure_registered<T0>(arg0);
        let v0 = 0x1::type_name::get<T0>();
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v0), arg1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v0);
        *v1 = *v1 + 0x2::balance::value<T0>(&arg1);
    }

    public(friend) fun mark_rebalanced(arg0: &mut SuiX5Vault, arg1: u64) {
        arg0.last_rebalance_ms = arg1;
    }

    public(friend) fun max_slippage_bps(arg0: &SuiX5Vault) : u64 {
        arg0.max_slippage_bps
    }

    public(friend) fun mint_suix5(arg0: &mut SuiX5Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::suix5::SUIX5> {
        assert!(arg1 > 0, 105);
        arg0.suix5_supply = arg0.suix5_supply + arg1;
        0x2::coin::mint<0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::suix5::SUIX5>(&mut arg0.suix5_treasury, arg1, arg2)
    }

    public fun nav_per_suix5(arg0: &SuiX5Vault) : u64 {
        arg0.cached_nav_per_suix5
    }

    public fun nav_timestamp_ms(arg0: &SuiX5Vault) : u64 {
        arg0.cached_nav_ms
    }

    public fun operators(arg0: &SuiX5Vault) : vector<address> {
        arg0.authorized_operators
    }

    public(friend) fun oracle_mut(arg0: &mut SuiX5Vault) : &mut 0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::oracle::OracleConfig {
        &mut arg0.oracle
    }

    public(friend) fun oracle_ref(arg0: &SuiX5Vault) : &0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::oracle::OracleConfig {
        &arg0.oracle
    }

    public fun orphans(arg0: &SuiX5Vault) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.discovered_tokens)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.discovered_tokens, v1);
            if (tracked_balance(arg0, v2) > 0 && !0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::composition::contains(&arg0.composition, v2)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun portfolio_usdc(arg0: &SuiX5Vault) : u64 {
        arg0.cached_portfolio_usdc
    }

    entry fun propose_adapter(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        assert!(0x1::vector::is_empty<0x2::object::ID>(&arg0.pending_adapter), 110);
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg0.adapter_timelock_ms;
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pending_adapter, arg2);
        arg0.pending_adapter_ms = v0;
        let v1 = AdapterProposed{
            new_cache    : arg2,
            effective_ms : v0,
            proposed_by  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<AdapterProposed>(v1);
    }

    entry fun propose_composition<T0, T1, T2, T3, T4>(arg0: &mut SuiX5Vault, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_authorized(arg0, arg8);
        let v0 = orphans(arg0);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v0), 108);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T4>());
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg1);
        0x1::vector::push_back<u64>(v4, arg2);
        0x1::vector::push_back<u64>(v4, arg3);
        0x1::vector::push_back<u64>(v4, arg4);
        0x1::vector::push_back<u64>(v4, arg5);
        0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::composition::propose(&mut arg0.composition, &arg0.oracle, v1, v3, arg6, arg7, arg8);
    }

    public(friend) fun record_fee(arg0: &mut SuiX5Vault, arg1: u64) {
        arg0.total_fees_collected_usdc = arg0.total_fees_collected_usdc + arg1;
    }

    entry fun remove_operator(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.authorized_operators)) {
            if (*0x1::vector::borrow<address>(&arg0.authorized_operators, v0) == arg2) {
                0x1::vector::remove<address>(&mut arg0.authorized_operators, v0);
                let v1 = OperatorRemoved{operator: arg2};
                0x2::event::emit<OperatorRemoved>(v1);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun schedule(arg0: &SuiX5Vault) : (u64, u64, u64) {
        (arg0.last_rebalance_ms, arg0.rebalance_interval_ms, arg0.open_crank_grace_ms)
    }

    entry fun set_adapter_timelock(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg2 >= 172800000, 106);
        arg0.adapter_timelock_ms = arg2;
        let v0 = AdapterTimelockUpdated{adapter_timelock_ms: arg2};
        0x2::event::emit<AdapterTimelockUpdated>(v0);
    }

    entry fun set_composition_timelock(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::composition::set_timelock(&mut arg0.composition, arg2);
    }

    entry fun set_fee_collector(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg2 != @0x0, 103);
        arg0.fee_collector = arg2;
    }

    entry fun set_fees(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        assert!(arg2 <= 1000 && arg3 <= 1000, 102);
        arg0.deposit_fee_bps = arg2;
        arg0.withdrawal_fee_bps = arg3;
        let v0 = FeesUpdated{
            deposit_fee_bps    : arg2,
            withdrawal_fee_bps : arg3,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    entry fun set_gating(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: bool, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        arg0.require_admin_for_feeds = arg2;
        arg0.require_admin_for_pools = arg3;
        let v0 = GatingUpdated{
            require_admin_for_feeds : arg2,
            require_admin_for_pools : arg3,
        };
        0x2::event::emit<GatingUpdated>(v0);
    }

    entry fun set_genesis_composition<T0, T1, T2, T3, T4>(arg0: &mut SuiX5Vault, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_authorized(arg0, arg8);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg1);
        0x1::vector::push_back<u64>(v3, arg2);
        0x1::vector::push_back<u64>(v3, arg3);
        0x1::vector::push_back<u64>(v3, arg4);
        0x1::vector::push_back<u64>(v3, arg5);
        0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::composition::set_genesis(&mut arg0.composition, &arg0.oracle, v0, v2, arg6, arg7);
    }

    entry fun set_max_slippage(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg2 >= 10 && arg2 <= 2000, 106);
        arg0.max_slippage_bps = arg2;
        let v0 = MaxSlippageUpdated{max_slippage_bps: arg2};
        0x2::event::emit<MaxSlippageUpdated>(v0);
    }

    entry fun set_nav_max_age(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg2 >= 15000 && arg2 <= 900000, 106);
        arg0.max_nav_age_ms = arg2;
    }

    entry fun set_open_crank_grace(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        arg0.open_crank_grace_ms = arg2;
    }

    entry fun set_oracle_config(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg5);
        0x970aec9b5d34c2953fc3dd7656b5eeed04099c902fe1e6a6f314e0113facc1fe::oracle::set_config(&mut arg0.oracle, arg2, arg3, arg4);
    }

    entry fun set_pause(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        arg0.paused = arg2;
        let v0 = PausedToggled{
            paused : arg2,
            by     : arg0.admin,
        };
        0x2::event::emit<PausedToggled>(v0);
    }

    entry fun set_rebalance_interval(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg2 >= 3600000 && arg2 <= 604800000, 106);
        arg0.rebalance_interval_ms = arg2;
    }

    entry fun set_target_reserve(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg2 <= 3000, 106);
        arg0.target_reserve_bps = arg2;
    }

    public(friend) fun split_balance<T0>(arg0: &mut SuiX5Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.token_stores, v0), 107);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 104);
        let v2 = 0x2::balance::split<T0>(v1, arg1);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v0);
        *v3 = *v3 - arg1;
        v2
    }

    public(friend) fun sub_reserve(arg0: &mut SuiX5Vault, arg1: u64) {
        assert!(arg0.usdc_reserve >= arg1, 104);
        arg0.usdc_reserve = arg0.usdc_reserve - arg1;
    }

    public fun suix5_supply(arg0: &SuiX5Vault) : u64 {
        arg0.suix5_supply
    }

    public(friend) fun supply_internal(arg0: &SuiX5Vault) : u64 {
        arg0.suix5_supply
    }

    public(friend) fun target_reserve_bps(arg0: &SuiX5Vault) : u64 {
        arg0.target_reserve_bps
    }

    public fun total_fees(arg0: &SuiX5Vault) : u64 {
        arg0.total_fees_collected_usdc
    }

    public(friend) fun tracked_balance(arg0: &SuiX5Vault, arg1: 0x1::type_name::TypeName) : u64 {
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_balances, arg1)) {
            return 0
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, arg1)
    }

    entry fun transfer_admin(arg0: &mut SuiX5Vault, arg1: &AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg2 != @0x0, 103);
        arg0.admin = arg2;
        let v0 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public fun usdc_reserve(arg0: &SuiX5Vault) : u64 {
        arg0.usdc_reserve
    }

    public(friend) fun usdc_reserve_internal(arg0: &SuiX5Vault) : u64 {
        arg0.usdc_reserve
    }

    public(friend) fun write_nav_cache(arg0: &mut SuiX5Vault, arg1: u64, arg2: u64, arg3: u64) {
        arg0.cached_nav_per_suix5 = arg1;
        arg0.cached_portfolio_usdc = arg2;
        arg0.cached_nav_ms = arg3;
    }

    // decompiled from Move bytecode v7
}

