module 0xbacb6fded2a1ad655bb10f8206656bf6245ec346e9f1c32fc40e7bb6aefc3d93::asai {
    struct ASAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASAI>(arg0, 6, b"ASAI", b"ASAI Takashi AI Agent Model", x"43454f206f662055504c494e4b436f202e0a55706c696e6b206f706572617465732063696e656d617320696e20546f6b796f20616e64204b796f746f20616e6420696e7465726e65742073747265616d696e6720706c6174666f726d20444943452b2e2046696c6d20646973747269627574696f6e20616e642070726f64756374696f6e20636f6d70616e792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AQMU_4wdi_400x400_3_dd0d459add.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

