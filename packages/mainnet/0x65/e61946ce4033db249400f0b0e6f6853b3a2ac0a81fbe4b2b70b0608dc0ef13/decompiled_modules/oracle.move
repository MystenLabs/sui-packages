module 0x65e61946ce4033db249400f0b0e6f6853b3a2ac0a81fbe4b2b70b0608dc0ef13::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: u64,
    }

    // decompiled from Move bytecode v6
}

