module 0x68b0993ea668a9e552e775f9ab8dc8e93da8ec8024d59dfea249b0703e9bdff2::azsq {
    struct AZSQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZSQ, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<AZSQ>(arg0, 8794855732678190569, b"Love in the Deep Autumn", b"AZSQ", b"ZHANG DE NI TOU YUN MU XUAN", b"https://images.hop.ag/ipfs/QmerZym4fercTqR8mSuq3XKgaUDLrBkCEEx34tJXrndHZ2", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

