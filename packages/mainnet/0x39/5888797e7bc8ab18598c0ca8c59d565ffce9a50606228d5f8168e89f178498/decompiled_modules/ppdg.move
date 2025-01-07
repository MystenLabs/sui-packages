module 0x395888797e7bc8ab18598c0ca8c59d565ffce9a50606228d5f8168e89f178498::ppdg {
    struct PPDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPDG>(arg0, 6, b"PPDG", b"PepeDoge", x"436f6d62696e696e67207468652074776f206c617267657374206d656d657320746f67657468657221205768617420636f756c6420706f737369626c7920676f2077726f6e673f204974277320446f676520776974682050657065210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_ZC_3_Fk_Lfx_Gyh_Li5j_Pr_S_De_V5_Gs_M3o1_Hy_WS_8dt7_Egp_F2_JQ_5a5c418a64.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

