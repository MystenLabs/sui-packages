module 0xaefb14f7e1fb656753e5b82201904fb5dac16b154e70d154cac8b851ff4d2548::fd {
    struct FD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FD>(arg0, 8722403801472703703, b"fdgdd", b"fd", b"fd is coming", b"https://images.hop.ag/ipfs/QmUReb1DcGKSp9d1H9JTXjoZSqtMUT4rcfF4WduGrGQvhX", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

