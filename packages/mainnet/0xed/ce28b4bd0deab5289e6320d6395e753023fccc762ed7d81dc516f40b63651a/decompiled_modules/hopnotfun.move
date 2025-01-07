module 0xedce28b4bd0deab5289e6320d6395e753023fccc762ed7d81dc516f40b63651a::hopnotfun {
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

