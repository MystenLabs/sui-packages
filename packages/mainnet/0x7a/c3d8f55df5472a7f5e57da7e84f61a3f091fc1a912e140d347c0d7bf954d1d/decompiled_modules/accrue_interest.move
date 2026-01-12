module 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::Version, arg1: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg2: &0x2::clock::Clock) {
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::assert_current_version(arg0);
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::Version, arg1: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg2: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

