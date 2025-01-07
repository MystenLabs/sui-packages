module 0x4a067580a382a4beae879413faac774ef254cee3f757591a2684a8a0a3fe480a::muu {
    struct MUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUU>(arg0, 6, b"MUU", b"Muu Deng", b"Muu Deng the retarded hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XZA_Hhvck_Jn25_MJ_Xp_M_Ghcef_N946yd_P_Tb_Zy_DS_7_L5_MDVVLG_2a575aedf7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

