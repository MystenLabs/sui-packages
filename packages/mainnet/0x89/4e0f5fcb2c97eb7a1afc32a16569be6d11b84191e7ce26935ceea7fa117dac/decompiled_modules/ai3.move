module 0x894e0f5fcb2c97eb7a1afc32a16569be6d11b84191e7ce26935ceea7fa117dac::ai3 {
    struct AI3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI3>(arg0, 6, b"AI3", b"AI", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AI3>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI3>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AI3>>(v2);
    }

    // decompiled from Move bytecode v6
}

