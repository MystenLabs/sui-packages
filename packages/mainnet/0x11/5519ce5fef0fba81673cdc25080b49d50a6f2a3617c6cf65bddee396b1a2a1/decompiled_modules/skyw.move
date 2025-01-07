module 0x115519ce5fef0fba81673cdc25080b49d50a6f2a3617c6cf65bddee396b1a2a1::skyw {
    struct SKYW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYW>(arg0, 6, b"SKYW", b"Bananakin Skywalker", b"Bananakin Skywalker is a cosmic banana wielding a lightsaber. With his quirky personality and hilarious attitude, Bananakin reminds us to enjoy our investments. He travels the meme galaxy, battling the meme dark side.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734240335666.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

