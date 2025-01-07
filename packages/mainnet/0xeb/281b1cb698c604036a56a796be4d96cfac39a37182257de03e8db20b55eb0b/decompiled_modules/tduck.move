module 0xeb281b1cb698c604036a56a796be4d96cfac39a37182257de03e8db20b55eb0b::tduck {
    struct TDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDUCK>(arg0, 6, b"TDUCK", b"TRUMP DUCK", x"5472756d702d4475636b203a202054686520626174746c6520666f7220636f6e74726f6c206f662074686520626c6f636b636861696e3a20412067726f7570206f660a6861636b65727320697320706c6f7474696e6720746f2061747461636b2074686520537569206e6574776f726b20616e642074616b65206f7665720a544455434b2e200a43616e20544455434b204475636b20616e642069747320636f6d6d756e6974792070726f74656374207468656972207669727475616c0a63757272656e63793f0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_7_e86a6f57d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

