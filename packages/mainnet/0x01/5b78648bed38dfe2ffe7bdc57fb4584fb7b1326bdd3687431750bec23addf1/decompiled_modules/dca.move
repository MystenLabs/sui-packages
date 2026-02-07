module 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca {
    struct TradePromise<phantom T0, phantom T1> {
        input: u64,
        min_output: u64,
        dca_id: 0x2::object::ID,
    }

    struct Price has copy, drop, store {
        base_val: u64,
        quote_val: u64,
    }

    struct TradeParams has copy, drop, store {
        min_price: 0x1::option::Option<Price>,
        max_price: 0x1::option::Option<Price>,
        slippage_bps: 0x1::option::Option<u64>,
    }

    struct DCA<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        delegatee: address,
        start_time_ms: u64,
        last_time_ms: u64,
        every: u64,
        initial_orders: u64,
        remaining_orders: u64,
        time_scale: u8,
        input_balance: 0x2::balance::Balance<T0>,
        split_allocation: u64,
        trade_params: TradeParams,
        active: bool,
        executor_reward_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        config_snapshot: 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::ConfigSnapshot,
        accepted_terms_version: u64,
        input_decimals: u8,
        output_decimals: u8,
    }

    struct DCACreatedEvent has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        delegatee: address,
        total_orders: u64,
        input_amount: u64,
        split_allocation: u64,
        every: u64,
        time_scale: u8,
        fee_bps: u64,
        executor_reward_per_trade: u64,
        default_slippage_bps: u64,
        start_time_ms: u64,
        accepted_terms_version: u64,
    }

    struct TradeInitiatedEvent has copy, drop {
        dca_id: 0x2::object::ID,
        executor: address,
        input_amount: u64,
        fee_amount: u64,
        remaining_orders: u64,
        order_number: u64,
        min_output: u64,
    }

    struct TradeCompletedEvent has copy, drop {
        dca_id: 0x2::object::ID,
        executor: address,
        output_amount: u64,
        executor_reward: u64,
        active: bool,
    }

    struct DCADeactivatedEvent has copy, drop {
        dca_id: 0x2::object::ID,
        reason: u8,
        remaining_orders: u64,
        remaining_input: u64,
        remaining_executor_reward: u64,
    }

    struct DelegateeUpdatedEvent has copy, drop {
        dca_id: 0x2::object::ID,
        old_delegatee: address,
        new_delegatee: address,
    }

    struct SlippageUpdatedEvent has copy, drop {
        dca_id: 0x2::object::ID,
        old_slippage_bps: 0x1::option::Option<u64>,
        new_slippage_bps: 0x1::option::Option<u64>,
    }

    public fun new<T0, T1>(arg0: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::terms::TermsRegistry, arg2: &0x2::clock::Clock, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg18: &mut 0x2::tx_context::TxContext) : DCA<T0, T1> {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_version(arg0);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_not_paused(arg0);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::terms::assert_terms_acceptable(arg1, arg9);
        assert_time_scale(arg7);
        assert_every(arg5, arg7);
        assert!(interval_to_seconds(arg5, arg7) >= 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::min_interval_seconds(arg0), 44);
        assert!(arg6 <= 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::max_orders_per_account(arg0), 16);
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg4)) >= 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(arg6, 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::min_funding_per_trade(arg0)), 12);
        let v0 = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::executor_reward_per_trade(arg0), arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg17) >= v0, 13);
        let v1 = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::create_snapshot(arg0);
        let v2 = 0x2::coin::into_balance<T0>(arg4);
        let v3 = compute_split_allocation(0x2::balance::value<T0>(&v2), arg6);
        let v4 = if (arg8 == 0) {
            0x2::clock::timestamp_ms(arg2)
        } else {
            arg8
        };
        let v5 = 0x2::object::new(arg18);
        let v6 = 0x2::tx_context::sender(arg18);
        let v7 = DCACreatedEvent{
            id                        : 0x2::object::uid_to_inner(&v5),
            owner                     : v6,
            delegatee                 : arg3,
            total_orders              : arg6,
            input_amount              : 0x2::balance::value<T0>(&v2),
            split_allocation          : v3,
            every                     : arg5,
            time_scale                : arg7,
            fee_bps                   : 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_fee_bps(&v1),
            executor_reward_per_trade : 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_executor_reward(&v1),
            default_slippage_bps      : 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_slippage_bps(&v1),
            start_time_ms             : v4,
            accepted_terms_version    : arg9,
        };
        0x2::event::emit<DCACreatedEvent>(v7);
        let v8 = if (arg12 == 0) {
            0x1::option::none<u64>()
        } else {
            assert!(arg12 <= 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::max_slippage_bps(arg0), 43);
            0x1::option::some<u64>(arg12)
        };
        let v9 = if (arg13 == 0 && arg14 == 0) {
            0x1::option::none<Price>()
        } else {
            let v10 = Price{
                base_val  : arg13,
                quote_val : arg14,
            };
            0x1::option::some<Price>(v10)
        };
        let v11 = if (arg15 == 0 && arg16 == 0) {
            0x1::option::none<Price>()
        } else {
            let v12 = Price{
                base_val  : arg15,
                quote_val : arg16,
            };
            0x1::option::some<Price>(v12)
        };
        let v13 = TradeParams{
            min_price    : v9,
            max_price    : v11,
            slippage_bps : v8,
        };
        DCA<T0, T1>{
            id                      : v5,
            version                 : 4,
            owner                   : v6,
            delegatee               : arg3,
            start_time_ms           : v4,
            last_time_ms            : v4,
            every                   : arg5,
            initial_orders          : arg6,
            remaining_orders        : arg6,
            time_scale              : arg7,
            input_balance           : v2,
            split_allocation        : v3,
            trade_params            : v13,
            active                  : true,
            executor_reward_balance : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg17, v0, arg18)),
            config_snapshot         : v1,
            accepted_terms_version  : arg9,
            input_decimals          : 0x2::coin::get_decimals<T0>(arg10),
            output_decimals         : 0x2::coin::get_decimals<T1>(arg11),
        }
    }

    public fun executor_reward_per_trade<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_executor_reward(&arg0.config_snapshot)
    }

    public fun accepted_terms_version<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.accepted_terms_version
    }

    public fun active<T0, T1>(arg0: &DCA<T0, T1>) : bool {
        arg0.active
    }

    public entry fun add_executor_reward<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version_and_upgrade<T0, T1>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.executor_reward_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun assert_active<T0, T1>(arg0: &DCA<T0, T1>) {
        assert!(arg0.active == true, 31);
    }

    fun assert_delegatee<T0, T1>(arg0: &DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.delegatee == 0x2::tx_context::sender(arg1), 21);
    }

    fun assert_every(arg0: u64, arg1: u8) {
        let v0 = if (arg1 == 0) {
            arg0 >= 30 && arg0 <= 59
        } else if (arg1 == 1) {
            arg0 >= 1 && arg0 <= 59
        } else if (arg1 == 2) {
            arg0 >= 1 && arg0 <= 24
        } else if (arg1 == 3) {
            arg0 >= 1 && arg0 <= 30
        } else if (arg1 == 4) {
            arg0 >= 1 && arg0 <= 52
        } else {
            assert!(arg1 == 5, 10);
            arg0 >= 1 && arg0 <= 12
        };
        assert!(v0, 11);
    }

    public fun assert_max_price_via_output<T0, T1>(arg0: u64, arg1: &TradePromise<T0, T1>) {
        assert!(arg0 >= trade_min_output<T0, T1>(arg1), 33);
    }

    fun assert_owner<T0, T1>(arg0: &DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 22);
    }

    fun assert_owner_or_delegatee<T0, T1>(arg0: &DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.owner == v0 || arg0.delegatee == v0, 23);
    }

    fun assert_time(arg0: u64, arg1: u64, arg2: u64, arg3: u8) {
        let v0 = if (arg3 == 0) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::time::has_n_seconds_passed(arg0, arg1, arg2)
        } else if (arg3 == 1) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::time::has_n_minutes_passed(arg0, arg1, arg2)
        } else if (arg3 == 2) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::time::has_n_hours_passed(arg0, arg1, arg2)
        } else if (arg3 == 3) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::time::has_n_days_passed(arg0, arg1, arg2)
        } else if (arg3 == 4) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::time::has_n_weeks_passed(arg0, arg1, arg2)
        } else {
            assert!(arg3 == 5, 0);
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::time::has_n_months_passed(arg0, arg1, arg2)
        };
        assert!(v0 == true, 30);
    }

    fun assert_time_scale(arg0: u8) {
        assert!(arg0 <= 5, 10);
    }

    fun check_version_and_upgrade<T0, T1>(arg0: &mut DCA<T0, T1>) {
        if (arg0.version < 4) {
            arg0.version = 4;
        };
        assert!(arg0.version == 4, 0);
    }

    fun compute_split_allocation(arg0: u64, arg1: u64) : u64 {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::div(arg0, arg1)
    }

    public fun default_slippage_bps<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_slippage_bps(&arg0.config_snapshot)
    }

    public fun delegatee<T0, T1>(arg0: &DCA<T0, T1>) : address {
        arg0.delegatee
    }

    public fun effective_slippage_bps<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        if (0x1::option::is_some<u64>(&arg0.trade_params.slippage_bps)) {
            *0x1::option::borrow<u64>(&arg0.trade_params.slippage_bps)
        } else {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_slippage_bps(&arg0.config_snapshot)
        }
    }

    fun emit_deactivation_event<T0, T1>(arg0: &DCA<T0, T1>, arg1: u8) {
        let v0 = DCADeactivatedEvent{
            dca_id                    : 0x2::object::uid_to_inner(&arg0.id),
            reason                    : arg1,
            remaining_orders          : arg0.remaining_orders,
            remaining_input           : 0x2::balance::value<T0>(&arg0.input_balance),
            remaining_executor_reward : 0x2::balance::value<0x2::sui::SUI>(&arg0.executor_reward_balance),
        };
        0x2::event::emit<DCADeactivatedEvent>(v0);
    }

    fun fee_amount_with_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= 1844674407370955) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::div(arg0, 10000), arg1)
        } else {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::div(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(arg0, arg1), 10000)
        }
    }

    public fun fee_bps<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_fee_bps(&arg0.config_snapshot)
    }

    public entry fun init_account<T0, T1>(arg0: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::terms::TermsRegistry, arg2: &0x2::clock::Clock, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg18: &mut 0x2::tx_context::TxContext) {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_version(arg0);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_not_paused(arg0);
        0x2::transfer::share_object<DCA<T0, T1>>(new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18));
    }

    public entry fun init_account_v2<T0, T1>(arg0: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::terms::TermsRegistry, arg2: &0x2::clock::Clock, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg18: &mut 0x2::tx_context::TxContext) {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_version(arg0);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_not_paused(arg0);
        0x2::transfer::share_object<DCA<T0, T1>>(new_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18));
    }

    public(friend) fun init_trade<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::PriceFeedRegistry, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, TradePromise<T0, T1>) {
        check_version_and_upgrade<T0, T1>(arg0);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_not_paused(arg1);
        assert_active<T0, T1>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert_time(v0, arg0.last_time_ms, arg0.every, arg0.time_scale);
        let v1 = if (arg0.remaining_orders > 1) {
            0x2::balance::split<T0>(&mut arg0.input_balance, arg0.split_allocation)
        } else {
            0x2::balance::withdraw_all<T0>(&mut arg0.input_balance)
        };
        let v2 = v1;
        arg0.last_time_ms = v0;
        arg0.remaining_orders = arg0.remaining_orders - 1;
        let v3 = fee_amount_with_bps(0x2::balance::value<T0>(&v2), 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_fee_bps(&arg0.config_snapshot));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v3), arg8), 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_treasury(&arg0.config_snapshot));
        let v4 = 0x2::object::uid_to_inner(&arg0.id);
        let v5 = 0x2::balance::value<T0>(&v2);
        let v6 = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::oracle::calculate_min_output<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, v5, effective_slippage_bps<T0, T1>(arg0), arg0.input_decimals, arg0.output_decimals);
        let v7 = TradeInitiatedEvent{
            dca_id           : v4,
            executor         : 0x2::tx_context::sender(arg8),
            input_amount     : v5,
            fee_amount       : v3,
            remaining_orders : arg0.remaining_orders,
            order_number     : arg0.initial_orders - arg0.remaining_orders,
            min_output       : v6,
        };
        0x2::event::emit<TradeInitiatedEvent>(v7);
        let v8 = TradePromise<T0, T1>{
            input      : v5,
            min_output : v6,
            dca_id     : v4,
        };
        (v2, v8)
    }

    public fun initial_orders<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.initial_orders
    }

    public fun input_decimals<T0, T1>(arg0: &DCA<T0, T1>) : u8 {
        arg0.input_decimals
    }

    fun interval_to_seconds(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0
        } else if (arg1 == 1) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(arg0, 60)
        } else if (arg1 == 2) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(arg0, 3600)
        } else if (arg1 == 3) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(arg0, 86400)
        } else if (arg1 == 4) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(arg0, 604800)
        } else if (arg1 == 5) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(arg0, 2592000)
        } else {
            0
        }
    }

    fun net_trade_amount_with_bps(arg0: u64, arg1: u64) : u64 {
        arg0 - fee_amount_with_bps(arg0, arg1)
    }

    public fun new_v2<T0, T1>(arg0: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::terms::TermsRegistry, arg2: &0x2::clock::Clock, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg18: &mut 0x2::tx_context::TxContext) : DCA<T0, T1> {
        assert!(arg10 <= 18, 47);
        assert!(arg11 <= 18, 47);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_version(arg0);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_not_paused(arg0);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::terms::assert_terms_acceptable(arg1, arg9);
        assert_time_scale(arg7);
        assert_every(arg5, arg7);
        assert!(interval_to_seconds(arg5, arg7) >= 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::min_interval_seconds(arg0), 44);
        assert!(arg6 <= 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::max_orders_per_account(arg0), 16);
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg4)) >= 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(arg6, 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::min_funding_per_trade(arg0)), 12);
        let v0 = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::executor_reward_per_trade(arg0), arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg17) >= v0, 13);
        let v1 = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::create_snapshot(arg0);
        let v2 = 0x2::coin::into_balance<T0>(arg4);
        let v3 = compute_split_allocation(0x2::balance::value<T0>(&v2), arg6);
        let v4 = if (arg8 == 0) {
            0x2::clock::timestamp_ms(arg2)
        } else {
            arg8
        };
        let v5 = 0x2::object::new(arg18);
        let v6 = 0x2::tx_context::sender(arg18);
        let v7 = DCACreatedEvent{
            id                        : 0x2::object::uid_to_inner(&v5),
            owner                     : v6,
            delegatee                 : arg3,
            total_orders              : arg6,
            input_amount              : 0x2::balance::value<T0>(&v2),
            split_allocation          : v3,
            every                     : arg5,
            time_scale                : arg7,
            fee_bps                   : 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_fee_bps(&v1),
            executor_reward_per_trade : 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_executor_reward(&v1),
            default_slippage_bps      : 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_slippage_bps(&v1),
            start_time_ms             : v4,
            accepted_terms_version    : arg9,
        };
        0x2::event::emit<DCACreatedEvent>(v7);
        let v8 = if (arg12 == 0) {
            0x1::option::none<u64>()
        } else {
            assert!(arg12 <= 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::max_slippage_bps(arg0), 43);
            0x1::option::some<u64>(arg12)
        };
        let v9 = if (arg13 == 0 && arg14 == 0) {
            0x1::option::none<Price>()
        } else {
            let v10 = Price{
                base_val  : arg13,
                quote_val : arg14,
            };
            0x1::option::some<Price>(v10)
        };
        let v11 = if (arg15 == 0 && arg16 == 0) {
            0x1::option::none<Price>()
        } else {
            let v12 = Price{
                base_val  : arg15,
                quote_val : arg16,
            };
            0x1::option::some<Price>(v12)
        };
        let v13 = TradeParams{
            min_price    : v9,
            max_price    : v11,
            slippage_bps : v8,
        };
        DCA<T0, T1>{
            id                      : v5,
            version                 : 4,
            owner                   : v6,
            delegatee               : arg3,
            start_time_ms           : v4,
            last_time_ms            : v4,
            every                   : arg5,
            initial_orders          : arg6,
            remaining_orders        : arg6,
            time_scale              : arg7,
            input_balance           : v2,
            split_allocation        : v3,
            trade_params            : v13,
            active                  : true,
            executor_reward_balance : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg17, v0, arg18)),
            config_snapshot         : v1,
            accepted_terms_version  : arg9,
            input_decimals          : arg10,
            output_decimals         : arg11,
        }
    }

    public fun output_decimals<T0, T1>(arg0: &DCA<T0, T1>) : u8 {
        arg0.output_decimals
    }

    public fun owner<T0, T1>(arg0: &DCA<T0, T1>) : address {
        arg0.owner
    }

    public entry fun reactivate_as_owner<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner<T0, T1>(arg0, arg1);
        assert!(0x2::balance::value<T0>(&arg0.input_balance) > 0, 40);
        assert!(arg0.remaining_orders > 0, 41);
        arg0.split_allocation = compute_split_allocation(0x2::balance::value<T0>(&arg0.input_balance), arg0.remaining_orders);
        arg0.active = true;
    }

    public entry fun redeem_funds_and_deactivate<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner_or_delegatee<T0, T1>(arg0, arg1);
        let v0 = arg0.owner;
        if (0x2::balance::value<T0>(&arg0.input_balance) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.input_balance), arg1), v0);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.executor_reward_balance) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.executor_reward_balance), arg1), v0);
        };
        emit_deactivation_event<T0, T1>(arg0, 1);
        set_inactive_and_reset<T0, T1>(arg0);
    }

    public fun remaining_orders<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.remaining_orders
    }

    public entry fun reset_slippage<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner<T0, T1>(arg0, arg1);
        arg0.trade_params.slippage_bps = 0x1::option::none<u64>();
        let v0 = SlippageUpdatedEvent{
            dca_id           : 0x2::object::uid_to_inner(&arg0.id),
            old_slippage_bps : arg0.trade_params.slippage_bps,
            new_slippage_bps : 0x1::option::none<u64>(),
        };
        0x2::event::emit<SlippageUpdatedEvent>(v0);
    }

    public(friend) fun resolve_trade<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::FeeTracker, arg2: TradePromise<T0, T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let TradePromise {
            input      : _,
            min_output : v1,
            dca_id     : v2,
        } = arg2;
        assert!(arg3 >= v1, 46);
        let v3 = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_executor_reward(&arg0.config_snapshot);
        assert!(arg4 <= v3, 35);
        let v4 = v3 - arg4;
        if (v4 > 0) {
            0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::deposit_sui(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.executor_reward_balance, v4));
        };
        if (arg0.remaining_orders == 0 || 0x2::balance::value<T0>(&arg0.input_balance) == 0) {
            emit_deactivation_event<T0, T1>(arg0, 0);
            set_inactive_and_reset<T0, T1>(arg0);
        };
        let v5 = TradeCompletedEvent{
            dca_id          : v2,
            executor        : 0x2::tx_context::sender(arg5),
            output_amount   : arg3,
            executor_reward : arg4,
            active          : arg0.active,
        };
        0x2::event::emit<TradeCompletedEvent>(v5);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.executor_reward_balance, arg4), arg5)
    }

    public entry fun set_delegatee<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner<T0, T1>(arg0, arg2);
        arg0.delegatee = arg1;
        let v0 = DelegateeUpdatedEvent{
            dca_id        : 0x2::object::uid_to_inner(&arg0.id),
            old_delegatee : arg0.delegatee,
            new_delegatee : arg1,
        };
        0x2::event::emit<DelegateeUpdatedEvent>(v0);
    }

    public entry fun set_inactive<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner_or_delegatee<T0, T1>(arg0, arg1);
        emit_deactivation_event<T0, T1>(arg0, 1);
        arg0.active = false;
    }

    fun set_inactive_and_reset<T0, T1>(arg0: &mut DCA<T0, T1>) {
        arg0.split_allocation = 0;
        arg0.remaining_orders = 0;
        arg0.active = false;
    }

    public entry fun set_slippage<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner<T0, T1>(arg0, arg3);
        assert!(arg2 > 0 && arg2 <= 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::max_slippage_bps(arg1), 43);
        arg0.trade_params.slippage_bps = 0x1::option::some<u64>(arg2);
        let v0 = SlippageUpdatedEvent{
            dca_id           : 0x2::object::uid_to_inner(&arg0.id),
            old_slippage_bps : arg0.trade_params.slippage_bps,
            new_slippage_bps : 0x1::option::some<u64>(arg2),
        };
        0x2::event::emit<SlippageUpdatedEvent>(v0);
    }

    public fun start_time_ms<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.start_time_ms
    }

    public fun trade_input<T0, T1>(arg0: &TradePromise<T0, T1>) : u64 {
        arg0.input
    }

    public fun trade_min_output<T0, T1>(arg0: &TradePromise<T0, T1>) : u64 {
        arg0.min_output
    }

    public entry fun withdraw_input<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner<T0, T1>(arg0, arg3);
        assert!(0x2::balance::value<T0>(&arg0.input_balance) >= arg1, 42);
        assert!(arg2 <= arg0.remaining_orders, 48);
        let v0 = arg0.owner;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.input_balance, arg1), arg3), v0);
        arg0.remaining_orders = arg0.remaining_orders - arg2;
        let v1 = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math::mul(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::snapshot_executor_reward(&arg0.config_snapshot), arg2);
        if (v1 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.executor_reward_balance) >= v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.executor_reward_balance, v1), arg3), v0);
        };
        if (arg0.remaining_orders > 0) {
            arg0.split_allocation = compute_split_allocation(0x2::balance::value<T0>(&arg0.input_balance), arg0.remaining_orders);
        } else {
            emit_deactivation_event<T0, T1>(arg0, 1);
            set_inactive_and_reset<T0, T1>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

