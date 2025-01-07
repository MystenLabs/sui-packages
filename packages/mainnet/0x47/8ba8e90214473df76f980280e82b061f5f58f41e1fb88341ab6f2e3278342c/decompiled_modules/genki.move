module 0x478ba8e90214473df76f980280e82b061f5f58f41e1fb88341ab6f2e3278342c::genki {
    struct GENKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENKI>(arg0, 6, b"GENKI", b"SUGENKI", b"GENKI means good health. This was posted by the same founder that had recently got Pochita. We aim to also spread good health.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_L2_Uh_B5_U3_ZNZ_Ssac8_Gj13_JU_6_Sn_GNZ_Tcn_Xbxh_H_Neuix4s_031282c7f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

