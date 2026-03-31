module 0x71cbd51848a8129784118e997aa175ecad6f1d18ccd8831eefe16f3ac243f586::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: u64,
    }

    // decompiled from Move bytecode v6
}

