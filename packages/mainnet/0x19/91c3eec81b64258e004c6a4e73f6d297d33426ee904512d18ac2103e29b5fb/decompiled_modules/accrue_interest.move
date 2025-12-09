module 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::version::Version, arg1: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::Market, arg2: &0x2::clock::Clock) {
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::version::assert_current_version(arg0);
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::version::Version, arg1: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::Market, arg2: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

