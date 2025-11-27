module 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::Version, arg1: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg2: &0x2::clock::Clock) {
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::assert_current_version(arg0);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::Version, arg1: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg2: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

