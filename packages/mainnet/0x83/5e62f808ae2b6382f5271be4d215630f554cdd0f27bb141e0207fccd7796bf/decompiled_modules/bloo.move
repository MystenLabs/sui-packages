module 0x835e62f808ae2b6382f5271be4d215630f554cdd0f27bb141e0207fccd7796bf::bloo {
    struct BLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOO>(arg0, 6, b"BLOO", b"SuiBLoo", x"426c6f6f436f696e206973206120626f6c642063727970746f63757272656e6379206f6e2074686520537569206e6574776f726b2c206f66666572696e672063726561746976652066726565646f6d20616e642067726f777468206f70706f7274756e697469657320746f20616e20656e676167656420636f6d6d756e6974792e204a6f696e20426c6f6f20616e64207269646520746865207761766520696e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_B_Loo_d84d64e844.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

