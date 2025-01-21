module 0xef2996c68005a434e837bf9d081508bb8e38795fbaf6a18826ecb7eb5d2dbe60::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BARRON>(arg0, 14888594825941934406, b"BARRON on SUI", b"BARRON", b"none", b"https://images.hop.ag/ipfs/QmbHxNr95WCYbHRpquKazaMgxwhNMykLgx5RUiJ33vBQad", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

