module 0xed2d2502a65508ce53fe7fd872461e927ab67d7ca0a06d411a9cc5351e3cb10c::qqqohta {
    struct QQQOHTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQOHTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQQOHTA>(arg0, 6, b"QQQOHTA", b"Qohta", b"50  50    50", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_13_43_09_7b73cf71f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQQOHTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQQOHTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

