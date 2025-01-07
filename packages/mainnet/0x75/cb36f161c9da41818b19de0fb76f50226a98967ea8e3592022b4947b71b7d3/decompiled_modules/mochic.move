module 0x75cb36f161c9da41818b19de0fb76f50226a98967ea8e3592022b4947b71b7d3::mochic {
    struct MOCHIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHIC>(arg0, 6, b"MOCHIC", b"mochicatonSUI", b"mochicatonsUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zyu_Ip8o_Sgrv_Gdybi_Oiv_Vt_X_Ebz_A_1003dd556d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCHIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

