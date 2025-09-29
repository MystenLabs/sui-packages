module 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::mmt {
    struct RepositionEvent has copy, drop, store {
        position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        amount_a: u64,
        amount_b: u64,
    }

    struct AddMoreLiquidityEvent has copy, drop, store {
        position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        amount_a: u64,
        amount_b: u64,
    }

    struct ClosePositionEvent has copy, drop, store {
        position_id: 0x2::object::ID,
        liquidity: u128,
        fee_a: u64,
        fee_b: u64,
        amount_a: u64,
        amount_b: u64,
    }

    struct PositionInfoEvent has copy, drop, store {
        position_id: 0x2::object::ID,
        lower: u32,
        upper: u32,
        liquidity: u128,
    }

    public fun close_position<T0, T1>(arg0: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::only_operator_funder<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0x2::tx_context::sender(arg4));
        let (v0, v1) = close_position_internal<T0, T1>(arg1, 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::extract_position<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0), arg2, arg3, arg4);
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T0>(arg0, v0);
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T1>(arg0, v1);
    }

    public entry fun add_more_liquidity<T0, T1>(arg0: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u32, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::only_operator_funder<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0x2::tx_context::sender(arg8));
        assert!(0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::has_position<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0), 5);
        assert!(0x2::clock::timestamp_ms(arg7) <= arg5, 6);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg1)) == arg4, 4);
        assert!(!0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::stopped<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0), 7);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::borrow_position<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0));
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::borrow_position<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0));
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v0);
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v1);
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), v2, v3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amounts(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), v2, v3, arg2, arg3), true);
        let (v6, v7) = 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::check_out<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T0, T1>(arg0, v4, v5);
        let (v8, v9) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg1, 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::borrow_position_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0), 0x2::coin::from_balance<T0>(v6, arg8), 0x2::coin::from_balance<T1>(v7, arg8), v4, v5, arg7, arg6, arg8);
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T0>(arg0, 0x2::coin::into_balance<T0>(v8));
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T1>(arg0, 0x2::coin::into_balance<T1>(v9));
        let v10 = AddMoreLiquidityEvent{
            position_id : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::borrow_position<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0)),
            tick_lower  : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v0),
            tick_upper  : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v1),
            amount_a    : v4,
            amount_b    : v5,
        };
        0x2::event::emit<AddMoreLiquidityEvent>(v10);
    }

    public(friend) fun close_position_internal<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg0, &mut arg1, arg3, arg2, arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&arg1);
        let (v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(&arg1)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(&arg1)), v4, true);
        let (v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg0, &mut arg1, v4, v5, v6, arg3, arg2, arg4);
        let v9 = v8;
        let v10 = v7;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(arg1, arg2, arg4);
        0x2::coin::join<T0>(&mut v3, v10);
        0x2::coin::join<T1>(&mut v2, v9);
        let v11 = ClosePositionEvent{
            position_id : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg1),
            liquidity   : v4,
            fee_a       : 0x2::coin::value<T0>(&v3),
            fee_b       : 0x2::coin::value<T1>(&v2),
            amount_a    : 0x2::coin::value<T0>(&v10),
            amount_b    : 0x2::coin::value<T1>(&v9),
        };
        0x2::event::emit<ClosePositionEvent>(v11);
        (0x2::coin::into_balance<T0>(v3), 0x2::coin::into_balance<T1>(v2))
    }

    public fun close_position_reward1<T0, T1, T2>(arg0: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::only_operator_funder<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::extract_position<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg1, &mut v0, arg3, arg2, arg4);
        let (v2, v3) = close_position_internal<T0, T1>(arg1, v0, arg2, arg3, arg4);
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T2>(arg0, 0x2::coin::into_balance<T2>(v1));
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T0>(arg0, v2);
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T1>(arg0, v3);
    }

    public fun position_info(arg0: &0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>) {
        let v0 = 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::borrow_position<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0);
        let v1 = PositionInfoEvent{
            position_id : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(v0),
            lower       : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(v0)),
            upper       : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(v0)),
            liquidity   : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(v0),
        };
        0x2::event::emit<PositionInfoEvent>(v1);
    }

    public entry fun reposition<T0, T1>(arg0: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u32, arg5: u32, arg6: u64, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::only_operator_funder<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0x2::tx_context::sender(arg9));
        assert!(0x2::clock::timestamp_ms(arg8) <= arg6, 6);
        assert!(!0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::has_position<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0), 2);
        assert!(!0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::stopped<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0), 7);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg1);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg4);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg5);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v0, v1) && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lt(v0, v2), 3);
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg1, v1, v2, arg7, arg9);
        let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v1);
        let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v2);
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), v4, v5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amounts(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), v4, v5, arg2, arg3), true);
        let (v8, v9) = 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::check_out<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T0, T1>(arg0, v6, v7);
        let (v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg1, &mut v3, 0x2::coin::from_balance<T0>(v8, arg9), 0x2::coin::from_balance<T1>(v9, arg9), v6, v7, arg8, arg7, arg9);
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T0>(arg0, 0x2::coin::into_balance<T0>(v10));
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, T1>(arg0, 0x2::coin::into_balance<T1>(v11));
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::fill_position<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, v3);
        let v12 = RepositionEvent{
            position_id : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&v3),
            tick_lower  : arg4,
            tick_upper  : arg5,
            amount_a    : v6,
            amount_b    : v7,
        };
        0x2::event::emit<RepositionEvent>(v12);
    }

    public entry fun reposition2<T0, T1>(arg0: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u32, arg5: u32, arg6: u32, arg7: u64, arg8: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::only_operator_funder<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0x2::tx_context::sender(arg10));
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg1)) == arg4, 4);
        assert!(!0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::stopped<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0), 7);
        reposition<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    // decompiled from Move bytecode v6
}

