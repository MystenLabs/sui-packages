module 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::oracle {
    fun assert_market_oracle<T0, T1>(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::PriceQuote) {
        assert!(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::oracle<T0, T1>(arg0) == 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::oracle_id(arg1), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_invalid_oracle());
    }

    public(friend) fun get_both_exchange_rate<T0, T1>(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::PriceQuote) : (u128, u128) {
        assert_market_oracle<T0, T1>(arg0, arg1);
        (0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::rate_liquidate(arg1), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::rate_operate(arg1))
    }

    public(friend) fun get_exchange_rate_liquidate<T0, T1>(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::PriceQuote) : u128 {
        assert_market_oracle<T0, T1>(arg0, arg1);
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::rate_liquidate(arg1)
    }

    public(friend) fun get_exchange_rate_operate<T0, T1>(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::PriceQuote) : u128 {
        assert_market_oracle<T0, T1>(arg0, arg1);
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::rate_operate(arg1)
    }

    // decompiled from Move bytecode v7
}

