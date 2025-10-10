module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info {
    struct CoinInfo<phantom T0> has store {
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        decimals: u8,
        metadata: 0x1::option::Option<0x2::coin::CoinMetadata<T0>>,
    }

    public(friend) fun destroy_empty<T0>(arg0: CoinInfo<T0>) {
        assert!(0x1::option::is_none<0x2::coin::CoinMetadata<T0>>(&arg0.metadata), 13906834543710568449);
        let CoinInfo {
            name     : _,
            symbol   : _,
            decimals : _,
            metadata : v3,
        } = arg0;
        0x1::option::destroy_none<0x2::coin::CoinMetadata<T0>>(v3);
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
        let v0 = CoinInfo<T0>{
            name     : 0x2::coin::get_name<T0>(&arg0),
            symbol   : 0x2::coin::get_symbol<T0>(&arg0),
            decimals : 0x2::coin::get_decimals<T0>(&arg0),
            metadata : 0x1::option::none<0x2::coin::CoinMetadata<T0>>(),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg0);
        v0
    }

    public fun from_metadata_ref<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : CoinInfo<T0> {
        CoinInfo<T0>{
            name     : 0x2::coin::get_name<T0>(arg0),
            symbol   : 0x2::coin::get_symbol<T0>(arg0),
            decimals : 0x2::coin::get_decimals<T0>(arg0),
            metadata : 0x1::option::none<0x2::coin::CoinMetadata<T0>>(),
        }
    }

    public fun metadata<T0>(arg0: &CoinInfo<T0>) : &0x1::option::Option<0x2::coin::CoinMetadata<T0>> {
        &arg0.metadata
    }

    public fun name<T0>(arg0: &CoinInfo<T0>) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun release_metadata<T0>(arg0: &mut CoinInfo<T0>) {
        if (0x1::option::is_some<0x2::coin::CoinMetadata<T0>>(&arg0.metadata)) {
            0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(0x1::option::extract<0x2::coin::CoinMetadata<T0>>(&mut arg0.metadata));
        };
    }

    public fun symbol<T0>(arg0: &CoinInfo<T0>) : 0x1::ascii::String {
        arg0.symbol
    }

    // decompiled from Move bytecode v6
}

