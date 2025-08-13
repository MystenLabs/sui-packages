module 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::marketplace {
    struct MarketplaceData has store {
        name: 0x1::string::String,
        attributes: 0x1::string::String,
    }

    public fun marketplace_data_attributes(arg0: &MarketplaceData) : &0x1::string::String {
        &arg0.attributes
    }

    public fun marketplace_data_name(arg0: &MarketplaceData) : &0x1::string::String {
        &arg0.name
    }

    public fun new_marketplace_data(arg0: 0x1::string::String) : MarketplaceData {
        MarketplaceData{
            name       : arg0,
            attributes : 0x1::string::utf8(b""),
        }
    }

    // decompiled from Move bytecode v6
}

