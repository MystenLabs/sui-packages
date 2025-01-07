module 0x3a71e5254b30c938b9ccc603ba247d685b7b32f149c5b7dddd31b4bfb39b5e26::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 6, b"MEW", b"MeowWoof", x"4d656f77576f6f662069736e2774206a75737420736f6d65206f74686572206d656d6520636f696e2e204974277320612073796d626f6c206f6620756e6974792c206c6f79616c74792c20616d626974696f6e2c20616e6420656e746875736961736d2e0a0a4f75722073746f72792068617320736f206d756368206d6f726520746f2077726974652e2e2e20544f20424520434f4e54494e554544", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241103_074717_683_16aaf08450.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

