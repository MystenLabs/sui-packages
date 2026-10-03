module 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation {
    struct KoiVenue has drop {
        dummy_field: bool,
    }

    struct Rule has copy, drop, store {
        trigger_price: u128,
        above: bool,
        share_bps: u16,
        from_remaining: bool,
        filled: bool,
    }

    struct AutomationOrder<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        kind: u8,
        fee_in_venue: bool,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens: 0x2::balance::Balance<T0>,
        original_amount: u64,
        rules: vector<Rule>,
        steps_left: u64,
        interval_ms: u64,
        next_at_ms: u64,
        min_price: u128,
        max_price: u128,
        slippage_bps: u16,
        decimals: u8,
        referrer: 0x1::option::Option<address>,
    }

    struct StepTicket<phantom T0> {
        order_id: 0x2::object::ID,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        owner: address,
        cranker: address,
        kind: u8,
        fee_in_venue: bool,
        rule_index: u64,
        input: u64,
        min_out: u64,
        referrer: 0x1::option::Option<address>,
        price_scaled: u128,
        at_ms: u64,
    }

    struct AutomationPlaced has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        kind: u8,
        amount: u64,
        trigger_prices: vector<u128>,
        above: vector<bool>,
        share_bps: vector<u16>,
        from_remaining: vector<bool>,
        steps: u64,
        interval_ms: u64,
        min_price: u128,
        max_price: u128,
        slippage_bps: u16,
        decimals: u8,
        at_ms: u64,
    }

    struct AutomationFilled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        cranker: address,
        kind: u8,
        rule_index: u64,
        input: u64,
        received: u64,
        price_scaled: u128,
        at_ms: u64,
    }

    struct AutomationClosed has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        at_ms: u64,
    }

    struct AutomationRuleCancelled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        rule_index: u64,
        at_ms: u64,
    }

    struct AutomationRuleUpdated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        rule_index: u64,
        previous_price: u128,
        trigger_price: u128,
        at_ms: u64,
    }

    struct AutomationResized has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        tokens: u64,
        original_amount: u64,
        at_ms: u64,
    }

    public fun decimals<T0>(arg0: &AutomationOrder<T0>) : u8 {
        arg0.decimals
    }

    public fun above<T0>(arg0: &AutomationOrder<T0>, arg1: u64) : bool {
        assert!(arg0.kind == 0 && arg1 < 0x1::vector::length<Rule>(&arg0.rules), 3);
        0x1::vector::borrow<Rule>(&arg0.rules, arg1).above
    }

    public fun begin_step<T0, T1: drop>(arg0: &mut AutomationOrder<T0>, arg1: T1, arg2: 0x2::object::ID, arg3: u128, arg4: u64, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, StepTicket<T0>) {
        assert!(arg0.venue == 0x1::type_name::with_defining_ids<T1>() && arg0.venue_id == arg2, 1);
        let v0 = arg0.fee_in_venue;
        step_inner<T0>(arg0, arg3, arg4, v0, arg5, arg6, arg7, arg8, arg9)
    }

    public fun begin_step_graduated<T0, T1: drop>(arg0: &mut AutomationOrder<T0>, arg1: T1, arg2: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::Curve<T0>, arg3: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::migration::MigrationVault<T0>, arg4: 0x2::object::ID, arg5: u128, arg6: u64, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg8: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg9: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, StepTicket<T0>) {
        assert!(0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::is_graduated_filler<T1>(arg7), 8);
        assert!(arg0.venue == 0x1::type_name::with_defining_ids<KoiVenue>(), 1);
        assert!(arg0.venue_id == 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::id<T0>(arg2), 1);
        assert!(0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::is_graduated<T0>(arg2), 9);
        assert!(0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::migration::curve_id<T0>(arg3) == 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::id<T0>(arg2), 1);
        let v0 = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::migration::pool_id<T0>(arg3);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && *0x1::option::borrow<0x2::object::ID>(&v0) == arg4, 10);
        step_inner<T0>(arg0, arg5, arg6, false, arg7, arg8, arg9, arg10, arg11)
    }

    public fun cancel<T0>(arg0: AutomationOrder<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        let AutomationOrder {
            id              : v0,
            owner           : v1,
            venue           : _,
            venue_id        : _,
            curve_id        : _,
            kind            : _,
            fee_in_venue    : _,
            sui             : v7,
            tokens          : v8,
            original_amount : _,
            rules           : _,
            steps_left      : _,
            interval_ms     : _,
            next_at_ms      : _,
            min_price       : _,
            max_price       : _,
            slippage_bps    : _,
            decimals        : _,
            referrer        : _,
        } = arg0;
        let v19 = v0;
        0x2::object::delete(v19);
        pay<0x2::sui::SUI>(v7, v1, arg2);
        pay<T0>(v8, v1, arg2);
        let v20 = AutomationClosed{
            order_id : 0x2::object::uid_to_inner(&v19),
            owner    : v1,
            at_ms    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AutomationClosed>(v20);
    }

    public fun cancel_rule<T0>(arg0: &mut AutomationOrder<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        assert!(arg0.kind == 0 && arg1 < 0x1::vector::length<Rule>(&arg0.rules), 3);
        assert!(!0x1::vector::borrow<Rule>(&arg0.rules, arg1).filled, 4);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Rule>(&arg0.rules)) {
            if (v1 != arg1 && !0x1::vector::borrow<Rule>(&arg0.rules, v1).filled) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 3);
        0x1::vector::borrow_mut<Rule>(&mut arg0.rules, arg1).filled = true;
        let v2 = AutomationRuleCancelled{
            order_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner      : arg0.owner,
            rule_index : arg1,
            at_ms      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AutomationRuleCancelled>(v2);
    }

    fun emit_resized<T0>(arg0: &AutomationOrder<T0>, arg1: &0x2::clock::Clock) {
        let v0 = AutomationResized{
            order_id        : 0x2::object::uid_to_inner(&arg0.id),
            owner           : arg0.owner,
            tokens          : 0x2::balance::value<T0>(&arg0.tokens),
            original_amount : arg0.original_amount,
            at_ms           : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AutomationResized>(v0);
    }

    public fun fill_koi<T0>(arg0: &mut AutomationOrder<T0>, arg1: u64, arg2: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::Curve<T0>, arg3: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg4: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg5: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = is_buy<T0>(arg0);
        let v1 = arg0.slippage_bps;
        let v2 = KoiVenue{dummy_field: false};
        let (v3, v4, v5) = begin_step<T0, KoiVenue>(arg0, v2, 0x2::object::id<0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::Curve<T0>>(arg2), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::price_scaled<T0>(arg2), arg1, arg3, arg4, arg5, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        if (v0) {
            0x2::balance::destroy_zero<T0>(v7);
            let (v9, _, _, _) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::quote_buy<T0>(arg2, 0x2::balance::value<0x2::sui::SUI>(&v8));
            let v13 = (((v9 as u128) * ((10000 - (v1 as u64)) as u128) / (10000 as u128)) as u64);
            v6.min_out = v13;
            let (v14, v15) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::buy_for<T0>(arg2, arg3, arg4, arg5, v6.owner, 0x2::coin::from_balance<0x2::sui::SUI>(v8, arg7), v13, v6.referrer, arg6, arg7);
            settle_step<T0>(v6, 0x2::coin::into_balance<0x2::sui::SUI>(v15), 0x2::coin::into_balance<T0>(v14), arg3, arg4, arg7);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
            let (v16, _, _) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::quote_sell<T0>(arg2, 0x2::balance::value<T0>(&v7));
            let v19 = (((v16 as u128) * ((10000 - (v1 as u64)) as u128) / (10000 as u128)) as u64);
            v6.min_out = v19;
            let v20 = 0x2::coin::into_balance<0x2::sui::SUI>(0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::sell_for<T0>(arg2, arg3, arg4, arg5, v6.owner, 0x2::coin::from_balance<T0>(v7, arg7), v19, v6.referrer, arg6, arg7));
            settle_step<T0>(v6, v20, 0x2::balance::zero<T0>(), arg3, arg4, arg7);
        };
    }

    public fun is_buy<T0>(arg0: &AutomationOrder<T0>) : bool {
        arg0.kind == 1
    }

    public fun max_price<T0>(arg0: &AutomationOrder<T0>) : u128 {
        arg0.max_price
    }

    public fun min_price<T0>(arg0: &AutomationOrder<T0>) : u128 {
        arg0.min_price
    }

    public fun owner<T0>(arg0: &AutomationOrder<T0>) : address {
        arg0.owner
    }

    fun pay<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun place_dca<T0, T1: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u16, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        place_dca_inner<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::coin::get_decimals<T0>(arg2), arg9, arg10, arg11);
    }

    public fun place_dca_currency<T0, T1: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u16, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        place_dca_inner<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::coin_registry::decimals<T0>(arg2), arg9, arg10, arg11);
    }

    fun place_dca_inner<T0, T1: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u16, arg8: u8, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = if (arg3 > 0) {
            if (arg3 <= 100) {
                if (v0 >= arg3) {
                    arg4 >= 60000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        assert!(arg6 == 0 || arg6 >= arg5, 3);
        assert!(arg7 < 10000 && arg8 <= 18, 3);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        let v3 = 0x2::object::new(arg11);
        let v4 = 0x2::clock::timestamp_ms(arg10);
        let v5 = AutomationPlaced{
            order_id       : 0x2::object::uid_to_inner(&v3),
            owner          : 0x2::tx_context::sender(arg11),
            venue          : v2,
            venue_id       : arg0,
            curve_id       : arg1,
            kind           : 1,
            amount         : v0,
            trigger_prices : vector[],
            above          : vector[],
            share_bps      : vector[],
            from_remaining : vector[],
            steps          : arg3,
            interval_ms    : arg4,
            min_price      : arg5,
            max_price      : arg6,
            slippage_bps   : arg7,
            decimals       : arg8,
            at_ms          : v4,
        };
        0x2::event::emit<AutomationPlaced>(v5);
        let v6 = AutomationOrder<T0>{
            id              : v3,
            owner           : 0x2::tx_context::sender(arg11),
            venue           : v2,
            venue_id        : arg0,
            curve_id        : arg1,
            kind            : 1,
            fee_in_venue    : v2 == 0x1::type_name::with_defining_ids<KoiVenue>(),
            sui             : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            tokens          : 0x2::balance::zero<T0>(),
            original_amount : v0,
            rules           : 0x1::vector::empty<Rule>(),
            steps_left      : arg3,
            interval_ms     : arg4,
            next_at_ms      : v4,
            min_price       : arg5,
            max_price       : arg6,
            slippage_bps    : arg7,
            decimals        : arg8,
            referrer        : arg9,
        };
        0x2::transfer::share_object<AutomationOrder<T0>>(v6);
    }

    public fun place_strategy<T0, T1: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u128>, arg5: vector<bool>, arg6: vector<u16>, arg7: vector<bool>, arg8: u16, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        place_strategy_inner<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::coin::get_decimals<T0>(arg2), arg9, arg10, arg11);
    }

    public fun place_strategy_currency<T0, T1: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u128>, arg5: vector<bool>, arg6: vector<u16>, arg7: vector<bool>, arg8: u16, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        place_strategy_inner<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::coin_registry::decimals<T0>(arg2), arg9, arg10, arg11);
    }

    fun place_strategy_inner<T0, T1: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: vector<u128>, arg4: vector<bool>, arg5: vector<u16>, arg6: vector<bool>, arg7: u16, arg8: u8, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u128>(&arg3);
        let v1 = if (v0 > 0) {
            if (v0 <= 12) {
                if (0x1::vector::length<bool>(&arg4) == v0) {
                    if (0x1::vector::length<u16>(&arg5) == v0) {
                        0x1::vector::length<bool>(&arg6) == v0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        let v2 = 0x1::vector::empty<Rule>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u128>(&arg3, v3);
            let v5 = *0x1::vector::borrow<u16>(&arg5, v3);
            let v6 = if (v4 > 0) {
                if (v5 > 0) {
                    (v5 as u64) <= 10000
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v6, 3);
            let v7 = Rule{
                trigger_price  : v4,
                above          : *0x1::vector::borrow<bool>(&arg4, v3),
                share_bps      : v5,
                from_remaining : *0x1::vector::borrow<bool>(&arg6, v3),
                filled         : false,
            };
            0x1::vector::push_back<Rule>(&mut v2, v7);
            v3 = v3 + 1;
        };
        let v8 = 0x2::coin::value<T0>(&arg2);
        let v9 = if (v8 > 0) {
            if (arg7 < 10000) {
                arg8 <= 18
            } else {
                false
            }
        } else {
            false
        };
        assert!(v9, 3);
        let v10 = 0x1::type_name::with_defining_ids<T1>();
        let v11 = 0x2::object::new(arg11);
        let v12 = AutomationPlaced{
            order_id       : 0x2::object::uid_to_inner(&v11),
            owner          : 0x2::tx_context::sender(arg11),
            venue          : v10,
            venue_id       : arg0,
            curve_id       : arg1,
            kind           : 0,
            amount         : v8,
            trigger_prices : arg3,
            above          : arg4,
            share_bps      : arg5,
            from_remaining : arg6,
            steps          : 0,
            interval_ms    : 0,
            min_price      : 0,
            max_price      : 0,
            slippage_bps   : arg7,
            decimals       : arg8,
            at_ms          : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<AutomationPlaced>(v12);
        let v13 = AutomationOrder<T0>{
            id              : v11,
            owner           : 0x2::tx_context::sender(arg11),
            venue           : v10,
            venue_id        : arg0,
            curve_id        : arg1,
            kind            : 0,
            fee_in_venue    : v10 == 0x1::type_name::with_defining_ids<KoiVenue>(),
            sui             : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens          : 0x2::coin::into_balance<T0>(arg2),
            original_amount : v8,
            rules           : v2,
            steps_left      : 0,
            interval_ms     : 0,
            next_at_ms      : 0,
            min_price       : 0,
            max_price       : 0,
            slippage_bps    : arg7,
            decimals        : arg8,
            referrer        : arg9,
        };
        0x2::transfer::share_object<AutomationOrder<T0>>(v13);
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun scale_original<T0>(arg0: &mut AutomationOrder<T0>, arg1: u64, arg2: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = (arg0.original_amount as u128) * (arg2 as u128) / (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 7);
        arg0.original_amount = (v0 as u64);
    }

    public fun settle_step<T0>(arg0: StepTicket<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg4: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg5: &mut 0x2::tx_context::TxContext) {
        let StepTicket {
            order_id     : v0,
            venue_id     : _,
            curve_id     : v2,
            owner        : v3,
            cranker      : v4,
            kind         : v5,
            fee_in_venue : v6,
            rule_index   : v7,
            input        : v8,
            min_out      : v9,
            referrer     : v10,
            price_scaled : v11,
            at_ms        : v12,
        } = arg0;
        let v13 = if (v5 == 0) {
            if (!v6) {
                let v14 = &mut arg1;
                take_fee(arg3, arg4, v2, v14, v10);
            };
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) > 0, 6);
            0x2::balance::value<0x2::sui::SUI>(&arg1)
        } else {
            assert!(0x2::balance::value<T0>(&arg2) > 0, 6);
            0x2::balance::value<T0>(&arg2)
        };
        assert!(v13 >= v9, 5);
        pay<0x2::sui::SUI>(arg1, v3, arg5);
        pay<T0>(arg2, v3, arg5);
        let v15 = AutomationFilled{
            order_id     : v0,
            owner        : v3,
            cranker      : v4,
            kind         : v5,
            rule_index   : v7,
            input        : v8,
            received     : v13,
            price_scaled : v11,
            at_ms        : v12,
        };
        0x2::event::emit<AutomationFilled>(v15);
    }

    fun step_inner<T0>(arg0: &mut AutomationOrder<T0>, arg1: u128, arg2: u64, arg3: bool, arg4: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg5: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, StepTicket<T0>) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = 0x2::balance::zero<T0>();
        let v3 = if (arg0.kind == 0) {
            assert!(arg2 < 0x1::vector::length<Rule>(&arg0.rules) && 0x2::balance::value<T0>(&arg0.tokens) > 0, 4);
            let v4 = 0x1::vector::borrow_mut<Rule>(&mut arg0.rules, arg2);
            assert!(!v4.filled, 4);
            assert!(v4.above && arg1 >= v4.trigger_price || arg1 <= v4.trigger_price, 4);
            let v5 = if (v4.from_remaining) {
                (((0x2::balance::value<T0>(&arg0.tokens) as u128) * (v4.share_bps as u128) / (10000 as u128)) as u64)
            } else {
                (((arg0.original_amount as u128) * (v4.share_bps as u128) / (10000 as u128)) as u64)
            };
            let v6 = if (v5 > 0x2::balance::value<T0>(&arg0.tokens)) {
                0x2::balance::value<T0>(&arg0.tokens)
            } else {
                v5
            };
            assert!(v6 > 0, 3);
            0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg0.tokens, v6));
            v4.filled = true;
            v6
        } else {
            let v7 = if (arg0.kind == 1) {
                if (arg0.steps_left > 0) {
                    v0 >= arg0.next_at_ms
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v7, 4);
            assert!(arg0.min_price == 0 || arg1 >= arg0.min_price, 4);
            assert!(arg0.max_price == 0 || arg1 <= arg0.max_price, 4);
            let v8 = if (arg0.steps_left == 1) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
            } else {
                0x2::balance::value<0x2::sui::SUI>(&arg0.sui) / arg0.steps_left
            };
            assert!(v8 > 0, 3);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v8));
            arg0.steps_left = arg0.steps_left - 1;
            arg0.next_at_ms = v0 + arg0.interval_ms;
            v8
        };
        let v9 = if (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::has_referrer(arg6, arg0.owner)) {
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::referrer_of(arg6, arg0.owner)
        } else {
            arg0.referrer
        };
        if (arg0.kind == 1 && !arg3) {
            let v10 = &mut v1;
            take_fee(arg4, arg5, arg0.curve_id, v10, v9);
        };
        let v11 = if (arg0.kind == 0) {
            (v3 as u256) * (arg1 as u256) / pow10(arg0.decimals) * 1000000000000
        } else {
            (0x2::balance::value<0x2::sui::SUI>(&v1) as u256) * pow10(arg0.decimals) * 1000000000000 / (arg1 as u256)
        };
        let v12 = if (arg0.kind == 0 && !arg3) {
            v11 * ((10000 - 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::fee_bps(arg4)) as u256) / (10000 as u256)
        } else {
            v11
        };
        let v13 = v12 * ((10000 - (arg0.slippage_bps as u64)) as u256) / (10000 as u256);
        assert!(v13 <= 18446744073709551615, 7);
        let v14 = StepTicket<T0>{
            order_id     : 0x2::object::uid_to_inner(&arg0.id),
            venue_id     : arg0.venue_id,
            curve_id     : arg0.curve_id,
            owner        : arg0.owner,
            cranker      : 0x2::tx_context::sender(arg8),
            kind         : arg0.kind,
            fee_in_venue : arg3,
            rule_index   : arg2,
            input        : v3,
            min_out      : (v13 as u64),
            referrer     : v9,
            price_scaled : arg1,
            at_ms        : v0,
        };
        (v1, v2, v14)
    }

    fun take_fee(arg0: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg1: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg2: 0x2::object::ID, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x1::option::Option<address>) {
        assert!(0x2::balance::value<0x2::sui::SUI>(arg3) > 0, 3);
        let v0 = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::mul_bps(0x2::balance::value<0x2::sui::SUI>(arg3), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::fee_bps(arg0));
        if (v0 > 0) {
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::deposit_external(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(arg3, v0), arg4);
        };
    }

    public fun top_up<T0>(arg0: &mut AutomationOrder<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        assert!(arg0.kind == 0, 6);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Rule>(&arg0.rules)) {
            if (!0x1::vector::borrow<Rule>(&arg0.rules, v2).filled) {
                v1 = true;
            };
            v2 = v2 + 1;
        };
        assert!(v1, 4);
        let v3 = 0x2::balance::value<T0>(&arg0.tokens);
        scale_original<T0>(arg0, v3, v3 + v0);
        0x2::coin::put<T0>(&mut arg0.tokens, arg1);
        emit_resized<T0>(arg0, arg2);
    }

    public fun trigger_price<T0>(arg0: &AutomationOrder<T0>, arg1: u64) : u128 {
        assert!(arg0.kind == 0 && arg1 < 0x1::vector::length<Rule>(&arg0.rules), 3);
        0x1::vector::borrow<Rule>(&arg0.rules, arg1).trigger_price
    }

    public fun update_rule<T0>(arg0: &mut AutomationOrder<T0>, arg1: u64, arg2: u128, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 2);
        let v0 = if (arg0.kind == 0) {
            if (arg1 < 0x1::vector::length<Rule>(&arg0.rules)) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = 0x1::vector::borrow_mut<Rule>(&mut arg0.rules, arg1);
        assert!(!v1.filled && v1.trigger_price == arg2, 4);
        v1.trigger_price = arg3;
        let v2 = AutomationRuleUpdated{
            order_id       : 0x2::object::uid_to_inner(&arg0.id),
            owner          : arg0.owner,
            rule_index     : arg1,
            previous_price : arg2,
            trigger_price  : arg3,
            at_ms          : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AutomationRuleUpdated>(v2);
    }

    public fun withdraw_part<T0>(arg0: &mut AutomationOrder<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        assert!(arg0.kind == 0, 6);
        let v0 = 0x2::balance::value<T0>(&arg0.tokens);
        assert!(arg1 > 0 && arg1 < v0, 3);
        scale_original<T0>(arg0, v0, v0 - arg1);
        emit_resized<T0>(arg0, arg2);
        0x2::coin::take<T0>(&mut arg0.tokens, arg1, arg3)
    }

    // decompiled from Move bytecode v7
}

