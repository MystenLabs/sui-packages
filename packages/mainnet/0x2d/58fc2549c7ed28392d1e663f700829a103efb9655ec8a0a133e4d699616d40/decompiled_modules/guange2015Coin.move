module 0x2d58fc2549c7ed28392d1e663f700829a103efb9655ec8a0a133e4d699616d40::guange2015Coin {
    struct GUANGE2015COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUANGE2015COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUANGE2015COIN>(arg0, 6, b"guange2015Coin", b"guange2015Coin", b"guange2015Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUANGE2015COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUANGE2015COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint<T0: drop>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

