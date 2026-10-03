module 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::venue_orders {
    struct ReceiptOrder<phantom T0, T1: store + key> has key {
        id: 0x2::object::UID,
        owner: address,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        is_buy: bool,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        receipt: 0x1::option::Option<T1>,
        receipt_amount: u64,
        sell_amount: u64,
        trigger_price: u128,
        above: bool,
        min_out: u64,
        referrer: 0x1::option::Option<address>,
        expires_at_ms: u64,
        decimals: u8,
    }

    struct FillTicket<phantom T0> {
        order_id: 0x2::object::ID,
        owner: address,
        cranker: address,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        is_buy: bool,
        amount_in: u64,
        trigger_price: u128,
        above: bool,
        min_out: u64,
        fee_paid: u64,
        referrer: 0x1::option::Option<address>,
        decimals: u8,
        at_ms: u64,
    }

    struct VenueOrderPlaced has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        is_buy: bool,
        amount: u64,
        trigger_price: u128,
        above: bool,
        escrowed: u64,
        min_out: u64,
        referrer: 0x1::option::Option<address>,
        expires_at_ms: u64,
        decimals: u8,
        coin_type: 0x1::type_name::TypeName,
        receipt_type: 0x1::type_name::TypeName,
        at_ms: u64,
    }

    struct VenueOrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        cranker: address,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        is_buy: bool,
        input: u64,
        received: u64,
        gross_received: u64,
        fee_paid: u64,
        price_scaled: u128,
        at_ms: u64,
    }

    struct VenueOrderClosed has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        venue_id: 0x2::object::ID,
        expired: bool,
        completed: bool,
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
        allocated_amount: u64,
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
        coin_type: 0x1::type_name::TypeName,
        receipt_type: 0x1::type_name::TypeName,
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
        completed: bool,
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

    public fun decimals<T0, T1: store + key>(arg0: &ReceiptOrder<T0, T1>) : u8 {
        arg0.decimals
    }

    public fun above<T0, T1: store + key>(arg0: &ReceiptOrder<T0, T1>) : bool {
        arg0.above
    }

    fun assert_net_minimum(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 5);
    }

    fun assert_selected_within_escrowed(arg0: u64, arg1: u64) {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg1 <= arg0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
    }

    fun assert_supported_decimals(arg0: u8) {
        assert!(arg0 <= 18, 8);
    }

    public(friend) fun automation_closed(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64) {
        let v0 = AutomationClosed{
            order_id  : arg0,
            owner     : arg1,
            completed : arg2,
            at_ms     : arg3,
        };
        0x2::event::emit<AutomationClosed>(v0);
    }

    public(friend) fun automation_filled(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u64) {
        let v0 = AutomationFilled{
            order_id     : arg0,
            owner        : arg1,
            cranker      : arg2,
            kind         : arg3,
            rule_index   : arg4,
            input        : arg5,
            received     : arg6,
            price_scaled : arg7,
            at_ms        : arg8,
        };
        0x2::event::emit<AutomationFilled>(v0);
    }

    public(friend) fun automation_placed(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u8, arg6: u64, arg7: u64, arg8: vector<u128>, arg9: vector<bool>, arg10: vector<u16>, arg11: vector<bool>, arg12: u64, arg13: u64, arg14: u128, arg15: u128, arg16: u16, arg17: u8, arg18: 0x1::type_name::TypeName, arg19: 0x1::type_name::TypeName, arg20: u64) {
        let v0 = AutomationPlaced{
            order_id         : arg0,
            owner            : arg1,
            venue            : arg2,
            venue_id         : arg3,
            curve_id         : arg4,
            kind             : arg5,
            amount           : arg6,
            allocated_amount : arg7,
            trigger_prices   : arg8,
            above            : arg9,
            share_bps        : arg10,
            from_remaining   : arg11,
            steps            : arg12,
            interval_ms      : arg13,
            min_price        : arg14,
            max_price        : arg15,
            slippage_bps     : arg16,
            decimals         : arg17,
            coin_type        : arg18,
            receipt_type     : arg19,
            at_ms            : arg20,
        };
        0x2::event::emit<AutomationPlaced>(v0);
    }

    public(friend) fun automation_rule_cancelled(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = AutomationRuleCancelled{
            order_id   : arg0,
            owner      : arg1,
            rule_index : arg2,
            at_ms      : arg3,
        };
        0x2::event::emit<AutomationRuleCancelled>(v0);
    }

    public(friend) fun automation_rule_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u128, arg4: u128, arg5: u64) {
        let v0 = AutomationRuleUpdated{
            order_id       : arg0,
            owner          : arg1,
            rule_index     : arg2,
            previous_price : arg3,
            trigger_price  : arg4,
            at_ms          : arg5,
        };
        0x2::event::emit<AutomationRuleUpdated>(v0);
    }

    public(friend) fun begin_buy<T0, T1: store + key>(arg0: ReceiptOrder<T0, T1>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg3: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg4: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: u128, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, FillTicket<T0>) {
        assert!(arg0.is_buy && arg0.venue == 0x1::type_name::with_defining_ids<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(), 1);
        assert!(arg0.venue_id == arg6, 0);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.expires_at_ms == 0 || v0 < arg0.expires_at_ms, 3);
        assert!(ready(arg0.above, arg0.trigger_price, arg7), 7);
        let ReceiptOrder {
            id             : v1,
            owner          : v2,
            venue          : v3,
            venue_id       : v4,
            curve_id       : v5,
            is_buy         : _,
            sui            : v7,
            receipt        : v8,
            receipt_amount : _,
            sell_amount    : _,
            trigger_price  : v11,
            above          : v12,
            min_out        : v13,
            referrer       : v14,
            expires_at_ms  : _,
            decimals       : v16,
        } = arg0;
        let v17 = v8;
        let v18 = v7;
        let v19 = v1;
        assert!(0x1::option::is_none<T1>(&v17), 1);
        0x1::option::destroy_none<T1>(v17);
        0x2::object::delete(v19);
        let v20 = effective_referrer(arg4, v2, v14);
        let v21 = 0x2::balance::value<0x2::sui::SUI>(&v18);
        let v22 = &mut v18;
        take_fee(arg2, arg3, v5, v22, v20);
        let v23 = FillTicket<T0>{
            order_id      : 0x2::object::uid_to_inner(&v19),
            owner         : v2,
            cranker       : 0x2::tx_context::sender(arg8),
            venue         : v3,
            venue_id      : v4,
            curve_id      : v5,
            is_buy        : true,
            amount_in     : v21,
            trigger_price : v11,
            above         : v12,
            min_out       : v13,
            fee_paid      : v21 - 0x2::balance::value<0x2::sui::SUI>(&v18),
            referrer      : v20,
            decimals      : v16,
            at_ms         : v0,
        };
        (v18, v23)
    }

    public(friend) fun begin_sell<T0, T1: store + key>(arg0: ReceiptOrder<T0, T1>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: u128, arg5: &0x2::tx_context::TxContext) : (T1, FillTicket<T0>) {
        assert!(!arg0.is_buy && arg0.venue == 0x1::type_name::with_defining_ids<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(), 1);
        assert!(arg0.venue_id == arg3, 0);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.expires_at_ms == 0 || v0 < arg0.expires_at_ms, 3);
        assert!(ready(arg0.above, arg0.trigger_price, arg4), 7);
        let ReceiptOrder {
            id             : v1,
            owner          : v2,
            venue          : v3,
            venue_id       : v4,
            curve_id       : v5,
            is_buy         : _,
            sui            : v7,
            receipt        : v8,
            receipt_amount : v9,
            sell_amount    : v10,
            trigger_price  : v11,
            above          : v12,
            min_out        : v13,
            referrer       : v14,
            expires_at_ms  : _,
            decimals       : v16,
        } = arg0;
        let v17 = v8;
        let v18 = v1;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v7);
        assert!(0x1::option::is_some<T1>(&v17), 1);
        assert_selected_within_escrowed(v9, v10);
        0x1::option::destroy_none<T1>(v17);
        0x2::object::delete(v18);
        let v19 = FillTicket<T0>{
            order_id      : 0x2::object::uid_to_inner(&v18),
            owner         : v2,
            cranker       : 0x2::tx_context::sender(arg5),
            venue         : v3,
            venue_id      : v4,
            curve_id      : v5,
            is_buy        : false,
            amount_in     : v10,
            trigger_price : v11,
            above         : v12,
            min_out       : v13,
            fee_paid      : 0,
            referrer      : v14,
            decimals      : v16,
            at_ms         : v0,
        };
        (0x1::option::extract<T1>(&mut v17), v19)
    }

    public fun cancel<T0, T1: store + key>(arg0: ReceiptOrder<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        refund<T0, T1>(arg0, false, arg1, arg2);
    }

    public fun curve_id<T0, T1: store + key>(arg0: &ReceiptOrder<T0, T1>) : 0x2::object::ID {
        arg0.curve_id
    }

    fun effective_referrer(arg0: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg1: address, arg2: 0x1::option::Option<address>) : 0x1::option::Option<address> {
        if (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::has_referrer(arg0, arg1)) {
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::referrer_of(arg0, arg1)
        } else {
            arg2
        }
    }

    public fun execution_price(arg0: u64, arg1: u64, arg2: u8) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 4);
        assert_supported_decimals(arg2);
        (arg0 as u128) * 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::pow10(arg2) * 1000000000000 / (arg1 as u128)
    }

    public fun is_buy<T0, T1: store + key>(arg0: &ReceiptOrder<T0, T1>) : bool {
        arg0.is_buy
    }

    public fun min_out<T0, T1: store + key>(arg0: &ReceiptOrder<T0, T1>) : u64 {
        arg0.min_out
    }

    public fun owner<T0, T1: store + key>(arg0: &ReceiptOrder<T0, T1>) : address {
        arg0.owner
    }

    fun pay(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg0);
        };
    }

    public fun place_buy<T0, T1: store + key>(arg0: 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v0 > 0 && arg6 > 0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg11);
        assert!(arg10 == 0 || arg10 > v1, 3);
        let v2 = 0x1::type_name::with_defining_ids<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>();
        let v3 = 0x2::object::new(arg12);
        let v4 = 0x2::coin::get_decimals<T0>(arg4);
        assert_supported_decimals(v4);
        let v5 = VenueOrderPlaced{
            order_id      : 0x2::object::uid_to_inner(&v3),
            owner         : 0x2::tx_context::sender(arg12),
            venue         : v2,
            venue_id      : arg2,
            curve_id      : arg3,
            is_buy        : true,
            amount        : v0,
            trigger_price : arg6,
            above         : arg7,
            escrowed      : v0,
            min_out       : arg8,
            referrer      : arg9,
            expires_at_ms : arg10,
            decimals      : v4,
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            receipt_type  : 0x1::type_name::with_defining_ids<T1>(),
            at_ms         : v1,
        };
        0x2::event::emit<VenueOrderPlaced>(v5);
        let v6 = ReceiptOrder<T0, T1>{
            id             : v3,
            owner          : 0x2::tx_context::sender(arg12),
            venue          : v2,
            venue_id       : arg2,
            curve_id       : arg3,
            is_buy         : true,
            sui            : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            receipt        : 0x1::option::none<T1>(),
            receipt_amount : 0,
            sell_amount    : 0,
            trigger_price  : arg6,
            above          : arg7,
            min_out        : arg8,
            referrer       : arg9,
            expires_at_ms  : arg10,
            decimals       : v4,
        };
        0x2::transfer::share_object<ReceiptOrder<T0, T1>>(v6);
    }

    public fun place_buy_currency<T0, T1: store + key>(arg0: 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v0 > 0 && arg6 > 0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg11);
        assert!(arg10 == 0 || arg10 > v1, 3);
        let v2 = 0x1::type_name::with_defining_ids<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>();
        let v3 = 0x2::object::new(arg12);
        let v4 = 0x2::coin_registry::decimals<T0>(arg4);
        assert_supported_decimals(v4);
        let v5 = VenueOrderPlaced{
            order_id      : 0x2::object::uid_to_inner(&v3),
            owner         : 0x2::tx_context::sender(arg12),
            venue         : v2,
            venue_id      : arg2,
            curve_id      : arg3,
            is_buy        : true,
            amount        : v0,
            trigger_price : arg6,
            above         : arg7,
            escrowed      : v0,
            min_out       : arg8,
            referrer      : arg9,
            expires_at_ms : arg10,
            decimals      : v4,
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            receipt_type  : 0x1::type_name::with_defining_ids<T1>(),
            at_ms         : v1,
        };
        0x2::event::emit<VenueOrderPlaced>(v5);
        let v6 = ReceiptOrder<T0, T1>{
            id             : v3,
            owner          : 0x2::tx_context::sender(arg12),
            venue          : v2,
            venue_id       : arg2,
            curve_id       : arg3,
            is_buy         : true,
            sui            : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            receipt        : 0x1::option::none<T1>(),
            receipt_amount : 0,
            sell_amount    : 0,
            trigger_price  : arg6,
            above          : arg7,
            min_out        : arg8,
            referrer       : arg9,
            expires_at_ms  : arg10,
            decimals       : v4,
        };
        0x2::transfer::share_object<ReceiptOrder<T0, T1>>(v6);
    }

    public fun place_sell<T0, T1: store + key>(arg0: 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: T1, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: u64, arg11: 0x1::option::Option<address>, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        assert_selected_within_escrowed(arg6, arg7);
        assert!(arg8 > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        assert!(arg12 == 0 || arg12 > v0, 3);
        let v1 = 0x1::type_name::with_defining_ids<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>();
        let v2 = 0x2::object::new(arg14);
        let v3 = 0x2::coin::get_decimals<T0>(arg4);
        assert_supported_decimals(v3);
        let v4 = VenueOrderPlaced{
            order_id      : 0x2::object::uid_to_inner(&v2),
            owner         : 0x2::tx_context::sender(arg14),
            venue         : v1,
            venue_id      : arg2,
            curve_id      : arg3,
            is_buy        : false,
            amount        : arg7,
            trigger_price : arg8,
            above         : arg9,
            escrowed      : arg6,
            min_out       : arg10,
            referrer      : arg11,
            expires_at_ms : arg12,
            decimals      : v3,
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            receipt_type  : 0x1::type_name::with_defining_ids<T1>(),
            at_ms         : v0,
        };
        0x2::event::emit<VenueOrderPlaced>(v4);
        let v5 = ReceiptOrder<T0, T1>{
            id             : v2,
            owner          : 0x2::tx_context::sender(arg14),
            venue          : v1,
            venue_id       : arg2,
            curve_id       : arg3,
            is_buy         : false,
            sui            : 0x2::balance::zero<0x2::sui::SUI>(),
            receipt        : 0x1::option::some<T1>(arg5),
            receipt_amount : arg6,
            sell_amount    : arg7,
            trigger_price  : arg8,
            above          : arg9,
            min_out        : arg10,
            referrer       : arg11,
            expires_at_ms  : arg12,
            decimals       : v3,
        };
        0x2::transfer::share_object<ReceiptOrder<T0, T1>>(v5);
    }

    public fun place_sell_currency<T0, T1: store + key>(arg0: 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: T1, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: u64, arg11: 0x1::option::Option<address>, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>(arg1), 0);
        assert_selected_within_escrowed(arg6, arg7);
        assert!(arg8 > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        assert!(arg12 == 0 || arg12 > v0, 3);
        let v1 = 0x1::type_name::with_defining_ids<0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad::PerpsVenue>();
        let v2 = 0x2::object::new(arg14);
        let v3 = 0x2::coin_registry::decimals<T0>(arg4);
        assert_supported_decimals(v3);
        let v4 = VenueOrderPlaced{
            order_id      : 0x2::object::uid_to_inner(&v2),
            owner         : 0x2::tx_context::sender(arg14),
            venue         : v1,
            venue_id      : arg2,
            curve_id      : arg3,
            is_buy        : false,
            amount        : arg7,
            trigger_price : arg8,
            above         : arg9,
            escrowed      : arg6,
            min_out       : arg10,
            referrer      : arg11,
            expires_at_ms : arg12,
            decimals      : v3,
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            receipt_type  : 0x1::type_name::with_defining_ids<T1>(),
            at_ms         : v0,
        };
        0x2::event::emit<VenueOrderPlaced>(v4);
        let v5 = ReceiptOrder<T0, T1>{
            id             : v2,
            owner          : 0x2::tx_context::sender(arg14),
            venue          : v1,
            venue_id       : arg2,
            curve_id       : arg3,
            is_buy         : false,
            sui            : 0x2::balance::zero<0x2::sui::SUI>(),
            receipt        : 0x1::option::some<T1>(arg5),
            receipt_amount : arg6,
            sell_amount    : arg7,
            trigger_price  : arg8,
            above          : arg9,
            min_out        : arg10,
            referrer       : arg11,
            expires_at_ms  : arg12,
            decimals       : v3,
        };
        0x2::transfer::share_object<ReceiptOrder<T0, T1>>(v5);
    }

    public fun ready(arg0: bool, arg1: u128, arg2: u128) : bool {
        arg0 && arg2 >= arg1 || arg2 <= arg1
    }

    public fun receipt_amount<T0, T1: store + key>(arg0: &ReceiptOrder<T0, T1>) : u64 {
        arg0.receipt_amount
    }

    public fun reclaim_expired<T0, T1: store + key>(arg0: ReceiptOrder<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.expires_at_ms != 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.expires_at_ms, 3);
        refund<T0, T1>(arg0, true, arg1, arg2);
    }

    fun refund<T0, T1: store + key>(arg0: ReceiptOrder<T0, T1>, arg1: bool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let ReceiptOrder {
            id             : v0,
            owner          : v1,
            venue          : _,
            venue_id       : v3,
            curve_id       : _,
            is_buy         : _,
            sui            : v6,
            receipt        : v7,
            receipt_amount : _,
            sell_amount    : _,
            trigger_price  : _,
            above          : _,
            min_out        : _,
            referrer       : _,
            expires_at_ms  : _,
            decimals       : _,
        } = arg0;
        let v16 = v7;
        let v17 = v0;
        0x2::object::delete(v17);
        pay(v6, v1, arg3);
        if (0x1::option::is_some<T1>(&v16)) {
            0x1::option::destroy_none<T1>(v16);
            0x2::transfer::public_transfer<T1>(0x1::option::extract<T1>(&mut v16), v1);
        } else {
            0x1::option::destroy_none<T1>(v16);
        };
        let v18 = VenueOrderClosed{
            order_id  : 0x2::object::uid_to_inner(&v17),
            owner     : v1,
            venue_id  : v3,
            expired   : arg1,
            completed : false,
            at_ms     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VenueOrderClosed>(v18);
    }

    public fun sell_amount<T0, T1: store + key>(arg0: &ReceiptOrder<T0, T1>) : u64 {
        arg0.sell_amount
    }

    public(friend) fun settle_buy<T0, T1: store + key>(arg0: FillTicket<T0>, arg1: T1, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.is_buy) {
            if (arg2 >= arg0.min_out) {
                if (arg2 > 0) {
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
        assert!(v0, 5);
        let v1 = execution_price(arg3, arg2, arg0.decimals);
        assert!(ready(arg0.above, arg0.trigger_price, v1), 6);
        let FillTicket {
            order_id      : v2,
            owner         : v3,
            cranker       : v4,
            venue         : v5,
            venue_id      : v6,
            curve_id      : v7,
            is_buy        : v8,
            amount_in     : _,
            trigger_price : _,
            above         : _,
            min_out       : _,
            fee_paid      : v13,
            referrer      : _,
            decimals      : _,
            at_ms         : v16,
        } = arg0;
        pay(arg4, v3, arg5);
        0x2::transfer::public_transfer<T1>(arg1, v3);
        let v17 = VenueOrderFilled{
            order_id       : v2,
            owner          : v3,
            cranker        : v4,
            venue          : v5,
            venue_id       : v6,
            curve_id       : v7,
            is_buy         : v8,
            input          : arg3 + v13,
            received       : arg2,
            gross_received : arg2,
            fee_paid       : v13,
            price_scaled   : v1,
            at_ms          : v16,
        };
        0x2::event::emit<VenueOrderFilled>(v17);
    }

    public(friend) fun settle_sell<T0>(arg0: FillTicket<T0>, arg1: u64, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg4: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (!arg0.is_buy) {
            if (arg1 > 0) {
                if (arg1 == arg0.amount_in) {
                    0x2::balance::value<0x2::sui::SUI>(&arg2) > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = execution_price(0x2::balance::value<0x2::sui::SUI>(&arg2), arg1, arg0.decimals);
        assert!(ready(arg0.above, arg0.trigger_price, v1), 6);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v3 = &mut arg2;
        take_fee(arg3, arg4, arg0.curve_id, v3, effective_referrer(arg5, arg0.owner, arg0.referrer));
        assert_net_minimum(0x2::balance::value<0x2::sui::SUI>(&arg2), arg0.min_out);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let FillTicket {
            order_id      : v5,
            owner         : v6,
            cranker       : v7,
            venue         : v8,
            venue_id      : v9,
            curve_id      : v10,
            is_buy        : _,
            amount_in     : _,
            trigger_price : _,
            above         : _,
            min_out       : _,
            fee_paid      : _,
            referrer      : _,
            decimals      : _,
            at_ms         : v19,
        } = arg0;
        pay(arg2, v6, arg6);
        let v20 = VenueOrderFilled{
            order_id       : v5,
            owner          : v6,
            cranker        : v7,
            venue          : v8,
            venue_id       : v9,
            curve_id       : v10,
            is_buy         : false,
            input          : arg1,
            received       : v4,
            gross_received : v2,
            fee_paid       : v2 - v4,
            price_scaled   : v1,
            at_ms          : v19,
        };
        0x2::event::emit<VenueOrderFilled>(v20);
    }

    fun take_fee(arg0: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg1: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg2: 0x2::object::ID, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x1::option::Option<address>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(arg3);
        assert!(v0 > 0, 4);
        let v1 = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::mul_bps(v0, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::fee_bps(arg0));
        if (v1 > 0) {
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::deposit_external(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(arg3, v1), arg4);
        };
    }

    public(friend) fun ticket_amount<T0>(arg0: &FillTicket<T0>) : u64 {
        arg0.amount_in
    }

    public(friend) fun ticket_min_out<T0>(arg0: &FillTicket<T0>) : u64 {
        arg0.min_out
    }

    public fun trigger_price<T0, T1: store + key>(arg0: &ReceiptOrder<T0, T1>) : u128 {
        arg0.trigger_price
    }

    public fun venue_id<T0, T1: store + key>(arg0: &ReceiptOrder<T0, T1>) : 0x2::object::ID {
        arg0.venue_id
    }

    // decompiled from Move bytecode v7
}

