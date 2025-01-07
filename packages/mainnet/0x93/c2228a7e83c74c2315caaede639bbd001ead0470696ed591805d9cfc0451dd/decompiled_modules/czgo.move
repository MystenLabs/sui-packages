module 0x93c2228a7e83c74c2315caaede639bbd001ead0470696ed591805d9cfc0451dd::czgo {
    struct CZGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZGO>(arg0, 6, b"CzGo", b"Cz Go Free", b"IF YOU CAN'T HOLD, YOU WON'T BE RICH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma6_ZA_Ne5_ZDYD_Ri2_Z_Be_Har_NCJ_24_Hvp_QA_1_J_Eoj_Zy2j6_K_Qtg_d7d21e23fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

