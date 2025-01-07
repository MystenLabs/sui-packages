module 0x1d9b6eeb97c482bf24dd930c8b475aa10ee4dc5d223b6144caf92f0065c2c6fd::pweng {
    struct PWENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWENG>(arg0, 6, b"PWENG", b"PWENG ON SUI", b"Jus a wittle Pweng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wa_S_Sb_A_Vhwad_Ck_Jj_Jdz_M7gosb_Nangr8s_V_To_J6m8_J_Hc8_Qq_05e846937d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

