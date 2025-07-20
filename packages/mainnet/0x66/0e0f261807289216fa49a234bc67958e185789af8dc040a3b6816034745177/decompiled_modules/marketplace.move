module 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::marketplace {
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

    public fun new_marketplace_data(arg0: 0x1::string::String, arg1: 0x1::string::String) : MarketplaceData {
        MarketplaceData{
            name       : arg0,
            attributes : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

