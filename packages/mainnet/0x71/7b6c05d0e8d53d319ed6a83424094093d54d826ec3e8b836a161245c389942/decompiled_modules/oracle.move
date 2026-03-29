module 0x717b6c05d0e8d53d319ed6a83424094093d54d826ec3e8b836a161245c389942::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: u64,
    }

    // decompiled from Move bytecode v6
}

