module 0xe739d002a011dafaa58251cb7ea87e2f56dcf28a5157a726eb7c3354479ed08d::square {
    struct SQUARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUARE>(arg0, 6, b"SQUARE", x"f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7", x"f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731874817572.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUARE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUARE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

