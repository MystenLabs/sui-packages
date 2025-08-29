module 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::Version, arg1: &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::Market, arg2: &0x2::clock::Clock) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::assert_current_version(arg0);
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::Version, arg1: &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::Market, arg2: &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

