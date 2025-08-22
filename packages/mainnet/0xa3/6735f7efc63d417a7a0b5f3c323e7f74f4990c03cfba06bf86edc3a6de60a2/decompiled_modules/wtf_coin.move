module 0xa36735f7efc63d417a7a0b5f3c323e7f74f4990c03cfba06bf86edc3a6de60a2::wtf_coin {
    struct WTF_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"");
        let v1 = if (0x1::ascii::length(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(v0))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<WTF_COIN>(arg0, 9, b"WTF", b"Wtf Coin", b"My wtf coin", v1, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTF_COIN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

