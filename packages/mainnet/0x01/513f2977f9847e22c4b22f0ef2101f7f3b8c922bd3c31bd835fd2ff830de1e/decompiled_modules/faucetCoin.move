module 0x1513f2977f9847e22c4b22f0ef2101f7f3b8c922bd3c31bd835fd2ff830de1e::faucetCoin {
    struct FAUCETCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETCOIN>(arg0, 6, b"FAUCETCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCETCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

