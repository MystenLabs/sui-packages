module 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::Version, arg1: &mut 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::Market, arg2: &0x2::clock::Clock) {
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::assert_current_version(arg0);
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::Version, arg1: &mut 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::Market, arg2: &mut 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

