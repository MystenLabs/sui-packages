module 0x76dfe53bfd6f88587b2eed14907a46a760c264e2afed96cf4ca929355d621730::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 6, b"WOJAK", b"WOJAK Maximus", b"Maximus Wojak is skyrocketing on SUI!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y3_N8m_W9byibxr_Nqm1jh_W3_Hry1n_Kat_DYT_Gu5ufqt_Xobqj_32f24f42fc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

