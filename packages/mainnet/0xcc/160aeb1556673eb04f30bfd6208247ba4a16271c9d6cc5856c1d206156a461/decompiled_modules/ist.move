module 0xcc160aeb1556673eb04f30bfd6208247ba4a16271c9d6cc5856c1d206156a461::ist {
    struct IST has drop {
        dummy_field: bool,
    }

    fun init(arg0: IST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IST>(arg0, 6, b"IST", b"IST6", b"do not buy this token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741794186293.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

