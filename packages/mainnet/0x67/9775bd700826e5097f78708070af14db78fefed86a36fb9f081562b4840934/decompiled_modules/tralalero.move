module 0x679775bd700826e5097f78708070af14db78fefed86a36fb9f081562b4840934::tralalero {
    struct TRALALERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRALALERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRALALERO>(arg0, 6, b"Tralalero", b"Tralalero Tralala", b"We coming for Sui Brainrot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicwdf3lfqpzw5npr5oaovke37noyao7llqlh4d2pajq3nsmnrrj3e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRALALERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRALALERO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

