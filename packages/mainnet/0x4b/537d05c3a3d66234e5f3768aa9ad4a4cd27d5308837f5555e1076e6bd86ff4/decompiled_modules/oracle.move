module 0x4b537d05c3a3d66234e5f3768aa9ad4a4cd27d5308837f5555e1076e6bd86ff4::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: u64,
    }

    // decompiled from Move bytecode v6
}

