module 0x1617106ec413cc226e0c2f8af70b46a881648d1c0e4ef095c36dc530ab731671::sam_coin_metadata {
    struct SamMetadata has copy, drop, store {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        decimals: u8,
    }

    public(friend) fun decimals(arg0: &SamMetadata) : u8 {
        arg0.decimals
    }

    public(friend) fun description(arg0: &SamMetadata) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun icon_url(arg0: &SamMetadata) : 0x1::string::String {
        arg0.icon_url
    }

    public(friend) fun name(arg0: &SamMetadata) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun symbol(arg0: &SamMetadata) : 0x1::string::String {
        arg0.symbol
    }

    public(friend) fun new<T0>(arg0: &0x2::coin_registry::Currency<T0>) : SamMetadata {
        SamMetadata{
            name        : 0x2::coin_registry::name<T0>(arg0),
            symbol      : 0x2::coin_registry::symbol<T0>(arg0),
            description : 0x2::coin_registry::description<T0>(arg0),
            icon_url    : 0x2::coin_registry::icon_url<T0>(arg0),
            decimals    : 0x2::coin_registry::decimals<T0>(arg0),
        }
    }

    // decompiled from Move bytecode v7
}

