module 0x5f0ed4185c32bab6c93b2e859d06c9f6586da656b64de9ab51d8718fcd8cda5d::pepesuichain {
    struct PEPESUICHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESUICHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUICHAIN>(arg0, 6, b"t.me/PepeSuiChain/ WHEN_GOOD_DEX?", b"t.me/PepeSuiChain/ WHEN_GOOD_DEX?", b"t.me/PepeSuiChain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/F8amRgy.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPESUICHAIN>>(v1);
        0x2::coin::mint_and_transfer<PEPESUICHAIN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPESUICHAIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

