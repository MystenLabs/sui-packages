module 0xb3b58497a37c20b7d8368a04f1d57fe1edfed14c55135245c0e0c218c0145a23::wumu {
    struct WUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUMU>(arg0, 6, b"WUMU", b"WuMu Sui", b"A wicked little trickster. A mind sharper than his claws. Ruling over the trenches with a grin. Prince of the Angels. Ruler of Heavens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih5x3nzfrgal7qbdpc3xww47a2sqt67vbkzeyapelwz3qygz6f3be")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WUMU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

