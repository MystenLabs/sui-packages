module 0x170ff6568ef073ca6a662456631ccdc0bf96697c2f5b7c607652c2f419644d7::melocats {
    struct MELOCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELOCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELOCATS>(arg0, 6, b"Melocats", b"Melo cat", x"48656c6c6f2065766572796f6e65206861766520796f752068656172642061626f7574204d696c6f20636174200a4d656c6f202069732061206d656d6520636f696e20666f722074686520636f6d6d756e69747920646f6e2774206d69737320796f7572206368616e6365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZDQ_Vag_WIAAKVI_3524f71a37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELOCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELOCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

