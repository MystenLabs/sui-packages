module 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::version::Version, arg1: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg2: &0x2::clock::Clock) {
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::version::assert_current_version(arg0);
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::version::Version, arg1: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg2: &mut 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

