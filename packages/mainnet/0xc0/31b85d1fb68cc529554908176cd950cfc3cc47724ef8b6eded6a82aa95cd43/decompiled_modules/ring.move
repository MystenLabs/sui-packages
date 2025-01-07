module 0xc031b85d1fb68cc529554908176cd950cfc3cc47724ef8b6eded6a82aa95cd43::ring {
    struct RING has drop {
        dummy_field: bool,
    }

    fun init(arg0: RING, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<RING>(arg0, 16732595150700766040, b"RING", b"RING", b"People's love expression of beauty is through RING", b"https://images.hop.ag/ipfs/QmSW6iTGN7EBBJDmyZ4FLhVFZ2HRkBvNibtmgCZk8f1eMz", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

