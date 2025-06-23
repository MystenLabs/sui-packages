module 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_metadata {
    struct BlizzardMetadata has copy, drop, store {
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        decimals: u8,
    }

    public(friend) fun decimals(arg0: &BlizzardMetadata) : u8 {
        arg0.decimals
    }

    public(friend) fun description(arg0: &BlizzardMetadata) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun icon_url(arg0: &BlizzardMetadata) : 0x1::option::Option<0x2::url::Url> {
        arg0.icon_url
    }

    public(friend) fun name(arg0: &BlizzardMetadata) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun new<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : BlizzardMetadata {
        BlizzardMetadata{
            name        : 0x2::coin::get_name<T0>(arg0),
            symbol      : 0x2::coin::get_symbol<T0>(arg0),
            description : 0x2::coin::get_description<T0>(arg0),
            icon_url    : 0x2::coin::get_icon_url<T0>(arg0),
            decimals    : 0x2::coin::get_decimals<T0>(arg0),
        }
    }

    public(friend) fun symbol(arg0: &BlizzardMetadata) : 0x1::ascii::String {
        arg0.symbol
    }

    // decompiled from Move bytecode v6
}

