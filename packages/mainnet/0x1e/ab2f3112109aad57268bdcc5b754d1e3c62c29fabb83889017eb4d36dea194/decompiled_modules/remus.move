module 0x1eab2f3112109aad57268bdcc5b754d1e3c62c29fabb83889017eb4d36dea194::remus {
    struct REMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<REMUS>(arg0, 6, b"Remus", b"Remus Dog", b"Remus Dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_KW_2d_YG_Rdx_Fae_MWV_Kh1_S_Tey_Gn_G8_Ky_R_Eb_K66_J6_RK_Mpump_15e468d0ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<REMUS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMUS>>(v2);
    }

    // decompiled from Move bytecode v6
}

