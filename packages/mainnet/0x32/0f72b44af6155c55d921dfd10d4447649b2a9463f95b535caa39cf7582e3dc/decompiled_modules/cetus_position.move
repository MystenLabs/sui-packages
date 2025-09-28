module 0x320f72b44af6155c55d921dfd10d4447649b2a9463f95b535caa39cf7582e3dc::cetus_position {
    struct CetusPosition has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        tick_lower: u32,
        tick_upper: u32,
        liquidity_amount_a: u64,
        liquidity_amount_b: u64,
        owner: address,
        created_at: u64,
        is_active: bool,
    }

    struct PositionCreated has copy, drop {
        position_id: address,
        pool_id: address,
        tick_lower: u32,
        tick_upper: u32,
        amount_a: u64,
        amount_b: u64,
        owner: address,
    }

    struct PositionClosed has copy, drop {
        position_id: address,
        pool_id: address,
        withdrawn_amount_a: u64,
        withdrawn_amount_b: u64,
        owner: address,
    }

    struct NewRange has copy, drop, store {
        tick_lower: u32,
        tick_upper: u32,
    }

    struct PositionRebalanced has copy, drop {
        position_id: address,
        old_tick_lower: u32,
        old_tick_upper: u32,
        new_tick_lower: u32,
        new_tick_upper: u32,
        owner: address,
    }

    struct GasVault has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::coin::Coin<0x2::sui::SUI>,
        owner: address,
        created_at: u64,
        total_deposited: u64,
        total_withdrawn: u64,
    }

    struct GasDeposited has copy, drop {
        vault_id: address,
        amount: u64,
        owner: address,
        new_balance: u64,
    }

    struct GasWithdrawn has copy, drop {
        vault_id: address,
        amount: u64,
        owner: address,
        remaining_balance: u64,
    }

    struct TWAPOrder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        keeper: address,
        coin_in_treasury: 0x2::coin::Coin<T0>,
        coin_out_treasury: 0x2::coin::Coin<T1>,
        total_orders: u64,
        order_amount: u64,
        interval_ms: u64,
        last_execution_time_ms: u64,
        orders_executed: u64,
        is_active: bool,
        created_at: u64,
    }

    struct TWAPOrderCreated has copy, drop {
        order_id: address,
        owner: address,
        total_amount: u64,
        total_orders: u64,
        interval_ms: u64,
        order_amount: u64,
    }

    struct TWAPSwapExecuted has copy, drop {
        order_id: address,
        owner: address,
        amount_in: u64,
        amount_out: u64,
        orders_executed: u64,
        orders_remaining: u64,
    }

    struct TWAPOrderCompleted has copy, drop {
        order_id: address,
        owner: address,
        total_amount_in: u64,
        total_amount_out: u64,
        orders_executed: u64,
    }

    public fun calculate_buy_the_dip_range(arg0: u32, arg1: u32, arg2: u32, arg3: u32) : NewRange {
        let v0 = (arg0 as u64) * (arg1 as u64) / 10000;
        let v1 = if (arg0 > (v0 as u32)) {
            arg0 - (v0 as u32)
        } else {
            0
        };
        let v2 = arg2 / 2;
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        NewRange{
            tick_lower : v3 / arg3 * arg3,
            tick_upper : (v1 + v2) / arg3 * arg3,
        }
    }

    public entry fun cancel_twap_order<T0, T1>(arg0: TWAPOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        finalize_twap_order<T0, T1>(arg0, arg1);
    }

    public fun close_position<T0, T1>(arg0: CetusPosition, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let CetusPosition {
            id                 : v1,
            pool_id            : v2,
            tick_lower         : _,
            tick_upper         : _,
            liquidity_amount_a : v5,
            liquidity_amount_b : v6,
            owner              : v7,
            created_at         : _,
            is_active          : _,
        } = arg0;
        let v10 = v1;
        assert!(v7 == v0, 0);
        let v11 = PositionClosed{
            position_id        : 0x2::object::uid_to_address(&v10),
            pool_id            : v2,
            withdrawn_amount_a : v5,
            withdrawn_amount_b : v6,
            owner              : v0,
        };
        0x2::event::emit<PositionClosed>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v5, arg3), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v6, arg3), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v0);
        0x2::object::delete(v10);
    }

    public fun create_gas_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v2 = GasVault{
            id              : 0x2::object::new(arg2),
            sui_balance     : arg0,
            owner           : v0,
            created_at      : 0x2::clock::timestamp_ms(arg1),
            total_deposited : v1,
            total_withdrawn : 0,
        };
        let v3 = GasDeposited{
            vault_id    : 0x2::object::uid_to_address(&v2.id),
            amount      : v1,
            owner       : v0,
            new_balance : v1,
        };
        0x2::event::emit<GasDeposited>(v3);
        0x2::transfer::transfer<GasVault>(v2, v0);
    }

    public fun create_position<T0, T1>(arg0: address, arg1: u32, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = 0x2::coin::value<T1>(&arg4);
        let v3 = CetusPosition{
            id                 : 0x2::object::new(arg6),
            pool_id            : arg0,
            tick_lower         : arg1,
            tick_upper         : arg2,
            liquidity_amount_a : v1,
            liquidity_amount_b : v2,
            owner              : v0,
            created_at         : 0x2::clock::timestamp_ms(arg5),
            is_active          : true,
        };
        let v4 = PositionCreated{
            position_id : 0x2::object::uid_to_address(&v3.id),
            pool_id     : arg0,
            tick_lower  : arg1,
            tick_upper  : arg2,
            amount_a    : v1,
            amount_b    : v2,
            owner       : v0,
        };
        0x2::event::emit<PositionCreated>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, v0);
        0x2::transfer::transfer<CetusPosition>(v3, v0);
    }

    public fun create_twap_order<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let v2 = v1 / arg2;
        assert!(v1 > 0, 104);
        assert!(arg2 > 0, 104);
        assert!(v2 > 0, 104);
        let v3 = TWAPOrder<T0, T1>{
            id                     : 0x2::object::new(arg5),
            owner                  : v0,
            keeper                 : v0,
            coin_in_treasury       : arg0,
            coin_out_treasury      : arg1,
            total_orders           : arg2,
            order_amount           : v2,
            interval_ms            : arg3,
            last_execution_time_ms : 0x2::clock::timestamp_ms(arg4),
            orders_executed        : 0,
            is_active              : true,
            created_at             : 0x2::clock::timestamp_ms(arg4),
        };
        let v4 = TWAPOrderCreated{
            order_id     : 0x2::object::uid_to_address(&v3.id),
            owner        : v0,
            total_amount : v1,
            total_orders : arg2,
            interval_ms  : arg3,
            order_amount : v2,
        };
        0x2::event::emit<TWAPOrderCreated>(v4);
        0x2::transfer::transfer<TWAPOrder<T0, T1>>(v3, v0);
    }

    public fun deposit_gas(arg0: &mut GasVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 101);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui_balance, arg1);
        arg0.total_deposited = arg0.total_deposited + v1;
        let v2 = GasDeposited{
            vault_id    : 0x2::object::uid_to_address(&arg0.id),
            amount      : v1,
            owner       : v0,
            new_balance : 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_balance),
        };
        0x2::event::emit<GasDeposited>(v2);
    }

    public fun destroy_empty_gas_vault(arg0: GasVault, arg1: &mut 0x2::tx_context::TxContext) {
        let GasVault {
            id              : v0,
            sui_balance     : v1,
            owner           : v2,
            created_at      : _,
            total_deposited : _,
            total_withdrawn : _,
        } = arg0;
        let v6 = v1;
        assert!(v2 == 0x2::tx_context::sender(arg1), 101);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v6) == 0, 103);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v6);
        0x2::object::delete(v0);
    }

    public fun destroy_position(arg0: CetusPosition, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let CetusPosition {
            id                 : v1,
            pool_id            : v2,
            tick_lower         : _,
            tick_upper         : _,
            liquidity_amount_a : v5,
            liquidity_amount_b : v6,
            owner              : v7,
            created_at         : _,
            is_active          : _,
        } = arg0;
        let v10 = v1;
        assert!(v7 == v0, 0);
        let v11 = PositionClosed{
            position_id        : 0x2::object::uid_to_address(&v10),
            pool_id            : v2,
            withdrawn_amount_a : v5,
            withdrawn_amount_b : v6,
            owner              : v0,
        };
        0x2::event::emit<PositionClosed>(v11);
        0x2::object::delete(v10);
    }

    public fun execute_twap_swap_simulation<T0, T1>(arg0: &mut TWAPOrder<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.keeper == 0x2::tx_context::sender(arg3), 101);
        assert!(arg0.is_active && arg0.orders_executed < arg0.total_orders, 102);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.last_execution_time_ms + arg0.interval_ms, 103);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        let v2 = 0x2::coin::split<T0>(&mut arg0.coin_in_treasury, arg0.order_amount, arg3);
        let v3 = 0x2::coin::value<T0>(&v2);
        0x2::coin::destroy_zero<T0>(0x2::coin::split<T0>(&mut v2, v3, arg3));
        0x2::coin::join<T1>(&mut arg0.coin_out_treasury, arg1);
        0x2::coin::join<T0>(&mut arg0.coin_in_treasury, v2);
        arg0.orders_executed = arg0.orders_executed + 1;
        arg0.last_execution_time_ms = v0;
        let v4 = TWAPSwapExecuted{
            order_id         : v1,
            owner            : arg0.owner,
            amount_in        : v3,
            amount_out       : 0x2::coin::value<T1>(&arg1),
            orders_executed  : arg0.orders_executed,
            orders_remaining : arg0.total_orders - arg0.orders_executed,
        };
        0x2::event::emit<TWAPSwapExecuted>(v4);
        if (arg0.orders_executed == arg0.total_orders) {
            arg0.is_active = false;
            let v5 = TWAPOrderCompleted{
                order_id         : v1,
                owner            : arg0.owner,
                total_amount_in  : v3 * arg0.total_orders,
                total_amount_out : 0x2::coin::value<T1>(&arg0.coin_out_treasury),
                orders_executed  : arg0.orders_executed,
            };
            0x2::event::emit<TWAPOrderCompleted>(v5);
        };
    }

    public fun finalize_twap_order<T0, T1>(arg0: TWAPOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let TWAPOrder {
            id                     : v1,
            owner                  : v2,
            keeper                 : _,
            coin_in_treasury       : v4,
            coin_out_treasury      : v5,
            total_orders           : _,
            order_amount           : _,
            interval_ms            : _,
            last_execution_time_ms : _,
            orders_executed        : _,
            is_active              : _,
            created_at             : _,
        } = arg0;
        let v13 = v5;
        let v14 = v4;
        assert!(v2 == v0, 101);
        if (0x2::coin::value<T0>(&v14) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v14);
        };
        if (0x2::coin::value<T1>(&v13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, v0);
        } else {
            0x2::coin::destroy_zero<T1>(v13);
        };
        0x2::object::delete(v1);
    }

    public fun get_gas_vault_info(arg0: &GasVault) : (u64, u64, u64, address) {
        (0x2::coin::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.total_deposited, arg0.total_withdrawn, arg0.owner)
    }

    public fun get_position_info(arg0: &CetusPosition) : (address, u32, u32, u64, u64, bool) {
        (arg0.pool_id, arg0.tick_lower, arg0.tick_upper, arg0.liquidity_amount_a, arg0.liquidity_amount_b, arg0.is_active)
    }

    public fun get_twap_order_info<T0, T1>(arg0: &TWAPOrder<T0, T1>) : (u64, u64, u64, u64, u64, bool) {
        (0x2::coin::value<T0>(&arg0.coin_in_treasury), 0x2::coin::value<T1>(&arg0.coin_out_treasury), arg0.orders_executed, arg0.total_orders, arg0.interval_ms, arg0.is_active)
    }

    public fun rebalance_position(arg0: &mut CetusPosition, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0, 101);
        arg0.tick_lower = arg1;
        arg0.tick_upper = arg2;
        let v1 = PositionRebalanced{
            position_id    : 0x2::object::uid_to_address(&arg0.id),
            old_tick_lower : arg0.tick_lower,
            old_tick_upper : arg0.tick_upper,
            new_tick_lower : arg1,
            new_tick_upper : arg2,
            owner          : v0,
        };
        0x2::event::emit<PositionRebalanced>(v1);
    }

    public entry fun rebalance_position_entry(arg0: &mut CetusPosition, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        rebalance_position(arg0, arg1, arg2, arg3);
    }

    public fun should_rebalance(arg0: u32, arg1: u32, arg2: &NewRange) : bool {
        arg0 != arg2.tick_lower || arg1 != arg2.tick_upper
    }

    public fun update_position(arg0: &mut CetusPosition, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        arg0.tick_lower = arg1;
        arg0.tick_upper = arg2;
    }

    public fun withdraw_gas(arg0: &mut GasVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 101);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 102);
        arg0.total_withdrawn = arg0.total_withdrawn + arg1;
        let v1 = GasWithdrawn{
            vault_id          : 0x2::object::uid_to_address(&arg0.id),
            amount            : arg1,
            owner             : v0,
            remaining_balance : 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_balance),
        };
        0x2::event::emit<GasWithdrawn>(v1);
        0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1, arg2)
    }

    public entry fun withdraw_gas_entry(arg0: &mut GasVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(withdraw_gas(arg0, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

