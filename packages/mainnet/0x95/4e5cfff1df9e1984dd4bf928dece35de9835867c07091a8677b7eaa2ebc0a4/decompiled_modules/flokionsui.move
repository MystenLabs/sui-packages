module 0x954e5cfff1df9e1984dd4bf928dece35de9835867c07091a8677b7eaa2ebc0a4::flokionsui {
    struct FLOKIONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKIONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKIONSUI>(arg0, 6, b"Flokionsui", b"FLOKI on SUI", x"436f6d6d756e6974792c205574696c6974792c20436861726974792e2024464c4f4b492068617320697420616c6c2e0a0a4255494c44204f4e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_SS_3st_JFN_Yw4_Ayp_Na44ktg7isvh_Cs9c9_C_Hj_Ax_S_Yk_Nqhs_10e62f42b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKIONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKIONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

