module 0xffde891d31f83f4657dc1cc7b3a0c274b1834070f7ea42efa0e433e866c9ef0b::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 6, b"GG", b"Geekfrog By Matt Furie On Sui", b"Geekfrog Greenhood ($GG) is a unique digital collectible and one of the 1,000 Hedz hand-drawn by the renowned artist Matt Furie in 2022 on planet Earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ut4_Ykg_Ibd_GZ_50_O7ks_M_Jf_QMA_Gck_2_f89c56e7dd.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}

