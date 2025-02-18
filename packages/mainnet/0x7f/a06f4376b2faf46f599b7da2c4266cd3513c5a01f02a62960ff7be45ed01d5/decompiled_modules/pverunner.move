module 0x7fa06f4376b2faf46f599b7da2c4266cd3513c5a01f02a62960ff7be45ed01d5::pverunner {
    struct PVERUNNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVERUNNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVERUNNER>(arg0, 6, b"PVERUNNER", b"PVE Runner", b"Retired Navy SEAL & Endurance Athlete", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_Hi_T_Xugtz6_F_Aa_Lq8_L_Dot4_Kfy_F_Qe_X_Mjabd_Cvy_Haav_NZTW_c1ba60b7f9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVERUNNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PVERUNNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

