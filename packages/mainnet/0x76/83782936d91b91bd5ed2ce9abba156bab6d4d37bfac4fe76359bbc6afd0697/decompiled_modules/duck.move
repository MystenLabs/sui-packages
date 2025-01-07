module 0x7683782936d91b91bd5ed2ce9abba156bab6d4d37bfac4fe76359bbc6afd0697::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK", b"Lemonade Stand Duck", x"4a7573742061206475636b206c6f6f6b696e6720666f7220736f6d65206772617065730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2ru7_VX_6_Nna_Z78zn_Ctg_Gm_Ys2_Pdc_AQR_Cr3_Ua_Pf_Rk_D_Upump_b7b0e2ca69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

