module 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::version::Version, arg1: &mut 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::market::Market, arg2: &0x2::clock::Clock) {
        0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::version::assert_current_version(arg0);
        0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::version::Version, arg1: &mut 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::market::Market, arg2: &mut 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

