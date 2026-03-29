module 0x4c2f371e08e1454d31bd8b9c8590d8f425b8beacd7c1a8cb578eec72c62654b9::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: u64,
    }

    // decompiled from Move bytecode v6
}

