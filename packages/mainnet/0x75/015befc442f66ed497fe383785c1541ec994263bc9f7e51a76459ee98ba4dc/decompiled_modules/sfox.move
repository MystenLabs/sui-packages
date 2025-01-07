module 0x75015befc442f66ed497fe383785c1541ec994263bc9f7e51a76459ee98ba4dc::sfox {
    struct SFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFOX>(arg0, 6, b"SFOX", b"Sui Fox", x"53756920466f783a205768657265204d656d6573204d65657420496e6e6f766174696f6e0a53756920466f78206973206120636f6d6d756e6974792d64726976656e206d656d6520636f696e206f6e20746865206661737420616e64207363616c61626c652053756920426c6f636b636861696e2e20436f6d62696e696e672068756d6f722c20746563686e6f6c6f67792c20616e6420646563656e7472616c697a6174696f6e2c2053756920466f78206372656174657320612066756e2c20696e636c757369766520737061636520666f722063727970746f20656e7468757369617374732e204a6f696e207769746820757320f09f90b1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731779445001.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

