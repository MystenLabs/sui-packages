module 0x23fea58e00c254ac1ecb5e6d5f1b0921f8e348504c732faeff9810f1e7aecf85::jfg {
    struct JFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JFG>(arg0, 6, b"JFG", b"Just", x"f09f95b5efb88f20407375696c61756e6368636f696e20244a4647202b204a757374204665656c20476f6f64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/jfg-uy41j0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JFG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

