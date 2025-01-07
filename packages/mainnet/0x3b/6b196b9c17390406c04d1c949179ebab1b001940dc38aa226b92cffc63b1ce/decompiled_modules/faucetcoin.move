module 0x3b6b196b9c17390406c04d1c949179ebab1b001940dc38aa226b92cffc63b1ce::faucetcoin {
    struct FAUCETCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCETCOIN>, arg1: 0x2::coin::Coin<FAUCETCOIN>) {
        0x2::coin::burn<FAUCETCOIN>(arg0, arg1);
    }

    fun init(arg0: FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETCOIN>(arg0, 6, b"FGMC", b"Faucet Coin", b"Don't ask why", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCETCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAUCETCOIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCETCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

