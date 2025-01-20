module 0x9c98c22e99e4e67af2011d7cddeef282d769f0d3580adad7878ad87078e1ff71::nao {
    struct NAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<NAO>(arg0, 357824732219881810, b"nao", b"nao", b"nao coin", b"https://images.hop.ag/ipfs/QmXiqdh2uN7PLpphVKxrUtwzWKkNJAhMofXsktJYGcBYZ3", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

