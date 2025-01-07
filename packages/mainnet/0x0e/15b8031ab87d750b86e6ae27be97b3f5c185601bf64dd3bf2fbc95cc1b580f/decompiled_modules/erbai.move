module 0xe15b8031ab87d750b86e6ae27be97b3f5c185601bf64dd3bf2fbc95cc1b580f::erbai {
    struct ERBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERBAI>(arg0, 6, b"ERBAI", b"ERBAI ai robot", b"$ERBAI, the first AI robot caught in a attempted kidnapping", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hh_Cx_PN_Tirk_TT_5_TE_8jn_Bhtca_S6n_Tc_Hp8_Zh_Pw_Kggj_Apump_c985718b73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

