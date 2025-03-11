module 0x6be82833ef62188d40c21d7983780cb59da7503fa42359357bd1eb55932962e8::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 9, b"S", b"Yosoyass", b"Hi, I'm S.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/arbitrum/0xd44257dde89ca53f1471582f718632e690e46dc2.png?size=lg&key=c192f9")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<S>>(0x2::coin::mint<S>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<S>>(v2);
    }

    // decompiled from Move bytecode v6
}

