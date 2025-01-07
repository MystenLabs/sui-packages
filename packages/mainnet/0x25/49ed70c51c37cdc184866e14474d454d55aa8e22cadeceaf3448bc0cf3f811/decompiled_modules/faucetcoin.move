module 0x2549ed70c51c37cdc184866e14474d454d55aa8e22cadeceaf3448bc0cf3f811::faucetcoin {
    struct FAUCETCOIN has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::coin::TreasuryCap<FAUCETCOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCETCOIN>>(0x2::coin::mint<FAUCETCOIN>(arg0, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETCOIN>(arg0, 6, b"FAUCETCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCETCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

