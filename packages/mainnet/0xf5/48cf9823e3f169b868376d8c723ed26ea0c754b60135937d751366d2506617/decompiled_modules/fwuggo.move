module 0xf548cf9823e3f169b868376d8c723ed26ea0c754b60135937d751366d2506617::fwuggo {
    struct FWUGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWUGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWUGGO>(arg0, 6, b"FWUGGO", b"Fwuggo AI", b"Just an army of fwuggers chillin at the pond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wovw_X4_K_Kkzxj_E_Kh_Yf8_Td_Avtxp9_H4_Y5t_W_Jw_Hx2_NF_Gjk_UN_47fbeef18a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWUGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWUGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

