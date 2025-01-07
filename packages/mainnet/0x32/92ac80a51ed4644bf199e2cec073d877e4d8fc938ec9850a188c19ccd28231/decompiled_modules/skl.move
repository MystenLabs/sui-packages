module 0x3292ac80a51ed4644bf199e2cec073d877e4d8fc938ec9850a188c19ccd28231::skl {
    struct SKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKL>(arg0, 6, b"SKL", b"SKULL", x"536b756c6c20546f6b656e20697320616e20696e6e6f766174697665206d656d6520746f6b656e2064657369676e65642c0a0a746f20636170747572652074686520737069726974206f662066756e20616e6420636f6d6d756e69747920656e676167656d656e742077697468696e207468650a537569204e6574776f726b2e200a0a466561747572696e67206120756e6971756520736b756c6c2d7468656d6564206272616e64696e672c207468697320746f6b656e2061696d7320746f20626c656e640a68756d6f7220616e642063726561746976697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731130984518.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

