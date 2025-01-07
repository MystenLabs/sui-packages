module 0x41be378c5b0244d1a526d65b2eac58dd3c8f60f21dadf12d2262e1cc8c4ba78b::based {
    struct BASED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASED, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BASED>(arg0, 3305248996717708500, b"BASED", b"BASED", b"BASED on SUI", b"https://images.hop.ag/ipfs/QmdxYUhLfu9yCAfUpmahGAZquzCgwRRUqCVNFsJufkgbcG", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

