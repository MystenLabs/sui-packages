module 0xa48caaaa54a6a5f7b20629802b18d433bfa8a51811293edab23d32e7629e0129::qqqohta {
    struct QQQOHTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQOHTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQQOHTA>(arg0, 6, b"QQQOHTA", b"QQQ ohta", x"35302f3530206f6874616e69206f6e205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_13_43_09_9b4f3eb219.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQQOHTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQQOHTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

