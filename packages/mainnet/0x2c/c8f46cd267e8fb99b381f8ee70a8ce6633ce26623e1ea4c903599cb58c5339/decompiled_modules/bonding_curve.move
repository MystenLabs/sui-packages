module 0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bonding_curve {
    public entry fun calculate_buy_amount(arg0: u64, arg1: u64) : u64 {
        let v0 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational((arg1 as u128), 1000000000);
        let v1 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational(5, 1000000000);
        (get_value_with_precision(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::sub(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::legato_math::ln(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::add(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::exp(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(v1, v0, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1))), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational((arg0 as u128), 1000000000), v1, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational(1866, 1000000000)))), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1), v1), v0), 9) as u64)
    }

    public entry fun calculate_sell_return(arg0: u64, arg1: u64) : u64 {
        let v0 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational((arg1 as u128), 1000000000);
        let v1 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational(5, 1000000000);
        (get_value_with_precision(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational(1866, 1000000000), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::sub(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::exp(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(v1, v0, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1))), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::exp(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(v1, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::sub(v0, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational((arg0 as u128), 1000000000)), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1)))), v1), 9) as u64)
    }

    public fun get_value_with_precision(arg0: 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64, arg1: u8) : u128 {
        let v0 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::get_raw_value(arg0);
        let v1 = 1;
        let v2 = 0;
        while (v2 < arg1) {
            v1 = v1 * 10;
            v2 = v2 + 1;
        };
        (v0 >> 64) * v1 + ((v0 & 18446744073709551615) * v1 >> 64)
    }

    // decompiled from Move bytecode v6
}

