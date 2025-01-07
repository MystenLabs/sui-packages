module 0x719fae167165ed0295a1bdfa46d7488dc2687ca091c3fbdbd1070a22fd03b6b5::mooncat {
    struct MOONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONCAT>(arg0, 6, b"MOONCAT", b"Moon Cat on Sui", x"546865206d6f737420646567656e20636174206d656d6520636f696e2061727269766564206f6e205375692e204765742072656164792120246d6f6f6e6361740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wo_Xv_CXUM_Fp7_Se_Mx_M5jy_Vu1k_Uzsa_Su_Fr_N_Ho_Gvm_A_Bj_K8_Dk_0d46856435.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

