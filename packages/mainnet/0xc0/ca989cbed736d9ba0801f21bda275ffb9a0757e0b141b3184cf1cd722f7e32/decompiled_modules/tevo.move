module 0xc0ca989cbed736d9ba0801f21bda275ffb9a0757e0b141b3184cf1cd722f7e32::tevo {
    struct TEVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEVO>(arg0, 6, b"TEVO", b"Theory of Evolution", b"The evolution of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Fa7_Qit2_Qk_Ppd_Bhm94_V_Vgp2_U2b_FK_Mq_B7s_BVB_1_Akn_Ar_Qh_21c73bf4c1.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEVO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEVO>>(v1);
    }

    // decompiled from Move bytecode v6
}

