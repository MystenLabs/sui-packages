module 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager {
    struct OrderMakerFees has drop, store {
        maker_fees: u64,
        maker_quantity: u64,
    }

    struct TurbosBalanceManager has store, key {
        id: 0x2::object::UID,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        advance_deep: u64,
        spent_deep: u64,
        refund_deep: u64,
        order_fee_table: 0x2::table::Table<u128, OrderMakerFees>,
    }

    public(friend) fun delete(arg0: TurbosBalanceManager) {
        let TurbosBalanceManager {
            id              : v0,
            balance_manager : v1,
            advance_deep    : _,
            spent_deep      : _,
            refund_deep     : _,
            order_fee_table : v5,
        } = arg0;
        0x2::object::delete(v0);
        0x2::table::drop<u128, OrderMakerFees>(v5);
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : TurbosBalanceManager {
        TurbosBalanceManager{
            id              : 0x2::object::new(arg0),
            balance_manager : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0),
            advance_deep    : 0,
            spent_deep      : 0,
            refund_deep     : 0,
            order_fee_table : 0x2::table::new<u128, OrderMakerFees>(arg0),
        }
    }

    public fun account<T0, T1>(arg0: &mut TurbosBalanceManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::Account {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg1, &arg0.balance_manager)
    }

    public(friend) fun balance<T0>(arg0: &TurbosBalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager)
    }

    public fun deposit<T0>(arg0: &mut TurbosBalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(&mut arg0.balance_manager, arg1, arg2);
    }

    public fun withdraw<T0>(arg0: &mut TurbosBalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(&mut arg0.balance_manager, arg1, arg2)
    }

    public fun withdraw_all<T0>(arg0: &mut TurbosBalanceManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(&mut arg0.balance_manager, arg1)
    }

    public fun account_open_orders<T0, T1>(arg0: &TurbosBalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : 0x2::vec_set::VecSet<u128> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, &arg0.balance_manager)
    }

    public(friend) fun cancel_order<T0, T1>(arg0: &mut TurbosBalanceManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut arg0.balance_manager, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg1, &mut arg0.balance_manager, &v0, arg2, arg3, arg4);
    }

    public(friend) fun place_limit_order<T0, T1>(arg0: &mut TurbosBalanceManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut arg0.balance_manager, arg11);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, &mut arg0.balance_manager, &v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v2 = OrderMakerFees{
            maker_fees     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::maker_fees(&v1),
            maker_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v1) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v1),
        };
        0x2::table::add<u128, OrderMakerFees>(&mut arg0.order_fee_table, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v1), v2);
        v1
    }

    public(friend) fun place_market_order<T0, T1>(arg0: &mut TurbosBalanceManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u8, arg4: u64, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut arg0.balance_manager, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg1, &mut arg0.balance_manager, &v0, arg4, arg3, arg2, arg5, arg6, arg7, arg8)
    }

    public fun withdraw_settled_amounts<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut TurbosBalanceManager, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut arg1.balance_manager, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, &mut arg1.balance_manager, &v0);
    }

    public(friend) fun add_refund_amount(arg0: &mut TurbosBalanceManager, arg1: u64) {
        arg0.refund_deep = arg0.refund_deep + arg1;
    }

    public(friend) fun balance_manager_id(arg0: &TurbosBalanceManager) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.balance_manager)
    }

    public(friend) fun deposit_advance_deep(arg0: &mut TurbosBalanceManager, arg1: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::withdraw_advance_deep(arg1, arg2);
        arg0.advance_deep = arg0.advance_deep + 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v0);
        deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, v0, arg2);
    }

    public(friend) fun get_order_maker_fee(arg0: &OrderMakerFees) : u64 {
        arg0.maker_fees
    }

    public(friend) fun get_order_maker_quantity(arg0: &OrderMakerFees) : u64 {
        arg0.maker_quantity
    }

    public(friend) fun get_order_paid_fees(arg0: &TurbosBalanceManager, arg1: u128) : &OrderMakerFees {
        0x2::table::borrow<u128, OrderMakerFees>(&arg0.order_fee_table, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun share(arg0: TurbosBalanceManager) {
        0x2::transfer::share_object<TurbosBalanceManager>(arg0);
    }

    public(friend) fun withdraw_all_refund_deep<T0>(arg0: &mut TurbosBalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0.refund_deep = arg0.refund_deep + arg1;
        withdraw_all<T0>(arg0, arg2)
    }

    public(friend) fun withdraw_refund_deep<T0>(arg0: &mut TurbosBalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0.refund_deep = arg0.refund_deep + arg1;
        withdraw<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

