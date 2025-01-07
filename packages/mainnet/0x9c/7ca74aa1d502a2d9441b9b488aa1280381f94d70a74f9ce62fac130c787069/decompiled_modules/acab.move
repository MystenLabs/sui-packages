module 0x9c7ca74aa1d502a2d9441b9b488aa1280381f94d70a74f9ce62fac130c787069::acab {
    struct ACAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACAB>(arg0, 6, b"ACAB", b"All Catz Are Biker", b"All Catz Are Biker ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_27_23_13_22_aadd13bc13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

