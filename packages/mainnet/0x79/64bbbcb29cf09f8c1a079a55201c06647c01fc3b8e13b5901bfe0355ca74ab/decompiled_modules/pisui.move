module 0x7964bbbcb29cf09f8c1a079a55201c06647c01fc3b8e13b5901bfe0355ca74ab::pisui {
    struct PISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISUI>(arg0, 6, b"PISUI", b"Pinky On Sui", x"46697273742050696e6b79204f6e205375693a2068747470733a2f2f70696e6b796f6e7375692e6f72670a68747470733a2f2f782e636f6d2f50696e6b795f5375690a68747470733a2f2f742e6d652f50696e6b795355494f696e6b5f4368616e6e656c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3_4_c7fe695c4e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

