module 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::version::Version, arg1: &mut 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::market::Market, arg2: &0x2::clock::Clock) {
        0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::version::assert_current_version(arg0);
        0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::version::Version, arg1: &mut 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::market::Market, arg2: &mut 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v7
}

