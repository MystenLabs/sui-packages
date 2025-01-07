module 0x271af64d44fb234d8c5e4f4fb5613d87ebea0a61fec0cac6ac4eeb8ed02a4c6e::woopig {
    struct WOOPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOPIG>(arg0, 6, b"WOOPIG", b"Woo Pig Sui", x"574f4f2050494720535549206973206120756e69717565206d656d65636f696e20696e7370697265642062792074686520737069726974656420686f672063616c6c20e2809c776f6f6f6f6f6f6f6f6f6f6f6f6f20706967207375692ce2809d2064657369676e656420746f20666f7374657220612073656e7365206f662062656c6f6e67696e6720616e6420636f6d6d756e69747920616d6f6e6720697473206d656d626572732e20546869732070726f6a6563742063656c656272617465732074686520706f776572206f6620636f6e6e656374696f6e207468726f75676820612066756e20616e6420656e676167696e672063757272656e6379", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734183862296.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOPIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOPIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

