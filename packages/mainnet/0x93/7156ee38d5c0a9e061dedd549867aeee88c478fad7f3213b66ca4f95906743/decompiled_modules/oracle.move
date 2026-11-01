module 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::oracle {
    fun assert_market_oracle<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::PriceQuote) {
        assert!(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::oracle<T0, T1>(arg0) == 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::oracle_id(arg1), 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_invalid_oracle());
    }

    public(friend) fun get_both_exchange_rate<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::PriceQuote) : (u128, u128) {
        assert_market_oracle<T0, T1>(arg0, arg1);
        (0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::rate_liquidate(arg1), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::rate_operate(arg1))
    }

    public(friend) fun get_exchange_rate_liquidate<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::PriceQuote) : u128 {
        assert_market_oracle<T0, T1>(arg0, arg1);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::rate_liquidate(arg1)
    }

    public(friend) fun get_exchange_rate_operate<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::PriceQuote) : u128 {
        assert_market_oracle<T0, T1>(arg0, arg1);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::rate_operate(arg1)
    }

    // decompiled from Move bytecode v7
}

