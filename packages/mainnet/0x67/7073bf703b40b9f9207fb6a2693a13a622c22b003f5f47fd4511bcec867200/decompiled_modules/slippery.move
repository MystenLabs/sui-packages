module 0x677073bf703b40b9f9207fb6a2693a13a622c22b003f5f47fd4511bcec867200::slippery {
    struct SLIPPERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIPPERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIPPERY>(arg0, 9, b"SLIPPERY", b"SLIPPERY", b"SLIPPERY", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SLIPPERY>>(0x2::coin::mint<SLIPPERY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLIPPERY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SLIPPERY>>(v2);
    }

    // decompiled from Move bytecode v6
}

