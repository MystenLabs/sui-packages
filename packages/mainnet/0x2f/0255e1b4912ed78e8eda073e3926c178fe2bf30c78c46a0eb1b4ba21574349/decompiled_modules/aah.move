module 0x2f0255e1b4912ed78e8eda073e3926c178fe2bf30c78c46a0eb1b4ba21574349::aah {
    struct AAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAH>(arg0, 6, b"AaH", b"AaHOP", b"Just do it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_D_D_1_cbf6ffe3fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

