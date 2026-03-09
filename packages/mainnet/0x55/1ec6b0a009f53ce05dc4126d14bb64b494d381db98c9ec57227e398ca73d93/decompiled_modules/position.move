module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lower_tick_index: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
        upper_tick_index: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
        liquidity: u128,
        fee_growth_inside_x_last: u128,
        fee_growth_inside_y_last: u128,
        owed_coin_x: u64,
        owed_coin_y: u64,
    }

    struct LockedPosition has store, key {
        id: 0x2::object::UID,
        position: Position,
        fee_owner: address,
    }

    public(friend) fun new<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg3: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id                       : 0x2::object::new(arg3),
            pool_id                  : 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(arg0),
            lower_tick_index         : arg1,
            upper_tick_index         : arg2,
            liquidity                : 0,
            fee_growth_inside_x_last : 0,
            fee_growth_inside_y_last : 0,
            owed_coin_x              : 0,
            owed_coin_y              : 0,
        }
    }

    public fun id(arg0: &Position) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun clear_owed_balance(arg0: &mut Position) {
        arg0.owed_coin_y = 0;
        arg0.owed_coin_x = 0;
    }

    public(friend) fun close(arg0: Position) {
        assert!(arg0.owed_coin_x == 0, 3);
        assert!(arg0.owed_coin_y == 0, 3);
        assert!(arg0.liquidity == 0, 3);
        let Position {
            id                       : v0,
            pool_id                  : _,
            lower_tick_index         : _,
            upper_tick_index         : _,
            liquidity                : _,
            fee_growth_inside_x_last : _,
            fee_growth_inside_y_last : _,
            owed_coin_x              : _,
            owed_coin_y              : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun fee_owner(arg0: &LockedPosition) : address {
        arg0.fee_owner
    }

    public(friend) fun get_position(arg0: &mut LockedPosition) : &mut Position {
        &mut arg0.position
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public fun lock(arg0: Position, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : LockedPosition {
        LockedPosition{
            id        : 0x2::object::new(arg2),
            position  : arg0,
            fee_owner : arg1,
        }
    }

    public fun lower_tick_index(arg0: &Position) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32 {
        arg0.lower_tick_index
    }

    public fun owed_coin_x(arg0: &Position) : u64 {
        arg0.owed_coin_x
    }

    public fun owed_coin_y(arg0: &Position) : u64 {
        arg0.owed_coin_y
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun update(arg0: &mut Position, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128, arg2: u128, arg3: u128) {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg2, arg0.fee_growth_inside_x_last), arg0.liquidity, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::q64());
        let v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg3, arg0.fee_growth_inside_y_last), arg0.liquidity, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::q64());
        assert!(v0 <= (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::max_u64() as u128) && v1 <= (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::max_u64() as u128), 1);
        assert!(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u64::add_check(arg0.owed_coin_x, (v0 as u64)) && 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u64::add_check(arg0.owed_coin_y, (v1 as u64)), 2);
        let v2 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::eq(arg1, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero())) {
            arg0.liquidity
        } else {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(arg1)) {
                assert!(arg0.liquidity >= 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(arg1), 0);
                arg0.liquidity = arg0.liquidity - 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(arg1);
            } else {
                arg0.liquidity = arg0.liquidity + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(arg1);
            };
            arg0.liquidity
        };
        arg0.liquidity = v2;
        arg0.fee_growth_inside_x_last = arg2;
        arg0.fee_growth_inside_y_last = arg3;
        arg0.owed_coin_x = arg0.owed_coin_x + (v0 as u64);
        arg0.owed_coin_y = arg0.owed_coin_y + (v1 as u64);
    }

    public fun upper_tick_index(arg0: &Position) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32 {
        arg0.upper_tick_index
    }

    // decompiled from Move bytecode v6
}

