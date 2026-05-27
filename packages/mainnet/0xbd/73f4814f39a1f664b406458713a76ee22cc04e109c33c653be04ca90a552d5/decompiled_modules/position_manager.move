module 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position_manager {
    struct PositionRegistry has store, key {
        id: 0x2::object::UID,
        num_positions: u64,
    }

    struct Open has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower_index: 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::i32::I32,
        tick_upper_index: 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::i32::I32,
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

    struct Collect has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    public fun collect<T0, T1>(arg0: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::PoolRegistry, arg1: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position, arg2: u64, arg3: u64, arg4: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::check_order<T0, T1>();
        if (arg2 == 0 && arg3 == 0) {
            abort 2
        };
        let v0 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::borrow_mut_pool<T0, T1>(arg0, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::fee_rate(arg1));
        if (0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::liquidity(arg1) > 0) {
            let (_, _) = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::modify_liquidity<T0, T1>(v0, arg1, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::i128::zero(), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg4, arg5, arg6);
        };
        let (v3, v4) = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::collect<T0, T1>(v0, arg1, arg2, arg3, arg4, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = Collect{
            sender      : 0x2::tx_context::sender(arg6),
            pool_id     : 0x2::object::id<0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::Pool<T0, T1>>(v0),
            position_id : 0x2::object::id<0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position>(arg1),
            amount_x    : 0x2::balance::value<T0>(&v6),
            amount_y    : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<Collect>(v7);
        (0x2::coin::from_balance<T0>(v6, arg6), 0x2::coin::from_balance<T1>(v5, arg6))
    }

    public fun collect_pool_reward<T0, T1, T2>(arg0: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::PoolRegistry, arg1: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position, arg2: u64, arg3: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::check_order<T0, T1>();
        if (arg2 == 0) {
            abort 2
        };
        let v0 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::borrow_mut_pool<T0, T1>(arg0, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::fee_rate(arg1));
        if (0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::liquidity(arg1) > 0) {
            let (_, _) = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::modify_liquidity<T0, T1>(v0, arg1, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::i128::zero(), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg3, arg4, arg5);
        };
        0x2::coin::from_balance<T2>(0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::collect_pool_reward<T0, T1, T2>(v0, arg1, arg2, arg3, arg5), arg5)
    }

    public fun close_position(arg0: &mut PositionRegistry, arg1: 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position, arg2: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::check_version(arg2);
        if (!0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::is_empty(&arg1)) {
            abort 0
        };
        let v0 = Close{
            sender      : 0x2::tx_context::sender(arg3),
            position_id : 0x2::object::id<0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position>(&arg1),
        };
        0x2::event::emit<Close>(v0);
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::close(arg1);
        arg0.num_positions = arg0.num_positions - 1;
    }

    public fun decrease_liquidity<T0, T1>(arg0: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::PoolRegistry, arg1: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::check_order<T0, T1>();
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::check_deadline(arg7, arg5);
        let v0 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::borrow_mut_pool<T0, T1>(arg0, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::fee_rate(arg1));
        let (v1, v2) = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::modify_liquidity<T0, T1>(v0, arg1, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::i128::neg_from(arg2), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg6, arg7, arg8);
        if (v1 < arg3 || v2 < arg4) {
            abort 1
        };
        let v3 = DecreaseLiquidity{
            sender      : 0x2::tx_context::sender(arg8),
            pool_id     : 0x2::object::id<0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::Pool<T0, T1>>(v0),
            position_id : 0x2::object::id<0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position>(arg1),
            liquidity   : arg2,
            amount_x    : v1,
            amount_y    : v2,
        };
        0x2::event::emit<DecreaseLiquidity>(v3);
    }

    public fun increase_liquidity<T0, T1>(arg0: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::PoolRegistry, arg1: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2;
        let v1 = &mut arg3;
        increase_liquidity_<T0, T1>(arg0, arg1, v0, v1, arg4, arg5, arg6, arg7, arg8, arg9);
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::refund<T0>(arg2, 0x2::tx_context::sender(arg9));
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::refund<T1>(arg3, 0x2::tx_context::sender(arg9));
    }

    fun increase_liquidity_<T0, T1>(arg0: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::PoolRegistry, arg1: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::check_order<T0, T1>();
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::check_deadline(arg8, arg6);
        let v0 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::borrow_mut_pool<T0, T1>(arg0, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::fee_rate(arg1));
        let v1 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::sqrt_price_current<T0, T1>(v0);
        let v2 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::tick_math::get_sqrt_price_at_tick(0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::tick_lower_index(arg1));
        let v3 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::tick_math::get_sqrt_price_at_tick(0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::tick_upper_index(arg1));
        let v4 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::liquidity_math::get_liquidity_for_amounts(v1, v2, v3, 0x2::coin::value<T0>(arg2), 0x2::coin::value<T1>(arg3));
        let (v5, v6) = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::liquidity_math::get_amounts_for_liquidity(v1, v2, v3, v4, true);
        if (v5 < arg4 || v6 < arg5) {
            abort 1
        };
        let (v7, v8) = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::modify_liquidity<T0, T1>(v0, arg1, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::i128::from(v4), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v5, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v6, arg9)), arg7, arg8, arg9);
        let v9 = IncreaseLiquidity{
            sender      : 0x2::tx_context::sender(arg9),
            pool_id     : 0x2::object::id<0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::Pool<T0, T1>>(v0),
            position_id : 0x2::object::id<0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position>(arg1),
            liquidity   : v4,
            amount_x    : v7,
            amount_y    : v8,
        };
        0x2::event::emit<IncreaseLiquidity>(v9);
    }

    public fun increase_liquidity_v2<T0, T1>(arg0: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::PoolRegistry, arg1: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        increase_liquidity_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionRegistry{
            id            : 0x2::object::new(arg0),
            num_positions : 0,
        };
        0x2::transfer::share_object<PositionRegistry>(v0);
    }

    public fun open_position<T0, T1>(arg0: &mut PositionRegistry, arg1: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::PoolRegistry, arg2: u64, arg3: 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::i32::I32, arg4: 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::i32::I32, arg5: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) : 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position {
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::check_version(arg5);
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::check_order<T0, T1>();
        let v0 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::borrow_pool<T0, T1>(arg1, arg2);
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::tick::check_ticks(arg3, arg4, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::tick_spacing<T0, T1>(v0));
        let v1 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::open(0x2::object::id<0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::Pool<T0, T1>>(v0), 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::swap_fee_rate<T0, T1>(v0), 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::coin_type_x<T0, T1>(v0), 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::coin_type_y<T0, T1>(v0), arg3, arg4, arg6);
        arg0.num_positions = arg0.num_positions + 1;
        let v2 = Open{
            sender           : 0x2::tx_context::sender(arg6),
            pool_id          : 0x2::object::id<0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::Pool<T0, T1>>(v0),
            position_id      : 0x2::object::id<0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position>(&v1),
            tick_lower_index : arg3,
            tick_upper_index : arg4,
        };
        0x2::event::emit<Open>(v2);
        v1
    }

    public fun open_position_by_sqrt_price<T0, T1>(arg0: &mut PositionRegistry, arg1: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::PoolRegistry, arg2: u64, arg3: u128, arg4: u128, arg5: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) : 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position {
        if (arg3 > arg4) {
            let v0 = arg3;
            arg3 = arg4;
            arg4 = v0;
        };
        if (arg3 == arg4) {
            abort 2
        };
        open_position<T0, T1>(arg0, arg1, arg2, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::tick_math::get_tick_at_sqrt_price(arg3), 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::tick_math::get_tick_at_sqrt_price(arg4), arg5, arg6)
    }

    public fun rebalance<T0, T1>(arg0: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::PoolRegistry, arg1: &mut PositionRegistry, arg2: 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position, arg3: u128, arg4: u128, arg5: bool, arg6: u64, arg7: u128, arg8: u64, arg9: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position {
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::check_version(arg9);
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::check_order<T0, T1>();
        let v0 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::fee_rate(&arg2);
        let v1 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::liquidity(&arg2);
        if (v1 > 0) {
            let v2 = &mut arg2;
            decrease_liquidity<T0, T1>(arg0, v2, v1, 0, 0, arg8, arg9, arg10, arg11);
        };
        let v3 = &mut arg2;
        let (v4, v5) = collect<T0, T1>(arg0, v3, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::constants::get_max_u64(), 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::constants::get_max_u64(), arg9, arg10, arg11);
        let v6 = v5;
        let v7 = v4;
        close_position(arg1, arg2, arg9, arg11);
        if (arg6 > 0) {
            let v8 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::borrow_mut_pool<T0, T1>(arg0, v0);
            if (arg5) {
                let (v9, v10, v11) = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::swap<T0, T1>(v8, true, true, arg6, arg7, arg9, arg10, arg11);
                0x2::balance::destroy_zero<T0>(v9);
                0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::pay<T0, T1>(v8, v11, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v7, arg6, arg11)), 0x2::balance::zero<T1>(), arg9, arg11);
                0x2::coin::join<T1>(&mut v6, 0x2::coin::from_balance<T1>(v10, arg11));
            } else {
                let (v12, v13, v14) = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::swap<T0, T1>(v8, false, true, arg6, arg7, arg9, arg10, arg11);
                0x2::balance::destroy_zero<T1>(v13);
                0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::pay<T0, T1>(v8, v14, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, arg6, arg11)), arg9, arg11);
                0x2::coin::join<T0>(&mut v7, 0x2::coin::from_balance<T0>(v12, arg11));
            };
        };
        let v15 = open_position_by_sqrt_price<T0, T1>(arg1, arg0, v0, arg3, arg4, arg9, arg11);
        let v16 = &mut v15;
        let v17 = &mut v7;
        let v18 = &mut v6;
        increase_liquidity_<T0, T1>(arg0, v16, v17, v18, 0, 0, arg8, arg9, arg10, arg11);
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::refund<T0>(v7, 0x2::tx_context::sender(arg11));
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::refund<T1>(v6, 0x2::tx_context::sender(arg11));
        v15
    }

    public fun rebalance_by_ticks<T0, T1>(arg0: &mut 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::PoolRegistry, arg1: &mut PositionRegistry, arg2: 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position, arg3: 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::i32::I32, arg4: 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::i32::I32, arg5: bool, arg6: u64, arg7: u128, arg8: u64, arg9: &0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::Position {
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::versioned::check_version(arg9);
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::check_order<T0, T1>();
        let v0 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::fee_rate(&arg2);
        let v1 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::position::liquidity(&arg2);
        if (v1 > 0) {
            let v2 = &mut arg2;
            decrease_liquidity<T0, T1>(arg0, v2, v1, 0, 0, arg8, arg9, arg10, arg11);
        };
        let v3 = &mut arg2;
        let (v4, v5) = collect<T0, T1>(arg0, v3, 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::constants::get_max_u64(), 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::constants::get_max_u64(), arg9, arg10, arg11);
        let v6 = v5;
        let v7 = v4;
        close_position(arg1, arg2, arg9, arg11);
        if (arg6 > 0) {
            let v8 = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool_manager::borrow_mut_pool<T0, T1>(arg0, v0);
            if (arg5) {
                let (v9, v10, v11) = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::swap<T0, T1>(v8, true, true, arg6, arg7, arg9, arg10, arg11);
                0x2::balance::destroy_zero<T0>(v9);
                0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::pay<T0, T1>(v8, v11, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v7, arg6, arg11)), 0x2::balance::zero<T1>(), arg9, arg11);
                0x2::coin::join<T1>(&mut v6, 0x2::coin::from_balance<T1>(v10, arg11));
            } else {
                let (v12, v13, v14) = 0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::swap<T0, T1>(v8, false, true, arg6, arg7, arg9, arg10, arg11);
                0x2::balance::destroy_zero<T1>(v13);
                0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::pool::pay<T0, T1>(v8, v14, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, arg6, arg11)), arg9, arg11);
                0x2::coin::join<T0>(&mut v7, 0x2::coin::from_balance<T0>(v12, arg11));
            };
        };
        let v15 = open_position<T0, T1>(arg1, arg0, v0, arg3, arg4, arg9, arg11);
        let v16 = &mut v15;
        let v17 = &mut v7;
        let v18 = &mut v6;
        increase_liquidity_<T0, T1>(arg0, v16, v17, v18, 0, 0, arg8, arg9, arg10, arg11);
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::refund<T0>(v7, 0x2::tx_context::sender(arg11));
        0xbd73f4814f39a1f664b406458713a76ee22cc04e109c33c653be04ca90a552d5::utils::refund<T1>(v6, 0x2::tx_context::sender(arg11));
        v15
    }

    // decompiled from Move bytecode v7
}

