module 0x3a1ab584b620325fc68217a63cf7efc6d59a7632028eaea4c00d0871df6c0e19::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PEPE>(arg0, 10943327922175338067, b"President Elect Party Era (P.E.P.E.)", b"PEPE", b"Kamala's never gonna beat me in november, Donald's gonna make the Country better than you can remember", b"https://images.hop.ag/ipfs/QmPim85i1zgnwc8oadL74W9Z5uZVUxZMKCWrN7eKD6uFSK", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

