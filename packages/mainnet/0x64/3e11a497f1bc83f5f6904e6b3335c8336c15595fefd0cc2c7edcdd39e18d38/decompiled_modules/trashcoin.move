module 0x643e11a497f1bc83f5f6904e6b3335c8336c15595fefd0cc2c7edcdd39e18d38::trashcoin {
    struct TRASHCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRASHCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRASHCOIN>(arg0, 6, b"TRASHCOIN", b"TRASH COIN", b"Trashcoin was discovered in the deepest crypto ocean trenches - a memecoin forge from a broken dreams. Now reborn as the most ironic coin of all time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeignfxlomu5uyiw2bcks3i5qexfsujaxculujhbjlxbuffcypik63a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRASHCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRASHCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

