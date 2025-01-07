module 0x8bd8c04e1feeeb40d011963d76fd289ebb0f9502abf67d7e785fb309b32089::maxx {
    struct MAXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXX>(arg0, 6, b"MAXX", b"MAXX SUI", x"43616e27742073746f7020766962696e672c20776f6e27742073746f7020766962696e672e20556c74696d61746520766962696e67206361742e20466f726576657220766962657320696e20796f75722077616c6c65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_Nb_WC_Rc41we_Yvzo_BCZ_Qbhx_Nih_A2_N_Ynkh_G_Rs1_NM_2_Vvgt_F_7271af0b02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

