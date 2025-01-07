module 0x65e6fbfe49cb93ced8ddbd037543a600cb773742686e3cc9cf63a73e5ee5645d::cmiw {
    struct CMIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMIW>(arg0, 6, b"CMIW", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMIW>>(v1);
        0x2::coin::mint_and_transfer<CMIW>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMIW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

