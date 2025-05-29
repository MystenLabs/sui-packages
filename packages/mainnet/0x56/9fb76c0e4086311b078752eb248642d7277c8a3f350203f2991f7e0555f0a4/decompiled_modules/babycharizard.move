module 0x569fb76c0e4086311b078752eb248642d7277c8a3f350203f2991f7e0555f0a4::babycharizard {
    struct BABYCHARIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCHARIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCHARIZARD>(arg0, 6, b"BABYCHARIZARD", b"Baby Charizard Sui", b"Baby Charizard On sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihxhcerq2cmawewsxa7gmoe5tl5mvdrf4m2kp7r5o5xelazlwpkw4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCHARIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYCHARIZARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

