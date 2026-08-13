module 0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::order {
    struct OrderAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        exchange_pool_id: 0x2::object::ID,
    }

    struct OrderProbabilityAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        exchange_pool_id: 0x2::object::ID,
    }

    struct OrderPauseAdminCap<phantom T0, phantom T1> has store, key {
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
        probability_weights: vector<u64>,
        total_probability_weight: u64,
        probability_version: u64,
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
        probability_admin: address,
        pause_admin: address,
        total_probability_weight: u64,
        probability_version: u64,
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
        probability_version: u64,
        created_at_ms: u64,
    }

    struct OrderPauseUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        timestamp_ms: u64,
    }

    struct OrderProbabilityUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_probability_version: u64,
        new_probability_version: u64,
        total_probability_weight: u64,
        timestamp_ms: u64,
    }

    public fun get_pool_id<T0, T1>(arg0: &OrderPool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<OrderPool<T0, T1>>(arg0)
    }

    fun assert_pause_admin<T0, T1>(arg0: &OrderPool<T0, T1>, arg1: &OrderPauseAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<OrderPool<T0, T1>>(arg0), 7);
        assert!(arg1.exchange_pool_id == arg0.exchange_pool_id, 7);
    }

    fun assert_probability_admin<T0, T1>(arg0: &OrderPool<T0, T1>, arg1: &OrderProbabilityAdminCap<T0, T1>) {
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
            probability_version  : arg0.probability_version,
            created_at_ms        : arg8,
        };
        0x2::event::emit<OrderCreated>(v2);
    }

    entry fun create_pool<T0, T1>(arg0: &0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::ExchangePool<T0, T1>, arg1: address, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        create_pool_internal<T0, T1>(arg0, arg1, arg2, v0, v1, v2, arg3, arg4);
    }

    fun create_pool_internal<T0, T1>(arg0: &0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::ExchangePool<T0, T1>, arg1: address, arg2: vector<u64>, arg3: address, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 14);
        let v0 = if (arg3 != @0x0) {
            if (arg4 != @0x0) {
                arg5 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 20);
        let v1 = validate_probability_weights(&arg2);
        let v2 = 0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::get_pool_id<T0, T1>(arg0);
        let v3 = OrderPool<T0, T1>{
            id                       : 0x2::object::new(arg7),
            schema_version           : 3,
            exchange_pool_id         : v2,
            ast_receiver             : arg1,
            paused                   : false,
            probability_weights      : arg2,
            total_probability_weight : v1,
            probability_version      : 1,
            next_order_no            : 1,
            total_orders             : 0,
            total_usdc_paid          : 0,
            total_ast_principal      : 0,
            total_ast_transferred    : 0,
        };
        let v4 = 0x2::object::id<OrderPool<T0, T1>>(&v3);
        let v5 = OrderAdminCap<T0, T1>{
            id               : 0x2::object::new(arg7),
            schema_version   : 3,
            pool_id          : v4,
            exchange_pool_id : v2,
        };
        let v6 = OrderProbabilityAdminCap<T0, T1>{
            id               : 0x2::object::new(arg7),
            schema_version   : 3,
            pool_id          : v4,
            exchange_pool_id : v2,
        };
        let v7 = OrderPauseAdminCap<T0, T1>{
            id               : 0x2::object::new(arg7),
            schema_version   : 3,
            pool_id          : v4,
            exchange_pool_id : v2,
        };
        let v8 = OrderPoolCreated{
            pool_id                  : v4,
            exchange_pool_id         : v2,
            ast_receiver             : arg1,
            admin                    : arg3,
            probability_admin        : arg4,
            pause_admin              : arg5,
            total_probability_weight : v1,
            probability_version      : 1,
            timestamp_ms             : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<OrderPoolCreated>(v8);
        0x2::transfer::share_object<OrderPool<T0, T1>>(v3);
        0x2::transfer::transfer<OrderAdminCap<T0, T1>>(v5, arg3);
        0x2::transfer::transfer<OrderProbabilityAdminCap<T0, T1>>(v6, arg4);
        0x2::transfer::transfer<OrderPauseAdminCap<T0, T1>>(v7, arg5);
    }

    entry fun create_pool_with_roles<T0, T1>(arg0: &0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::ExchangePool<T0, T1>, arg1: address, arg2: vector<u64>, arg3: address, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 != arg4) {
            if (arg3 != arg5) {
                arg4 != arg5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 21);
        create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun daily_rate_for_period(arg0: u8) : u64 {
        500000 + (((arg0 - 9) as u64) * 100 + 45) / 90 * 10000
    }

    public fun get_admin_pool_id<T0, T1>(arg0: &OrderAdminCap<T0, T1>) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.pool_id, arg0.exchange_pool_id)
    }

    public fun get_daily_rate_e6(arg0: u8) : u64 {
        assert!(arg0 >= 9 && arg0 <= 99, 4);
        daily_rate_for_period(arg0)
    }

    public fun get_payment_range<T0, T1>(arg0: &0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::ExchangePool<T0, T1>) : (u64, u64) {
        let v0 = 0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::get_usdc_unit<T0, T1>(arg0);
        (100 * v0, 10000 * v0)
    }

    public fun get_pool_info<T0, T1>(arg0: &OrderPool<T0, T1>) : (u64, 0x2::object::ID, address, bool, u64, u64, u128, u128, u128) {
        (arg0.schema_version, arg0.exchange_pool_id, arg0.ast_receiver, arg0.paused, arg0.next_order_no, arg0.total_orders, arg0.total_usdc_paid, arg0.total_ast_principal, arg0.total_ast_transferred)
    }

    public fun get_probability_info<T0, T1>(arg0: &OrderPool<T0, T1>) : (u64, u64, vector<u64>) {
        (arg0.probability_version, arg0.total_probability_weight, arg0.probability_weights)
    }

    public fun get_total_profit_cap_ast(arg0: u64, arg1: u8) : u64 {
        total_profit_cap_ast(arg0, arg1)
    }

    fun period_day_for_ticket(arg0: &vector<u64>, arg1: u64) : u8 {
        assert!(arg1 < validate_probability_weights(arg0), 13);
        let v0 = 0;
        let v1 = 0;
        let v2 = false;
        let v3 = 99;
        while (v0 < 91) {
            let v4 = v1 + *0x1::vector::borrow<u64>(arg0, v0);
            v1 = v4;
            if (!v2 && arg1 < v4) {
                v3 = 9 + (v0 as u8);
                v2 = true;
            };
            v0 = v0 + 1;
        };
        v3
    }

    public fun set_paused<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &OrderPauseAdminCap<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_pause_admin<T0, T1>(arg0, arg1);
        arg0.paused = arg2;
        let v0 = OrderPauseUpdated{
            pool_id      : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            paused       : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OrderPauseUpdated>(v0);
    }

    public fun set_probability_weights<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &OrderProbabilityAdminCap<T0, T1>, arg2: vector<u64>, arg3: &0x2::clock::Clock) {
        assert_probability_admin<T0, T1>(arg0, arg1);
        let v0 = validate_probability_weights(&arg2);
        let v1 = arg0.probability_version;
        arg0.probability_weights = arg2;
        arg0.total_probability_weight = v0;
        arg0.probability_version = v1 + 1;
        let v2 = OrderProbabilityUpdated{
            pool_id                  : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            old_probability_version  : v1,
            new_probability_version  : arg0.probability_version,
            total_probability_weight : v0,
            timestamp_ms             : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OrderProbabilityUpdated>(v2);
    }

    entry fun subscribe_and_draw<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &mut 0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::ExchangePool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg8, arg10);
        let v1 = period_day_for_ticket(&arg0.probability_weights, 0x2::random::generate_u64_in_range(&mut v0, 0, arg0.total_probability_weight - 1));
        subscribe_with_period<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, arg9, arg10);
    }

    fun subscribe_with_period<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &mut 0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::ExchangePool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg0.exchange_pool_id == 0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::get_pool_id<T0, T1>(arg1), 2);
        assert!(arg8 >= 9 && arg8 <= 99, 4);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::get_usdc_unit<T0, T1>(arg1);
        assert!(v0 >= 100 * v1 && v0 <= 10000 * v1, 3);
        let (v2, v3) = 0xb9309bb0dd4b3e92c68f049edd56aa88160cb813c4f637d40d9887e15cede817::exchange::buy_for_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v4 = 0x2::tx_context::sender(arg10);
        create_order<T0, T1>(arg0, v2, v3, v4, v0, arg8, arg3, arg4, 0x2::clock::timestamp_ms(arg9), arg10);
    }

    fun total_profit_cap_ast(arg0: u64, arg1: u8) : u64 {
        let v0 = (arg0 as u128) * (get_daily_rate_e6(arg1) as u128) * (arg1 as u128) / 100000000;
        assert!(v0 <= 18446744073709551615, 17);
        (v0 as u64)
    }

    fun validate_probability_weights(arg0: &vector<u64>) : u64 {
        assert!(0x1::vector::length<u64>(arg0) == 91, 18);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 91) {
            v0 = v0 + (*0x1::vector::borrow<u64>(arg0, v1) as u128);
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 18);
        assert!(v0 <= 18446744073709551615, 19);
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

