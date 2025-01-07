module 0xde7d2d6b031e3d0407f17eaf46b2fb2af3fb383a2b1056670538540a799a1261::ahri {
    struct AHRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHRI>(arg0, 1, b"AHRI", b"AHRI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AHRI>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHRI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AHRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

