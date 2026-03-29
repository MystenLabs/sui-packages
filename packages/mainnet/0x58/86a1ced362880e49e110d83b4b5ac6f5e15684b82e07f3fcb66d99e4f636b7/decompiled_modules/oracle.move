module 0x5886a1ced362880e49e110d83b4b5ac6f5e15684b82e07f3fcb66d99e4f636b7::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: u64,
    }

    // decompiled from Move bytecode v6
}

