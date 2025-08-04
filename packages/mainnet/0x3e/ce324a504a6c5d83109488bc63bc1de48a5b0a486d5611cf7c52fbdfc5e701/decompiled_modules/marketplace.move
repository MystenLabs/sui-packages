module 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::marketplace {
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

