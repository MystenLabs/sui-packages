module 0x74c4a1d048b7f3b0fa23a2392ff0f0f2b46a4b2881f999c8534107a43ae0cb9d::giro_point {
    struct GIRO_POINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRO_POINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRO_POINT>(arg0, 0, b"GP", b"Giro Point", b"Giro Point", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GIRO_POINT>>(0x2::coin::mint<GIRO_POINT>(&mut v2, 12345678, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIRO_POINT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRO_POINT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

