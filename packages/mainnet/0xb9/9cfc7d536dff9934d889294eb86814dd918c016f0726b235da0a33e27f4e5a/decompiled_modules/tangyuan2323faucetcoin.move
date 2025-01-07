module 0xb99cfc7d536dff9934d889294eb86814dd918c016f0726b235da0a33e27f4e5a::tangyuan2323faucetcoin {
    struct TANGYUAN2323FAUCETCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TANGYUAN2323FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TANGYUAN2323FAUCETCOIN>(arg0, 6, b"TANGYUAN2323FAUCETCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TANGYUAN2323FAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TANGYUAN2323FAUCETCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

