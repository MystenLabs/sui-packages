module 0x1ba09c1f54f4bcf12a6a7c0d4386f01b2e0c877a2fbabdb119000e201ed349d0::hun {
    struct HUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HUN>(arg0, 11208019182931225056, b"Hunters", b"HUN", b"For Fun Hunters", b"https://images.hop.ag/ipfs/QmQvTuVZt8xarDJYuV9hpsjdGvnfcr35kCzp7H5pnDT38E", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

