module 0x2441fb74d7684f43019fdabf27d6de24dc8e42826ddd86ba07bc21aded80c014::deepbook_guard {
    struct DeepbookGuard<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        maker: address,
        agent: address,
        paused: bool,
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        price_min: u64,
        price_max: u64,
        max_qty: u64,
        budget: u64,
        committed: u64,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
    }

    struct GuardCreated has copy, drop {
        guard_id: 0x2::object::ID,
        maker: address,
        agent: address,
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
    }

    struct GuardUpdated has copy, drop {
        guard_id: 0x2::object::ID,
        agent: address,
        paused: bool,
        price_min: u64,
        price_max: u64,
        max_qty: u64,
        budget: u64,
    }

    public fun agent<T0, T1>(arg0: &DeepbookGuard<T0, T1>) : address {
        arg0.agent
    }

    fun assert_agent_may_act<T0, T1>(arg0: &DeepbookGuard<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.agent, 13906835965344874499);
        assert!(!arg0.paused, 13906835969639972869);
        assert!(arg1 == arg0.pool_id, 13906835973935071239);
        assert!(arg2 == arg0.balance_manager_id, 13906835978230169609);
    }

    fun assert_caller_is_maker<T0, T1>(arg0: &DeepbookGuard<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.maker, 13906836119963566081);
    }

    fun assert_order_allowed<T0, T1>(arg0: &DeepbookGuard<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_agent_may_act<T0, T1>(arg0, arg1, arg2, arg5);
        assert!(arg3 >= arg0.price_min && arg3 <= arg0.price_max, 13906836034064875531);
        assert!(arg4 <= arg0.max_qty, 13906836038359973901);
        assert!(arg0.committed <= arg0.budget && arg4 <= arg0.budget - arg0.committed, 13906836059835072529);
    }

    fun assert_trade_cap_belongs(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg2: &0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg0, arg1, arg2);
    }

    public fun balance_manager_id<T0, T1>(arg0: &DeepbookGuard<T0, T1>) : 0x2::object::ID {
        arg0.balance_manager_id
    }

    public fun bounds<T0, T1>(arg0: &DeepbookGuard<T0, T1>) : (u64, u64, u64) {
        (arg0.price_min, arg0.price_max, arg0.max_qty)
    }

    public fun budget<T0, T1>(arg0: &DeepbookGuard<T0, T1>) : u64 {
        arg0.budget
    }

    public fun buy<T0, T1>(arg0: &mut DeepbookGuard<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        place<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, arg7, arg8, arg9)
    }

    public fun cancel<T0, T1>(arg0: &DeepbookGuard<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_agent_may_act<T0, T1>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), arg5);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg2, &arg0.trade_cap, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg1, arg2, &v0, arg3, arg4, arg5);
    }

    public fun cancel_all<T0, T1>(arg0: &DeepbookGuard<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_agent_may_act<T0, T1>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), arg4);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg2, &arg0.trade_cap, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg1, arg2, &v0, arg3, arg4);
    }

    public fun committed<T0, T1>(arg0: &DeepbookGuard<T0, T1>) : u64 {
        arg0.committed
    }

    public fun create<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg4 <= arg5, 13906834908783706127);
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg1);
        let v1 = &mut arg1;
        assert_trade_cap_belongs(v1, &arg2, arg8);
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1);
        let v2 = DeepbookGuard<T0, T1>{
            id                 : 0x2::object::new(arg8),
            maker              : 0x2::tx_context::sender(arg8),
            agent              : arg3,
            paused             : false,
            pool_id            : arg0,
            balance_manager_id : v0,
            price_min          : arg4,
            price_max          : arg5,
            max_qty            : arg6,
            budget             : arg7,
            committed          : 0,
            trade_cap          : arg2,
        };
        let v3 = 0x2::object::id<DeepbookGuard<T0, T1>>(&v2);
        0x2::transfer::share_object<DeepbookGuard<T0, T1>>(v2);
        let v4 = GuardCreated{
            guard_id           : v3,
            maker              : v2.maker,
            agent              : arg3,
            pool_id            : arg0,
            balance_manager_id : v0,
        };
        0x2::event::emit<GuardCreated>(v4);
        v3
    }

    fun emit_updated<T0, T1>(arg0: &DeepbookGuard<T0, T1>) {
        let v0 = GuardUpdated{
            guard_id  : 0x2::object::id<DeepbookGuard<T0, T1>>(arg0),
            agent     : arg0.agent,
            paused    : arg0.paused,
            price_min : arg0.price_min,
            price_max : arg0.price_max,
            max_qty   : arg0.max_qty,
            budget    : arg0.budget,
        };
        0x2::event::emit<GuardUpdated>(v0);
    }

    public fun guard_id<T0, T1>(arg0: &DeepbookGuard<T0, T1>) : 0x2::object::ID {
        0x2::object::id<DeepbookGuard<T0, T1>>(arg0)
    }

    public fun is_paused<T0, T1>(arg0: &DeepbookGuard<T0, T1>) : bool {
        arg0.paused
    }

    public fun maker<T0, T1>(arg0: &DeepbookGuard<T0, T1>) : address {
        arg0.maker
    }

    fun place<T0, T1>(arg0: &mut DeepbookGuard<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        assert_order_allowed<T0, T1>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), arg5, arg6, arg10);
        record_commitment<T0, T1>(arg0, arg6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg2, &arg0.trade_cap, arg10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, arg2, &v0, arg3, arg4, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg5, arg6, arg7, false, arg8, arg9, arg10)
    }

    public fun pool_id<T0, T1>(arg0: &DeepbookGuard<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    fun record_commitment<T0, T1>(arg0: &mut DeepbookGuard<T0, T1>, arg1: u64) {
        arg0.committed = arg0.committed + arg1;
    }

    public fun sell<T0, T1>(arg0: &mut DeepbookGuard<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        place<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg7, arg8, arg9)
    }

    public fun set_agent<T0, T1>(arg0: &mut DeepbookGuard<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_caller_is_maker<T0, T1>(arg0, arg2);
        arg0.agent = arg1;
        emit_updated<T0, T1>(arg0);
    }

    public fun set_bounds<T0, T1>(arg0: &mut DeepbookGuard<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_caller_is_maker<T0, T1>(arg0, arg4);
        assert!(arg1 <= arg2, 13906835501489192975);
        arg0.price_min = arg1;
        arg0.price_max = arg2;
        arg0.max_qty = arg3;
        emit_updated<T0, T1>(arg0);
    }

    public fun set_budget<T0, T1>(arg0: &mut DeepbookGuard<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_caller_is_maker<T0, T1>(arg0, arg2);
        arg0.budget = arg1;
        emit_updated<T0, T1>(arg0);
    }

    public fun set_paused<T0, T1>(arg0: &mut DeepbookGuard<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_caller_is_maker<T0, T1>(arg0, arg2);
        arg0.paused = arg1;
        emit_updated<T0, T1>(arg0);
    }

    public fun trade_cap_id<T0, T1>(arg0: &DeepbookGuard<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.trade_cap)
    }

    // decompiled from Move bytecode v7
}

