module 0x2ed2d31528dfbb938e6617f3fdbf985799eda24ad02daad173d1e902ab511acd::melondog {
    struct MELONDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELONDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELONDOG>(arg0, 6, b"MELONDOG", b"Melon Dog", x"244d454c4f4e444f472e20497473206c69746572616c6c79206a757374206120646f6720776974682061206d656c6f6e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_DG_Jn_Yf_Jr_Yi_P5_CK_Bx6wpbu8_F5_Ya1swd_Foesu_Cr_AK_Cz_Zc_2934f76ff6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELONDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELONDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

