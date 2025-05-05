module 0x88458e7db1fbbf60f6d7a7a9df85021cabcf8671026e167df970487fc14bd59::test_contract {
    struct TestEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_rate_per_sec: 0x1::fixed_point32::FixedPoint32,
        interest_rate_per_sec_scale: u64,
        util_rate: 0x1::fixed_point32::FixedPoint32,
        supply_rate_per_sec: 0x1::fixed_point32::FixedPoint32,
        supply_apr: 0x1::fixed_point32::FixedPoint32,
    }

    public fun test<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::util_rate(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0), v0);
        let v2 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::interest_model(arg0, v0);
        let (v3, v4) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::calc_interest(v2, v1);
        let v5 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(v3, v1), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0x1::fixed_point32::create_from_rational(1, 1), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::revenue_factor(v2)));
        let v6 = TestEvent{
            coin_type                   : v0,
            interest_rate_per_sec       : v3,
            interest_rate_per_sec_scale : v4,
            util_rate                   : v1,
            supply_rate_per_sec         : v5,
            supply_apr                  : 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(v5, 0x1::fixed_point32::create_from_rational(31536000, 1)), 0x1::fixed_point32::create_from_rational(v4, 1)),
        };
        0x2::event::emit<TestEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

