module 0x3db0146fe2fa5d8a31d54693d1931517cc4e6750492f1630990757c84e2c99b7::melo {
    struct MELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELO>(arg0, 6, b"Melo", b"Melo Cat", b"Melo is the official cat of Shibetoshi Nakamoto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0718_6d30100708.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

