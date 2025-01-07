module 0x397c19e9fea2a576291c39dfcb68f683b2e07c8ca68a1fc750133c058b54bfb3::popo {
    struct POPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPO>(arg0, 6, b"POPO", b"Pepes Dog", x"4a6f696e20504f504f206f6e2068697320616476656e7475726573207468726f7567686f75742073756920636861696e2e20506570657320646f6720686173206265656e206c6574206c6f6f73652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbh1_Pq4_N_Mdp_WJ_5xt_Thc_Bgpupu_Exoa9xv_G_Sty_Abw_Trfj_MM_3f27ffa736.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

