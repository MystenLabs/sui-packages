module 0xc933ec47ce4cf6773a9cc787c66a9c48b186f89a65d2d1a55009a3244ab75698::iykwim {
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

