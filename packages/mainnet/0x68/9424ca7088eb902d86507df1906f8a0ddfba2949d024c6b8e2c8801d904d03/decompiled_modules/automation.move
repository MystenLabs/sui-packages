module 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::automation {
    struct Rule has copy, drop, store {
        trigger_price: u128,
        above: bool,
        share_bps: u16,
        from_remaining: bool,
        filled: bool,
        cancelled: bool,
    }

    struct AutomationOrder<phantom T0, T1: store + key> has key {
        id: 0x2::object::UID,
        owner: address,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        kind: u8,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        receipt: 0x1::option::Option<T1>,
        receipt_amount: u64,
        original_amount: u64,
        budget_remaining: u64,
        rules: vector<Rule>,
        steps_left: u64,
        interval_ms: u64,
        next_at_ms: u64,
        min_price: u128,
        max_price: u128,
        slippage_bps: u16,
        decimals: u8,
        referrer: 0x1::option::Option<address>,
        closed: bool,
    }

    struct StepTicket<phantom T0> has drop {
        order_id: 0x2::object::ID,
        owner: address,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        cranker: address,
        kind: u8,
        rule_index: u64,
        input: u64,
        min_out: u64,
        observed_price: u128,
        receipt_amount: u64,
        original_amount: u64,
        budget_remaining: u64,
        rules: vector<Rule>,
        steps_left: u64,
        interval_ms: u64,
        next_at_ms: u64,
        min_price: u128,
        max_price: u128,
        slippage_bps: u16,
        decimals: u8,
        referrer: 0x1::option::Option<address>,
        at_ms: u64,
    }

    public fun decimals<T0, T1: store + key>(arg0: &AutomationOrder<T0, T1>) : u8 {
        arg0.decimals
    }

    fun after_fee_floor(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= (10000 as u64), 2);
        (((arg0 as u128) * (((10000 as u64) - arg1) as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun begin_dca_step<T0, T1: store + key>(arg0: &mut AutomationOrder<T0, T1>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: u128, arg4: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg5: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, StepTicket<T0>) {
        let v0 = if (!arg0.closed) {
            if (arg0.kind == 1) {
                arg0.venue_id == arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = if (arg0.steps_left > 0) {
            if (v1 >= arg0.next_at_ms) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
        assert!(arg0.min_price == 0 || arg3 >= arg0.min_price, 3);
        assert!(arg0.max_price == 0 || arg3 <= arg0.max_price, 3);
        let v3 = if (arg0.steps_left == 1) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.sui) / arg0.steps_left
        };
        assert!(v3 > 0, 2);
        let v4 = effective_referrer(arg6, arg0.owner, arg0.referrer);
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v3);
        let v6 = &mut v5;
        take_fee(arg4, arg5, arg0.curve_id, v6, v4);
        let v7 = StepTicket<T0>{
            order_id         : 0x2::object::uid_to_inner(&arg0.id),
            owner            : arg0.owner,
            venue            : arg0.venue,
            venue_id         : arg0.venue_id,
            curve_id         : arg0.curve_id,
            cranker          : 0x2::tx_context::sender(arg8),
            kind             : 1,
            rule_index       : 0,
            input            : v3,
            min_out          : expected_buy_floor(0x2::balance::value<0x2::sui::SUI>(&v5), arg3, arg0.decimals, arg0.slippage_bps),
            observed_price   : arg3,
            receipt_amount   : 0,
            original_amount  : arg0.original_amount,
            budget_remaining : 0,
            rules            : arg0.rules,
            steps_left       : arg0.steps_left - 1,
            interval_ms      : arg0.interval_ms,
            next_at_ms       : v1 + arg0.interval_ms,
            min_price        : arg0.min_price,
            max_price        : arg0.max_price,
            slippage_bps     : arg0.slippage_bps,
            decimals         : arg0.decimals,
            referrer         : v4,
            at_ms            : v1,
        };
        (v5, v7)
    }

    public(friend) fun begin_strategy_step<T0, T1: store + key>(arg0: &mut AutomationOrder<T0, T1>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (T1, u64, StepTicket<T0>) {
        let v0 = if (!arg0.closed) {
            if (arg0.kind == 0) {
                arg0.venue_id == arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        assert!(arg3 < 0x1::vector::length<Rule>(&arg0.rules) && arg0.receipt_amount > 0, 3);
        let v1 = 0x1::vector::borrow<Rule>(&arg0.rules, arg3);
        let v2 = if (!v1.filled) {
            if (!v1.cancelled) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
        assert!(v1.above && arg4 >= v1.trigger_price || arg4 <= v1.trigger_price, 3);
        let v3 = if (v1.from_remaining) {
            (((arg0.budget_remaining as u128) * (v1.share_bps as u128) / 10000) as u64)
        } else {
            (((arg0.original_amount as u128) * (v1.share_bps as u128) / 10000) as u64)
        };
        let v4 = if (v3 > arg0.budget_remaining) {
            arg0.budget_remaining
        } else {
            v3
        };
        let v5 = if (v4 > arg0.receipt_amount) {
            arg0.receipt_amount
        } else {
            v4
        };
        assert!(v5 > 0, 2);
        0x1::vector::borrow_mut<Rule>(&mut arg0.rules, arg3).filled = true;
        assert!(0x1::option::is_some<T1>(&arg0.receipt), 1);
        let v6 = StepTicket<T0>{
            order_id         : 0x2::object::uid_to_inner(&arg0.id),
            owner            : arg0.owner,
            venue            : arg0.venue,
            venue_id         : arg0.venue_id,
            curve_id         : arg0.curve_id,
            cranker          : 0x2::tx_context::sender(arg6),
            kind             : 0,
            rule_index       : arg3,
            input            : v5,
            min_out          : expected_sell_floor(v5, arg4, arg0.decimals, arg0.slippage_bps),
            observed_price   : arg4,
            receipt_amount   : arg0.receipt_amount,
            original_amount  : arg0.original_amount,
            budget_remaining : arg0.budget_remaining,
            rules            : arg0.rules,
            steps_left       : 0,
            interval_ms      : 0,
            next_at_ms       : 0,
            min_price        : 0,
            max_price        : 0,
            slippage_bps     : arg0.slippage_bps,
            decimals         : arg0.decimals,
            referrer         : arg0.referrer,
            at_ms            : 0x2::clock::timestamp_ms(arg5),
        };
        (0x1::option::extract<T1>(&mut arg0.receipt), v5, v6)
    }

    public fun cancel<T0, T1: store + key>(arg0: AutomationOrder<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2) && !arg0.closed, 6);
        let AutomationOrder {
            id               : v0,
            owner            : v1,
            venue            : _,
            venue_id         : _,
            curve_id         : _,
            kind             : _,
            sui              : v6,
            receipt          : v7,
            receipt_amount   : _,
            original_amount  : _,
            budget_remaining : _,
            rules            : _,
            steps_left       : _,
            interval_ms      : _,
            next_at_ms       : _,
            min_price        : _,
            max_price        : _,
            slippage_bps     : _,
            decimals         : _,
            referrer         : _,
            closed           : _,
        } = arg0;
        let v21 = v7;
        let v22 = v0;
        0x2::object::delete(v22);
        pay(v6, v1, arg2);
        if (0x1::option::is_some<T1>(&v21)) {
            0x1::option::destroy_none<T1>(v21);
            0x2::transfer::public_transfer<T1>(0x1::option::extract<T1>(&mut v21), v1);
        } else {
            0x1::option::destroy_none<T1>(v21);
        };
        0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_closed(0x2::object::uid_to_inner(&v22), v1, false, 0x2::clock::timestamp_ms(arg1));
    }

    public fun cancel_rule<T0, T1: store + key>(arg0: &mut AutomationOrder<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = if (arg0.owner == 0x2::tx_context::sender(arg3)) {
            if (arg0.kind == 0) {
                arg1 < 0x1::vector::length<Rule>(&arg0.rules)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Rule>(&arg0.rules)) {
            let v3 = if (v2 != arg1) {
                if (!0x1::vector::borrow<Rule>(&arg0.rules, v2).filled) {
                    !0x1::vector::borrow<Rule>(&arg0.rules, v2).cancelled
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                v1 = true;
            };
            v2 = v2 + 1;
        };
        assert!(v1, 2);
        let v4 = 0x1::vector::borrow_mut<Rule>(&mut arg0.rules, arg1);
        assert!(!v4.filled && !v4.cancelled, 3);
        v4.cancelled = true;
        0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_rule_cancelled(0x2::object::uid_to_inner(&arg0.id), arg0.owner, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun curve_id<T0, T1: store + key>(arg0: &AutomationOrder<T0, T1>) : 0x2::object::ID {
        arg0.curve_id
    }

    fun effective_referrer(arg0: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg1: address, arg2: 0x1::option::Option<address>) : 0x1::option::Option<address> {
        if (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::has_referrer(arg0, arg1)) {
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::referrer_of(arg0, arg1)
        } else {
            arg2
        }
    }

    fun execution_price(arg0: u64, arg1: u64, arg2: u8) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 2);
        let v0 = (arg0 as u256) * (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::pow10(arg2) as u256) * (1000000000000 as u256) / (arg1 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 2);
        (v0 as u128)
    }

    fun expected_buy_floor(arg0: u64, arg1: u128, arg2: u8, arg3: u16) : u64 {
        let v0 = (arg0 as u256) * (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::pow10(arg2) as u256) * (1000000000000 as u256) / (arg1 as u256) * ((10000 - (arg3 as u128)) as u256) / (10000 as u256);
        assert!(v0 <= 18446744073709551615, 2);
        if (v0 == 0) {
            1
        } else {
            (v0 as u64)
        }
    }

    fun expected_sell_floor(arg0: u64, arg1: u128, arg2: u8, arg3: u16) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::pow10(arg2) as u256) * (1000000000000 as u256) * ((10000 - (arg3 as u128)) as u256) / (10000 as u256);
        assert!(v0 <= 18446744073709551615, 2);
        if (v0 == 0) {
            1
        } else {
            (v0 as u64)
        }
    }

    fun has_open_rules(arg0: &vector<Rule>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rule>(arg0)) {
            if (!0x1::vector::borrow<Rule>(arg0, v0).filled && !0x1::vector::borrow<Rule>(arg0, v0).cancelled) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_buy<T0, T1: store + key>(arg0: &AutomationOrder<T0, T1>) : bool {
        arg0.kind == 1
    }

    fun keep_strategy_open(arg0: u64, arg1: u64, arg2: bool) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun kind<T0, T1: store + key>(arg0: &AutomationOrder<T0, T1>) : u8 {
        arg0.kind
    }

    fun pay(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg0);
        };
    }

    public fun place_dca<T0, T1: store + key>(arg0: 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u16, arg11: 0x1::option::Option<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        let v1 = if (arg6 > 0) {
            if (arg6 <= 100) {
                if (v0 >= arg6) {
                    arg7 >= 60000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
        assert!(arg9 == 0 || arg9 >= arg8, 2);
        assert!(arg10 < (10000 as u16), 2);
        let v2 = 0x2::coin::get_decimals<T0>(arg4);
        assert!(v2 <= 18, 2);
        let v3 = 0x1::type_name::with_defining_ids<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>();
        let v4 = 0x2::object::new(arg13);
        let v5 = 0x2::clock::timestamp_ms(arg12);
        0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_placed(0x2::object::uid_to_inner(&v4), 0x2::tx_context::sender(arg13), v3, arg2, arg3, 1, v0, 0, vector[], vector[], vector[], vector[], arg6, arg7, arg8, arg9, arg10, v2, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), v5);
        let v6 = AutomationOrder<T0, T1>{
            id               : v4,
            owner            : 0x2::tx_context::sender(arg13),
            venue            : v3,
            venue_id         : arg2,
            curve_id         : arg3,
            kind             : 1,
            sui              : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            receipt          : 0x1::option::none<T1>(),
            receipt_amount   : 0,
            original_amount  : v0,
            budget_remaining : 0,
            rules            : 0x1::vector::empty<Rule>(),
            steps_left       : arg6,
            interval_ms      : arg7,
            next_at_ms       : v5,
            min_price        : arg8,
            max_price        : arg9,
            slippage_bps     : arg10,
            decimals         : v2,
            referrer         : arg11,
            closed           : false,
        };
        0x2::transfer::share_object<AutomationOrder<T0, T1>>(v6);
    }

    public fun place_dca_currency<T0, T1: store + key>(arg0: 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u16, arg11: 0x1::option::Option<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        let v1 = if (arg6 > 0) {
            if (arg6 <= 100) {
                if (v0 >= arg6) {
                    arg7 >= 60000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
        assert!(arg9 == 0 || arg9 >= arg8, 2);
        assert!(arg10 < (10000 as u16), 2);
        let v2 = 0x2::coin_registry::decimals<T0>(arg4);
        assert!(v2 <= 18, 2);
        let v3 = 0x1::type_name::with_defining_ids<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>();
        let v4 = 0x2::object::new(arg13);
        let v5 = 0x2::clock::timestamp_ms(arg12);
        0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_placed(0x2::object::uid_to_inner(&v4), 0x2::tx_context::sender(arg13), v3, arg2, arg3, 1, v0, 0, vector[], vector[], vector[], vector[], arg6, arg7, arg8, arg9, arg10, v2, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), v5);
        let v6 = AutomationOrder<T0, T1>{
            id               : v4,
            owner            : 0x2::tx_context::sender(arg13),
            venue            : v3,
            venue_id         : arg2,
            curve_id         : arg3,
            kind             : 1,
            sui              : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            receipt          : 0x1::option::none<T1>(),
            receipt_amount   : 0,
            original_amount  : v0,
            budget_remaining : 0,
            rules            : 0x1::vector::empty<Rule>(),
            steps_left       : arg6,
            interval_ms      : arg7,
            next_at_ms       : v5,
            min_price        : arg8,
            max_price        : arg9,
            slippage_bps     : arg10,
            decimals         : v2,
            referrer         : arg11,
            closed           : false,
        };
        0x2::transfer::share_object<AutomationOrder<T0, T1>>(v6);
    }

    public fun place_strategy<T0, T1: store + key>(arg0: 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: T1, arg6: u64, arg7: u64, arg8: vector<u128>, arg9: vector<bool>, arg10: vector<u16>, arg11: vector<bool>, arg12: u16, arg13: 0x1::option::Option<address>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        let v0 = 0x1::vector::length<u128>(&arg8);
        let v1 = if (v0 > 0) {
            if (v0 <= 12) {
                if (0x1::vector::length<bool>(&arg9) == v0) {
                    if (0x1::vector::length<u16>(&arg10) == v0) {
                        0x1::vector::length<bool>(&arg11) == v0
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
        assert!(v1, 2);
        let v2 = if (arg6 >= arg7) {
            if (arg7 > 0) {
                arg12 < (10000 as u16)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 2);
        let v3 = 0x1::vector::empty<Rule>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = if (*0x1::vector::borrow<u128>(&arg8, v4) > 0) {
                if (*0x1::vector::borrow<u16>(&arg10, v4) > 0) {
                    (*0x1::vector::borrow<u16>(&arg10, v4) as u128) <= 10000
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v5, 2);
            let v6 = Rule{
                trigger_price  : *0x1::vector::borrow<u128>(&arg8, v4),
                above          : *0x1::vector::borrow<bool>(&arg9, v4),
                share_bps      : *0x1::vector::borrow<u16>(&arg10, v4),
                from_remaining : *0x1::vector::borrow<bool>(&arg11, v4),
                filled         : false,
                cancelled      : false,
            };
            0x1::vector::push_back<Rule>(&mut v3, v6);
            v4 = v4 + 1;
        };
        let v7 = 0x2::coin::get_decimals<T0>(arg4);
        assert!(v7 <= 18, 2);
        let v8 = 0x1::type_name::with_defining_ids<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>();
        let v9 = 0x2::object::new(arg15);
        0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_placed(0x2::object::uid_to_inner(&v9), 0x2::tx_context::sender(arg15), v8, arg2, arg3, 0, arg6, arg7, arg8, arg9, arg10, arg11, 0, 0, 0, 0, arg12, v7, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x2::clock::timestamp_ms(arg14));
        let v10 = AutomationOrder<T0, T1>{
            id               : v9,
            owner            : 0x2::tx_context::sender(arg15),
            venue            : v8,
            venue_id         : arg2,
            curve_id         : arg3,
            kind             : 0,
            sui              : 0x2::balance::zero<0x2::sui::SUI>(),
            receipt          : 0x1::option::some<T1>(arg5),
            receipt_amount   : arg6,
            original_amount  : arg7,
            budget_remaining : arg7,
            rules            : v3,
            steps_left       : 0,
            interval_ms      : 0,
            next_at_ms       : 0,
            min_price        : 0,
            max_price        : 0,
            slippage_bps     : arg12,
            decimals         : v7,
            referrer         : arg13,
            closed           : false,
        };
        0x2::transfer::share_object<AutomationOrder<T0, T1>>(v10);
    }

    public fun place_strategy_currency<T0, T1: store + key>(arg0: 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: T1, arg6: u64, arg7: u64, arg8: vector<u128>, arg9: vector<bool>, arg10: vector<u16>, arg11: vector<bool>, arg12: u16, arg13: 0x1::option::Option<address>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        let v0 = 0x1::vector::length<u128>(&arg8);
        let v1 = if (v0 > 0) {
            if (v0 <= 12) {
                if (0x1::vector::length<bool>(&arg9) == v0) {
                    if (0x1::vector::length<u16>(&arg10) == v0) {
                        0x1::vector::length<bool>(&arg11) == v0
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
        assert!(v1, 2);
        let v2 = if (arg6 >= arg7) {
            if (arg7 > 0) {
                arg12 < (10000 as u16)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 2);
        let v3 = 0x1::vector::empty<Rule>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = if (*0x1::vector::borrow<u128>(&arg8, v4) > 0) {
                if (*0x1::vector::borrow<u16>(&arg10, v4) > 0) {
                    (*0x1::vector::borrow<u16>(&arg10, v4) as u128) <= 10000
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v5, 2);
            let v6 = Rule{
                trigger_price  : *0x1::vector::borrow<u128>(&arg8, v4),
                above          : *0x1::vector::borrow<bool>(&arg9, v4),
                share_bps      : *0x1::vector::borrow<u16>(&arg10, v4),
                from_remaining : *0x1::vector::borrow<bool>(&arg11, v4),
                filled         : false,
                cancelled      : false,
            };
            0x1::vector::push_back<Rule>(&mut v3, v6);
            v4 = v4 + 1;
        };
        let v7 = 0x2::coin_registry::decimals<T0>(arg4);
        assert!(v7 <= 18, 2);
        let v8 = 0x1::type_name::with_defining_ids<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>();
        let v9 = 0x2::object::new(arg15);
        0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_placed(0x2::object::uid_to_inner(&v9), 0x2::tx_context::sender(arg15), v8, arg2, arg3, 0, arg6, arg7, arg8, arg9, arg10, arg11, 0, 0, 0, 0, arg12, v7, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x2::clock::timestamp_ms(arg14));
        let v10 = AutomationOrder<T0, T1>{
            id               : v9,
            owner            : 0x2::tx_context::sender(arg15),
            venue            : v8,
            venue_id         : arg2,
            curve_id         : arg3,
            kind             : 0,
            sui              : 0x2::balance::zero<0x2::sui::SUI>(),
            receipt          : 0x1::option::some<T1>(arg5),
            receipt_amount   : arg6,
            original_amount  : arg7,
            budget_remaining : arg7,
            rules            : v3,
            steps_left       : 0,
            interval_ms      : 0,
            next_at_ms       : 0,
            min_price        : 0,
            max_price        : 0,
            slippage_bps     : arg12,
            decimals         : v7,
            referrer         : arg13,
            closed           : false,
        };
        0x2::transfer::share_object<AutomationOrder<T0, T1>>(v10);
    }

    public fun receipt_amount<T0, T1: store + key>(arg0: &AutomationOrder<T0, T1>) : u64 {
        arg0.receipt_amount
    }

    public(friend) fun settle_dca_step<T0, T1: store + key>(arg0: &mut AutomationOrder<T0, T1>, arg1: StepTicket<T0>, arg2: T1, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (!arg0.closed) {
            if (0x2::object::uid_to_inner(&arg0.id) == arg1.order_id) {
                if (arg0.kind == 1) {
                    arg1.kind == 1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = if (arg3 > 0) {
            if (arg3 >= arg1.min_out) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 4);
        let v2 = execution_price(arg4, arg3, arg1.decimals);
        assert!(arg1.min_price == 0 || v2 >= arg1.min_price, 5);
        assert!(arg1.max_price == 0 || v2 <= arg1.max_price, 5);
        let v3 = arg1.order_id;
        let v4 = arg1.owner;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, arg5);
        0x2::transfer::public_transfer<T1>(arg2, v4);
        arg0.steps_left = arg0.steps_left - 1;
        arg0.next_at_ms = 0x2::clock::timestamp_ms(arg6) + arg0.interval_ms;
        if (arg0.steps_left == 0) {
            pay(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui), v4, arg7);
            arg0.closed = true;
            0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_closed(v3, v4, true, 0x2::clock::timestamp_ms(arg6));
        };
        0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_filled(v3, v4, arg1.cranker, arg1.kind, arg1.rule_index, arg1.input, arg3, v2, arg1.at_ms);
    }

    public(friend) fun settle_strategy_step<T0, T1: store + key>(arg0: &mut AutomationOrder<T0, T1>, arg1: StepTicket<T0>, arg2: T1, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (!arg0.closed) {
            if (0x2::object::uid_to_inner(&arg0.id) == arg1.order_id) {
                if (arg0.kind == 0) {
                    arg1.kind == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        assert!(arg3 == arg1.input && arg4 + arg3 == arg1.receipt_amount, 1);
        let v1 = execution_price(0x2::balance::value<0x2::sui::SUI>(&arg5), arg3, arg1.decimals);
        let v2 = 0x1::vector::borrow<Rule>(&arg1.rules, arg1.rule_index);
        assert!(v2.above && v1 >= v2.trigger_price || v1 <= v2.trigger_price, 5);
        let v3 = &mut arg5;
        take_fee(arg6, arg7, arg1.curve_id, v3, effective_referrer(arg8, arg1.owner, arg1.referrer));
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg5) >= after_fee_floor(arg1.min_out, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::fee_bps(arg6)), 4);
        let v4 = arg1.order_id;
        let v5 = arg1.owner;
        let v6 = arg1.budget_remaining;
        assert!(arg3 <= v6, 1);
        arg0.budget_remaining = v6 - arg3;
        let v7 = arg1.at_ms;
        if (keep_strategy_open(arg4, arg0.budget_remaining, has_open_rules(&arg0.rules))) {
            0x1::option::fill<T1>(&mut arg0.receipt, arg2);
            arg0.receipt_amount = arg4;
        } else {
            0x2::transfer::public_transfer<T1>(arg2, v5);
            arg0.receipt_amount = 0;
            arg0.closed = true;
            0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_closed(v4, v5, true, v7);
        };
        pay(arg5, v5, arg9);
        0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_filled(v4, v5, arg1.cranker, arg1.kind, arg1.rule_index, arg1.input, 0x2::balance::value<0x2::sui::SUI>(&arg5), v1, v7);
    }

    public fun steps_left<T0, T1: store + key>(arg0: &AutomationOrder<T0, T1>) : u64 {
        arg0.steps_left
    }

    fun take_fee(arg0: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg1: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg2: 0x2::object::ID, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x1::option::Option<address>) {
        let v0 = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::mul_bps(0x2::balance::value<0x2::sui::SUI>(arg3), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::fee_bps(arg0));
        if (v0 > 0) {
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::deposit_external(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(arg3, v0), arg4);
        };
    }

    public fun update_rule<T0, T1: store + key>(arg0: &mut AutomationOrder<T0, T1>, arg1: u64, arg2: u128, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = if (arg0.owner == 0x2::tx_context::sender(arg5)) {
            if (arg0.kind == 0) {
                if (arg1 < 0x1::vector::length<Rule>(&arg0.rules)) {
                    arg3 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        let v1 = 0x1::vector::borrow_mut<Rule>(&mut arg0.rules, arg1);
        let v2 = if (!v1.filled) {
            if (!v1.cancelled) {
                v1.trigger_price == arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
        v1.trigger_price = arg3;
        0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders::automation_rule_updated(0x2::object::uid_to_inner(&arg0.id), arg0.owner, arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public fun venue_id<T0, T1: store + key>(arg0: &AutomationOrder<T0, T1>) : 0x2::object::ID {
        arg0.venue_id
    }

    // decompiled from Move bytecode v7
}

