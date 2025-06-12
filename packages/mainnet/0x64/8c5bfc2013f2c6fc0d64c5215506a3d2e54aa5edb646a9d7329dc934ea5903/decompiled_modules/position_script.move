module 0xc9f008794e70543443bb49bc9719120a6d43bb2cf6b522ec924f495a36b7e69e::position_script {
    public entry fun position_fees_available<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::borrow_position_info(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::position_manager<T0, T1>(arg0), arg1);
        let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::info_tick_range(v0);
        let (v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::get_fee_in_tick_range<T0, T1>(arg0, v1, v2);
        let (v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::info_fee_growth_inside(v0);
        let (v7, v8) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::info_fee_owned(v0);
        ((0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::mul_shr(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::info_liquidity(v0), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u128::wrapping_sub(v3, v5), 64) as u64) + v7, (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::mul_shr(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::info_liquidity(v0), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u128::wrapping_sub(v4, v6), 64) as u64) + v8)
    }

    // decompiled from Move bytecode v6
}

