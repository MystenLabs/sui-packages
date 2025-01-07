module 0xe02c96c937e0025e2f9dfc71dfaf783a7dde65888ab2cae91e5c4c2038868797::mom {
    struct MOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOM>(arg0, 6, b"Mom", b"your mom", b"you already know", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rm_Vt_T_Sj7cj_Nj_Y_Aa_YZAP_6_Nr_S_Gp82_PN_Zh_Czg_Eo_Swo_Cco_YZ_8abaef65cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

