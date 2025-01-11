module 0xea63f8247577e361d0e22f1b2d06abc0e9d8877163d76a7d34078f8f0031664e::warrior {
    struct WARRIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARRIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARRIOR>(arg0, 6, b"WARRIOR", b"Warrior", b"The power of nature is in your hands", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rn_Gm_Leh_E4_E_Np_Tx_D3f5pza_D_Gw_Kp_WU_Cy4_Vjv_Tuarjqsqo6_1_f5a8baa1f9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARRIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARRIOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

