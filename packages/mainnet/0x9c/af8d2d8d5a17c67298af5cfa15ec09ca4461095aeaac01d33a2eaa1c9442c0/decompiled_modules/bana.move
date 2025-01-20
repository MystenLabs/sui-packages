module 0x9caf8d2d8d5a17c67298af5cfa15ec09ca4461095aeaac01d33a2eaa1c9442c0::bana {
    struct BANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BANA>(arg0, 1474370346359196660, b"banana", b"bana", b"banana coin", b"https://images.hop.ag/ipfs/QmXzRrF9njbrBHS84vgytq78PMoe7FmFyDRSiycYcZbTEV", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

