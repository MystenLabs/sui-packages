module 0xf6eff0f85d7a6d29ba1aa72ade1603ad87cff0029cd5bcfed341c70a88a345f0::babymew {
    struct BABYMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMEW>(arg0, 6, b"BabyMew", b"Baby Mew on Sui", x"42616279204d65772069732061206272617665206c6974746c65206b697474656e206669676874696e6720616761696e737420696e657175616c69747920696e206120776f726c6420646f6d696e6174656420627920646f67732e20446573706974652069747320736d616c6c2073697a652c2042616279204d6577207374616e64732074616c6c2c206368616d70696f6e696e67206a75737469636520666f7220746865206f7665726c6f6f6b65642c2070726f76696e672074686174207472756520737472656e67746820636f6d65732066726f6d2064657465726d696e6174696f6e2c206e6f742073697a652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E7_Y2_H9e8_400x400_840584a3e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

