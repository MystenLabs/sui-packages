module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::marketplace {
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

