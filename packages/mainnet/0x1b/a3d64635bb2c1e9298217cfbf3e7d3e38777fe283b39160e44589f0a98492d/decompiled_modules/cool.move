module 0x1ba3d64635bb2c1e9298217cfbf3e7d3e38777fe283b39160e44589f0a98492d::cool {
    struct COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOL>(arg0, 6, b"Cool", b"Cool Coin", b"asdjashdja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/intro_1640184659_78379db76b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

