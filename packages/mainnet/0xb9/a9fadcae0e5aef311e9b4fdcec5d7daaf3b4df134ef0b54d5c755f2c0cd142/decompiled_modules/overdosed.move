module 0xb9a9fadcae0e5aef311e9b4fdcec5d7daaf3b4df134ef0b54d5c755f2c0cd142::overdosed {
    struct OVERDOSED has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVERDOSED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVERDOSED>(arg0, 6, b"OVERDOSED", b"Overdosed", b"OVERDOSED MF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dj8_OC_4_H9cw8_Ojx_Jlr_B1_KS_Berkug_9a7e639534.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVERDOSED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OVERDOSED>>(v1);
    }

    // decompiled from Move bytecode v6
}

