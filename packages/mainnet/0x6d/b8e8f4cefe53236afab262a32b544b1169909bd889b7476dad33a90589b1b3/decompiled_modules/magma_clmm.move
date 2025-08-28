module 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::magma_clmm {
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

    struct PoolInfo has copy, drop, store {
        liquidity: u128,
        sqrt_price: u128,
        tick: u32,
    }

    struct QueryEvent has copy, drop, store {
        position_info: 0x1::option::Option<PositionInfoEvent>,
        pool_info: PoolInfo,
        timestamp_ms: u64,
        free_balance_x: u64,
        free_balance_y: u64,
    }

    public fun close_position<T0, T1>(arg0: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::only_operator_funder<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0, 0x2::tx_context::sender(arg4));
        let (v0, v1) = close_position_internal<T0, T1>(0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::extract_position<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0), arg1, arg2, arg3);
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::deposit<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, T0>(arg0, v0);
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::deposit<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, T1>(arg0, v1);
    }

    public entry fun add_more_liquidity<T0, T1>(arg0: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u32, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::has_position<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0), 5);
        assert!(0x2::clock::timestamp_ms(arg7) <= arg6, 6);
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2);
        assert!(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v0) == arg5, 4);
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::only_operator_funder<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0, 0x2::tx_context::sender(arg8));
        let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::tick_range(0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::borrow_position<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0));
        let (_, _, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(v1, v2, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), arg3, true);
        let (_, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(v1, v2, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), arg4, false);
        let v9 = if (v5 <= arg4) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::borrow_position_mut<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0), arg3, true, arg7, arg8)
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::borrow_position_mut<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0), arg4, false, arg7, arg8)
        };
        let v10 = v9;
        let (v11, v12) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v10);
        let (v13, v14) = 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::check_out<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, T0, T1>(arg0, v11, v12);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg1, arg2, v13, v14, v10);
        let v15 = AddMoreLiquidityEvent{
            position_id : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::borrow_position<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0)),
            tick_lower  : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v1),
            tick_upper  : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v2),
            amount_a    : v11,
            amount_b    : v12,
        };
        0x2::event::emit<AddMoreLiquidityEvent>(v15);
    }

    public(friend) fun close_position_internal<T0, T1>(arg0: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg1, arg2, &arg0, true);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&arg0);
        let (v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg0, v4, arg3);
        let v7 = v6;
        let v8 = v5;
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<T0, T1>(arg1, arg2, arg0);
        0x2::balance::join<T0>(&mut v3, v8);
        0x2::balance::join<T1>(&mut v2, v7);
        let v9 = ClosePositionEvent{
            position_id : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg0),
            liquidity   : v4,
            fee_a       : 0x2::balance::value<T0>(&v3),
            fee_b       : 0x2::balance::value<T1>(&v2),
            amount_a    : 0x2::balance::value<T0>(&v8),
            amount_b    : 0x2::balance::value<T1>(&v7),
        };
        0x2::event::emit<ClosePositionEvent>(v9);
        (v3, v2)
    }

    public fun close_position_reward1<T0, T1, T2>(arg0: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::only_operator_funder<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::extract_position<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg3, &v0, arg2, true, arg4);
        let (v2, v3) = close_position_internal<T0, T1>(v0, arg1, arg3, arg4);
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::deposit<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, T2>(arg0, v1);
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::deposit<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, T0>(arg0, v2);
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::deposit<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, T1>(arg0, v3);
    }

    public fun position_info(arg0: &0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>) {
        let v0 = 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::borrow_position<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0);
        let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::tick_range(v0);
        let v3 = PositionInfoEvent{
            position_id : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(v0),
            lower       : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v1),
            upper       : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v2),
            liquidity   : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(v0),
        };
        0x2::event::emit<PositionInfoEvent>(v3);
    }

    public fun query<T0, T1>(arg0: &0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        let v0 = if (0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::has_position<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0)) {
            let v1 = 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::borrow_position<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0);
            let (v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::tick_range(v1);
            let v4 = PositionInfoEvent{
                position_id : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(v1),
                lower       : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v2),
                upper       : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v3),
                liquidity   : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(v1),
            };
            0x1::option::some<PositionInfoEvent>(v4)
        } else {
            0x1::option::none<PositionInfoEvent>()
        };
        let (v5, v6) = 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::available_amounts<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, T0, T1>(arg0);
        let v7 = PoolInfo{
            liquidity  : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg1),
            sqrt_price : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1),
            tick       : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1)),
        };
        let v8 = QueryEvent{
            position_info  : v0,
            pool_info      : v7,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg2),
            free_balance_x : v5,
            free_balance_y : v6,
        };
        0x2::event::emit<QueryEvent>(v8);
    }

    public entry fun reposition<T0, T1>(arg0: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u32, arg6: u32, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7, 6);
        assert!(!0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::has_position<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0), 2);
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::only_operator_funder<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0, 0x2::tx_context::sender(arg9));
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2);
        assert!(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::gte(v0, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg5)) && 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::lt(v0, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg6)), 3);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg9);
        let (_, _, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg5), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg6), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), arg3, true);
        let (_, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg5), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg6), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), arg4, false);
        let v8 = if (v4 <= arg4) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v1, arg3, true, arg8, arg9)
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v1, arg4, false, arg8, arg9)
        };
        let v9 = v8;
        let (v10, v11) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v9);
        let (v12, v13) = 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::check_out<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, T0, T1>(arg0, v10, v11);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg1, arg2, v12, v13, v9);
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::fill_position<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0, v1);
        let v14 = RepositionEvent{
            position_id : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v1),
            tick_lower  : arg5,
            tick_upper  : arg6,
            amount_a    : v10,
            amount_b    : v11,
        };
        0x2::event::emit<RepositionEvent>(v14);
    }

    public entry fun reposition2<T0, T1>(arg0: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u32, arg6: u32, arg7: u32, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2)) == arg5, 4);
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::only_operator_funder<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0, 0x2::tx_context::sender(arg10));
        reposition<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10);
    }

    // decompiled from Move bytecode v6
}

