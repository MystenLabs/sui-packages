module 0x99c916ee91a68bd4301e6fad729c6fefd4f8f76f554978f71ff594703a66db20::mika_lahtinen_coin {
    struct MIKA_LAHTINEN_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MIKA_LAHTINEN_COIN>, arg1: 0x2::coin::Coin<MIKA_LAHTINEN_COIN>) {
        0x2::coin::burn<MIKA_LAHTINEN_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIKA_LAHTINEN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MIKA_LAHTINEN_COIN>>(0x2::coin::mint<MIKA_LAHTINEN_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MIKA_LAHTINEN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKA_LAHTINEN_COIN>(arg0, 6, b"MLC", b"MIKA_LAHTINEN_COIN", b"Coin created by Mika Lahtinen.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKA_LAHTINEN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKA_LAHTINEN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

