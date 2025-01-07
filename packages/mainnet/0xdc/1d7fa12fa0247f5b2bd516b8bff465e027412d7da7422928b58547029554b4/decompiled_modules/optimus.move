module 0xdc1d7fa12fa0247f5b2bd516b8bff465e027412d7da7422928b58547029554b4::optimus {
    struct OPTIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTIMUS>(arg0, 6, b"OPTIMUS", b"OptimusBotSUI", x"412067656e6572616c20707572706f73652c2062692d706564616c2c2068756d616e6f696420726f626f742063617061626c65206f6620706572666f726d696e67207461736b7320746861742061726520756e736166652c2072657065746974697665206f7220626f72696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9f_UR_Vh8_Ykz_X_Dch2_Kmi_BK_7_YT_1z_PYGC_9_Uc_Wf_XA_Tvcupump_024d9e5aa0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPTIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

