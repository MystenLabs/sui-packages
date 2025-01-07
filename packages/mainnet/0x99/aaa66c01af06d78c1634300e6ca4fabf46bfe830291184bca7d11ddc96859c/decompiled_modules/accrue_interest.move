module 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::accrue_interest {
    public fun accrue_interest_for_market(arg0: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg1: &0x2::clock::Clock) {
        0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::accrue_all_interests(arg0, 0x2::clock::timestamp_ms(arg1) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg1: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::Obligation, arg2: &0x2::clock::Clock) {
        accrue_interest_for_market(arg0, arg2);
        0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::accrue_interests_and_rewards(arg1, arg0);
    }

    // decompiled from Move bytecode v6
}

