module 0x3c0b26bfd3615dfab2d2828c4f8e7537aa3c9a4b3c40ea26f18e8a46311e1225::bwog {
    struct BWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWOG>(arg0, 6, b"BWOG", b"Bwog On Sui", b"Not just your Ordinary bear, but the coolest bear on sui, first of it's kind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibka4wnkhd5uib7b2qbvvgttaceeguqhigswgox56dgvwavpobqyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BWOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

