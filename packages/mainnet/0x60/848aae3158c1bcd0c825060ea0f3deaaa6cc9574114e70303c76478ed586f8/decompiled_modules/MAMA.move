module 0x60848aae3158c1bcd0c825060ea0f3deaaa6cc9574114e70303c76478ed586f8::MAMA {
    struct MAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMA>(arg0, 9, b"MAMA", b"Mama Trump", b"Mama Trump Boost", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

