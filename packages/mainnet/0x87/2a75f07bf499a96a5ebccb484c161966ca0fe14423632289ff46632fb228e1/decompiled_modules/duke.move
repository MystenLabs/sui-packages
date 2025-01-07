module 0x872a75f07bf499a96a5ebccb484c161966ca0fe14423632289ff46632fb228e1::duke {
    struct DUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DUKE>(arg0, 7401507329192939185, b"DUKE", b"DUKE", b"DUKE", b"https://images.hop.ag/ipfs/QmXZBcoYXUxXEVWjrM2FkUwHjsQr6A6gH5mJwVh8qePAxK", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/dukesui"), arg1);
    }

    // decompiled from Move bytecode v6
}

