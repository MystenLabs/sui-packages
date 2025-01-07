module 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils {
    struct CoinMetadata has copy, drop, store {
        url: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
    }

    public fun coin_metadata(arg0: vector<u8>, arg1: vector<u8>, arg2: u8) : CoinMetadata {
        CoinMetadata{
            url      : arg0,
            symbol   : arg1,
            decimals : arg2,
        }
    }

    public fun coin_metadata_decimals(arg0: &CoinMetadata) : u8 {
        arg0.decimals
    }

    public fun coin_metadata_symbol(arg0: &CoinMetadata) : &vector<u8> {
        &arg0.symbol
    }

    public fun coin_metadata_url(arg0: &CoinMetadata) : &vector<u8> {
        &arg0.url
    }

    // decompiled from Move bytecode v6
}

