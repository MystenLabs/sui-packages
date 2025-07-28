module 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::marketplace {
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

