module 0x99275d5e2b03890e2325cad8d65e282fb77e864eb418b03b102d22b07a95f9a6::mooncat {
    struct MOONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONCAT>(arg0, 6, b"MOONCAT", b"Moon Cat on Sui", b"The most degen cat meme coin arrived on Sui. Get ready! $mooncat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wo_Xv_CXUM_Fp7_Se_Mx_M5jy_Vu1k_Uzsa_Su_Fr_N_Ho_Gvm_A_Bj_K8_Dk_b41aef1247.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

