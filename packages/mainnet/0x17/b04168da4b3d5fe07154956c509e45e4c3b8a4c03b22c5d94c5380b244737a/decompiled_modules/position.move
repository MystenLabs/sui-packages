module 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        lower: u32,
        upper: u32,
        liquidity: u128,
        fee_growth_inside_x: u256,
        fee_growth_inside_y: u256,
        owed_x: u64,
        owed_y: u64,
    }

    struct PositionOpened has copy, drop {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
        owner: address,
        lower: u32,
        upper: u32,
    }

    struct PositionClosed has copy, drop {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : Position {
        let v0 = Position{
            id                  : 0x2::object::new(arg3),
            pool                : arg0,
            lower               : arg1,
            upper               : arg2,
            liquidity           : 0,
            fee_growth_inside_x : 0,
            fee_growth_inside_y : 0,
            owed_x              : 0,
            owed_y              : 0,
        };
        let v1 = PositionOpened{
            position : 0x2::object::id<Position>(&v0),
            pool     : arg0,
            owner    : 0x2::tx_context::sender(arg3),
            lower    : arg1,
            upper    : arg2,
        };
        0x2::event::emit<PositionOpened>(v1);
        v0
    }

    public(friend) fun add_liquidity(arg0: &mut Position, arg1: u128) {
        arg0.liquidity = arg0.liquidity + arg1;
    }

    public(friend) fun destroy(arg0: Position) {
        let v0 = if (arg0.liquidity == 0) {
            if (arg0.owed_x == 0) {
                arg0.owed_y == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = PositionClosed{
            position : 0x2::object::id<Position>(&arg0),
            pool     : arg0.pool,
        };
        0x2::event::emit<PositionClosed>(v1);
        let Position {
            id                  : v2,
            pool                : _,
            lower               : _,
            upper               : _,
            liquidity           : _,
            fee_growth_inside_x : _,
            fee_growth_inside_y : _,
            owed_x              : _,
            owed_y              : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    public fun fee_growth_inside(arg0: &Position) : (u256, u256) {
        (arg0.fee_growth_inside_x, arg0.fee_growth_inside_y)
    }

    public fun liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public fun lower(arg0: &Position) : u32 {
        arg0.lower
    }

    public fun owed(arg0: &Position) : (u64, u64) {
        (arg0.owed_x, arg0.owed_y)
    }

    public fun pool(arg0: &Position) : 0x2::object::ID {
        arg0.pool
    }

    public(friend) fun remove_liquidity(arg0: &mut Position, arg1: u128) {
        arg0.liquidity = arg0.liquidity - arg1;
    }

    public(friend) fun settle(arg0: &mut Position, arg1: u256, arg2: u256) {
        if (arg0.liquidity > 0) {
            let v0 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::fees_earned(arg0.liquidity, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(arg1, arg0.fee_growth_inside_x));
            let v1 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::fees_earned(arg0.liquidity, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(arg2, arg0.fee_growth_inside_y));
            let v2 = if (v0 > 18446744073709551615 - arg0.owed_x) {
                18446744073709551615
            } else {
                arg0.owed_x + v0
            };
            arg0.owed_x = v2;
            let v3 = if (v1 > 18446744073709551615 - arg0.owed_y) {
                18446744073709551615
            } else {
                arg0.owed_y + v1
            };
            arg0.owed_y = v3;
        };
        arg0.fee_growth_inside_x = arg1;
        arg0.fee_growth_inside_y = arg2;
    }

    public(friend) fun take_owed(arg0: &mut Position) : (u64, u64) {
        arg0.owed_x = 0;
        arg0.owed_y = 0;
        (arg0.owed_x, arg0.owed_y)
    }

    public fun upper(arg0: &Position) : u32 {
        arg0.upper
    }

    // decompiled from Move bytecode v7
}

