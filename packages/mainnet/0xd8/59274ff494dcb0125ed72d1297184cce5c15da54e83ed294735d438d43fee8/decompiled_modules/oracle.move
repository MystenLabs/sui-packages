module 0xd859274ff494dcb0125ed72d1297184cce5c15da54e83ed294735d438d43fee8::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: u64,
    }

    // decompiled from Move bytecode v6
}

