module 0x941e71403e0836bc7fe6e884119d64b694c291498f9d04b0f6532487690767b8::diffminter {
    struct DIFFMINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIFFMINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIFFMINTER>(arg0, 6, b"diffminter", b"teswithdiffminter", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIFFMINTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIFFMINTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

