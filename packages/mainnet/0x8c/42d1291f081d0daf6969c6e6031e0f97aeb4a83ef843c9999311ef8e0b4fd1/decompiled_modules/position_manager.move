module 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position_manager {
    struct PositionRegistry has store, key {
        id: 0x2::object::UID,
        num_positions: u64,
    }

    struct Open has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower_index: 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::i32::I32,
        tick_upper_index: 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::i32::I32,
    }

    struct Close has copy, drop, store {
        sender: address,
        position_id: 0x2::object::ID,
    }

    struct IncreaseLiquidity has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
        amount_x: u64,
        amount_y: u64,
    }

    struct DecreaseLiquidity has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
        amount_x: u64,
        amount_y: u64,
    }

    public fun collect<T0, T1>(arg0: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool_manager::PoolRegistry, arg1: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::Position, arg2: u64, arg3: u64, arg4: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::check_order<T0, T1>();
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::check_zero_amount(arg2);
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::check_zero_amount(arg3);
        let v0 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool_manager::borrow_mut_pool<T0, T1>(arg0, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::fee_rate(arg1));
        if (0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::liquidity(arg1) > 0) {
            let (_, _) = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::modify_liquidity<T0, T1>(v0, arg1, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::i128::zero(), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg4, arg5, arg6);
        };
        let (v3, v4) = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::collect<T0, T1>(v0, arg1, arg2, arg3, arg4, arg6);
        (0x2::coin::from_balance<T0>(v3, arg6), 0x2::coin::from_balance<T1>(v4, arg6))
    }

    public fun collect_pool_reward<T0, T1, T2>(arg0: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool_manager::PoolRegistry, arg1: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::Position, arg2: u64, arg3: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::check_order<T0, T1>();
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::check_zero_amount(arg2);
        let v0 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool_manager::borrow_mut_pool<T0, T1>(arg0, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::fee_rate(arg1));
        if (0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::liquidity(arg1) > 0) {
            let (_, _) = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::modify_liquidity<T0, T1>(v0, arg1, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::i128::zero(), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg3, arg4, arg5);
        };
        0x2::coin::from_balance<T2>(0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::collect_pool_reward<T0, T1, T2>(v0, arg1, arg2, arg3, arg5), arg5)
    }

    public fun close_position(arg0: &mut PositionRegistry, arg1: 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::Position, arg2: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::versioned::check_version_and_upgrade(arg2);
        let v0 = if (0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::liquidity(&arg1) != 0) {
            true
        } else if (0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::coins_owed_x(&arg1) != 0) {
            true
        } else {
            0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::coins_owed_y(&arg1) != 0
        };
        if (v0) {
            abort 0
        };
        let v1 = Close{
            sender      : 0x2::tx_context::sender(arg3),
            position_id : 0x2::object::id<0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::Position>(&arg1),
        };
        0x2::event::emit<Close>(v1);
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::close(arg1);
        arg0.num_positions = arg0.num_positions - 1;
    }

    public fun decrease_liquidity<T0, T1>(arg0: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool_manager::PoolRegistry, arg1: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::Position, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::check_order<T0, T1>();
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::check_deadline(arg7, arg5);
        let v0 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool_manager::borrow_mut_pool<T0, T1>(arg0, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::fee_rate(arg1));
        let (v1, v2) = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::modify_liquidity<T0, T1>(v0, arg1, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::i128::neg_from(arg2), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg6, arg7, arg8);
        if (v1 < arg3 || v2 < arg4) {
            abort 1
        };
        let v3 = DecreaseLiquidity{
            sender      : 0x2::tx_context::sender(arg8),
            pool_id     : 0x2::object::id<0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::Pool<T0, T1>>(v0),
            position_id : 0x2::object::id<0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::Position>(arg1),
            liquidity   : arg2,
            amount_x    : v1,
            amount_y    : v2,
        };
        0x2::event::emit<DecreaseLiquidity>(v3);
    }

    public fun increase_liquidity<T0, T1>(arg0: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool_manager::PoolRegistry, arg1: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::check_order<T0, T1>();
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::check_deadline(arg8, arg6);
        let v0 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool_manager::borrow_mut_pool<T0, T1>(arg0, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::fee_rate(arg1));
        let v1 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::sqrt_price_current<T0, T1>(v0);
        let v2 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::tick_math::get_sqrt_price_at_tick(0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::tick_lower_index(arg1));
        let v3 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::tick_math::get_sqrt_price_at_tick(0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::tick_upper_index(arg1));
        let v4 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::liquidity_math::get_liquidity_for_amounts(v1, v2, v3, 0x2::coin::value<T0>(&arg2), 0x2::coin::value<T1>(&arg3));
        let (v5, v6) = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::liquidity_math::get_amounts_for_liquidity(v1, v2, v3, v4, true);
        if (v5 < arg4 || v6 < arg5) {
            abort 1
        };
        let (v7, v8) = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::modify_liquidity<T0, T1>(v0, arg1, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::i128::from(v4), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v5, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v6, arg9)), arg7, arg8, arg9);
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::refund<T0>(arg2, 0x2::tx_context::sender(arg9));
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::refund<T1>(arg3, 0x2::tx_context::sender(arg9));
        let v9 = IncreaseLiquidity{
            sender      : 0x2::tx_context::sender(arg9),
            pool_id     : 0x2::object::id<0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::Pool<T0, T1>>(v0),
            position_id : 0x2::object::id<0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::Position>(arg1),
            liquidity   : v4,
            amount_x    : v7,
            amount_y    : v8,
        };
        0x2::event::emit<IncreaseLiquidity>(v9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionRegistry{
            id            : 0x2::object::new(arg0),
            num_positions : 0,
        };
        0x2::transfer::share_object<PositionRegistry>(v0);
    }

    public fun open_position<T0, T1>(arg0: &mut PositionRegistry, arg1: &0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool_manager::PoolRegistry, arg2: u64, arg3: 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::i32::I32, arg4: 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::i32::I32, arg5: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) : 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::Position {
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::versioned::check_version_and_upgrade(arg5);
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::utils::check_order<T0, T1>();
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::tick::check_ticks(arg3, arg4);
        let v0 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool_manager::borrow_pool<T0, T1>(arg1, arg2);
        let v1 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::open(0x2::object::id<0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::Pool<T0, T1>>(v0), 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::swap_fee_rate<T0, T1>(v0), 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::coin_type_x<T0, T1>(v0), 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::coin_type_y<T0, T1>(v0), arg3, arg4, arg6);
        arg0.num_positions = arg0.num_positions + 1;
        let v2 = Open{
            sender           : 0x2::tx_context::sender(arg6),
            pool_id          : 0x2::object::id<0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::pool::Pool<T0, T1>>(v0),
            position_id      : 0x2::object::id<0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::position::Position>(&v1),
            tick_lower_index : arg3,
            tick_upper_index : arg4,
        };
        0x2::event::emit<Open>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

