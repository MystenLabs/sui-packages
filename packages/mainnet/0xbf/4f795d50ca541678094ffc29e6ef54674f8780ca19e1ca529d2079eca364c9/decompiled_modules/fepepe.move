module 0xbf4f795d50ca541678094ffc29e6ef54674f8780ca19e1ca529d2079eca364c9::fepepe {
    struct FEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEPEPE>(arg0, 6, b"FEPEPE", b"Fetus Pepe", b"Im just a fetus Pepe waiting to be born ^_^ Feel me kicking in mommies belly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Yc_Pe_FBN_Rh_Q65_Yn_Y_Pz_Cmh66b_N_Nh4pja1_Sm_BTVK_7_Cfj6_S_5d243a86ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

