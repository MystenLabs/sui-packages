module 0x981c0994df832f2a334ea7bcbb1ead7dd25794ed18fdb8b636b4f5557d5b96dd::sonar_token {
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

