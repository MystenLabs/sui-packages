module 0xe3b17668ea777a44293e9a92d81f7ebbce9c8b253ec0fae577952efaf912d37b::LOPY {
    struct LOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOPY>(arg0, 9, b"TRUMP", b"Trump Musk", b"Trump Musk usa", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

