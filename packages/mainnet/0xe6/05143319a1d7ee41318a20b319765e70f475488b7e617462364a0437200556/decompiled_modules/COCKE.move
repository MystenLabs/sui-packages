module 0xe605143319a1d7ee41318a20b319765e70f475488b7e617462364a0437200556::COCKE {
    struct COCKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCKE>(arg0, 6, b"Give me Cocke", b"COCKE", x"4f72646572696e6720434f4b45204f522024434f434b453f20426f726e2066726f6d206f6e6520746f6f206d616e79206d6973686561726420436f6b65206f72646572732e0a24434f434b452069732066697a7a792c20756e66696c74657265642c20616e64206865726520746f206d616b6520657665727920736c6970206f662074686520746f6e67756520776f7274682069742e0a68747470733a2f2f7777772e796f75747562652e636f6d2f77617463683f763d46694a645f6438492d6945", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/13a4110b-7279-43d1-bc03-b02d5fbc4cfb")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCKE>>(v0, @0xfec885527fc854a6894a9a8b975d0bdfdefe1d8d7364d7ca1f5e89267f72ccf7);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

