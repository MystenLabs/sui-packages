module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::marketplace {
    struct MarketplaceData has store {
        name: 0x1::string::String,
    }

    public(friend) fun new_marketplace_data(arg0: 0x1::string::String) : MarketplaceData {
        MarketplaceData{name: arg0}
    }

    // decompiled from Move bytecode v6
}

