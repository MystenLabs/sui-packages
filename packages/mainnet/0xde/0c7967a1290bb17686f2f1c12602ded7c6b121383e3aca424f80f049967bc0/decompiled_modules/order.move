module 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::order {
    struct OrderAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct OrderProbabilityAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct OrderPauseAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct OrderPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        swap_pool_id: 0x2::object::ID,
        admin: address,
        admin_version: u64,
        probability_admin: address,
        probability_admin_version: u64,
        pause_admin: address,
        pause_admin_version: u64,
        ast_receiver: address,
        paused: bool,
        probability_weights: vector<u64>,
        daily_rates_e6: vector<u64>,
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
        swap_pool_id: 0x2::object::ID,
        owner: address,
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
        swap_pool_id: 0x2::object::ID,
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

    struct OrderAdminUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        role: u8,
        old_admin: address,
        new_admin: address,
        role_version: u64,
        timestamp_ms: u64,
    }

    fun assert_pause_admin<T0, T1>(arg0: &OrderPool<T0, T1>, arg1: &OrderPauseAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<OrderPool<T0, T1>>(arg0), 7);
        assert!(arg1.swap_pool_id == arg0.swap_pool_id, 7);
        assert!(arg1.role_version == arg0.pause_admin_version, 7);
    }

    fun assert_probability_admin<T0, T1>(arg0: &OrderPool<T0, T1>, arg1: &OrderProbabilityAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<OrderPool<T0, T1>>(arg0), 7);
        assert!(arg1.swap_pool_id == arg0.swap_pool_id, 7);
        assert!(arg1.role_version == arg0.probability_admin_version, 7);
    }

    fun assert_valid_daily_rate(arg0: u64) {
        let v0 = if (arg0 > 0) {
            if (arg0 <= 100000000) {
                arg0 % 10000 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 21);
    }

    fun create_order<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: address, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = daily_rate_for_period(&arg0.daily_rates_e6, arg5);
        let v1 = arg0.next_order_no;
        let v2 = arg0.ast_receiver;
        arg0.next_order_no = v1 + 1;
        arg0.total_orders = arg0.total_orders + 1;
        arg0.total_usdc_paid = arg0.total_usdc_paid + (arg4 as u128);
        arg0.total_ast_principal = arg0.total_ast_principal + (arg2 as u128);
        arg0.total_ast_transferred = arg0.total_ast_transferred + (arg2 as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg9), v2);
        let v3 = OrderCreated{
            order_no             : v1,
            pool_id              : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            swap_pool_id         : arg0.swap_pool_id,
            owner                : arg3,
            ast_receiver         : v2,
            payment_usdc         : arg4,
            principal_ast        : arg2,
            period_days          : arg5,
            daily_rate_e6        : v0,
            total_profit_cap_ast : total_profit_cap_ast(arg2, arg5, v0),
            purchase_price_e8    : arg6,
            price_version        : arg7,
            probability_version  : arg0.probability_version,
            created_at_ms        : arg8,
        };
        0x2::event::emit<OrderCreated>(v3);
    }

    entry fun create_pool<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg2: address, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        create_pool_internal<T0, T1>(arg1, arg2, arg3, arg4, v0, v1, v2, arg5, arg6);
    }

    fun create_pool_internal<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: address, arg2: vector<u64>, arg3: vector<u64>, arg4: address, arg5: address, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 14);
        let v0 = if (arg4 != @0x0) {
            if (arg5 != @0x0) {
                arg6 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 20);
        let v1 = validate_probability_weights(&arg2);
        validate_daily_rates(&arg3);
        let v2 = 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_pool_id<T0, T1>(arg0);
        let v3 = OrderPool<T0, T1>{
            id                        : 0x2::object::new(arg8),
            schema_version            : 6,
            swap_pool_id              : v2,
            admin                     : arg4,
            admin_version             : 1,
            probability_admin         : arg5,
            probability_admin_version : 1,
            pause_admin               : arg6,
            pause_admin_version       : 1,
            ast_receiver              : arg1,
            paused                    : false,
            probability_weights       : arg2,
            daily_rates_e6            : arg3,
            total_probability_weight  : v1,
            probability_version       : 1,
            next_order_no             : 1,
            total_orders              : 0,
            total_usdc_paid           : 0,
            total_ast_principal       : 0,
            total_ast_transferred     : 0,
        };
        let v4 = 0x2::object::id<OrderPool<T0, T1>>(&v3);
        let v5 = OrderAdminCap<T0, T1>{
            id             : 0x2::object::new(arg8),
            schema_version : 6,
            pool_id        : v4,
            swap_pool_id   : v2,
            role_version   : 1,
        };
        let v6 = OrderProbabilityAdminCap<T0, T1>{
            id             : 0x2::object::new(arg8),
            schema_version : 6,
            pool_id        : v4,
            swap_pool_id   : v2,
            role_version   : 1,
        };
        let v7 = OrderPauseAdminCap<T0, T1>{
            id             : 0x2::object::new(arg8),
            schema_version : 6,
            pool_id        : v4,
            swap_pool_id   : v2,
            role_version   : 1,
        };
        let v8 = OrderPoolCreated{
            pool_id                  : v4,
            swap_pool_id             : v2,
            owner                    : 0x2::tx_context::sender(arg8),
            ast_receiver             : arg1,
            admin                    : arg4,
            probability_admin        : arg5,
            pause_admin              : arg6,
            total_probability_weight : v1,
            probability_version      : 1,
            timestamp_ms             : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<OrderPoolCreated>(v8);
        0x2::transfer::share_object<OrderPool<T0, T1>>(v3);
        0x2::transfer::transfer<OrderAdminCap<T0, T1>>(v5, arg4);
        0x2::transfer::transfer<OrderProbabilityAdminCap<T0, T1>>(v6, arg5);
        0x2::transfer::transfer<OrderPauseAdminCap<T0, T1>>(v7, arg6);
    }

    entry fun create_pool_with_roles<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg2: address, arg3: vector<u64>, arg4: vector<u64>, arg5: address, arg6: address, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg0);
        create_pool_internal<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun daily_rate_for_period(arg0: &vector<u64>, arg1: u8) : u64 {
        assert!(arg1 >= 9 && arg1 <= 99, 4);
        assert!(0x1::vector::length<u64>(arg0) == 91, 21);
        let v0 = *0x1::vector::borrow<u64>(arg0, ((arg1 - 9) as u64));
        assert_valid_daily_rate(v0);
        v0
    }

    fun emit_admin_updated<T0, T1>(arg0: &OrderPool<T0, T1>, arg1: u8, arg2: address, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = OrderAdminUpdated{
            pool_id      : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            role         : arg1,
            old_admin    : arg2,
            new_admin    : arg3,
            role_version : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<OrderAdminUpdated>(v0);
    }

    public fun get_admin_pool_id<T0, T1>(arg0: &OrderAdminCap<T0, T1>) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.pool_id, arg0.swap_pool_id)
    }

    public fun get_daily_rate_e6<T0, T1>(arg0: &OrderPool<T0, T1>, arg1: u8) : u64 {
        daily_rate_for_period(&arg0.daily_rates_e6, arg1)
    }

    public fun get_payment_range<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>) : (u64, u64) {
        let v0 = 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_usdc_unit<T0, T1>(arg0);
        (100 * v0, 10000 * v0)
    }

    public fun get_pool_id<T0, T1>(arg0: &OrderPool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<OrderPool<T0, T1>>(arg0)
    }

    public fun get_pool_info<T0, T1>(arg0: &OrderPool<T0, T1>) : (u64, 0x2::object::ID, address, bool, u64, u64, u128, u128, u128) {
        (arg0.schema_version, arg0.swap_pool_id, arg0.ast_receiver, arg0.paused, arg0.next_order_no, arg0.total_orders, arg0.total_usdc_paid, arg0.total_ast_principal, arg0.total_ast_transferred)
    }

    public fun get_probability_info<T0, T1>(arg0: &OrderPool<T0, T1>) : (u64, u64, vector<u64>, vector<u64>) {
        (arg0.probability_version, arg0.total_probability_weight, arg0.probability_weights, arg0.daily_rates_e6)
    }

    public fun get_role_info<T0, T1>(arg0: &OrderPool<T0, T1>) : (address, u64, address, u64, address, u64) {
        (arg0.admin, arg0.admin_version, arg0.probability_admin, arg0.probability_admin_version, arg0.pause_admin, arg0.pause_admin_version)
    }

    public fun get_total_profit_cap_ast(arg0: u64, arg1: u8, arg2: u64) : u64 {
        total_profit_cap_ast(arg0, arg1, arg2)
    }

    public fun owner_replace_admin<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 20);
        arg0.admin = arg2;
        arg0.admin_version = arg0.admin_version + 1;
        let v0 = arg0.admin_version;
        let v1 = OrderAdminCap<T0, T1>{
            id             : 0x2::object::new(arg4),
            schema_version : 6,
            pool_id        : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            swap_pool_id   : arg0.swap_pool_id,
            role_version   : v0,
        };
        emit_admin_updated<T0, T1>(arg0, 1, arg0.admin, arg2, v0, arg3);
        0x2::transfer::transfer<OrderAdminCap<T0, T1>>(v1, arg2);
    }

    public fun owner_replace_pause_admin<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 20);
        arg0.pause_admin = arg2;
        arg0.pause_admin_version = arg0.pause_admin_version + 1;
        let v0 = arg0.pause_admin_version;
        let v1 = OrderPauseAdminCap<T0, T1>{
            id             : 0x2::object::new(arg4),
            schema_version : 6,
            pool_id        : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            swap_pool_id   : arg0.swap_pool_id,
            role_version   : v0,
        };
        emit_admin_updated<T0, T1>(arg0, 3, arg0.pause_admin, arg2, v0, arg3);
        0x2::transfer::transfer<OrderPauseAdminCap<T0, T1>>(v1, arg2);
    }

    public fun owner_replace_probability_admin<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 20);
        arg0.probability_admin = arg2;
        arg0.probability_admin_version = arg0.probability_admin_version + 1;
        let v0 = arg0.probability_admin_version;
        let v1 = OrderProbabilityAdminCap<T0, T1>{
            id             : 0x2::object::new(arg4),
            schema_version : 6,
            pool_id        : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            swap_pool_id   : arg0.swap_pool_id,
            role_version   : v0,
        };
        emit_admin_updated<T0, T1>(arg0, 2, arg0.probability_admin, arg2, v0, arg3);
        0x2::transfer::transfer<OrderProbabilityAdminCap<T0, T1>>(v1, arg2);
    }

    public fun owner_set_paused<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg2: bool, arg3: &0x2::clock::Clock) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg1);
        set_paused_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun owner_set_probability_weights<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::clock::Clock) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg1);
        set_probability_weights_internal<T0, T1>(arg0, arg2, arg3, arg4);
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
        set_paused_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun set_paused_internal<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: bool, arg2: &0x2::clock::Clock) {
        arg0.paused = arg1;
        let v0 = OrderPauseUpdated{
            pool_id      : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            paused       : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OrderPauseUpdated>(v0);
    }

    public fun set_probability_weights<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &OrderProbabilityAdminCap<T0, T1>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::clock::Clock) {
        assert_probability_admin<T0, T1>(arg0, arg1);
        set_probability_weights_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    fun set_probability_weights_internal<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: vector<u64>, arg2: vector<u64>, arg3: &0x2::clock::Clock) {
        let v0 = validate_probability_weights(&arg1);
        validate_daily_rates(&arg2);
        let v1 = arg0.probability_version;
        arg0.probability_weights = arg1;
        arg0.daily_rates_e6 = arg2;
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

    entry fun subscribe_and_draw<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &mut 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg7, arg9);
        let v1 = period_day_for_ticket(&arg0.probability_weights, 0x2::random::generate_u64_in_range(&mut v0, 0, arg0.total_probability_weight - 1));
        subscribe_with_period<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v1, arg8, arg9);
    }

    fun subscribe_with_period<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &mut 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg0.swap_pool_id == 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_pool_id<T0, T1>(arg1), 2);
        assert!(arg7 >= 9 && arg7 <= 99, 4);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_usdc_unit<T0, T1>(arg1);
        assert!(v0 >= 100 * v1 && v0 <= 10000 * v1, 3);
        let (v2, v3) = 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::buy_for_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        let v4 = 0x2::tx_context::sender(arg9);
        create_order<T0, T1>(arg0, v2, v3, v4, v0, arg7, arg3, arg4, 0x2::clock::timestamp_ms(arg8), arg9);
    }

    fun total_profit_cap_ast(arg0: u64, arg1: u8, arg2: u64) : u64 {
        assert!(arg1 >= 9 && arg1 <= 99, 4);
        assert_valid_daily_rate(arg2);
        let v0 = (arg0 as u128) * (arg2 as u128) * (arg1 as u128) / 100000000;
        assert!(v0 <= 18446744073709551615, 17);
        (v0 as u64)
    }

    fun validate_daily_rates(arg0: &vector<u64>) {
        assert!(0x1::vector::length<u64>(arg0) == 91, 21);
        let v0 = 0;
        while (v0 < 91) {
            assert_valid_daily_rate(*0x1::vector::borrow<u64>(arg0, v0));
            v0 = v0 + 1;
        };
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

