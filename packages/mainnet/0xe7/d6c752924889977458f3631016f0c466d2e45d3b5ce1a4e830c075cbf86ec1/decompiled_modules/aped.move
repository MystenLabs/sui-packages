module 0xe7d6c752924889977458f3631016f0c466d2e45d3b5ce1a4e830c075cbf86ec1::aped {
    struct APED has drop {
        dummy_field: bool,
    }

    fun init(arg0: APED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APED>(arg0, 6, b"Aped", b"ngl I aped", x"6e676c20492061706564206120736d616c6c20626167200a0a6c6574732072756e207468697320746f676574686572206173206120636f6d6d756e69747920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6234_9b3a04b9ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APED>>(v1);
    }

    // decompiled from Move bytecode v6
}

