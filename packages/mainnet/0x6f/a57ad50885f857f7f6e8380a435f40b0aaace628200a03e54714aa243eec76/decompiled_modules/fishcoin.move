module 0x6fa57ad50885f857f7f6e8380a435f40b0aaace628200a03e54714aa243eec76::fishcoin {
    struct FISHCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHCOIN>(arg0, 9, b"Fish", b"Fish Coin", b"Fish coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

