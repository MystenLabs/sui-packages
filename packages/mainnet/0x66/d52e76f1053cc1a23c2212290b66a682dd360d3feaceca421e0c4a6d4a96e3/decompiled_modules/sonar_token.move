module 0x21da5a7c7eaba5a757d7f8bdb06818d9cda19d734d469a052252bad5764e7043::sonar_token {
    struct SONAR_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONAR_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONAR_TOKEN>(arg0, 9, b"SNR", b"SONAR Token", b"Sound Oracle Network for Audio Rewards", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONAR_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONAR_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

