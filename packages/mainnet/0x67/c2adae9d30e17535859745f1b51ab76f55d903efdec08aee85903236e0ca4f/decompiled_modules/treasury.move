module 0x67c2adae9d30e17535859745f1b51ab76f55d903efdec08aee85903236e0ca4f::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        version: u64,
        funds: 0x2::bag::Bag,
    }

    // decompiled from Move bytecode v6
}

