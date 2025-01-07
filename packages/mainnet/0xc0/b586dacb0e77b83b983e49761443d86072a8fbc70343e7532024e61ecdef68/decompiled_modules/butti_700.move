module 0xc0b586dacb0e77b83b983e49761443d86072a8fbc70343e7532024e61ecdef68::butti_700 {
    struct BUTTI_700 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTI_700, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BUTTI_700>(arg0, 8737192580726835016, b"boatamol gach 700", b"Butti700", x"5468652063757272656e6379206f66205a696c6c657276616c6c657920696e2074686520416c70730a50656f706c65207468657265207573652069742073696e63652074686f7573616e6473206f662079656172730a4e6f77206974732074696d6520746f20737072656164206974206f7665722074686520776f726c64", b"https://images.hop.ag/ipfs/QmNdQn9gkmctSkoEXs5kEwQ6XW33EXubcntgc28q6tnpxD", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

