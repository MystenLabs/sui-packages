module 0xdae67ce9dcc0bea4842e3dfb3af0303aa6890d9a2106de7eb760e114befc61fd::bitmog {
    struct BITMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITMOG>(arg0, 6, b"BITMOG", b"8-Bit Mog On Sui", x"54686520382d6269742076657273696f6e206f6620746865204d4f47206d656d6520636f696e2061646473206120706c617966756c2c20726574726f207477697374207769746820636c617373696320706978656c206172742c206272696e67696e67206261636b20746865206f6c642d7363686f6f6c20766964656f2067616d6520766962652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/19_1_1bad8ded63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

