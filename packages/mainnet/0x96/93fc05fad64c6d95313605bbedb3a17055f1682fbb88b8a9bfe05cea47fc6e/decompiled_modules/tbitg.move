module 0x9693fc05fad64c6d95313605bbedb3a17055f1682fbb88b8a9bfe05cea47fc6e::tbitg {
    struct TBITG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBITG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBITG>(arg0, 6, b"TBITG", b"The Banana in the Galaxy", x"412062616e616e612064726966746564207468726f756768207468652067616c6178792c20626f756e63696e672066726f6d2061737465726f696420746f2061737465726f69642e204974206c616e646564206f6e20612064697374616e7420706c616e65742c20776865726520616c69656e73206465636c61726564206974206120726172652074726561737572652c2063656c6562726174696e672077697468206120636f736d69632066656173742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xr8_Rq_Thu_R_Ea1p_Guq_M_Rj_Xy_V5fq_M9_Hrr_Rah7ayjni_D9_Ta_J_ee19115117.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBITG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBITG>>(v1);
    }

    // decompiled from Move bytecode v6
}

