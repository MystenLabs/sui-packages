module 0x4077194de2f54d8d4d318de3604636c3827c829edd30341d155ebe3ad119a370::sumilio {
    struct SUMILIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMILIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMILIO>(arg0, 6, b"Sumilio", b"Suimilio", b"Suimilio is here to take over the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suimilady_fcd2d707a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMILIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMILIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

