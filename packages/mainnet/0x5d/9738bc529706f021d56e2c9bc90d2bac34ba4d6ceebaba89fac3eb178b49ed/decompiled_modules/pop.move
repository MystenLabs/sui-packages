module 0x5d9738bc529706f021d56e2c9bc90d2bac34ba4d6ceebaba89fac3eb178b49ed::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP>(arg0, 6, b"POP", b"POPA", x"4120636f6d6d756e69747920636c61696d6564206f776e65727368697020666f72207468697320746f6b656e206f6e2053657020323620323032340a0a436f6d6d756e69747920436c61696d0a333525206275726e207468656e206465762064756d706564206f6e20616c742c20616e64206c6566742e204e6f772074686520777566207570726973696e6720626567696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d40431e0_72cb_4ed2_b635_b3f89b084ada_a3acf57895.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POP>>(v1);
    }

    // decompiled from Move bytecode v6
}

