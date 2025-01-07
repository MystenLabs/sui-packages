module 0x8fead3b66412950e9fb0b44ef81103b7ce2b5084038df71b84e1d45527bd068f::baaz {
    struct BAAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAAZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BAAZ>(arg0, 12129317088406774871, b"BAAZ", b"BAAZ", b"BAAZ", b"https://images.hop.ag/ipfs/QmXkSswvrnYpyCiyjsQYok9bydFSuVz32GXWpeJV4x3ywF", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

