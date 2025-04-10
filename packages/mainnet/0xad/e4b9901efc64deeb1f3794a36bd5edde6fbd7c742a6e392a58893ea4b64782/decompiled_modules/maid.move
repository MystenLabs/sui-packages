module 0xade4b9901efc64deeb1f3794a36bd5edde6fbd7c742a6e392a58893ea4b64782::maid {
    struct MAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAID>(arg0, 6, b"Maid", b"SuiMaid", x"496e20746865206d7973746572696f757320776f726c64206f66205375692c20746865206d65726d61696420656d6261726b73206f6e20616e20616476656e7475726520746f2066696e64207468652068696464656e20747265617375726573206f66207468652064656570207365612e200a0a4f7572206e6577204f6365616e204d657461204865726f205375694d61696420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2753_361b77d769.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

