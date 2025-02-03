module 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::tick_bitmap {
    public fun cast_to_u8(arg0: 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32) : u8 {
        assert!(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::abs_u32(arg0) < 256, 0);
        ((0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::abs_u32(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::add(arg0, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from(256))) & 255) as u8)
    }

    public(friend) fun flip_tick(arg0: &mut 0x2::table::Table<0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, u256>, arg1: 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, arg2: u32) {
        assert!(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::abs_u32(arg1) % arg2 == 0, 0);
        let (v0, v1) = position(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::div(arg1, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from(arg2)));
        let v2 = try_borrow_mut_tick_word(arg0, v0);
        *v2 = *v2 ^ 1 << v1;
    }

    public fun next_initialized_tick_within_one_word(arg0: &0x2::table::Table<0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, u256>, arg1: 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, arg2: u32, arg3: bool) : (0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, bool) {
        let v0 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from(arg2);
        let v1 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::div(arg1, v0);
        let v2 = v1;
        if (0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::is_neg(arg1) && 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::abs_u32(arg1) % arg2 != 0) {
            v2 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::sub(v1, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from(1));
        };
        if (arg3) {
            let (v5, v6) = position(v2);
            let v7 = try_get_tick_word(arg0, v5) & (1 << v6) - 1 + (1 << v6);
            let v8 = if (v7 != 0) {
                0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::mul(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::sub(v2, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::sub(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from((v6 as u32)), 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from((0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::bit_math::most_significant_bit(v7) as u32)))), v0)
            } else {
                0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::mul(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::sub(v2, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from((v6 as u32))), v0)
            };
            (v8, v7 != 0)
        } else {
            let (v9, v10) = position(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::add(v2, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from(1)));
            let v11 = try_get_tick_word(arg0, v9) & ((1 << v10) - 1 ^ 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::constants::max_u256());
            let v12 = if (v11 != 0) {
                0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::mul(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::add(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::add(v2, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from(1)), 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from((0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::bit_math::least_significant_bit(v11) as u32) - (v10 as u32))), v0)
            } else {
                0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::mul(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::add(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::add(v2, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from(1)), 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from((0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::constants::max_u8() as u32) - (v10 as u32))), v0)
            };
            (v12, v11 != 0)
        }
    }

    fun position(arg0: 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32) : (0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, u8) {
        (0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::shr(arg0, 8), cast_to_u8(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::mod(arg0, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::from(256))))
    }

    fun try_borrow_mut_tick_word(arg0: &mut 0x2::table::Table<0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, u256>, arg1: 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32) : &mut u256 {
        if (!0x2::table::contains<0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, u256>(arg0, arg1)) {
            0x2::table::add<0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, u256>(arg0, arg1, 0);
        };
        0x2::table::borrow_mut<0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, u256>(arg0, arg1)
    }

    fun try_get_tick_word(arg0: &0x2::table::Table<0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, u256>, arg1: 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32) : u256 {
        if (!0x2::table::contains<0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, u256>(arg0, arg1)) {
            0
        } else {
            *0x2::table::borrow<0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::i32::I32, u256>(arg0, arg1)
        }
    }

    // decompiled from Move bytecode v6
}

