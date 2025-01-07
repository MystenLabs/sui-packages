module 0x37ffcddd987888201851deecc0edc39ddd7feb274ff86fdc96a1a18781e59ca0::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MEOW>(arg0, 13890960366343082773, b"MEOW", b"MEOW", b"MEOW token embodies the playful and charming spirit of cats. Perfect for a community-driven project, it aims to bring joy and engagement to its users.", b"https://images.hop.ag/ipfs/QmPPv22Y5pdcvUsG33boWx5nmx26AUxwfziVJFgkXb2BYL", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

