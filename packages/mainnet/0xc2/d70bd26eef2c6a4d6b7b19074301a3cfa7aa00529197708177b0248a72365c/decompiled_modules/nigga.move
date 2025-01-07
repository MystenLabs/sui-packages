module 0xc2d70bd26eef2c6a4d6b7b19074301a3cfa7aa00529197708177b0248a72365c::nigga {
    struct NIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<NIGGA>(arg0, 12467137790384471409, b"Nigga patrol", b"$NIGGA", b"PROJECT 2025 IS HERE THANK YOU TRUMP", b"https://images.hop.ag/ipfs/QmUUQ5TyDNx93abt6of7osPtDkhdzubaDmPuwmatCwuxtx", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

