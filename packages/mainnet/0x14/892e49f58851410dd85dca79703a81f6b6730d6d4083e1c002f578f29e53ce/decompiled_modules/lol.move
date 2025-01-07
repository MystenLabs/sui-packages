module 0x14892e49f58851410dd85dca79703a81f6b6730d6d4083e1c002f578f29e53ce::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 6, b"LOL", b"Lololi", b"$LOL - Born on January 16, 2024 at Taronga Zoo in Sydney, Australia, Lololi's name means \"There is always love.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V_Nss_K_Ddue_Rse_Sugu6_HS_Lef_He2oz_Poj_Pg_Nqw_B8_N_Paw_LBF_65c123a624.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

