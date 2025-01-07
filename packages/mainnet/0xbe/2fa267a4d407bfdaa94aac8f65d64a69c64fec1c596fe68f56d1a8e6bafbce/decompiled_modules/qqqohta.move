module 0xbe2fa267a4d407bfdaa94aac8f65d64a69c64fec1c596fe68f56d1a8e6bafbce::qqqohta {
    struct QQQOHTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQOHTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQQOHTA>(arg0, 6, b"QQQOHTA", b"50/50", b"50 50 50", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_13_43_09_6c41154164.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQQOHTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQQOHTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

