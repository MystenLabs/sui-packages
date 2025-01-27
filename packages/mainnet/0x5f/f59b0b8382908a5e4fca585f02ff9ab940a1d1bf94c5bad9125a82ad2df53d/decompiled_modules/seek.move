module 0x5ff59b0b8382908a5e4fca585f02ff9ab940a1d1bf94c5bad9125a82ad2df53d::seek {
    struct SEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEK>(arg0, 9, b"SEEK", b"DeepSeek", b"DeepSeek-R1 AI Has Arrived!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xe1afea76e4002a0c1befa1aa2edf431f3632214a96c7fd069aa529b2a8b21c25::seek::seek.png?size=lg&key=3c007a")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEEK>>(0x2::coin::mint<SEEK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SEEK>>(v2);
    }

    // decompiled from Move bytecode v6
}

