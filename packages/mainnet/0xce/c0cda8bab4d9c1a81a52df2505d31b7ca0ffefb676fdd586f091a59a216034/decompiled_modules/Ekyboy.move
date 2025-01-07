module 0xcec0cda8bab4d9c1a81a52df2505d31b7ca0ffefb676fdd586f091a59a216034::Ekyboy {
    struct EKYBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EKYBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EKYBOY>(arg0, 6, b"EKYBOY", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EKYBOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EKYBOY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

