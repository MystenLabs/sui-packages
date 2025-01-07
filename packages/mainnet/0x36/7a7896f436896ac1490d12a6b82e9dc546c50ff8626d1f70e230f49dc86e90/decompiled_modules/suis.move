module 0x367a7896f436896ac1490d12a6b82e9dc546c50ff8626d1f70e230f49dc86e90::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 9, b"SUIS", b"SUIS", b"SUIS token for swap example", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

