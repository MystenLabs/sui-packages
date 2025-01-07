module 0xe9cb91e761bc28de08c7dbbb6b4a2d50c1522b31ba72175dd8f824887f5aaddf::smileyy {
    struct SMILEYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILEYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILEYY>(arg0, 6, b"SMILEYY", b"Smiley Sui", x"57616c2d4d617274207265766976657320736d696c6579206661636520696d61676520666f72207072696365206d61726b6574696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_02_02_16_21_12_d533f60a29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILEYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMILEYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

