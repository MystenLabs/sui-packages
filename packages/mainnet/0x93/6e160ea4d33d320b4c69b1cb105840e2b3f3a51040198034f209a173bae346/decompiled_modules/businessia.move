module 0x936e160ea4d33d320b4c69b1cb105840e2b3f3a51040198034f209a173bae346::businessia {
    struct BUSINESSIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSINESSIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSINESSIA>(arg0, 6, b"BusinessIA", b"Business IA PROAgent", b"Join an immersive MMO adventure where stylish secret agents with golden hair and sharp suits navigate a vibrant world of intrigue and danger. Embark on quests, solve mysteries, and face thrilling challenges alongside allies in a universe where strategy and elegance are the keys to victory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Psogc_JB_5_Nd4_Ja_MW_Gy_Vo_CTG_9_XHAQ_Uga_R7_S_Kt_Jv_Af1_LK_5z_8fe33d3e3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSINESSIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUSINESSIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

