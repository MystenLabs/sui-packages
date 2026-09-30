module 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::oracle {
    fun assert_market_oracle<T0, T1>(arg0: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg1: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::PriceQuote) {
        assert!(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::oracle<T0, T1>(arg0) == 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::oracle_id(arg1), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::errors::vault_invalid_oracle());
    }

    public(friend) fun get_both_exchange_rate<T0, T1>(arg0: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg1: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::PriceQuote) : (u128, u128) {
        assert_market_oracle<T0, T1>(arg0, arg1);
        (0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::rate_liquidate(arg1), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::rate_operate(arg1))
    }

    public(friend) fun get_exchange_rate_liquidate<T0, T1>(arg0: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg1: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::PriceQuote) : u128 {
        assert_market_oracle<T0, T1>(arg0, arg1);
        0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::rate_liquidate(arg1)
    }

    public(friend) fun get_exchange_rate_operate<T0, T1>(arg0: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg1: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::PriceQuote) : u128 {
        assert_market_oracle<T0, T1>(arg0, arg1);
        0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::rate_operate(arg1)
    }

    // decompiled from Move bytecode v7
}

