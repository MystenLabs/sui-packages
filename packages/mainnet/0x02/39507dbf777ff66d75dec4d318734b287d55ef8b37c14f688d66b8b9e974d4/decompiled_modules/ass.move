module 0x239507dbf777ff66d75dec4d318734b287d55ef8b37c14f688d66b8b9e974d4::ass {
    struct ASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ASS>(arg0, 3564120112888000510, b"AssCoin", b"ASS", b"Perfect ass", b"https://images.hop.ag/ipfs/QmabEZNhn2wLsrBKT4hnjgvy96RztbwbLMqYJneKWjWzaT", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

