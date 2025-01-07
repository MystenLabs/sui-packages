module 0x7805ab194e2526ca440aa48c71ee6a59db0e6b7d84e03ca73179cf2ecec5ce9e::cipro {
    struct CIPRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIPRO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CIPRO>(arg0, 10079995166624909672, b"Ciprofloxacin", b"CIPRO", b"The Best Killer of Bacteria", b"https://images.hop.ag/ipfs/QmSnn2Aub5jQqMzNAgmKhdB31uV1LVfqnMhj4DiPGFWiMd", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

