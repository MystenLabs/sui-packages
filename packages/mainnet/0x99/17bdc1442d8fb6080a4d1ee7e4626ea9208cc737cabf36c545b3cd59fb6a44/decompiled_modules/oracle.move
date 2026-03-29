module 0x9917bdc1442d8fb6080a4d1ee7e4626ea9208cc737cabf36c545b3cd59fb6a44::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: u64,
    }

    // decompiled from Move bytecode v6
}

