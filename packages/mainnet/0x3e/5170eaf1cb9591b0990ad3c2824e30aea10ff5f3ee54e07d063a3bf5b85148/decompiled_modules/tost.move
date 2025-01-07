module 0x3e5170eaf1cb9591b0990ad3c2824e30aea10ff5f3ee54e07d063a3bf5b85148::tost {
    struct TOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TOST>(arg0, 14932253625017809470, b"TOST", b"TOST", b"TOST", b"https://images.hop.ag/ipfs/QmdXMDeK7AisA9UssAqTuLzpgsanmx6QraNEydXiZ9b3w7", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

