module 0xf10aa339affd7fd89c9e2040de7ba251bef8c2d152c350949104956148338330::nos {
    struct NOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOS>(arg0, 6, b"NOS", b"Neiro on Sui", x"4e6569726f204f6e205375695b4e4f535d206973206120636f6d6d756e6974792d64726976656e206d656d6520636f696e207468617420726570726573656e74732074686520657373656e6365206f6620646563656e7472616c697a65642068756d6f7220616e6420637265617469766974792e20496e7370697265642062792074686520636f6e63657074206f6620226e6575726f74696322206d656d65732c200a4e6569726f2061696d7320746f207265766f6c7574696f6e697a6520616e6420656e68616e6365207472616e73616374696f6e20616e64207065727370656374697665206f6e2063727970746f63757272656e63792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image0_1f16b5a7c9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

