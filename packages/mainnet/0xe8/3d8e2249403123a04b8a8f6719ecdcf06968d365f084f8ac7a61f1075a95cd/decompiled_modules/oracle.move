module 0xe83d8e2249403123a04b8a8f6719ecdcf06968d365f084f8ac7a61f1075a95cd::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: u64,
    }

    // decompiled from Move bytecode v6
}

