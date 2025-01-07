module 0xde21069bec260936aea4d32512b11b218aff618afdcad2fa3f811f5c02e768e9::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"MOMO", b"MOMO The Google Cat", x"412063757465206361742c20612077697a6172642c20612066616d6f757320766964656f2067616d65206368617261637465722066726f6d20476f6f676c6520446f6f646c652c20612048616c6c6f7765656e2067686f73747320666967687465722e20546865206e617272617469766520697320746f6f20677265617420746f206e6f7420686f6c6420736f6d6520244d4f4d4f20210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zcpo_ZK_8g_Pt_BW_8_L9_L_Gc1zt_Y6_KCMV_4_Wo_B4t_KSKDQB_6wbzo_61243becfe.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

