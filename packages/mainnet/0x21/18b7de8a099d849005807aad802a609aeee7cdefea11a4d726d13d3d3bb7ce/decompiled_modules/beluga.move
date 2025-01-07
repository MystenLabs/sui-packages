module 0x2118b7de8a099d849005807aad802a609aeee7cdefea11a4d726d13d3d3bb7ce::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BELUGA>(arg0, 1435464344351283902, b"Bobbin Beluga", b"BELUGA", b"he bobbin", b"https://images.hop.ag/ipfs/QmbGiV4uokLyF7FSctH7Tx7yQz57TyZvk8Tm7j7oY3aTs7", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://www.belugawhalealliance.org/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

