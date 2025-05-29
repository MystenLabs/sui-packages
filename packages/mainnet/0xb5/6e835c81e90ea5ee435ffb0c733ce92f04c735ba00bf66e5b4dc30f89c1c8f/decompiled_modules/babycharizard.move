module 0xb56e835c81e90ea5ee435ffb0c733ce92f04c735ba00bf66e5b4dc30f89c1c8f::babycharizard {
    struct BABYCHARIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCHARIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCHARIZARD>(arg0, 6, b"BABYCHARIZARD", b"Baby Charizard", b"Baby Charizard on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihxhcerq2cmawewsxa7gmoe5tl5mvdrf4m2kp7r5o5xelazlwpkw4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCHARIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYCHARIZARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

