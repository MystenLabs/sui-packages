module 0x196c89071f88dcc333935f5fba388918ff19792fddd751d57c121364e72b5d2a::pkush {
    struct PKUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKUSH>(arg0, 6, b"PKUSH", b"Purple Kush", x"507572706c6520426974636f696e2c20507572706c6520506570652c20616e64206e6f7720507572706c65204b7573682020746865204f47206f662076696272616e74206469676974616c206173736574732e2041206e6f6420746f20746865206c6567656e646172792073747261696e7320616e6420616e20686f6d61676520746f2074686520636c6173736963732c20507572706c65204b757368206973206865726520746f2074616b65206f7665722e20446f6e7420736c656570206f6e2069742c2066616d210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_WV_Kgp_Kx_MH_7c7_WZ_Dhf87_S7_Y_Eq_Nx_Qimnr7ea_Bg_Cn_Rg_Tay_J_624413134d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

