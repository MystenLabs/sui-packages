module 0xe31a18ace543a8d317824b15718a54cf0477e5c93bcedb2f4c5d877dedc16a18::faucet {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET>(arg0, 8, b"FAUCET", b"faucet", b"faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

