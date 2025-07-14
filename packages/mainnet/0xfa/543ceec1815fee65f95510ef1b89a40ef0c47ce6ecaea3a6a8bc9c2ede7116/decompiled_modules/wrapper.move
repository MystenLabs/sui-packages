module 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::wrapper {
    struct Wrapper has store, key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
        deep_reserves: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        deep_reserves_coverage_fees: 0x2::bag::Bag,
        protocol_fees: 0x2::bag::Bag,
        unsettled_fees: 0x2::bag::Bag,
    }

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

    struct ChargedFeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct UnsettledFeeAdded has copy, drop {
        key: UnsettledFeeKey,
        fee_value: u64,
        order_quantity: u64,
        maker_quantity: u64,
    }

    struct UserFeesSettled has copy, drop {
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
        assert!(0x2::balance::value<T0>(&arg0.balance) == 0, 14);
        let UnsettledFee {
            balance        : v0,
            order_quantity : _,
            maker_quantity : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v0);
    }

    public fun join(arg0: &mut Wrapper, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        verify_version(arg0);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public(friend) fun add_unsettled_fee<T0>(arg0: &mut Wrapper, arg1: 0x2::balance::Balance<T0>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) {
        verify_version(arg0);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(arg2);
        assert!(v0 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::live() || v0 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::partially_filled(), 8);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(arg2);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg2);
        assert!(v2 < v1, 9);
        let v3 = 0x2::balance::value<T0>(&arg1);
        assert!(v3 > 0, 10);
        let v4 = UnsettledFeeKey{
            pool_id            : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::pool_id(arg2),
            balance_manager_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::balance_manager_id(arg2),
            order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(arg2),
        };
        let v5 = v1 - v2;
        if (0x2::bag::contains_with_type<UnsettledFeeKey, UnsettledFee<T0>>(&arg0.unsettled_fees, v4)) {
            let v6 = 0x2::bag::borrow_mut<UnsettledFeeKey, UnsettledFee<T0>>(&mut arg0.unsettled_fees, v4);
            assert!(v6.order_quantity == v1 && v6.maker_quantity == v5, 11);
            0x2::balance::join<T0>(&mut v6.balance, arg1);
        } else {
            assert!(!0x2::bag::contains<UnsettledFeeKey>(&arg0.unsettled_fees, v4), 15);
            let v7 = UnsettledFee<T0>{
                balance        : arg1,
                order_quantity : v1,
                maker_quantity : v5,
            };
            0x2::bag::add<UnsettledFeeKey, UnsettledFee<T0>>(&mut arg0.unsettled_fees, v4, v7);
        };
        let v8 = UnsettledFeeAdded{
            key            : v4,
            fee_value      : v3,
            order_quantity : v1,
            maker_quantity : v5,
        };
        0x2::event::emit<UnsettledFeeAdded>(v8);
    }

    public fun deep_reserves(arg0: &Wrapper) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_reserves)
    }

    public fun disable_version(arg0: &mut Wrapper, arg1: &0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::admin::AdminCap, arg2: u16, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::multisig::check_if_sender_is_multisig_address(arg3, arg4, arg5, arg6), 6);
        assert!(arg2 != 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::helper::current_version(), 3);
        assert!(0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2), 4);
        0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg2);
    }

    public fun enable_version(arg0: &mut Wrapper, arg1: &0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::admin::AdminCap, arg2: u16, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::multisig::check_if_sender_is_multisig_address(arg3, arg4, arg5, arg6), 6);
        assert!(!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2), 2);
        0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg2);
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Wrapper{
            id                          : 0x2::object::new(arg0),
            allowed_versions            : 0x2::vec_set::singleton<u16>(0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::helper::current_version()),
            deep_reserves               : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            deep_reserves_coverage_fees : 0x2::bag::new(arg0),
            protocol_fees               : 0x2::bag::new(arg0),
            unsettled_fees              : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Wrapper>(v0);
    }

    public(friend) fun join_deep_reserves_coverage_fee<T0>(arg0: &mut Wrapper, arg1: 0x2::balance::Balance<T0>) {
        verify_version(arg0);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.deep_reserves_coverage_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.deep_reserves_coverage_fees, v0), arg1);
        } else {
            0x2::bag::add<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.deep_reserves_coverage_fees, v0, arg1);
        };
    }

    public(friend) fun join_protocol_fee<T0>(arg0: &mut Wrapper, arg1: 0x2::balance::Balance<T0>) {
        verify_version(arg0);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.protocol_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0), arg1);
        } else {
            0x2::bag::add<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0, arg1);
        };
    }

    public fun settle_protocol_fee_and_record<T0, T1, T2>(arg0: &mut Wrapper, arg1: &mut FeeSettlementReceipt<T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u128) {
        verify_version(arg0);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg2, arg3);
        if (0x2::vec_set::contains<u128>(&v0, &arg4)) {
            return
        };
        let v1 = UnsettledFeeKey{
            pool_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg3),
            order_id           : arg4,
        };
        if (!0x2::bag::contains<UnsettledFeeKey>(&arg0.unsettled_fees, v1)) {
            return
        };
        let v2 = 0x2::bag::remove<UnsettledFeeKey, UnsettledFee<T2>>(&mut arg0.unsettled_fees, v1);
        let v3 = 0x2::balance::withdraw_all<T2>(&mut v2.balance);
        let v4 = 0x2::balance::value<T2>(&v3);
        if (v4 > 0) {
            arg1.orders_count = arg1.orders_count + 1;
            arg1.total_fees_settled = arg1.total_fees_settled + v4;
        };
        join_protocol_fee<T2>(arg0, v3);
        destroy_empty<T2>(v2);
    }

    public(friend) fun settle_user_fees<T0, T1, T2>(arg0: &mut Wrapper, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        verify_version(arg0);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg2) == 0x2::tx_context::sender(arg4), 7);
        let v0 = UnsettledFeeKey{
            pool_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
            order_id           : arg3,
        };
        if (!0x2::bag::contains<UnsettledFeeKey>(&arg0.unsettled_fees, v0)) {
            return 0x2::coin::zero<T2>(arg4)
        };
        let v1 = 0x2::bag::borrow_mut<UnsettledFeeKey, UnsettledFee<T2>>(&mut arg0.unsettled_fees, v0);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg1, arg3);
        let v3 = 0x2::balance::value<T2>(&v1.balance);
        let v4 = v1.order_quantity;
        let v5 = v1.maker_quantity;
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v2);
        if (v3 == 0) {
            destroy_empty<T2>(0x2::bag::remove<UnsettledFeeKey, UnsettledFee<T2>>(&mut arg0.unsettled_fees, v0));
            return 0x2::coin::zero<T2>(arg4)
        };
        assert!(v5 > 0, 12);
        assert!(v6 <= v4, 13);
        let v7 = if (v6 == 0) {
            v3
        } else {
            0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::math::div(0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::math::mul(v3, v4 - v6), v5)
        };
        let v8 = 0x2::balance::split<T2>(&mut v1.balance, v7);
        let v9 = 0x2::balance::value<T2>(&v8);
        if (0x2::balance::value<T2>(&v1.balance) == 0) {
            destroy_empty<T2>(0x2::bag::remove<UnsettledFeeKey, UnsettledFee<T2>>(&mut arg0.unsettled_fees, v0));
        };
        if (v9 > 0) {
            let v10 = UserFeesSettled{
                key             : v0,
                fee_value       : v9,
                order_quantity  : v4,
                maker_quantity  : v5,
                filled_quantity : v6,
            };
            0x2::event::emit<UserFeesSettled>(v10);
        };
        0x2::coin::from_balance<T2>(v8, arg4)
    }

    public(friend) fun split_deep_reserves(arg0: &mut Wrapper, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        verify_version(arg0);
        assert!(arg1 <= 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_reserves), 1);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, arg1), arg2)
    }

    public fun start_protocol_fee_settlement<T0>() : FeeSettlementReceipt<T0> {
        FeeSettlementReceipt<T0>{
            orders_count       : 0,
            total_fees_settled : 0,
        }
    }

    public(friend) fun verify_version(arg0: &Wrapper) {
        let v0 = 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::helper::current_version();
        assert!(0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0), 5);
    }

    public fun withdraw_deep_reserves(arg0: &mut Wrapper, arg1: 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::AdminTicket, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        verify_version(arg0);
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::validate_ticket(&arg1, 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::withdraw_deep_reserves_ticket_type(), arg3, arg4);
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::destroy_ticket(arg1);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, arg2), arg4)
    }

    public fun withdraw_deep_reserves_coverage_fee<T0>(arg0: &mut Wrapper, arg1: 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::AdminTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_version(arg0);
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::validate_ticket(&arg1, 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::withdraw_coverage_fee_ticket_type(), arg2, arg3);
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::destroy_ticket(arg1);
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.deep_reserves_coverage_fees, v0)) {
            0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.deep_reserves_coverage_fees, v0)), arg3)
        } else {
            0x2::coin::zero<T0>(arg3)
        }
    }

    public fun withdraw_protocol_fee<T0>(arg0: &mut Wrapper, arg1: 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::AdminTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_version(arg0);
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::validate_ticket(&arg1, 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::withdraw_protocol_fee_ticket_type(), arg2, arg3);
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::destroy_ticket(arg1);
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.protocol_fees, v0)) {
            0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0)), arg3)
        } else {
            0x2::coin::zero<T0>(arg3)
        }
    }

    // decompiled from Move bytecode v6
}

