module 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::version::Version, arg1: &mut 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::Market, arg2: &0x2::clock::Clock) {
        0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::version::assert_current_version(arg0);
        0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::version::Version, arg1: &mut 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::Market, arg2: &mut 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

