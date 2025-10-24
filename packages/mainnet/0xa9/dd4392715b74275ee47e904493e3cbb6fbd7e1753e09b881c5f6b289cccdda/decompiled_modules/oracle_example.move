module 0xa9dd4392715b74275ee47e904493e3cbb6fbd7e1753e09b881c5f6b289cccdda::oracle_example {
    struct Decimal has copy, drop, store {
        is_negative: bool,
        magnitude: u8,
    }

    struct Signed has copy, drop, store {
        negative: bool,
        magnitude: u128,
    }

    struct Price has copy, drop, store {
        decimal: Decimal,
        price: Signed,
    }

    fun pow10_u128(arg0: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_via_observe<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: u8, arg4: u8) : (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u128, Price) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg1);
        0x1::vector::push_back<u64>(v1, 0);
        let (v2, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::observe<T0, T1>(arg0, v0, arg2);
        let v4 = v2;
        let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::div(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::sub(*0x1::vector::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::I64>(&v4, 0x1::vector::length<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::I64>(&v4) - 1), *0x1::vector::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::I64>(&v4, 0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::from(arg1));
        let v6 = if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::sign(v5) != 0) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::neg_from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::abs_u64(v5) as u32))
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::abs_u64(v5) as u32))
        };
        let v7 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v6);
        (v6, v7, sqrt_price_x64_to_price(v7, arg3, arg4))
    }

    fun q64x64_squared_to_linear(arg0: u128) : u128 {
        let v0 = arg0 >> 64;
        v0 * v0 + (v0 * (arg0 & 18446744073709551615) >> 63)
    }

    public fun sqrt_price_x64_to_price(arg0: u128, arg1: u8, arg2: u8) : Price {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((arg1 as u32)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((arg2 as u32)));
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sign(v0) != 0;
        let v2 = pow10_u128((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::abs_u32(v0) as u8));
        let v3 = if (!v1) {
            pow10_u128(8) * v2
        } else {
            pow10_u128(8)
        };
        let v4 = if (!v1) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::full_math_u128::mul_div_floor(q64x64_squared_to_linear(arg0), v3, 1)
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::full_math_u128::mul_div_floor(q64x64_squared_to_linear(arg0), v3, v2)
        };
        let v5 = Signed{
            negative  : false,
            magnitude : v4,
        };
        let v6 = Decimal{
            is_negative : true,
            magnitude   : 8,
        };
        Price{
            decimal : v6,
            price   : v5,
        }
    }

    // decompiled from Move bytecode v6
}

