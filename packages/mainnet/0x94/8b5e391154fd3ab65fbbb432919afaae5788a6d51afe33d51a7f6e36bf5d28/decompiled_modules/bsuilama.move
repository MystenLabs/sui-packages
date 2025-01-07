module 0x948b5e391154fd3ab65fbbb432919afaae5788a6d51afe33d51a7f6e36bf5d28::bsuilama {
    struct BSUILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUILAMA>(arg0, 6, b"BSUILAMA", b"Baby Suilama", b"Suilama's kid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_01_30_10_524f233dbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUILAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUILAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

