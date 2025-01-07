module 0xb93dbb0f9b6a34b1243fc825f6680bf41fa66ed5b3f8b36211d1b7853e98b3b6::OGCHRISTMAS {
    struct OGCHRISTMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGCHRISTMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGCHRISTMAS>(arg0, 6, b"OG CHRISTMAS", b"The good old OG Christmas", b"I know. The feeling of the new era of christmas is not as good as it was. This may help you.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGCHRISTMAS>>(v1);
        0x2::coin::mint_and_transfer<OGCHRISTMAS>(&mut v2, 69000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGCHRISTMAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

