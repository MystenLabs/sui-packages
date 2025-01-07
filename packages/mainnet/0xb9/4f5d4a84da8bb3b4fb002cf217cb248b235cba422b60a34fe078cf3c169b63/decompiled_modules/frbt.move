module 0xb94f5d4a84da8bb3b4fb002cf217cb248b235cba422b60a34fe078cf3c169b63::frbt {
    struct FRBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRBT>(arg0, 6, b"FRBT", b"FROSTBOT", x"46726f7374626f74206973206865726520746f207370726561642066657374697665206761696e7320616e64206b65657020697420636f6f6c20696e207468652077696c6420776f726c64206f66206d656d6520636f696e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W12_LT_Nxc_U_Zq_V1k_CR_7_Powg_J9_Jma9_UH_Hbt_Vceqo15k_VE_Ge_b7f62ea182.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

