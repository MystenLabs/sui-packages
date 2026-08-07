module 0xcf27b665bf7a2ba6df4068c72096fac0f2e351e9aa215b7ca71804f62b8889b9::order {
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
        paused: bool,
        fixed_payment_usdc: u64,
        reward_reserve: 0x2::balance::Balance<T0>,
        active_orders: u64,
        total_orders: u64,
        total_usdc_paid: u128,
        total_ast_principal: u128,
        total_ast_rewards_reserved: u128,
        locked_ast_principal: u128,
        locked_ast_rewards: u128,
        total_ast_redeemed: u128,
    }

    struct StakeOrder<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        exchange_pool_id: 0x2::object::ID,
        owner: address,
        payment_usdc: u64,
        principal_ast: 0x2::balance::Balance<T0>,
        reward_ast: 0x2::balance::Balance<T0>,
        period_days: u8,
        daily_rate_e6: u64,
        price_e8: u64,
        price_version: u64,
        created_at_ms: u64,
        unlock_at_ms: u64,
    }

    struct OrderPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        exchange_pool_id: 0x2::object::ID,
        admin: address,
        fixed_payment_usdc: u64,
        initial_reward_reserve: u64,
        timestamp_ms: u64,
    }

    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        exchange_pool_id: 0x2::object::ID,
        owner: address,
        payment_usdc: u64,
        principal_ast: u64,
        reward_ast: u64,
        period_days: u8,
        daily_rate_e6: u64,
        price_e8: u64,
        price_version: u64,
        created_at_ms: u64,
        unlock_at_ms: u64,
    }

    struct OrderRedeemed has copy, drop {
        order_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        owner: address,
        principal_ast: u64,
        reward_ast: u64,
        total_ast: u64,
        redeemed_at_ms: u64,
    }

    struct OrderPauseUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        timestamp_ms: u64,
    }

    struct RewardReserveUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        deposited: bool,
        amount: u64,
        reserve_after: u64,
        timestamp_ms: u64,
    }

    public fun get_pool_id<T0, T1>(arg0: &OrderPool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<OrderPool<T0, T1>>(arg0)
    }

    fun assert_admin<T0, T1>(arg0: &OrderPool<T0, T1>, arg1: &OrderAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<OrderPool<T0, T1>>(arg0), 7);
        assert!(arg1.exchange_pool_id == arg0.exchange_pool_id, 7);
    }

    fun calculate_reward(arg0: u64, arg1: u8, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) * (arg2 as u128) / (100000000 as u128);
        assert!(v0 <= 18446744073709551615, 6);
        (v0 as u64)
    }

    entry fun create_pool<T0, T1>(arg0: &0xcf27b665bf7a2ba6df4068c72096fac0f2e351e9aa215b7ca71804f62b8889b9::exchange::ExchangePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        create_pool_internal<T0, T1>(arg0, arg1, v0, arg2, arg3);
    }

    fun create_pool_internal<T0, T1>(arg0: &0xcf27b665bf7a2ba6df4068c72096fac0f2e351e9aa215b7ca71804f62b8889b9::exchange::ExchangePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcf27b665bf7a2ba6df4068c72096fac0f2e351e9aa215b7ca71804f62b8889b9::exchange::get_pool_id<T0, T1>(arg0);
        let v1 = 1000 * 0xcf27b665bf7a2ba6df4068c72096fac0f2e351e9aa215b7ca71804f62b8889b9::exchange::get_usdc_unit<T0, T1>(arg0);
        let v2 = OrderPool<T0, T1>{
            id                         : 0x2::object::new(arg4),
            schema_version             : 1,
            exchange_pool_id           : v0,
            paused                     : false,
            fixed_payment_usdc         : v1,
            reward_reserve             : 0x2::coin::into_balance<T0>(arg1),
            active_orders              : 0,
            total_orders               : 0,
            total_usdc_paid            : 0,
            total_ast_principal        : 0,
            total_ast_rewards_reserved : 0,
            locked_ast_principal       : 0,
            locked_ast_rewards         : 0,
            total_ast_redeemed         : 0,
        };
        let v3 = 0x2::object::id<OrderPool<T0, T1>>(&v2);
        let v4 = OrderAdminCap<T0, T1>{
            id               : 0x2::object::new(arg4),
            schema_version   : 1,
            pool_id          : v3,
            exchange_pool_id : v0,
        };
        let v5 = OrderPoolCreated{
            pool_id                : v3,
            exchange_pool_id       : v0,
            admin                  : arg2,
            fixed_payment_usdc     : v1,
            initial_reward_reserve : 0x2::coin::value<T0>(&arg1),
            timestamp_ms           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OrderPoolCreated>(v5);
        0x2::transfer::share_object<OrderPool<T0, T1>>(v2);
        0x2::transfer::transfer<OrderAdminCap<T0, T1>>(v4, arg2);
    }

    fun cumulative_weights() : vector<u64> {
        vector[5472, 14444, 28991, 52318, 89310, 147324, 237301, 375310, 584652, 898689, 1364575, 2048097, 3039843, 4462902, 6482292, 9316241, 13249375, 18647712, 25975215, 35811400, 48869262, 66012473, 88270513, 116850128, 153141261, 198715493, 255315031, 324830444, 409265737, 510689942, 631175198, 772722268, 937175555, 1126130787, 1340839651, 1582116538, 1850253174, 2144947167, 2465250237, 2809541190, 3175527475, 3560277539, 3960284255, 4371557593, 4789742659, 5210257351, 5628442417, 6039715755, 6439722471, 6824472535, 7190458820, 7534749773, 7855052843, 8149746836, 8417883472, 8659160359, 8873869223, 9062824455, 9227277742, 9368824812, 9489310068, 9590734273, 9675169566, 9744684979, 9801284517, 9846858749, 9883149882, 9911729497, 9933987537, 9951130748, 9964188610, 9974024795, 9981352298, 9986750635, 9990683769, 9993517718, 9995537108, 9996960167, 9997951913, 9998635435, 9999101321, 9999415358, 9999624700, 9999762709, 9999852686, 9999910700, 9999947692, 9999971019, 9999985566, 9999994538, 10000000010]
    }

    fun daily_rate_for_period(arg0: u8) : u64 {
        500000 + ((arg0 - 9) as u64) * 1000000 / 90
    }

    public fun deposit_reward_reserve<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &OrderAdminCap<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        0x2::balance::join<T0>(&mut arg0.reward_reserve, 0x2::coin::into_balance<T0>(arg2));
        let v0 = RewardReserveUpdated{
            pool_id       : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            deposited     : true,
            amount        : 0x2::coin::value<T0>(&arg2),
            reserve_after : 0x2::balance::value<T0>(&arg0.reward_reserve),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardReserveUpdated>(v0);
    }

    public fun get_admin_pool_id<T0, T1>(arg0: &OrderAdminCap<T0, T1>) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.pool_id, arg0.exchange_pool_id)
    }

    public fun get_daily_rate_e6(arg0: u8) : u64 {
        assert!(arg0 >= 9 && arg0 <= 99, 4);
        daily_rate_for_period(arg0)
    }

    public fun get_fixed_payment<T0, T1>(arg0: &OrderPool<T0, T1>) : u64 {
        arg0.fixed_payment_usdc
    }

    public fun get_order_info<T0, T1>(arg0: &StakeOrder<T0, T1>) : (0x2::object::ID, 0x2::object::ID, address, u64, u64, u64, u8, u64, u64, u64, u64, u64) {
        (arg0.pool_id, arg0.exchange_pool_id, arg0.owner, arg0.payment_usdc, 0x2::balance::value<T0>(&arg0.principal_ast), 0x2::balance::value<T0>(&arg0.reward_ast), arg0.period_days, arg0.daily_rate_e6, arg0.price_e8, arg0.price_version, arg0.created_at_ms, arg0.unlock_at_ms)
    }

    public fun get_pool_info<T0, T1>(arg0: &OrderPool<T0, T1>) : (u64, 0x2::object::ID, bool, u64, u64, u64, u128, u128, u128, u128, u128, u128) {
        (arg0.schema_version, arg0.exchange_pool_id, arg0.paused, arg0.fixed_payment_usdc, 0x2::balance::value<T0>(&arg0.reward_reserve), arg0.active_orders, arg0.total_usdc_paid, arg0.total_ast_principal, arg0.total_ast_rewards_reserved, arg0.locked_ast_principal, arg0.locked_ast_rewards, arg0.total_ast_redeemed)
    }

    public fun is_matured<T0, T1>(arg0: &StakeOrder<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_at_ms
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

    public fun quote_reward(arg0: u64, arg1: u8) : u64 {
        assert!(arg1 >= 9 && arg1 <= 99, 4);
        calculate_reward(arg0, arg1, daily_rate_for_period(arg1))
    }

    entry fun redeem<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: StakeOrder<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        redeem_internal<T0, T1>(arg0, arg1, v0, arg2, arg3);
    }

    fun redeem_internal<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: StakeOrder<T0, T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<OrderPool<T0, T1>>(arg0), 8);
        assert!(arg1.owner == arg2, 9);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.unlock_at_ms, 10);
        let v1 = 0x2::balance::value<T0>(&arg1.principal_ast);
        let v2 = 0x2::balance::value<T0>(&arg1.reward_ast);
        assert!(arg0.active_orders > 0, 11);
        assert!(arg0.locked_ast_principal >= (v1 as u128), 11);
        assert!(arg0.locked_ast_rewards >= (v2 as u128), 11);
        arg0.active_orders = arg0.active_orders - 1;
        arg0.locked_ast_principal = arg0.locked_ast_principal - (v1 as u128);
        arg0.locked_ast_rewards = arg0.locked_ast_rewards - (v2 as u128);
        arg0.total_ast_redeemed = arg0.total_ast_redeemed + (v1 as u128) + (v2 as u128);
        let StakeOrder {
            id               : v3,
            schema_version   : _,
            pool_id          : _,
            exchange_pool_id : _,
            owner            : _,
            payment_usdc     : _,
            principal_ast    : v9,
            reward_ast       : v10,
            period_days      : _,
            daily_rate_e6    : _,
            price_e8         : _,
            price_version    : _,
            created_at_ms    : _,
            unlock_at_ms     : _,
        } = arg1;
        let v17 = v9;
        0x2::object::delete(v3);
        0x2::balance::join<T0>(&mut v17, v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v17, arg4), arg2);
        let v18 = OrderRedeemed{
            order_id       : 0x2::object::id<StakeOrder<T0, T1>>(&arg1),
            pool_id        : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            owner          : arg2,
            principal_ast  : v1,
            reward_ast     : v2,
            total_ast      : v1 + v2,
            redeemed_at_ms : v0,
        };
        0x2::event::emit<OrderRedeemed>(v18);
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

    entry fun subscribe_and_draw<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &mut 0xcf27b665bf7a2ba6df4068c72096fac0f2e351e9aa215b7ca71804f62b8889b9::exchange::ExchangePool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg8, arg10);
        subscribe_with_period<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, period_day_for_ticket(0x2::random::generate_u64_in_range(&mut v0, 0, 10000000010 - 1)), arg9, arg10);
    }

    fun subscribe_with_period<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &mut 0xcf27b665bf7a2ba6df4068c72096fac0f2e351e9aa215b7ca71804f62b8889b9::exchange::ExchangePool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg0.exchange_pool_id == 0xcf27b665bf7a2ba6df4068c72096fac0f2e351e9aa215b7ca71804f62b8889b9::exchange::get_pool_id<T0, T1>(arg1), 2);
        assert!(0x2::coin::value<T1>(&arg2) == arg0.fixed_payment_usdc, 3);
        assert!(arg8 >= 9 && arg8 <= 99, 4);
        let (v0, v1) = 0xcf27b665bf7a2ba6df4068c72096fac0f2e351e9aa215b7ca71804f62b8889b9::exchange::buy_for_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v2 = daily_rate_for_period(arg8);
        let v3 = calculate_reward(v1, arg8, v2);
        assert!(0x2::balance::value<T0>(&arg0.reward_reserve) >= v3, 5);
        let v4 = 0x2::tx_context::sender(arg10);
        let v5 = 0x2::clock::timestamp_ms(arg9);
        let v6 = v5 + (arg8 as u64) * 86400000;
        let v7 = StakeOrder<T0, T1>{
            id               : 0x2::object::new(arg10),
            schema_version   : 1,
            pool_id          : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            exchange_pool_id : arg0.exchange_pool_id,
            owner            : v4,
            payment_usdc     : arg0.fixed_payment_usdc,
            principal_ast    : v0,
            reward_ast       : 0x2::balance::split<T0>(&mut arg0.reward_reserve, v3),
            period_days      : arg8,
            daily_rate_e6    : v2,
            price_e8         : arg3,
            price_version    : arg4,
            created_at_ms    : v5,
            unlock_at_ms     : v6,
        };
        arg0.active_orders = arg0.active_orders + 1;
        arg0.total_orders = arg0.total_orders + 1;
        arg0.total_usdc_paid = arg0.total_usdc_paid + (arg0.fixed_payment_usdc as u128);
        arg0.total_ast_principal = arg0.total_ast_principal + (v1 as u128);
        arg0.total_ast_rewards_reserved = arg0.total_ast_rewards_reserved + (v3 as u128);
        arg0.locked_ast_principal = arg0.locked_ast_principal + (v1 as u128);
        arg0.locked_ast_rewards = arg0.locked_ast_rewards + (v3 as u128);
        let v8 = OrderCreated{
            order_id         : 0x2::object::id<StakeOrder<T0, T1>>(&v7),
            pool_id          : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            exchange_pool_id : arg0.exchange_pool_id,
            owner            : v4,
            payment_usdc     : arg0.fixed_payment_usdc,
            principal_ast    : v1,
            reward_ast       : v3,
            period_days      : arg8,
            daily_rate_e6    : v2,
            price_e8         : arg3,
            price_version    : arg4,
            created_at_ms    : v5,
            unlock_at_ms     : v6,
        };
        0x2::event::emit<OrderCreated>(v8);
        0x2::transfer::transfer<StakeOrder<T0, T1>>(v7, v4);
    }

    public fun withdraw_reward_reserve<T0, T1>(arg0: &mut OrderPool<T0, T1>, arg1: &OrderAdminCap<T0, T1>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1);
        assert!(arg3 != @0x0, 12);
        assert!(0x2::balance::value<T0>(&arg0.reward_reserve) >= arg2, 5);
        let v0 = RewardReserveUpdated{
            pool_id       : 0x2::object::id<OrderPool<T0, T1>>(arg0),
            deposited     : false,
            amount        : arg2,
            reserve_after : 0x2::balance::value<T0>(&arg0.reward_reserve),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RewardReserveUpdated>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_reserve, arg2), arg5), arg3);
    }

    // decompiled from Move bytecode v7
}

