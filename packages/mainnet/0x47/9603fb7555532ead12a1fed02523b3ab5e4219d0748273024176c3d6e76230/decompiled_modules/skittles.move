module 0x479603fb7555532ead12a1fed02523b3ab5e4219d0748273024176c3d6e76230::skittles {
    struct SKITTLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITTLES, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SKITTLES>(arg0, 16496650624865367472, b"Skittles jontavius", b"SKITTLES", b"It's going up on a Tuesday !!!", b"https://images.hop.ag/ipfs/QmXFojWNbkiV65Pzm6ozkpF9wLKH9g6Je9CHCd7WKmWu4e", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

