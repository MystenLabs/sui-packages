module 0xce5d13eaf3ada1cf0e42570f181355b3822a3155ba96c955a7cac2e1ded205ab::purcit {
    struct PURCIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURCIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURCIT>(arg0, 6, b"PURCIT", b"Purcit", x"546865204d697363686965766f75732056616d7069726520436174206f6e205375692e2e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SSY_2_UMQ_5red_SB_2_V3g1g_C915kzm_FWV_Fy_F_Pf_L_Ex_P2_RM_8zw_97d3efdfce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURCIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURCIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

