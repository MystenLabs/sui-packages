module 0x8edefa6914e2235a5337d176028dec53d227d25a9109e2c050f9c82fa5aac19b::twx {
    struct TWX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWX>(arg0, 6, b"TWX", b"Twiskers", x"486577776f2c20496d20547769736b6572732c20746865206669657263657374206b6974747920696e20746f776e2c20726561647920746f2073686f772074686520696e7465726e65742077686f7320626f73732e204d7920706177732061726520736d6f6c20627574206d69676874792c20616e64206d792070757272733f205468657972652074686520736f756e64206f662061206368616d70696f6e2e20426574746572207761746368206f75742c20636175736520496d206865726520746f20636f6e7175657220616c6c20746865206d656d65732077697468206d7920666c75666620616e6420636c6177732c206e7961210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TWX_TF_8z6_B_b_Qu1_A9s9_Wox2_8ce2323dee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWX>>(v1);
    }

    // decompiled from Move bytecode v6
}

