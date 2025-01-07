module 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::accrue_interest {
    public fun accrue_interest_for_market(arg0: &mut 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::Market, arg1: &0x2::clock::Clock) {
        0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::accrue_all_interests(arg0, 0x2::clock::timestamp_ms(arg1) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &mut 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::Market, arg1: &mut 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::Obligation, arg2: &0x2::clock::Clock) {
        accrue_interest_for_market(arg0, arg2);
        0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::accrue_interests_and_rewards(arg1, arg0);
    }

    // decompiled from Move bytecode v6
}

