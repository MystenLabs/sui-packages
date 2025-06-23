module 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::sam_coin_metadata {
    struct SamMetadata has copy, drop, store {
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        decimals: u8,
    }

    public(friend) fun decimals(arg0: &SamMetadata) : u8 {
        arg0.decimals
    }

    public(friend) fun description(arg0: &SamMetadata) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun icon_url(arg0: &SamMetadata) : 0x1::option::Option<0x2::url::Url> {
        arg0.icon_url
    }

    public(friend) fun name(arg0: &SamMetadata) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun new<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : SamMetadata {
        SamMetadata{
            name        : 0x2::coin::get_name<T0>(arg0),
            symbol      : 0x2::coin::get_symbol<T0>(arg0),
            description : 0x2::coin::get_description<T0>(arg0),
            icon_url    : 0x2::coin::get_icon_url<T0>(arg0),
            decimals    : 0x2::coin::get_decimals<T0>(arg0),
        }
    }

    public(friend) fun symbol(arg0: &SamMetadata) : 0x1::ascii::String {
        arg0.symbol
    }

    // decompiled from Move bytecode v6
}

