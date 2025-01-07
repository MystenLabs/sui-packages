module 0x1adb82205b7f4a4368fb35b7af72a0e565ca643b096c8b4ff3f0a38b2e670262::hopnotfun {
    struct HOPNOTFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPNOTFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPNOTFUN>(arg0, 6, b"HOPNOTFUN", b"HOP_NOT_FUN", b"Wen launch ??", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cropped_Image_801681c304.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPNOTFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPNOTFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

