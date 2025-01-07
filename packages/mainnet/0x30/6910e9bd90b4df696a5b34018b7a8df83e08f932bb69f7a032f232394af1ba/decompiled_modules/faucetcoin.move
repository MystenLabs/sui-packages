module 0x306910e9bd90b4df696a5b34018b7a8df83e08f932bb69f7a032f232394af1ba::faucetcoin {
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

