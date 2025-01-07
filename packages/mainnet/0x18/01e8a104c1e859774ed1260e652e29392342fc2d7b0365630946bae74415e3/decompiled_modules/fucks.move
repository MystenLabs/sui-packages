module 0x1801e8a104c1e859774ed1260e652e29392342fc2d7b0365630946bae74415e3::fucks {
    struct FUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKS>(arg0, 6, b"FUCKS", b"CryptoFucks", b"Utility token for NFT collection new generation of crypto collectors and builders, sleepless degens, lurking the web3, planning their next steps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ST_Bg_Hg8_U_Pf6_Wxr_TCT_2_H94_Qf_Ct_HMY_Ya_X_Wx_Eba3_Fp_F_Ljz7_aa3b4b590d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

