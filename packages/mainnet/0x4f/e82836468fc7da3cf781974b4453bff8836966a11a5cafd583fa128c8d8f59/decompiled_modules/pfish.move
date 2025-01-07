module 0x4fe82836468fc7da3cf781974b4453bff8836966a11a5cafd583fa128c8d8f59::pfish {
    struct PFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFISH>(arg0, 6, b"Pfish", b"Pig Fish", b"No 1 tiktok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmea7zvug_G_Nb7ire_E3n_Ge_TLT_Jh_NE_Fmz_M4_B8_Gurd95h_Psw_R_3dc8321c15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

