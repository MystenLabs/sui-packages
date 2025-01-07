module 0xa5abc71fcd0effdb9510474d0f2b80dbecc691ba532ee055d39477bcaa38dddf::shuicount {
    struct SHUICOUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUICOUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUICOUNT>(arg0, 6, b"SHUICOUNT", b"HowManyShuis", b"How many Shuis are you guys counting?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6259_d453e035bb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUICOUNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUICOUNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

