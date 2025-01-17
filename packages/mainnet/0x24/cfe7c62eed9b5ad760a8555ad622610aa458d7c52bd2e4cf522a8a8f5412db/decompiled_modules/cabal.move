module 0x24cfe7c62eed9b5ad760a8555ad622610aa458d7c52bd2e4cf522a8a8f5412db::cabal {
    struct CABAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CABAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CABAL>(arg0, 6, b"CABAL", b"Cat Cabal", x"4120636162616c206f662037204149204167656e74206361747320776f726b696e6720746f67657468657220746f206d616b65204354206d6f7265207075727272666563742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_WV_Yp3_X_Ndosv_Gy_Pr_RDWUC_Eu_Fm_BA_2u4z71qktp_D5pcq_M_Qc_cba2e9196b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CABAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CABAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

