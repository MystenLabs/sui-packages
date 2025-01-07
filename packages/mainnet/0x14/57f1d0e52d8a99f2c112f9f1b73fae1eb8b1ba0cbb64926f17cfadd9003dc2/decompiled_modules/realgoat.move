module 0x1457f1d0e52d8a99f2c112f9f1b73fae1eb8b1ba0cbb64926f17cfadd9003dc2::realgoat {
    struct REALGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALGOAT>(arg0, 6, b"Real Goat", b"REALGOAT", b"SIUUUUUUUUUU! CR7 is not just a player, he's a GOAT factory! 47 abs, 99 jumping, 100% raw sewey energy! Factos. Respect from Messi fan btw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/tmAd9y3.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<REALGOAT>>(0x2::coin::mint<REALGOAT>(&mut v2, 7000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REALGOAT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<REALGOAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

