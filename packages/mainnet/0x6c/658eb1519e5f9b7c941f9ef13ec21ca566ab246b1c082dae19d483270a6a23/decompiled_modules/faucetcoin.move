module 0x6c658eb1519e5f9b7c941f9ef13ec21ca566ab246b1c082dae19d483270a6a23::faucetcoin {
    struct FAUCETCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCETCOIN>, arg1: 0x2::coin::Coin<FAUCETCOIN>) {
        0x2::coin::burn<FAUCETCOIN>(arg0, arg1);
    }

    fun init(arg0: FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETCOIN>(arg0, 2, b"Faucet Coin", b"FC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCETCOIN>>(v0);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCETCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

