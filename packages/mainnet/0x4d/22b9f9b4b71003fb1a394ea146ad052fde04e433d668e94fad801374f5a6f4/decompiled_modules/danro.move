module 0x4d22b9f9b4b71003fb1a394ea146ad052fde04e433d668e94fad801374f5a6f4::danro {
    struct DANRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANRO>(arg0, 6, b"DANRO", b"Danro", x"6d79206d6173636f74206861732073686f72742065796562726f7773210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yez_Jym_MJ_Qd_H6soc_ZH_Cy_CQ_2tswm_Xkw_GJA_3fht_Jd_A_Mbr_Wi_a6e783e44a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

