module 0x6c133f0cd8315757f40dcb581e901c9f0fb6d62317b72d7215fa415e95629f62::SUIGUY {
    struct SUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUY>(arg0, 2, b"SUI GUY", b"SUIGUY", b"The most chill Sui guy https://t.me/SUI_GUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/wxRKdJYM/suiguy.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGUY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGUY>(&mut v2, 1000000000, @0xbc6fc16a54028903b5c0e26a6f2dabc6c6f56fc934d5de872fab3520fa849edd, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

