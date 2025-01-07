module 0x490b9c606488c47b9eaa4482393cc03f14a4bcd31039763a2cafd686d33bc821::misty {
    struct MISTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTY>(arg0, 9, b"MISTY", b"Misty", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://Qma4f7XM5YtL3oueJEnaSLaiUCXmoMMycGTv2eugGn3JMx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MISTY>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MISTY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MISTY>>(v2);
    }

    // decompiled from Move bytecode v6
}

