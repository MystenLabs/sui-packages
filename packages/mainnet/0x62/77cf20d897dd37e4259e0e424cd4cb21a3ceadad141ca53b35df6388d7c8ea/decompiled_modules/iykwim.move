module 0x6277cf20d897dd37e4259e0e424cd4cb21a3ceadad141ca53b35df6388d7c8ea::iykwim {
    struct IYKWIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: IYKWIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IYKWIM>(arg0, 6, b"IYKWIM", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IYKWIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IYKWIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

