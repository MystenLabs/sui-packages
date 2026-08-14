module 0xed93808765495549cc4cb32f98a42c839012439e33f068e69bd31c0ec8094447::ADAPT {
    struct ADAPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAPT>(arg0, 9, b"AD", b"ADAPT", b"ADAPT is a fixed-supply community token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://adapt-anp3.ai/logo.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ADAPT>>(0x2::coin::mint<ADAPT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADAPT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ADAPT>>(v2);
    }

    // decompiled from Move bytecode v7
}

