module 0x896d4a47f1dac9551a0e8a4079827e3ad3c36f028f56b19fd3756399dae241c9::khalifa {
    struct KHALIFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHALIFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHALIFA>(arg0, 6, b"KHALIFA", b"MIA KHALIFA", b"oooooooohhhhhhhhhh yeaaaaaaaah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_16_23_14_09_a0d92e09f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHALIFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHALIFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

