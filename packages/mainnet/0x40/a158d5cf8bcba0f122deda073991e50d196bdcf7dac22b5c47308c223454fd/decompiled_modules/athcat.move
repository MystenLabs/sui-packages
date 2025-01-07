module 0x40a158d5cf8bcba0f122deda073991e50d196bdcf7dac22b5c47308c223454fd::athcat {
    struct ATHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATHCAT>(arg0, 6, b"ATHCAT", b"SUI ATH CAT", b"$SUI better ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_12_12_050104_b81282b7e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

