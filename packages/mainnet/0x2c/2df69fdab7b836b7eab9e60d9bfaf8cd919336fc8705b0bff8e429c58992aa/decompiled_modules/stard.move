module 0x2c2df69fdab7b836b7eab9e60d9bfaf8cd919336fc8705b0bff8e429c58992aa::stard {
    struct STARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARD>(arg0, 6, b"STARD", b"SUITARDIO", b"SUITARDIO WORLD ORDER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_C53_FF_09_F5_D5_4_A2_B_923_F_1264_D8_D6_E7_DE_0e5c8cf28c_1fe8df6ec7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

