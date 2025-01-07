module 0xa695552c39d6a4d89c0999b5dd74d268ad0b45242acee44ff7d72078e277688d::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 6, b"FUD", b"Frog Uncovers Diamonds", b"fud all today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_A3hcg_Bgkixfx_R1_T_Hxq_Mc_P29s_F_Bm_Jy_Wngi_Dd4e_QGJ_Mss_50eb735bfb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

