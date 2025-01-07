module 0xed547ba628c95d443734f7448aac58f354ed53cc5aea61cfdabdba0603a171ea::nomage {
    struct NOMAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOMAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOMAGE>(arg0, 6, b"TTKN", b"TEST TOKEN", b"Don't ask why", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NOMAGE>>(0x2::coin::mint<NOMAGE>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOMAGE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOMAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

