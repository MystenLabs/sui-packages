module 0x536df9dc06df81e7651305a2e8089a20ceddffca30a29e6c69704a0af69771ac::flipper {
    struct FLIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPPER>(arg0, 6, b"Flipper", b"Flipper the DolPhin", x"446f6c7068696e20436f696e202824444f4c29206973207468652073656e736174696f6e20696e2074686520536561206f662074686520537569206d656d65636f696e732e0a0a54473a2068747470733a2f2f742e6d652f646f6c7068696e6f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Flipper_2abdbac846.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

