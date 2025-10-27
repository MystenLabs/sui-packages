module 0x923027e879f8fb5bd58aa67c3fd99b4e16c8a3401f7a7dc31b8aa0324e61d0b8::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USD Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDC>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<USDC>>(v2);
    }

    // decompiled from Move bytecode v6
}

