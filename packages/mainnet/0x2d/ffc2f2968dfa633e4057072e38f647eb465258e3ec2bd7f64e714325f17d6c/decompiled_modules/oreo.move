module 0x2dffc2f2968dfa633e4057072e38f647eb465258e3ec2bd7f64e714325f17d6c::oreo {
    struct OREO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OREO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OREO>(arg0, 6, b"OREO", b"OREO the Baby Otter", b"Baby  Otter on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcvqet_Jr_Lr_Hqd1n_Ak_Wd1_Hysb_Kd_HKKQDX_12_Xjjgu1rsc_Yj_4bb758036c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OREO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OREO>>(v1);
    }

    // decompiled from Move bytecode v6
}

