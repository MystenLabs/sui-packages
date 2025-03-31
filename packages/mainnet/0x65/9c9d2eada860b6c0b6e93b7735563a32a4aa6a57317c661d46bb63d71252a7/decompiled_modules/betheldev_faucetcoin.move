module 0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin {
    struct BETHELDEV_FAUCETCOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BETHELDEV_FAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BETHELDEV_FAUCETCOIN>>(0x2::coin::mint<BETHELDEV_FAUCETCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BETHELDEV_FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETHELDEV_FAUCETCOIN>(arg0, 6, b"BETHELDEV_FAUCETCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETHELDEV_FAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BETHELDEV_FAUCETCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

