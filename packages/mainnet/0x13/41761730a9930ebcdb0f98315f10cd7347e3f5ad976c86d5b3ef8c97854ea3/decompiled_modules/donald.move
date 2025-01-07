module 0x1341761730a9930ebcdb0f98315f10cd7347e3f5ad976c86d5b3ef8c97854ea3::donald {
    struct DONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALD>(arg0, 6, b"DONALD", b"Donald Duck", x"446f6e616c644475636b20697320612066756e206d656d65636f696e2020626c656e64696e67206e6f7374616c67696120776974682063727970746f207472656e64732e20466561747572696e672061207374796c697368207361696c6f72206475636b2020616e6420676f6c64656e2063727970746f2076696265732c2069747320616c6c2061626f757420636f6d6d756e6974792c2068756d6f722c20616e64207374616e64696e67206f757420696e2074686520626c6f636b636861696e20776f726c6421200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_NPEE_Fw_Pkzjnrwqwk_B5wn_Q_Mzk_R_Ur_Xd_BJ_2qx_X1f_Ga_D_Aiov_49ed2540e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

