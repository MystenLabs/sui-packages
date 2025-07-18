module 0x646be877599a0c307c33912a2abda4106b3c25c232ae2b7c9d686d70ec8f73ad::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITS>(arg0, 6, b"SuiTS", b"SuiTst", b"Tst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidgas5daowezbr2zwzqyliaztce6dpmlolyu2ontt6itgfh7bdt3e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

