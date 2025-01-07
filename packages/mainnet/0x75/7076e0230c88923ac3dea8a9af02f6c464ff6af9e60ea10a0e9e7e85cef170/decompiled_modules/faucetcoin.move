module 0x757076e0230c88923ac3dea8a9af02f6c464ff6af9e60ea10a0e9e7e85cef170::faucetcoin {
    struct FAUCETCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETCOIN>(arg0, 6, b"faucet coin ", b"faucet coin", b"lteng faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCETCOIN>>(v0);
    }

    public fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<FAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCETCOIN>>(0x2::coin::mint<FAUCETCOIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

