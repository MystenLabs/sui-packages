module 0xbce219e6c7077d8575e6a4b3e34cbb0922fc84f43c91a14d399edb2e8236db60::pepesuichain {
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

