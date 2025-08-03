module 0xf9565379e4cbed8b7cc0bb262e1a37c728426cd06a31369c5ed4c6063d9277cb::air_token {
    struct AIR_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIR_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIR_TOKEN>(arg0, 9, b"AIR", b"Air Token", b"Need Air to breawe", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<AIR_TOKEN>>(v0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIR_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

