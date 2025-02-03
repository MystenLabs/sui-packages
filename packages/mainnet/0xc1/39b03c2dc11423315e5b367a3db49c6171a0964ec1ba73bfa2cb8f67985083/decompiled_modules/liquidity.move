module 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::liquidity {
    struct OpenPositionEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower_index: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32,
        tick_upper_index: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32,
    }

    struct ClosePositionEvent has copy, drop, store {
        sender: address,
        position_id: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
        amount_x: u64,
        amount_y: u64,
        upper_tick_index: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32,
        lower_tick_index: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32,
    }

    struct RemoveLiquidityEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
        amount_x: u64,
        amount_y: u64,
        upper_tick_index: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32,
        lower_tick_index: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>, arg1: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::Version, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::assert_current_version(arg7);
        let (v0, v1, v2, v3, v4) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3), arg6);
        assert!(v0 >= arg4 && v1 >= arg5, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::high_slippage());
        let v5 = AddLiquidityEvent{
            sender           : 0x2::tx_context::sender(arg8),
            pool_id          : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position>(arg1),
            liquidity        : v2,
            amount_x         : v0,
            amount_y         : v1,
            upper_tick_index : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::tick_upper_index(arg1),
            lower_tick_index : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::tick_lower_index(arg1),
        };
        0x2::event::emit<AddLiquidityEvent>(v5);
        (0x2::coin::from_balance<T0>(v3, arg8), 0x2::coin::from_balance<T1>(v4, arg8))
    }

    public fun close_position(arg0: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position, arg1: &0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::assert_current_version(arg1);
        assert!(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::is_empty(&arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::position_not_empty());
        let v0 = ClosePositionEvent{
            sender      : 0x2::tx_context::sender(arg2),
            position_id : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position>(&arg0),
        };
        0x2::event::emit<ClosePositionEvent>(v0);
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::close(arg0);
    }

    public fun open_position<T0, T1>(arg0: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>, arg1: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, arg2: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, arg3: &0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position {
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::assert_current_version(arg3);
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::verify_tick(arg1, arg2, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::tick_spacing<T0, T1>(arg0));
        let v0 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::open(0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::swap_fee_rate<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::type_x<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::type_y<T0, T1>(arg0), arg1, arg2, arg4);
        let v1 = OpenPositionEvent{
            sender           : 0x2::tx_context::sender(arg4),
            pool_id          : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position>(&v0),
            tick_lower_index : arg1,
            tick_upper_index : arg2,
        };
        0x2::event::emit<OpenPositionEvent>(v1);
        v0
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>, arg1: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position, arg2: u128, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::assert_current_version(arg6);
        let (v0, v1) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::remove_liquidity<T0, T1>(arg0, arg1, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::neg_from(arg2), arg5);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) >= arg3 && 0x2::balance::value<T1>(&v2) >= arg4, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::high_slippage());
        let v4 = RemoveLiquidityEvent{
            sender           : 0x2::tx_context::sender(arg7),
            pool_id          : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position>(arg1),
            liquidity        : arg2,
            amount_x         : 0x2::balance::value<T0>(&v3),
            amount_y         : 0x2::balance::value<T1>(&v2),
            upper_tick_index : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::tick_upper_index(arg1),
            lower_tick_index : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::tick_lower_index(arg1),
        };
        0x2::event::emit<RemoveLiquidityEvent>(v4);
        (0x2::coin::from_balance<T0>(v3, arg7), 0x2::coin::from_balance<T1>(v2, arg7))
    }

    // decompiled from Move bytecode v6
}

