module 0x79157c4574da2ff3ede4e105de2c5c443728197deaa7c80d1330b0b6df1299ef::pepelord {
    struct PEPELORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPELORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPELORD>(arg0, 6, b"PEPELORD", b"Pepe Lord", x"546865204c6f7264206f66204d656d6520436f696e7320204c617567682e20486f6c642e204d6f6f6e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U_Hhs_Vg_Z7p_Mmhvdvshwso_Uy_S_Yrf_ND_2z_QW_Af_HP_69di_Dxf_J_310745287d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPELORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPELORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

