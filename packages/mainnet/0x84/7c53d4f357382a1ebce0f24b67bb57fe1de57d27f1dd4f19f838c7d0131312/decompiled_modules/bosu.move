module 0x847c53d4f357382a1ebce0f24b67bb57fe1de57d27f1dd4f19f838c7d0131312::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"BOOK OF SUI", b"In the beginning, there was chaosand out of that chaos, the Sui Chain emerged, written in the language of degens. This sacred text holds the secrets of moonshots, pump prophecies, and the ancient art of buying the dip.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/book_25b6876092.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

