module 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::version::Version, arg1: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::Market, arg2: &0x2::clock::Clock) {
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::version::assert_current_version(arg0);
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::version::Version, arg1: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::Market, arg2: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

