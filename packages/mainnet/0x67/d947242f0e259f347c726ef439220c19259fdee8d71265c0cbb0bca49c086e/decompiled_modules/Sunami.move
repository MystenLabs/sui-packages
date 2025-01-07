module 0x67d947242f0e259f347c726ef439220c19259fdee8d71265c0cbb0bca49c086e::Sunami {
    struct SUNAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNAMI>(arg0, 6, b"Sunami", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUNAMI>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNAMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNAMI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

