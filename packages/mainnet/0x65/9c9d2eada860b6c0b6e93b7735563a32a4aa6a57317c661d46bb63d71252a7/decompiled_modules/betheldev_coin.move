module 0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_coin {
    struct BETHELDEV_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETHELDEV_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETHELDEV_COIN>(arg0, 6, b"BETHELDEV_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETHELDEV_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETHELDEV_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BETHELDEV_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BETHELDEV_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

