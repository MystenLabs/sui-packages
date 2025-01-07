module 0x46d31d9f3ac1ad2bc3deeadd1d8e606c32e73264b2ef22676171e2b52591e326::as {
    struct AS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<AS>(arg0, 9662978138487471881, b"zhn", b"as", b"asd", b"https://images.hop.ag/ipfs/QmQ9hEKKCj9civAXmxUqzP68EsVTGTu9FrqXtRxRMGk4SL", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

