module 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::Version, arg1: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg2: &0x2::clock::Clock) {
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::assert_current_version(arg0);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::Version, arg1: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg2: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

