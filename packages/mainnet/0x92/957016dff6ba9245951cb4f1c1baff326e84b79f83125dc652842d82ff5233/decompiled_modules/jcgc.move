module 0x92957016dff6ba9245951cb4f1c1baff326e84b79f83125dc652842d82ff5233::jcgc {
    struct JCGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JCGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JCGC>(arg0, 6, b"JCGC", b"Julius Caesar's Gold", x"5765206172652070726f756420746f20696e74726f64756365204a756c69757320436165736172277320476f6c6420436f696e2c206f7572206669727374206d656d65206469676974616c20636f696e2064657369676e656420666f722066756e20616e6420696e6e6f766174696f6e21204f757220636f696e2062726964676573206265747765656e2074686520536f6c616e6120616e642053756920626c6f636b636861696e732c206d61696e7461696e696e6720657175616c2076616c7565206163726f737320626f7468207768696c65206368617267696e67206f6e6c792061206d696e696d616cc2a07472616e73666572c2a06665652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735650230530.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JCGC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JCGC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

