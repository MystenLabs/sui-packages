module 0x93b7d619329f1e7a4b5e308c3cbb859a272fe7c7c776fde671b98bbbbc021de3::ltest3 {
    struct LTEST3 has drop {
        dummy_field: bool,
    }

    public fun dummy_field(arg0: &mut 0x2::coin::TreasuryCap<LTEST3>) {
    }

    public fun freeze_metadata(arg0: 0x2::coin::CoinMetadata<LTEST3>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTEST3>>(arg0);
    }

    fun init(arg0: LTEST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTEST3>(arg0, 6, b"LTEST3", b"Launchpad Token", b"Token launched via Strategy Launchpad", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTEST3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LTEST3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

