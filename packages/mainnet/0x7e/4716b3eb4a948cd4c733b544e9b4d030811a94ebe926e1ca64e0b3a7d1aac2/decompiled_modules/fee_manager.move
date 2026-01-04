module 0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::fee_manager {
    struct FeeManager has key {
        id: 0x2::object::UID,
        owner: address,
        user_unsettled_fees: 0x2::bag::Bag,
        protocol_unsettled_fees: 0x2::bag::Bag,
    }

    struct FeeManagerOwnerCap has store, key {
        id: 0x2::object::UID,
        fee_manager_id: 0x2::object::ID,
    }

    struct UserUnsettledFeeKey has copy, drop, store {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        order_id: u128,
    }

    struct ProtocolUnsettledFeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct UserUnsettledFee<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        order_quantity: u64,
        maker_quantity: u64,
    }

    struct FeeSettlementReceipt<phantom T0> {
        orders_count: u64,
        total_fees_settled: u64,
    }

    struct FeeManagerShareTicket {
        fee_manager_id: 0x2::object::ID,
    }

    struct UserUnsettledFeeAdded<phantom T0> has copy, drop {
        key: UserUnsettledFeeKey,
        unsettled_fee_value: u64,
        order_quantity: u64,
        maker_quantity: u64,
    }

    struct UserFeesSettled<phantom T0> has copy, drop {
        key: UserUnsettledFeeKey,
        returned_to_user: u64,
        paid_to_protocol: u64,
        order_quantity: u64,
        maker_quantity: u64,
        filled_quantity: u64,
    }

    struct ProtocolFeesSettled<phantom T0> has copy, drop {
        orders_count: u64,
        total_fees_settled: u64,
    }

    struct FeeManagerCreated has copy, drop {
        fee_manager_id: 0x2::object::ID,
        fee_manager_owner_cap_id: 0x2::object::ID,
        owner: address,
    }

    fun destroy_empty<T0>(arg0: UserUnsettledFee<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.balance) == 0, 8);
        let UserUnsettledFee {
            balance        : v0,
            order_quantity : _,
            maker_quantity : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v0);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (FeeManager, FeeManagerOwnerCap, FeeManagerShareTicket) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = 0x2::object::new(arg0);
        let v3 = 0x2::object::uid_to_inner(&v1);
        let v4 = FeeManagerOwnerCap{
            id             : v2,
            fee_manager_id : v3,
        };
        let v5 = FeeManager{
            id                      : v1,
            owner                   : v0,
            user_unsettled_fees     : 0x2::bag::new(arg0),
            protocol_unsettled_fees : 0x2::bag::new(arg0),
        };
        let v6 = FeeManagerShareTicket{fee_manager_id: v3};
        let v7 = FeeManagerCreated{
            fee_manager_id           : v3,
            fee_manager_owner_cap_id : 0x2::object::uid_to_inner(&v2),
            owner                    : v0,
        };
        0x2::event::emit<FeeManagerCreated>(v7);
        (v5, v4, v6)
    }

    public(friend) fun add_to_protocol_unsettled_fees<T0>(arg0: &mut FeeManager, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        validate_owner(arg0, arg2);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = ProtocolUnsettledFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ProtocolUnsettledFeeKey<T0>>(&arg0.protocol_unsettled_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<ProtocolUnsettledFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_unsettled_fees, v0), arg1);
        } else {
            0x2::bag::add<ProtocolUnsettledFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_unsettled_fees, v0, arg1);
        };
    }

    public(friend) fun add_to_user_unsettled_fees<T0>(arg0: &mut FeeManager, arg1: 0x2::balance::Balance<T0>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg3: &0x2::tx_context::TxContext) {
        validate_owner(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(arg2);
        assert!(v0 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::live() || v0 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::partially_filled(), 2);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(arg2);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg2);
        assert!(v2 < v1, 3);
        let v3 = 0x2::balance::value<T0>(&arg1);
        assert!(v3 > 0, 4);
        let v4 = UserUnsettledFeeKey{
            pool_id            : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::pool_id(arg2),
            balance_manager_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::balance_manager_id(arg2),
            order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(arg2),
        };
        let v5 = v1 - v2;
        assert!(!0x2::bag::contains<UserUnsettledFeeKey>(&arg0.user_unsettled_fees, v4), 5);
        let v6 = UserUnsettledFee<T0>{
            balance        : arg1,
            order_quantity : v1,
            maker_quantity : v5,
        };
        0x2::bag::add<UserUnsettledFeeKey, UserUnsettledFee<T0>>(&mut arg0.user_unsettled_fees, v4, v6);
        let v7 = UserUnsettledFeeAdded<T0>{
            key                 : v4,
            unsettled_fee_value : v3,
            order_quantity      : v1,
            maker_quantity      : v5,
        };
        0x2::event::emit<UserUnsettledFeeAdded<T0>>(v7);
    }

    fun claim_protocol_unsettled_fee_rebate_core<T0>(arg0: &mut FeeManager) {
        let v0 = ProtocolUnsettledFeeKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<ProtocolUnsettledFeeKey<T0>>(&arg0.protocol_unsettled_fees, v0)) {
            return
        };
        let v1 = 0x2::bag::remove<ProtocolUnsettledFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_unsettled_fees, v0);
        assert!(0x2::balance::value<T0>(&v1) == 0, 9);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun claim_protocol_unsettled_fee_storage_rebate<T0>(arg0: &0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::Treasury, arg1: &mut FeeManager, arg2: &mut 0x2::tx_context::TxContext) {
        0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::verify_version(arg0);
        validate_owner(arg1, arg2);
        claim_protocol_unsettled_fee_rebate_core<T0>(arg1);
    }

    public fun claim_protocol_unsettled_fee_storage_rebate_admin<T0>(arg0: &0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::Treasury, arg1: &mut FeeManager, arg2: &0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::multisig_config::MultisigConfig, arg3: &0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::admin::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::multisig_config::validate_sender_is_admin_multisig(arg2, arg4);
        0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::verify_version(arg0);
        claim_protocol_unsettled_fee_rebate_core<T0>(arg1);
    }

    fun claim_user_unsettled_fee_rebate_core<T0, T1, T2>(arg0: &mut FeeManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u128) {
        let v0 = UserUnsettledFeeKey{
            pool_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
            order_id           : arg3,
        };
        if (!0x2::bag::contains<UserUnsettledFeeKey>(&arg0.user_unsettled_fees, v0)) {
            return
        };
        destroy_empty<T2>(0x2::bag::remove<UserUnsettledFeeKey, UserUnsettledFee<T2>>(&mut arg0.user_unsettled_fees, v0));
    }

    public fun claim_user_unsettled_fee_storage_rebate<T0, T1, T2>(arg0: &0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::Treasury, arg1: &mut FeeManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::verify_version(arg0);
        validate_owner(arg1, arg5);
        claim_user_unsettled_fee_rebate_core<T0, T1, T2>(arg1, arg2, arg3, arg4);
    }

    public fun claim_user_unsettled_fee_storage_rebate_admin<T0, T1, T2>(arg0: &0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::Treasury, arg1: &mut FeeManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::multisig_config::MultisigConfig, arg5: &0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::admin::AdminCap, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::multisig_config::validate_sender_is_admin_multisig(arg4, arg7);
        0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::verify_version(arg0);
        claim_user_unsettled_fee_rebate_core<T0, T1, T2>(arg1, arg2, arg3, arg6);
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

    public fun settle_filled_order_fee_and_record<T0, T1, T2>(arg0: &mut 0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::Treasury, arg1: &mut FeeManager, arg2: &mut FeeSettlementReceipt<T2>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u128) {
        0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::verify_version(arg0);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg3, arg4);
        if (0x2::vec_set::contains<u128>(&v0, &arg5)) {
            return
        };
        let v1 = UserUnsettledFeeKey{
            pool_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg4),
            order_id           : arg5,
        };
        if (!0x2::bag::contains<UserUnsettledFeeKey>(&arg1.user_unsettled_fees, v1)) {
            return
        };
        let v2 = 0x2::balance::withdraw_all<T2>(&mut 0x2::bag::borrow_mut<UserUnsettledFeeKey, UserUnsettledFee<T2>>(&mut arg1.user_unsettled_fees, v1).balance);
        let v3 = 0x2::balance::value<T2>(&v2);
        if (v3 > 0) {
            arg2.orders_count = arg2.orders_count + 1;
            arg2.total_fees_settled = arg2.total_fees_settled + v3;
        };
        0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::join_protocol_fee<T2>(arg0, v2);
    }

    public fun settle_protocol_fee_and_record<T0>(arg0: &mut 0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::Treasury, arg1: &mut FeeManager, arg2: &mut FeeSettlementReceipt<T0>) {
        0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::verify_version(arg0);
        let v0 = ProtocolUnsettledFeeKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<ProtocolUnsettledFeeKey<T0>>(&arg1.protocol_unsettled_fees, v0)) {
            return
        };
        let v1 = 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<ProtocolUnsettledFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.protocol_unsettled_fees, v0));
        let v2 = 0x2::balance::value<T0>(&v1);
        if (v2 > 0) {
            arg2.total_fees_settled = arg2.total_fees_settled + v2;
        };
        0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::treasury::join_protocol_fee<T0>(arg0, v1);
    }

    public(friend) fun settle_user_fees<T0, T1, T2>(arg0: &mut FeeManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        validate_owner(arg0, arg4);
        let v0 = UserUnsettledFeeKey{
            pool_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
            order_id           : arg3,
        };
        if (!0x2::bag::contains<UserUnsettledFeeKey>(&arg0.user_unsettled_fees, v0)) {
            return 0x2::coin::zero<T2>(arg4)
        };
        let v1 = 0x2::bag::remove<UserUnsettledFeeKey, UserUnsettledFee<T2>>(&mut arg0.user_unsettled_fees, v0);
        let v2 = 0x2::balance::value<T2>(&v1.balance);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg1, arg3);
        let v4 = v1.order_quantity;
        let v5 = v1.maker_quantity;
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v3);
        assert!(v5 > 0, 6);
        assert!(v6 < v4, 7);
        let v7 = if (v6 == 0) {
            v2
        } else {
            0x7e4716b3eb4a948cd4c733b544e9b4d030811a94ebe926e1ca64e0b3a7d1aac2::dt_math::mul_div(v2, v4 - v6, v5)
        };
        let v8 = v2 - v7;
        if (v8 > 0) {
            add_to_protocol_unsettled_fees<T2>(arg0, 0x2::balance::split<T2>(&mut v1.balance, v8), arg4);
        };
        destroy_empty<T2>(v1);
        let v9 = UserFeesSettled<T2>{
            key              : v0,
            returned_to_user : v7,
            paid_to_protocol : v8,
            order_quantity   : v4,
            maker_quantity   : v5,
            filled_quantity  : v6,
        };
        0x2::event::emit<UserFeesSettled<T2>>(v9);
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v1.balance, v7), arg4)
    }

    public fun share_fee_manager(arg0: FeeManager, arg1: FeeManagerShareTicket) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.fee_manager_id, 10);
        let FeeManagerShareTicket {  } = arg1;
        0x2::transfer::share_object<FeeManager>(arg0);
    }

    public fun start_protocol_fee_settlement<T0>() : FeeSettlementReceipt<T0> {
        FeeSettlementReceipt<T0>{
            orders_count       : 0,
            total_fees_settled : 0,
        }
    }

    fun validate_owner(arg0: &FeeManager, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
    }

    // decompiled from Move bytecode v6
}

