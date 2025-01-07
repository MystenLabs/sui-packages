module 0xe1573bb141b546574c1fe6e21cb70395950c9b41c82a642fb5ac94d3d870cd83::fwendies {
    struct FWENDIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWENDIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWENDIES>(arg0, 6, b"FWENDIES", b"fwendies", x"4974736166776169670a4a75737420736f6d65204657454e44494553206c6f76657273206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_ZDLYEF_Mj_Ym_M_Nc8ep_E98h_Nf7q_G_Nf_Hmhf_H_Sdf_Govq_Epyq_4be1e55ed8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWENDIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWENDIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

