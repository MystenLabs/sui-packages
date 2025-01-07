module 0xd02ffb82f7f0e1d7d7d7d3d7e036c58cef0067eb60436b7a51aaf3230c7801db::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 6, b"ANON", b"First nigga to create bitcoin", x"54686520666972737420426c61636b206d616e20746f206372656174650a426974636f696e20776f756c64206d61726b20610a67726f756e64627265616b696e67206d6f6d656e7420696e0a63727970746f63757272656e637920686973746f72792c0a726570726573656e74696e672064697665727369747920616e640a696e6e6f766174696f6e20696e206120707265646f6d696e616e746c790a776869746520746563682073706163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_04_48_53_78e282b325.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANON>>(v1);
    }

    // decompiled from Move bytecode v6
}

