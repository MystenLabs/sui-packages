module 0xf83be64a14593874110c88fce102b91015c16fb0fd5716e0eafa43874bcd9584::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: u64,
    }

    // decompiled from Move bytecode v6
}

