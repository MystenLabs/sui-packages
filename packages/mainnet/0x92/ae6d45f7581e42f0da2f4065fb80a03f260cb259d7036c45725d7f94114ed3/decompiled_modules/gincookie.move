module 0x92ae6d45f7581e42f0da2f4065fb80a03f260cb259d7036c45725d7f94114ed3::gincookie {
    struct GINCOOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINCOOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINCOOKIE>(arg0, 6, b"GINCOOKIE", b"GINCOOKIE SUI", b"GINCOOKIE is a utility and collectible token that combines the fun of an iconic character with the world of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma6cnr3_K9fdspifvbv_Ctf_SL_Rr5_Xz_HE_9m_NZHW_77_HT_8_Qjpb_1996d966bc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINCOOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINCOOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

