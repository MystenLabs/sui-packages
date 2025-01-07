module 0xb811aa38e543be4183761adf8dcd03d53f4958b2d8577d08ec12d941681fdca1::pike_coin {
    struct PIKE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKE_COIN>(arg0, 6, b"PIKE_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PIKE_COIN>>(0x2::coin::mint<PIKE_COIN>(&mut v2, 100000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKE_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

