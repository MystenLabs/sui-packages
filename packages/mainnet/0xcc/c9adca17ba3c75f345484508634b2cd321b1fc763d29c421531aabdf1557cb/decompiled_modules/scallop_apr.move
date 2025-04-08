module 0xff3bdba674e8e9683a19774185f1138a104f23df1a978caec30f4eda9daa6560::scallop_apr {
    fun calculate_utilization_rate<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : 0x1::fixed_point32::FixedPoint32 {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::util_rate(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0), 0x1::type_name::get<T0>())
    }

    public fun get_deposit_apr<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        let v0 = calculate_utilization_rate<T0>(arg0);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::interest_model(arg0, 0x1::type_name::get<T0>());
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::calc_interest(v1, v0);
        0x1::fixed_point32::multiply_u64(0x1::fixed_point32::multiply_u64(0x1::fixed_point32::multiply_u64(0x1::fixed_point32::multiply_u64(0x1::fixed_point32::get_raw_value(v0), v2), 0x1::fixed_point32::create_from_rational(v3 - 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::revenue_factor(v1)), v3)), 0x1::fixed_point32::create_from_rational(31536000, 1)), 0x1::fixed_point32::create_from_rational(10000, 1))
    }

    // decompiled from Move bytecode v6
}

