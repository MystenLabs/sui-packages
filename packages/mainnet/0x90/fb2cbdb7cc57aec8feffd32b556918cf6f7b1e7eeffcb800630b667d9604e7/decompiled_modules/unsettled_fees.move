module 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::unsettled_fees {
    struct UnsettledFeeKey has copy, drop, store {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        order_id: u128,
    }

    struct UnsettledFee<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        order_quantity: u64,
        maker_quantity: u64,
    }

    struct FeeSettlementReceipt<phantom T0> {
        orders_count: u64,
        total_fees_settled: u64,
    }

    struct UnsettledFeeAdded<phantom T0> has copy, drop {
        key: UnsettledFeeKey,
        fee_value: u64,
        order_quantity: u64,
        maker_quantity: u64,
    }

    struct UserFeesSettled<phantom T0> has copy, drop {
        key: UnsettledFeeKey,
        fee_value: u64,
        order_quantity: u64,
        maker_quantity: u64,
        filled_quantity: u64,
    }

    struct ProtocolFeesSettled<phantom T0> has copy, drop {
        orders_count: u64,
        total_fees_settled: u64,
    }

    fun destroy_empty<T0>(arg0: UnsettledFee<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.balance) == 0, 8);
        let UnsettledFee {
            balance        : v0,
            order_quantity : _,
            maker_quantity : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v0);
    }

    public(friend) fun add_unsettled_fee<T0>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: 0x2::balance::Balance<T0>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(arg2);
        assert!(v0 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::live() || v0 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::partially_filled(), 2);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(arg2);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg2);
        assert!(v2 < v1, 3);
        let v3 = 0x2::balance::value<T0>(&arg1);
        assert!(v3 > 0, 4);
        let v4 = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::unsettled_fees_mut(arg0);
        let v5 = UnsettledFeeKey{
            pool_id            : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::pool_id(arg2),
            balance_manager_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::balance_manager_id(arg2),
            order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(arg2),
        };
        let v6 = v1 - v2;
        assert!(!0x2::bag::contains<UnsettledFeeKey>(v4, v5), 5);
        let v7 = UnsettledFee<T0>{
            balance        : arg1,
            order_quantity : v1,
            maker_quantity : v6,
        };
        0x2::bag::add<UnsettledFeeKey, UnsettledFee<T0>>(v4, v5, v7);
        let v8 = UnsettledFeeAdded<T0>{
            key            : v5,
            fee_value      : v3,
            order_quantity : v1,
            maker_quantity : v6,
        };
        0x2::event::emit<UnsettledFeeAdded<T0>>(v8);
    }

    public fun finish_protocol_fee_settlement<T0>(arg0: FeeSettlementReceipt<T0>) {
        if (arg0.total_fees_settled > 0) {
            let v0 = ProtocolFeesSettled<T0>{
                orders_count       : arg0.orders_count,
                total_fees_settled : arg0.total_fees_settled,
            };
            0x2::event::emit<ProtocolFeesSettled<T0>>(v0);
        };
        let FeeSettlementReceipt {
            orders_count       : _,
            total_fees_settled : _,
        } = arg0;
    }

    public fun settle_protocol_fee_and_record<T0, T1, T2>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &mut FeeSettlementReceipt<T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u128) {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        let v0 = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::unsettled_fees_mut(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg2, arg3);
        if (0x2::vec_set::contains<u128>(&v1, &arg4)) {
            return
        };
        let v2 = UnsettledFeeKey{
            pool_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg3),
            order_id           : arg4,
        };
        if (!0x2::bag::contains<UnsettledFeeKey>(v0, v2)) {
            return
        };
        let v3 = 0x2::bag::remove<UnsettledFeeKey, UnsettledFee<T2>>(v0, v2);
        let v4 = 0x2::balance::withdraw_all<T2>(&mut v3.balance);
        let v5 = 0x2::balance::value<T2>(&v4);
        if (v5 > 0) {
            arg1.orders_count = arg1.orders_count + 1;
            arg1.total_fees_settled = arg1.total_fees_settled + v5;
        };
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::join_protocol_fee<T2>(arg0, v4);
        destroy_empty<T2>(v3);
    }

    public(friend) fun settle_user_fees<T0, T1, T2>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg2) == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::unsettled_fees_mut(arg0);
        let v1 = UnsettledFeeKey{
            pool_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
            order_id           : arg3,
        };
        if (!0x2::bag::contains<UnsettledFeeKey>(v0, v1)) {
            return 0x2::coin::zero<T2>(arg4)
        };
        let v2 = 0x2::bag::borrow_mut<UnsettledFeeKey, UnsettledFee<T2>>(v0, v1);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg1, arg3);
        let v4 = 0x2::balance::value<T2>(&v2.balance);
        let v5 = v2.order_quantity;
        let v6 = v2.maker_quantity;
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v3);
        if (v4 == 0) {
            destroy_empty<T2>(0x2::bag::remove<UnsettledFeeKey, UnsettledFee<T2>>(v0, v1));
            return 0x2::coin::zero<T2>(arg4)
        };
        assert!(v6 > 0, 6);
        assert!(v7 < v5, 7);
        let v8 = if (v7 == 0) {
            v4
        } else {
            0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::math::div(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::math::mul(v4, v5 - v7), v6)
        };
        if (0x2::balance::value<T2>(&v2.balance) == 0) {
            destroy_empty<T2>(0x2::bag::remove<UnsettledFeeKey, UnsettledFee<T2>>(v0, v1));
        };
        let v9 = UserFeesSettled<T2>{
            key             : v1,
            fee_value       : v8,
            order_quantity  : v5,
            maker_quantity  : v6,
            filled_quantity : v7,
        };
        0x2::event::emit<UserFeesSettled<T2>>(v9);
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v2.balance, v8), arg4)
    }

    public fun start_protocol_fee_settlement<T0>() : FeeSettlementReceipt<T0> {
        FeeSettlementReceipt<T0>{
            orders_count       : 0,
            total_fees_settled : 0,
        }
    }

    // decompiled from Move bytecode v6
}

