module 0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::dca {
    struct DCA has drop {
        dummy_field: bool,
    }

    struct Order<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        user: address,
        recipient: address,
        remaining_balance: 0x2::balance::Balance<T0>,
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
        min_slippage_amount_out: u64,
    }

    fun transfer<T0, T1>(arg0: Order<T0, T1>, arg1: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::Config, arg2: vector<u8>) {
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_interacting_with_most_up_to_date_package(arg1);
        0x2::transfer::transfer<Order<T0, T1>>(arg0, 0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::derive_multisig_address(arg1, arg2));
    }

    fun assert_acceptable_slippage<T0>(arg0: &OrderCap<T0>, arg1: u64) {
        assert!(arg0.min_slippage_amount_out <= arg1, 0);
    }

    fun assert_order_has_remaining_trades<T0, T1>(arg0: &Order<T0, T1>) {
        assert!(arg0.remaining_trades > 0, 2);
    }

    fun assert_trade_resulted_in_price_above_min_amount_out<T0, T1>(arg0: &Order<T0, T1>, arg1: u64) {
        assert!(arg0.min_amount_out <= arg1, 1);
    }

    fun assert_trade_resulted_in_price_below_max_amount_out<T0, T1>(arg0: &Order<T0, T1>, arg1: u64) {
        assert!(arg1 <= arg0.max_amount_out, 1);
    }

    public fun begin_dca_tx<T0, T1>(arg0: &mut Order<T0, T1>, arg1: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::Config, arg2: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::treasury::Treasury, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (OrderCap<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_interacting_with_most_up_to_date_package(arg1);
        assert_order_has_remaining_trades<T0, T1>(arg0);
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_enough_time_has_passed_since_last_trade(arg1, arg0.last_trade_timestamp_ms, arg0.frequency_ms, arg3);
        let v0 = OrderCap<T1>{min_slippage_amount_out: arg4};
        let v1 = if (arg0.remaining_trades == 1) {
            0x2::balance::value<T0>(&arg0.remaining_balance)
        } else {
            arg0.amount_per_trade
        };
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.remaining_balance, v1), arg6);
        let v3 = &mut v2;
        take_protocol_fee<T0>(arg1, arg2, v3, arg6);
        (v0, v2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas, arg5), arg6))
    }

    public fun close_order<T0, T1>(arg0: Order<T0, T1>, arg1: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_interacting_with_most_up_to_date_package(arg1);
        let Order {
            id                         : v0,
            user                       : v1,
            recipient                  : v2,
            remaining_balance          : v3,
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
        transfer_or_destroy_zero<T0>(0x2::coin::from_balance<T0>(v13, arg2), v1);
        transfer_or_destroy_zero<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v12, arg2), v1);
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::events::emit_closed_order_event<T0, T1>(0x2::object::id<Order<T0, T1>>(&arg0), v1, v2, 0x2::balance::value<T0>(&v13), 0x2::balance::value<0x2::sui::SUI>(&v12), v4, v5, v6, v7, v8, v9, v10);
    }

    public fun create_order<T0, T1>(arg0: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u16, arg10: u64, arg11: u64, arg12: u8, arg13: &mut 0x2::tx_context::TxContext) {
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_interacting_with_most_up_to_date_package(arg0);
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_public_key_corresponds_to_tx_sender(&arg4, 0x2::tx_context::sender(arg13));
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_trading_frequency_is_above_minimum_frequency(arg0, arg6);
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_enough_gas_was_provided_to_cover_all_trades(arg0, &arg2, arg12);
        let v0 = Order<T0, T1>{
            id                         : 0x2::object::new(arg13),
            user                       : 0x2::tx_context::sender(arg13),
            recipient                  : arg5,
            remaining_balance          : 0x2::coin::into_balance<T0>(arg1),
            frequency_ms               : arg6,
            last_trade_timestamp_ms    : 0x2::clock::timestamp_ms(arg3) + arg7,
            amount_per_trade           : arg8,
            max_allowable_slippage_bps : arg9,
            min_amount_out             : arg10,
            max_amount_out             : arg11,
            remaining_trades           : arg12,
            gas                        : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
        };
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::events::emit_created_order_event<T0, T1>(0x2::object::id<Order<T0, T1>>(&v0), v0.user, v0.recipient, arg4, 0x2::balance::value<T0>(&v0.remaining_balance), 0x2::balance::value<0x2::sui::SUI>(&v0.gas), v0.frequency_ms, v0.last_trade_timestamp_ms, v0.amount_per_trade, v0.max_allowable_slippage_bps, v0.min_amount_out, v0.max_amount_out, v0.remaining_trades);
        transfer<T0, T1>(v0, arg0, arg4);
    }

    public fun finish_dca_tx<T0, T1>(arg0: &mut Order<T0, T1>, arg1: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::Config, arg2: OrderCap<T1>, arg3: 0x2::coin::Coin<T1>) {
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_interacting_with_most_up_to_date_package(arg1);
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert_acceptable_slippage<T1>(&arg2, v0);
        assert_trade_resulted_in_price_above_min_amount_out<T0, T1>(arg0, v0);
        assert_trade_resulted_in_price_below_max_amount_out<T0, T1>(arg0, v0);
        let OrderCap {  } = arg2;
        arg0.remaining_trades = arg0.remaining_trades - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg0.recipient);
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::events::emit_executed_trade_event<T0, T1>(0x2::object::id<Order<T0, T1>>(arg0), arg0.user, arg0.recipient, arg0.amount_per_trade, v0);
    }

    fun init(arg0: DCA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::create_package_config<DCA>(&arg0, arg1);
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::treasury::create_treasury<DCA>(&arg0, arg1);
        0x2::transfer::public_transfer<0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::admin::AdminCap>(0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::admin::create_admin_cap<DCA>(&arg0, arg1), v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DCA>(arg0, arg1), v0);
    }

    fun take_protocol_fee<T0>(arg0: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::Config, arg1: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::treasury::Treasury, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::calculate_protocol_fee(arg0, 0x2::coin::value<T0>(arg2));
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::treasury::deposit<T0>(arg1, arg0, 0x2::coin::split<T0>(arg2, v0, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, v1, arg3), 0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::dev_wallet(arg0));
    }

    fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

