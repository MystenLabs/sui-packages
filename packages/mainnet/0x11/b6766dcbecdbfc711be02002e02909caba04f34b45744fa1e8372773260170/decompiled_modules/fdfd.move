module 0x11b6766dcbecdbfc711be02002e02909caba04f34b45744fa1e8372773260170::fdfd {
    struct FDFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDFD>(arg0, 9, b"FDFD", b"dfd", b"dfd", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FDFD>(&mut v2, 3333000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDFD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

