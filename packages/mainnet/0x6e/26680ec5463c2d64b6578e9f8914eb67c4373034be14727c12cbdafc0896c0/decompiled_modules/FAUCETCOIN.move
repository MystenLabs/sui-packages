module 0x6e26680ec5463c2d64b6578e9f8914eb67c4373034be14727c12cbdafc0896c0::FAUCETCOIN {
    struct FAUCETCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCETCOIN>, arg1: 0x2::coin::Coin<FAUCETCOIN>) {
        0x2::coin::burn<FAUCETCOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCETCOIN>>(0x2::coin::mint<FAUCETCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETCOIN>(arg0, 6, b"XEMOLD_COIN", b"hhh", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCETCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

