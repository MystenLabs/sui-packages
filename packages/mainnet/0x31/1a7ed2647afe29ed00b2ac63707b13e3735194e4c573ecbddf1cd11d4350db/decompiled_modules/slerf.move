module 0x311a7ed2647afe29ed00b2ac63707b13e3735194e4c573ecbddf1cd11d4350db::slerf {
    struct SLERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLERF>(arg0, 6, b"SLERF", b"Slerf", x"24536c65726620656d65726765642077697468206120766973696f6e20746f20626520612066756e616e6420656e676167696e67206d656d6520636f696e2c206272696d6d696e6720776974686578636974696e6720636f6e74656e7420746f2070726f70656c20697473206a6f75726e6579666f72776172642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731851742665.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLERF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLERF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

