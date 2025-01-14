module 0xcb1f71f5afe51cf556d72a57254a22b85dbad234d71e7e354ae876a7710db120::zeroxone {
    struct ZEROXONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEROXONE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZEROXONE>(arg0, 6, b"ZEROXONE", b"SuiPlay by SuiAI", b"0X1 the first-of-its-kind handheld gaming console with integrated AI, supporting a wide range of PC games and new AAA titles developed using Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3793_1bf801e0f2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZEROXONE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEROXONE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

