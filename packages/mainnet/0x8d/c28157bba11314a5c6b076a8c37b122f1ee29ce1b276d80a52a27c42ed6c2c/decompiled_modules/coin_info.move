module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info {
    struct CoinInfo<phantom T0> has store {
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        decimals: u8,
        metadata: 0x1::option::Option<0x2::coin::CoinMetadata<T0>>,
    }

    public fun decimals<T0>(arg0: &CoinInfo<T0>) : u8 {
        arg0.decimals
    }

    public fun from_info<T0>(arg0: 0x1::string::String, arg1: 0x1::ascii::String, arg2: u8) : CoinInfo<T0> {
        CoinInfo<T0>{
            name     : arg0,
            symbol   : arg1,
            decimals : arg2,
            metadata : 0x1::option::none<0x2::coin::CoinMetadata<T0>>(),
        }
    }

    public fun from_metadata<T0>(arg0: 0x2::coin::CoinMetadata<T0>) : CoinInfo<T0> {
        CoinInfo<T0>{
            name     : 0x2::coin::get_name<T0>(&arg0),
            symbol   : 0x2::coin::get_symbol<T0>(&arg0),
            decimals : 0x2::coin::get_decimals<T0>(&arg0),
            metadata : 0x1::option::some<0x2::coin::CoinMetadata<T0>>(arg0),
        }
    }

    public fun metadata<T0>(arg0: &CoinInfo<T0>) : &0x1::option::Option<0x2::coin::CoinMetadata<T0>> {
        &arg0.metadata
    }

    public fun name<T0>(arg0: &CoinInfo<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun symbol<T0>(arg0: &CoinInfo<T0>) : 0x1::ascii::String {
        arg0.symbol
    }

    // decompiled from Move bytecode v6
}

