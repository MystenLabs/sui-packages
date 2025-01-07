module 0x827119303f6026fa24c71eba6d82abcd8389d044db011b6e67e856ce45c60935::azsq {
    struct AZSQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZSQ, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<AZSQ>(arg0, 9887194511552029469, b"Love in the Deep Autumn", b"AZSQ", b"LA DE NI TOU YUN NAO ZHANG", b"https://images.hop.ag/ipfs/QmerZym4fercTqR8mSuq3XKgaUDLrBkCEEx34tJXrndHZ2", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

