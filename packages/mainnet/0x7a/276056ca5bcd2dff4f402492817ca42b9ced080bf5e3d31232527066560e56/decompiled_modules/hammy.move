module 0x7a276056ca5bcd2dff4f402492817ca42b9ced080bf5e3d31232527066560e56::hammy {
    struct HAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMY>(arg0, 6, b"HAMMY", b"Suihamster", x"52756e2c2068616d737465722c2072756e210a0a546865206661737465737420726f64656e74206f6e207468652053756920626c6f636b636861696e206861732066696e616c6c792061727269766564210a53554948414d5354455220282448414d4d59292069732061203130302520636f6d6d756e6974792d64726976656e206d656d65636f696e2c20696e7370697265642062792074686520656e65726779206f662068616d73746572732072756e6e696e67206e6f6e73746f70e28094616e64206e6f772c20726163696e6720746f20746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754680192784.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAMMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

