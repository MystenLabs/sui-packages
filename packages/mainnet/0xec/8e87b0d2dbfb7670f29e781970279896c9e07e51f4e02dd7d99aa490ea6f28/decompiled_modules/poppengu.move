module 0xec8e87b0d2dbfb7670f29e781970279896c9e07e51f4e02dd7d99aa490ea6f28::poppengu {
    struct POPPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPENGU>(arg0, 6, b"POPPENGU", b"Pop Pengu", x"504f50504f504f504f504f504f504f4f504f504f504f504f504f504f500a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb1i_Wxr_S8jd_Fct7_D53pm5_FAWK_Kf_HG_9_S7s_Xx9_EG_3bo6ew1_33f8a1db28.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPPENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

