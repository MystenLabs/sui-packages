module 0x2f493d83c22f56ac057706e09ec7b0db518a5c5cf983f8a12b6f95f197ae0d2d::stuart {
    struct STUART has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUART>(arg0, 6, b"STUART", b"Stuart SUI", b"STUART IS LOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NIERO_97a7f775fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUART>>(v1);
    }

    // decompiled from Move bytecode v6
}

