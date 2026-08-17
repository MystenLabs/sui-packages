module 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy {
    struct TradeIntent {
        vault_id: 0x2::object::ID,
        strategy_cap_id: 0x2::object::ID,
        nonce: u64,
        dex: u8,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        amount_in: u64,
        min_amount_out: u64,
        deadline_ms: u64,
    }

    struct StrategyNonces has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        last_nonce: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
    }

    struct StrategyPolicy has copy, drop, store {
        venue_mask: u32,
        max_notional_per_cycle: u64,
        max_notional_per_period: u64,
        period_ms: u64,
        period_start_ms: u64,
        period_used: u64,
        max_slippage_bps: u64,
        expires_at_ms: u64,
        max_executions: u64,
        executions: u64,
        last_sequence: u64,
        last_source_ts_ms: u64,
        paused: bool,
        max_flash_notional: u64,
        min_flash_profit_bps: u64,
    }

    struct StrategyBook<phantom T0> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        policies: 0x2::table::Table<0x2::object::ID, StrategyPolicy>,
        cap_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun policy_executions(arg0: &StrategyPolicy) : u64 {
        arg0.executions
    }

    public fun policy_paused(arg0: &StrategyPolicy) : bool {
        arg0.paused
    }

    public(friend) fun assert_provider_active<T0>(arg0: &StrategyBook<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultTradeCap<T0>, arg3: u64) {
        assert_strategy_book<T0>(arg0, arg1);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_trade_cap<T0>(arg1, arg2);
        let v0 = 0x2::object::id<0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultTradeCap<T0>>(arg2);
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::is_strategy_cap_allowed<T0>(arg1, v0), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::strategy_cap_mismatch());
        assert!(0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, v0), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_not_found());
        let v1 = 0x2::table::borrow<0x2::object::ID, StrategyPolicy>(&arg0.policies, v0);
        assert!(!v1.paused, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_paused());
        assert!(v1.expires_at_ms == 0 || arg3 <= v1.expires_at_ms, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_expired());
    }

    public fun assert_strategy_book<T0>(arg0: &StrategyBook<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>) {
        assert!(arg0.vault_id == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_book_mismatch());
    }

    public(friend) fun charge_flash<T0>(arg0: &mut StrategyBook<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_not_found());
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, StrategyPolicy>(&mut arg0.policies, arg1);
        assert!(!v0.paused, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_paused());
        assert!(v0.max_flash_notional > 0, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::flash_not_permitted());
        assert!(arg2 <= v0.max_flash_notional, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::flash_notional_cap());
        assert!(v0.max_executions == 0 || v0.executions < v0.max_executions, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_executions());
        if (arg3 >= 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::add(v0.period_start_ms, v0.period_ms)) {
            v0.period_start_ms = arg3;
            v0.period_used = 0;
        };
        let v1 = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::add(v0.period_used, arg2);
        assert!(v0.max_notional_per_period == 0 || v1 <= v0.max_notional_per_period, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_period_cap());
        v0.period_used = v1;
        v0.executions = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::add(v0.executions, 1);
        v0.min_flash_profit_bps
    }

    public(friend) fun charge_notional<T0>(arg0: &mut StrategyBook<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: u64) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_not_found());
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, StrategyPolicy>(&mut arg0.policies, arg1);
        assert!(!v0.paused, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_paused());
        assert!(v0.venue_mask & 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::venue::venue_mask(arg2) != 0, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_not_allowed());
        assert!(arg3 <= v0.max_notional_per_cycle, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_cycle_cap());
        assert!(v0.max_executions == 0 || v0.executions < v0.max_executions, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_executions());
        if (arg4 >= 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::add(v0.period_start_ms, v0.period_ms)) {
            v0.period_start_ms = arg4;
            v0.period_used = 0;
        };
        let v1 = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::add(v0.period_used, arg3);
        assert!(v0.max_notional_per_period == 0 || v1 <= v0.max_notional_per_period, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_period_cap());
        v0.period_used = v1;
        v0.executions = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::add(v0.executions, 1);
        v0.max_slippage_bps
    }

    public fun consume_intent(arg0: TradeIntent, arg1: u64) {
        let TradeIntent {
            vault_id        : _,
            strategy_cap_id : _,
            nonce           : _,
            dex             : _,
            base            : _,
            quote           : _,
            amount_in       : _,
            min_amount_out  : v7,
            deadline_ms     : _,
        } = arg0;
        assert!(arg1 >= v7, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::slippage_exceeded());
    }

    public(friend) fun consume_sequence<T0>(arg0: &mut StrategyBook<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        assert!(0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_not_found());
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, StrategyPolicy>(&mut arg0.policies, arg1);
        assert!(arg2 > v0.last_sequence, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::price_replay());
        assert!(arg3 > v0.last_source_ts_ms, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::price_replay());
        v0.last_sequence = arg2;
        v0.last_source_ts_ms = arg3;
    }

    public fun create_strategy_book<T0>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        share_strategy_book<T0>(new_strategy_book<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun grant_provider<T0>(arg0: &mut StrategyBook<T0>, arg1: &mut 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T0>, arg3: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg4: u64, arg5: 0x2::object::ID, arg6: u32, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::assert_governance_active(arg3, arg4);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T0>(arg1, arg2);
        assert_strategy_book<T0>(arg0, arg1);
        validate_policy_params(arg3, arg7, arg9, arg10);
        assert!(!0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg5), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_already_granted());
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::cap_in_allowlist<T0>(arg1, arg5), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::cap_not_in_allowlist());
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::allow_strategy_cap<T0>(arg1, arg2, arg5);
        let v0 = StrategyPolicy{
            venue_mask              : arg6,
            max_notional_per_cycle  : arg7,
            max_notional_per_period : arg8,
            period_ms               : arg9,
            period_start_ms         : 0x2::clock::timestamp_ms(arg13),
            period_used             : 0,
            max_slippage_bps        : arg10,
            expires_at_ms           : arg11,
            max_executions          : arg12,
            executions              : 0,
            last_sequence           : 0,
            last_source_ts_ms       : 0,
            paused                  : false,
            max_flash_notional      : 0,
            min_flash_profit_bps    : 0,
        };
        0x2::table::add<0x2::object::ID, StrategyPolicy>(&mut arg0.policies, arg5, v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.cap_ids, arg5);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_policy_granted(arg0.vault_id, 0x2::object::uid_to_inner(&arg0.id), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun has_provider<T0>(arg0: &StrategyBook<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg1)
    }

    public fun intent_amount_in(arg0: &TradeIntent) : u64 {
        arg0.amount_in
    }

    public fun intent_base(arg0: &TradeIntent) : 0x1::type_name::TypeName {
        arg0.base
    }

    public fun intent_deadline(arg0: &TradeIntent) : u64 {
        arg0.deadline_ms
    }

    public fun intent_dex(arg0: &TradeIntent) : u8 {
        arg0.dex
    }

    public fun intent_min_amount_out(arg0: &TradeIntent) : u64 {
        arg0.min_amount_out
    }

    public fun intent_quote(arg0: &TradeIntent) : 0x1::type_name::TypeName {
        arg0.quote
    }

    public fun intent_vault_id(arg0: &TradeIntent) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun mint_provider_cap<T0>(arg0: &mut StrategyBook<T0>, arg1: &mut 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T0>, arg3: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg4: u64, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultTradeCap<T0> {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::assert_governance_active(arg3, arg4);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T0>(arg1, arg2);
        assert_strategy_book<T0>(arg0, arg1);
        validate_policy_params(arg3, arg6, arg8, arg9);
        let v0 = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::mint_trade_cap<T0>(arg1, arg2, arg13);
        let v1 = 0x2::object::id<0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultTradeCap<T0>>(&v0);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::allow_strategy_cap<T0>(arg1, arg2, v1);
        let v2 = StrategyPolicy{
            venue_mask              : arg5,
            max_notional_per_cycle  : arg6,
            max_notional_per_period : arg7,
            period_ms               : arg8,
            period_start_ms         : 0x2::clock::timestamp_ms(arg12),
            period_used             : 0,
            max_slippage_bps        : arg9,
            expires_at_ms           : arg10,
            max_executions          : arg11,
            executions              : 0,
            last_sequence           : 0,
            last_source_ts_ms       : 0,
            paused                  : false,
            max_flash_notional      : 0,
            min_flash_profit_bps    : 0,
        };
        0x2::table::add<0x2::object::ID, StrategyPolicy>(&mut arg0.policies, v1, v2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.cap_ids, v1);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_policy_granted(arg0.vault_id, 0x2::object::uid_to_inner(&arg0.id), v1, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        v0
    }

    public fun new_intent<T0, T1, T2>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg1: &mut StrategyNonces, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultTradeCap<T0>, arg3: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock) : TradeIntent {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::assert_product_active(arg3, arg4, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::product_trade());
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_trade_cap<T0>(arg0, arg2);
        assert!(arg1.vault_id == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg0), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::vault_mismatch());
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::is_strategy_cap_allowed<T0>(arg0, 0x2::object::id<0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultTradeCap<T0>>(arg2)), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::strategy_cap_mismatch());
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::is_dex_allowed<T0>(arg0, arg5), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::dex_not_allowed());
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::is_dex_allowed(arg3, arg5), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::dex_not_allowed());
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::strategy_deadline());
        assert!(arg7 > 0, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::strategy_bounds());
        let v0 = 0x2::object::id<0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultTradeCap<T0>>(arg2);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg1.last_nonce, &v0)) {
            let v1 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg1.last_nonce, &v0);
            assert!(arg6 > *v1, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::strategy_nonce());
            *v1 = arg6;
        } else {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg1.last_nonce, v0, arg6);
        };
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_strategy_intent(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg0), v0, arg6, arg5, 0x1::type_name::with_defining_ids<T1>(), 0x1::type_name::with_defining_ids<T2>(), arg7, arg8);
        TradeIntent{
            vault_id        : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg0),
            strategy_cap_id : v0,
            nonce           : arg6,
            dex             : arg5,
            base            : 0x1::type_name::with_defining_ids<T1>(),
            quote           : 0x1::type_name::with_defining_ids<T2>(),
            amount_in       : arg7,
            min_amount_out  : arg8,
            deadline_ms     : arg9,
        }
    }

    public fun new_nonces<T0>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : StrategyNonces {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T0>(arg0, arg1);
        StrategyNonces{
            id         : 0x2::object::new(arg2),
            vault_id   : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg0),
            last_nonce : 0x2::vec_map::empty<0x2::object::ID, u64>(),
        }
    }

    public fun new_strategy_book<T0>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StrategyBook<T0> {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::assert_governance_active(arg2, arg3);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T0>(arg0, arg1);
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::config_id<T0>(arg0) == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::id(arg2), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::vault_mismatch());
        StrategyBook<T0>{
            id        : 0x2::object::new(arg4),
            config_id : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::id(arg2),
            vault_id  : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg0),
            policies  : 0x2::table::new<0x2::object::ID, StrategyPolicy>(arg4),
            cap_ids   : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun policy<T0>(arg0: &StrategyBook<T0>, arg1: 0x2::object::ID) : StrategyPolicy {
        assert!(0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_not_found());
        *0x2::table::borrow<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg1)
    }

    public fun policy_expires_at_ms(arg0: &StrategyPolicy) : u64 {
        arg0.expires_at_ms
    }

    public fun policy_last_sequence(arg0: &StrategyPolicy) : u64 {
        arg0.last_sequence
    }

    public fun policy_last_source_ts_ms(arg0: &StrategyPolicy) : u64 {
        arg0.last_source_ts_ms
    }

    public fun policy_max_executions(arg0: &StrategyPolicy) : u64 {
        arg0.max_executions
    }

    public fun policy_max_flash_notional(arg0: &StrategyPolicy) : u64 {
        arg0.max_flash_notional
    }

    public fun policy_max_notional_per_cycle(arg0: &StrategyPolicy) : u64 {
        arg0.max_notional_per_cycle
    }

    public fun policy_max_notional_per_period(arg0: &StrategyPolicy) : u64 {
        arg0.max_notional_per_period
    }

    public fun policy_max_slippage_bps(arg0: &StrategyPolicy) : u64 {
        arg0.max_slippage_bps
    }

    public fun policy_may_flash(arg0: &StrategyPolicy) : bool {
        arg0.max_flash_notional > 0
    }

    public fun policy_min_flash_profit_bps(arg0: &StrategyPolicy) : u64 {
        arg0.min_flash_profit_bps
    }

    public fun policy_period_ms(arg0: &StrategyPolicy) : u64 {
        arg0.period_ms
    }

    public fun policy_period_used(arg0: &StrategyPolicy) : u64 {
        arg0.period_used
    }

    public fun policy_venue_mask(arg0: &StrategyPolicy) : u32 {
        arg0.venue_mask
    }

    public fun provider_count<T0>(arg0: &StrategyBook<T0>) : u64 {
        0x2::vec_set::size<0x2::object::ID>(&arg0.cap_ids)
    }

    public fun revoke_provider<T0>(arg0: &mut StrategyBook<T0>, arg1: &mut 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T0>, arg3: 0x2::object::ID) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T0>(arg1, arg2);
        assert_strategy_book<T0>(arg0, arg1);
        assert!(0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg3), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_not_found());
        let v0 = 0x2::table::remove<0x2::object::ID, StrategyPolicy>(&mut arg0.policies, arg3);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.cap_ids, &arg3);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::disallow_strategy_cap<T0>(arg1, arg2, arg3);
        if (0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::cap_in_allowlist<T0>(arg1, arg3)) {
            0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::revoke_cap<T0>(arg1, arg2, arg3);
        };
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_policy_revoked(arg0.vault_id, arg3, v0.executions);
    }

    public fun set_flash_allowance<T0>(arg0: &mut StrategyBook<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T0>, arg3: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::assert_governance_active(arg3, arg4);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T0>(arg1, arg2);
        assert_strategy_book<T0>(arg0, arg1);
        assert!(0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg5), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_not_found());
        assert!(arg7 <= 10000, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_bad_param());
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, StrategyPolicy>(&mut arg0.policies, arg5);
        v0.max_flash_notional = arg6;
        v0.min_flash_profit_bps = arg7;
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_flash_allowance_set(arg0.vault_id, arg5, arg6, arg7);
    }

    public fun set_provider_paused<T0>(arg0: &mut StrategyBook<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T0>, arg3: 0x2::object::ID, arg4: bool) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T0>(arg1, arg2);
        assert_strategy_book<T0>(arg0, arg1);
        assert!(0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg3), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_not_found());
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, StrategyPolicy>(&mut arg0.policies, arg3);
        v0.paused = arg4;
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_policy_updated(arg0.vault_id, arg3, arg4, v0.max_notional_per_cycle, v0.max_notional_per_period, v0.max_executions);
    }

    public fun share_nonces(arg0: StrategyNonces) {
        0x2::transfer::share_object<StrategyNonces>(arg0);
    }

    public fun share_strategy_book<T0>(arg0: StrategyBook<T0>) {
        0x2::transfer::share_object<StrategyBook<T0>>(arg0);
    }

    public fun strategy_book_id<T0>(arg0: &StrategyBook<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun strategy_book_vault_id<T0>(arg0: &StrategyBook<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun update_provider_policy<T0>(arg0: &mut StrategyBook<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T0>, arg3: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg4: u64, arg5: 0x2::object::ID, arg6: u32, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::assert_governance_active(arg3, arg4);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T0>(arg1, arg2);
        assert_strategy_book<T0>(arg0, arg1);
        validate_policy_params(arg3, arg7, arg9, arg10);
        assert!(0x2::table::contains<0x2::object::ID, StrategyPolicy>(&arg0.policies, arg5), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_not_found());
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, StrategyPolicy>(&mut arg0.policies, arg5);
        assert!(arg12 == 0 || arg12 >= v0.executions, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_bad_param());
        v0.venue_mask = arg6;
        v0.max_notional_per_cycle = arg7;
        v0.max_notional_per_period = arg8;
        v0.period_ms = arg9;
        v0.max_slippage_bps = arg10;
        v0.expires_at_ms = arg11;
        v0.max_executions = arg12;
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_policy_updated(arg0.vault_id, arg5, v0.paused, arg7, arg8, arg12);
    }

    fun validate_policy_params(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 > 0, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_bad_param());
        assert!(arg2 > 0, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_bad_param());
        assert!(arg3 <= 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::guard_max_slippage_bps_ceiling(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::price_guard_config(arg0)), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::policy_bad_param());
    }

    // decompiled from Move bytecode v7
}

