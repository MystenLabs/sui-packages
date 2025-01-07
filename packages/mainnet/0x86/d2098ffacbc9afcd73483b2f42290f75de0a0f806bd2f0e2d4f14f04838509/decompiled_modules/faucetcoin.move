module 0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin {
    struct FAUCETCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETCOIN>(arg0, 6, b"MYC", b"TheonInAu Faucet", b"First Faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCETCOIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

