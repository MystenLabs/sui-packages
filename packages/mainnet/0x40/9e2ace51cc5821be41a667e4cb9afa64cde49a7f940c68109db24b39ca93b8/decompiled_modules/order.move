module 0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::order {
    struct ORDER has drop {
        dummy_field: bool,
    }

    struct IntegratorFeeConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct IntegratorFeeConfig has copy, drop, store {
        pos0: u16,
        pos1: address,
    }

    struct Order<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        user: address,
        recipient: address,
        balance: 0x2::balance::Balance<T0>,
        frequency_ms: u64,
        last_trade_timestamp_ms: u64,
        amount_per_trade: u64,
        max_allowable_slippage_bps: u16,
        min_amount_out: u64,
        max_amount_out: u64,
        remaining_trades: u8,
        gas: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct OrderCap<phantom T0> {
        min_amount_out: u64,
    }

    fun transfer<T0, T1>(arg0: Order<T0, T1>, arg1: &0x85cfb414c8248aac148b649c9dd5e09dd266057a0b5a57c698f58dfe49917889::config::Config, arg2: vector<u8>) {
        0x2::transfer::transfer<Order<T0, T1>>(arg0, 0x85cfb414c8248aac148b649c9dd5e09dd266057a0b5a57c698f58dfe49917889::config::derive_multisig_address(arg1, arg2));
    }

    fun assert_acceptable_slippage<T0>(arg0: &OrderCap<T0>, arg1: u64) {
        assert!(arg0.min_amount_out <= arg1, 9223375133526196225);
    }

    fun assert_coin_has_non_zero_value<T0>(arg0: &0x2::coin::Coin<T0>) {
        assert!(0 < 0x2::coin::value<T0>(arg0), 9223375099166588931);
    }

    fun assert_coin_types_differ_for_self_transfer<T0, T1>(arg0: address, arg1: address) {
        if (arg0 == arg1) {
            assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 9223375189361295369);
        };
    }

    fun assert_order_has_remaining_trades<T0, T1>(arg0: &Order<T0, T1>) {
        assert!(arg0.remaining_trades > 0, 9223375116346720263);
    }

    fun assert_trade_resulted_in_price_above_min_amount_out<T0, T1>(arg0: &Order<T0, T1>, arg1: u64) {
        assert!(arg0.min_amount_out <= arg1, 9223375150706327557);
    }

    fun assert_trade_resulted_in_price_below_max_amount_out<T0, T1>(arg0: &Order<T0, T1>, arg1: u64) {
        assert!(arg1 <= arg0.max_amount_out, 9223375167886196741);
    }

    public fun begin_tx<T0, T1>(arg0: &mut Order<T0, T1>, arg1: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::Config, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (OrderCap<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::assert_interacting_with_most_up_to_date_package(arg1);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::assert_enough_time_has_passed_since_last_trade(arg1, arg0.last_trade_timestamp_ms, arg0.frequency_ms, arg2);
        assert_order_has_remaining_trades<T0, T1>(arg0);
        arg0.last_trade_timestamp_ms = arg0.last_trade_timestamp_ms + arg0.frequency_ms;
        let v0 = OrderCap<T1>{min_amount_out: arg3};
        let v1 = if (arg0.remaining_trades == 1) {
            0x2::balance::value<T0>(&arg0.balance)
        } else {
            arg0.amount_per_trade
        };
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg5);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::take_protocol_fee<T0>(arg1, &mut v2, arg5);
        let v3 = &mut v2;
        take_integrator_fee<T0, T1>(arg0, v3, arg5);
        (v0, v2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas, arg4), arg5))
    }

    public fun close_order<T0, T1>(arg0: Order<T0, T1>, arg1: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::assert_interacting_with_most_up_to_date_package(arg1);
        let Order {
            id                         : v0,
            user                       : v1,
            recipient                  : v2,
            balance                    : v3,
            frequency_ms               : v4,
            last_trade_timestamp_ms    : v5,
            amount_per_trade           : v6,
            max_allowable_slippage_bps : v7,
            min_amount_out             : v8,
            max_amount_out             : v9,
            remaining_trades           : v10,
            gas                        : v11,
        } = arg0;
        let v12 = v11;
        let v13 = v3;
        0x2::object::delete(v0);
        transfer_or_destroy_zero<T0>(v13, v1, arg2);
        transfer_or_destroy_zero<0x2::sui::SUI>(v12, v1, arg2);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::events::emit_closed_order_event<T0, T1>(0x2::object::id<Order<T0, T1>>(&arg0), v1, v2, 0x2::balance::value<T0>(&v13), 0x2::balance::value<0x2::sui::SUI>(&v12), v4, v5, v6, v7, v8, v9, v10);
    }

    public fun create_order<T0, T1>(arg0: &0x85cfb414c8248aac148b649c9dd5e09dd266057a0b5a57c698f58dfe49917889::config::Config, arg1: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: vector<u8>, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u16, arg11: u64, arg12: u64, arg13: u8, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::assert_interacting_with_most_up_to_date_package(arg1);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::assert_enough_gas_was_provided_to_cover_all_trades(arg1, &arg3, arg13);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::assert_trading_frequency_is_above_minimum_frequency(arg1, arg7);
        assert_coin_has_non_zero_value<T0>(&arg2);
        assert_coin_types_differ_for_self_transfer<T0, T1>(0x2::tx_context::sender(arg14), arg6);
        0x85cfb414c8248aac148b649c9dd5e09dd266057a0b5a57c698f58dfe49917889::config::assert_public_key_corresponds_to_tx_sender(&arg5, v0);
        let v1 = 0x2::clock::timestamp_ms(arg4) + arg8;
        let v2 = Order<T0, T1>{
            id                         : 0x2::object::new(arg14),
            user                       : v0,
            recipient                  : arg6,
            balance                    : 0x2::coin::into_balance<T0>(arg2),
            frequency_ms               : arg7,
            last_trade_timestamp_ms    : v1 - arg7,
            amount_per_trade           : arg9,
            max_allowable_slippage_bps : arg10,
            min_amount_out             : arg11,
            max_amount_out             : arg12,
            remaining_trades           : arg13,
            gas                        : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
        };
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::events::emit_created_order_event<T0, T1>(0x2::object::id<Order<T0, T1>>(&v2), v2.user, v2.recipient, arg5, 0x2::balance::value<T0>(&v2.balance), 0x2::balance::value<0x2::sui::SUI>(&v2.gas), v2.frequency_ms, v1, v2.amount_per_trade, v2.max_allowable_slippage_bps, v2.min_amount_out, v2.max_amount_out, v2.remaining_trades, 0, @0x0);
        transfer<T0, T1>(v2, arg0, arg5);
    }

    public fun create_order_with_fee<T0, T1>(arg0: &0x85cfb414c8248aac148b649c9dd5e09dd266057a0b5a57c698f58dfe49917889::config::Config, arg1: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: vector<u8>, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u16, arg11: u64, arg12: u64, arg13: u8, arg14: u16, arg15: address, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::assert_interacting_with_most_up_to_date_package(arg1);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::assert_enough_gas_was_provided_to_cover_all_trades(arg1, &arg3, arg13);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::assert_trading_frequency_is_above_minimum_frequency(arg1, arg7);
        assert_coin_has_non_zero_value<T0>(&arg2);
        assert_coin_types_differ_for_self_transfer<T0, T1>(0x2::tx_context::sender(arg16), arg6);
        0x85cfb414c8248aac148b649c9dd5e09dd266057a0b5a57c698f58dfe49917889::config::assert_public_key_corresponds_to_tx_sender(&arg5, v0);
        let v1 = 0x2::clock::timestamp_ms(arg4) + arg8;
        let v2 = Order<T0, T1>{
            id                         : 0x2::object::new(arg16),
            user                       : v0,
            recipient                  : arg6,
            balance                    : 0x2::coin::into_balance<T0>(arg2),
            frequency_ms               : arg7,
            last_trade_timestamp_ms    : v1 - arg7,
            amount_per_trade           : arg9,
            max_allowable_slippage_bps : arg10,
            min_amount_out             : arg11,
            max_amount_out             : arg12,
            remaining_trades           : arg13,
            gas                        : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
        };
        let v3 = IntegratorFeeConfigKey{dummy_field: false};
        let v4 = IntegratorFeeConfig{
            pos0 : arg14,
            pos1 : arg15,
        };
        0x2::dynamic_field::add<IntegratorFeeConfigKey, IntegratorFeeConfig>(&mut v2.id, v3, v4);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::events::emit_created_order_event<T0, T1>(0x2::object::id<Order<T0, T1>>(&v2), v2.user, v2.recipient, arg5, 0x2::balance::value<T0>(&v2.balance), 0x2::balance::value<0x2::sui::SUI>(&v2.gas), v2.frequency_ms, v1, v2.amount_per_trade, v2.max_allowable_slippage_bps, v2.min_amount_out, v2.max_amount_out, v2.remaining_trades, arg14, arg15);
        transfer<T0, T1>(v2, arg0, arg5);
    }

    public fun finish_tx<T0, T1>(arg0: &mut Order<T0, T1>, arg1: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::Config, arg2: OrderCap<T1>, arg3: 0x2::coin::Coin<T1>) {
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::assert_interacting_with_most_up_to_date_package(arg1);
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert_acceptable_slippage<T1>(&arg2, v0);
        assert_trade_resulted_in_price_above_min_amount_out<T0, T1>(arg0, v0);
        assert_trade_resulted_in_price_below_max_amount_out<T0, T1>(arg0, v0);
        let OrderCap {  } = arg2;
        arg0.remaining_trades = arg0.remaining_trades - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg0.recipient);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::events::emit_executed_trade_event<T0, T1>(0x2::object::id<Order<T0, T1>>(arg0), arg0.user, arg0.recipient, arg0.amount_per_trade, v0);
    }

    fun init(arg0: ORDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config::create_config<ORDER>(&arg0, arg1);
        0x2::transfer::public_transfer<0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::admin::AdminCap>(0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::admin::create_admin_cap<ORDER>(&arg0, arg1), v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ORDER>(arg0, arg1), v0);
    }

    fun integrator_fee_config<T0, T1>(arg0: &Order<T0, T1>) : IntegratorFeeConfig {
        let v0 = IntegratorFeeConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<IntegratorFeeConfigKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<IntegratorFeeConfigKey, IntegratorFeeConfig>(&arg0.id, v0)
        } else {
            IntegratorFeeConfig{pos0: 0, pos1: @0x0}
        }
    }

    fun must_pay_integrator_fee<T0, T1>(arg0: &Order<T0, T1>) : bool {
        let v0 = IntegratorFeeConfigKey{dummy_field: false};
        0x2::dynamic_field::exists_<IntegratorFeeConfigKey>(&arg0.id, v0)
    }

    fun take_integrator_fee<T0, T1>(arg0: &Order<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!must_pay_integrator_fee<T0, T1>(arg0)) {
            return
        };
        let v0 = integrator_fee_config<T0, T1>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, (((0x2::coin::value<T0>(arg1) as u128) * (v0.pos0 as u128) / 10000) as u64), arg2), v0.pos1);
    }

    fun transfer_or_destroy_zero<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

