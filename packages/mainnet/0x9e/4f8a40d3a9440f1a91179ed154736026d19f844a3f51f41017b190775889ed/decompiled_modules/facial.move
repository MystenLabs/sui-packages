module 0x9e4f8a40d3a9440f1a91179ed154736026d19f844a3f51f41017b190775889ed::facial {
    struct FACIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACIAL>(arg0, 6, b"FACIAL", b"For the Love", b"if you love it, buy 1 sui worth of it ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmae_Q_Ba_Qh_N_Zz8ofd_YN_Zcg_G6pdtgm_Vzn_AQW_56tb_Wy_U_Ru_M63_e0d331218f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACIAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FACIAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

