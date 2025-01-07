module 0x56581a62b6cddca742e31a9b4c2844221c7d8d19ad8d460b4e1847fc01c4eb68::rofl {
    struct ROFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROFL>(arg0, 6, b"ROFL", b"ROFL THE CAT", b"Rofl the orange cat, he likes to drink pee. Join the cult.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmekv_Rf_BES_Zp9b_SQ_Vy_Fb_Fyues_D4_P65nc_R_Qbz8_UQ_2_T_Gsq_J5_251b409517.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

