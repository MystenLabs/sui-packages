module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info {
    struct CoinInfo has copy, drop, store {
        symbol: 0x1::string::String,
        coin_type: 0x1::string::String,
        decimals: u8,
        price_feed_type: 0x1::string::String,
    }

    public fun coin_type(arg0: &CoinInfo) : 0x1::string::String {
        arg0.coin_type
    }

    public fun decimals(arg0: &CoinInfo) : u8 {
        arg0.decimals
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::string::String) : CoinInfo {
        CoinInfo{
            symbol          : arg0,
            coin_type       : arg1,
            decimals        : arg2,
            price_feed_type : arg3,
        }
    }

    public fun price_feed_type(arg0: &CoinInfo) : 0x1::string::String {
        arg0.price_feed_type
    }

    public fun symbol(arg0: &CoinInfo) : 0x1::string::String {
        arg0.symbol
    }

    public(friend) fun update_coin_info(arg0: &mut CoinInfo, arg1: 0x1::string::String) {
        arg0.price_feed_type = arg1;
    }

    // decompiled from Move bytecode v6
}

