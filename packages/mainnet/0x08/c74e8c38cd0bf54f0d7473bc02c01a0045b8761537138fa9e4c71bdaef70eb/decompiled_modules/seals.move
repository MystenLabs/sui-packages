module 0x8c74e8c38cd0bf54f0d7473bc02c01a0045b8761537138fa9e4c71bdaef70eb::seals {
    struct SEALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALS>(arg0, 6, b"Seals", b"Natural Born Chillers", b"Seals - Ready to Crack Pengus Ice!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BK_Qwz_Urcibz_Zsm1_Sm9_T_Vgzx_A9_G7b_A_Ysz_Ca_G_Jc_AL_Mpump_3a9f9e71b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

