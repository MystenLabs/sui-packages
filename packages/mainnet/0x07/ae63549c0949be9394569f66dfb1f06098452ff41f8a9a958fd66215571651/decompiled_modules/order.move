module 0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::order {
    struct OrderAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        exchange_pool_id: 0x2::object::ID,
    }

    struct OrderPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        exchange_pool_id: 0x2::object::ID,
        ast_receiver: address,
        paused: bool,
        next_order_no: u64,
        total_orders: u64,
        total_usdc_paid: u128,
        total_ast_principal: u128,
        total_ast_transferred: u128,
    }

    struct OrderPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        exchange_pool_id: 0x2::object::ID,
        ast_receiver: address,
        admin: address,
        timestamp_ms: u64,
    }

    struct OrderCreated has copy, drop {
        order_no: u64,
        pool_id: 0x2::object::ID,
        exchange_pool_id: 0x2::object::ID,
        owner: address,
        ast_receiver: address,
        payment_usdc: u64,
        principal_ast: u64,
        period_days: u8,
        daily_rate_e6: u64,
        total_profit_cap_ast: u64,
        purchase_price_e8: u64,
        price_version: u64,
        created_at_ms: u64,
    }

    struct OrderPauseUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        timestamp_ms: u64,
    }

    public fun get_pool_id<T0, T1>(arg0: &OrderPool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<OrderPool<T0, T1>>(arg0)
    }

    fun assert_admin<T0, T1>(arg0: &OrderPool<T0, T1>, arg1: &OrderAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<OrderPool<T0, T1>>(arg0), 7);
        assert!(arg1.exchange_pool_id == arg0.exchange_pool_id, 7);
    }

    fun create_order<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: address, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.next_order_no;
        let v1 = arg0.ast_receiver;
        arg0.next_order_no = v0 + 1;
        arg0.total_orders = arg0.total_orders + 1;
        arg0.total_usdc_paid = arg0.total_usdc_paid + (arg4 as u128);
        arg0.total_ast_principal = arg0.total_ast_principal + (arg2 as u128);
        arg0.total_ast_transferred = arg0.total_ast_transferred + (arg2 as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg9), v1);
        let v2 = OrderCreated{
            order_no             : v0,
            pool_id              : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            exchange_pool_id     : arg0.exchange_pool_id,
            owner                : arg3,
            ast_receiver         : v1,
            payment_usdc         : arg4,
            principal_ast        : arg2,
            period_days          : arg5,
            daily_rate_e6        : daily_rate_for_period(arg5),
            total_profit_cap_ast : total_profit_cap_ast(arg2, arg5),
            purchase_price_e8    : arg6,
            price_version        : arg7,
            created_at_ms        : arg8,
        };
        0x2::event::emit<OrderCreated>(v2);
    }

    entry fun create_pool<T0, T1>(arg0: &0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::exchange::ExchangePool<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        create_pool_internal<T0, T1>(arg0, arg1, v0, arg2, arg3);
    }

    fun create_pool_internal<T0, T1>(arg0: &0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::exchange::ExchangePool<T0, T1>, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 14);
        let v0 = 0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::exchange::get_pool_id<T0, T1>(arg0);
        let v1 = OrderPool<T0, T1>{
            id                    : 0x2::object::new(arg4),
            schema_version        : 2,
            exchange_pool_id      : v0,
            ast_receiver          : arg1,
            paused                : false,
            next_order_no         : 1,
            total_orders          : 0,
            total_usdc_paid       : 0,
            total_ast_principal   : 0,
            total_ast_transferred : 0,
        };
        let v2 = 0x2::object::id<OrderPool<T0, T1>>(&v1);
        let v3 = OrderAdminCap<T0, T1>{
            id               : 0x2::object::new(arg4),
            schema_version   : 2,
            pool_id          : v2,
            exchange_pool_id : v0,
        };
        let v4 = OrderPoolCreated{
            pool_id          : v2,
            exchange_pool_id : v0,
            ast_receiver     : arg1,
            admin            : arg2,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OrderPoolCreated>(v4);
        0x2::transfer::share_object<OrderPool<T0, T1>>(v1);
        0x2::transfer::transfer<OrderAdminCap<T0, T1>>(v3, arg2);
    }

    fun cumulative_weights() : vector<u64> {
        vector[5472, 14444, 28991, 52318, 89310, 147324, 237301, 375310, 584652, 898689, 1364575, 2048097, 3039843, 4462902, 6482292, 9316241, 13249375, 18647712, 25975215, 35811400, 48869262, 66012473, 88270513, 116850128, 153141261, 198715493, 255315031, 324830444, 409265737, 510689942, 631175198, 772722268, 937175555, 1126130787, 1340839651, 1582116538, 1850253174, 2144947167, 2465250237, 2809541190, 3175527475, 3560277539, 3960284255, 4371557593, 4789742659, 5210257351, 5628442417, 6039715755, 6439722471, 6824472535, 7190458820, 7534749773, 7855052843, 8149746836, 8417883472, 8659160359, 8873869223, 9062824455, 9227277742, 9368824812, 9489310068, 9590734273, 9675169566, 9744684979, 9801284517, 9846858749, 9883149882, 9911729497, 9933987537, 9951130748, 9964188610, 9974024795, 9981352298, 9986750635, 9990683769, 9993517718, 9995537108, 9996960167, 9997951913, 9998635435, 9999101321, 9999415358, 9999624700, 9999762709, 9999852686, 9999910700, 9999947692, 9999971019, 9999985566, 9999994538, 10000000010]
    }

    fun daily_rate_for_period(arg0: u8) : u64 {
        500000 + ((arg0 - 9) as u64) * 1000000 / 90
    }

    public fun get_admin_pool_id<T0, T1>(arg0: &OrderAdminCap<T0, T1>) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.pool_id, arg0.exchange_pool_id)
    }

    public fun get_daily_rate_e6(arg0: u8) : u64 {
        assert!(arg0 >= 9 && arg0 <= 99, 4);
        daily_rate_for_period(arg0)
    }

    public fun get_payment_range<T0, T1>(arg0: &0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::exchange::ExchangePool<T0, T1>) : (u64, u64) {
        let v0 = 0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::exchange::get_usdc_unit<T0, T1>(arg0);
        (100 * v0, 10000 * v0)
    }

    public fun get_pool_info<T0, T1>(arg0: &OrderPool<T0, T1>) : (u64, 0x2::object::ID, address, bool, u64, u64, u128, u128, u128) {
        (arg0.schema_version, arg0.exchange_pool_id, arg0.ast_receiver, arg0.paused, arg0.next_order_no, arg0.total_orders, arg0.total_usdc_paid, arg0.total_ast_principal, arg0.total_ast_transferred)
    }

    public fun get_total_profit_cap_ast(arg0: u64, arg1: u8) : u64 {
        total_profit_cap_ast(arg0, arg1)
    }

    fun period_day_for_ticket(arg0: u64) : u8 {
        assert!(arg0 < 10000000010, 13);
        let v0 = cumulative_weights();
        let v1 = 0;
        let v2 = false;
        let v3 = 99;
        while (v1 < 91) {
            if (!v2 && arg0 < *0x1::vector::borrow<u64>(&v0, v1)) {
                v3 = 9 + (v1 as u8);
                v2 = true;
            };
            v1 = v1 + 1;
        };
        v3
    }

    public fun set_paused<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &OrderAdminCap<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        arg0.paused = arg2;
        let v0 = OrderPauseUpdated{
            pool_id      : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            paused       : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OrderPauseUpdated>(v0);
    }

    entry fun subscribe_and_draw<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &mut 0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::exchange::ExchangePool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg8, arg10);
        subscribe_with_period<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, period_day_for_ticket(0x2::random::generate_u64_in_range(&mut v0, 0, 10000000010 - 1)), arg9, arg10);
    }

    fun subscribe_with_period<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &mut 0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::exchange::ExchangePool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg0.exchange_pool_id == 0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::exchange::get_pool_id<T0, T1>(arg1), 2);
        assert!(arg8 >= 9 && arg8 <= 99, 4);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::exchange::get_usdc_unit<T0, T1>(arg1);
        assert!(v0 >= 100 * v1 && v0 <= 10000 * v1, 3);
        let (v2, v3) = 0x7ae63549c0949be9394569f66dfb1f06098452ff41f8a9a958fd66215571651::exchange::buy_for_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v4 = 0x2::tx_context::sender(arg10);
        create_order<T0, T1>(arg0, v2, v3, v4, v0, arg8, arg3, arg4, 0x2::clock::timestamp_ms(arg9), arg10);
    }

    fun total_profit_cap_ast(arg0: u64, arg1: u8) : u64 {
        let v0 = (arg0 as u128) * (get_daily_rate_e6(arg1) as u128) * (arg1 as u128) / 100000000;
        assert!(v0 <= 18446744073709551615, 17);
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

