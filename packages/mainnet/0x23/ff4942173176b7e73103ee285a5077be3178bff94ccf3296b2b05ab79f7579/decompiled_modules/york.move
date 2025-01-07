module 0x23ff4942173176b7e73103ee285a5077be3178bff94ccf3296b2b05ab79f7579::york {
    struct YORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: YORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YORK>(arg0, 6, b"YORK", b"Satoshi's First Mascot", x"72656164207468652070726f6f6620686572652066726f6d2068697320666f75726d20706f73742e2020200a2068747470733a2f2f782e636f6d2f796f726b736f6c616d692f7374617475732f313739333537383439313632313133343434392f70686f746f2f310a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Quewf_Asg_Fg8_Y_Sx_A4_Aaa_Qh_Ua_K_Fzee_Fj_Kjsz_XGUL_Hiefxy_e6b7c7528b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

