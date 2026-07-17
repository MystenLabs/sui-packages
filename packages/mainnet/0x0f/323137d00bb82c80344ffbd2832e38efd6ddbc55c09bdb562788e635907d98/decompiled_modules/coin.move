module 0xf323137d00bb82c80344ffbd2832e38efd6ddbc55c09bdb562788e635907d98::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 9, b"XTSM", b"XTSMUSDC", b"XTSMUSDC (Sui Coin standard).", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

