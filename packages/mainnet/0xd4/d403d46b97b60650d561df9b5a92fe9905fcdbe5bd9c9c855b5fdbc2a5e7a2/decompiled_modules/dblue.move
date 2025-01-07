module 0xd4d403d46b97b60650d561df9b5a92fe9905fcdbe5bd9c9c855b5fdbc2a5e7a2::dblue {
    struct DBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DBLUE>(arg0, 3569727024183534058, b"darkblue", b"DBLUE", b"its just dark blue", b"https://images.hop.ag/ipfs/QmP2uZoJyfrTFPwuhHmaqHi3NE95HHwEKHTa9vZw4r4U8q", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

