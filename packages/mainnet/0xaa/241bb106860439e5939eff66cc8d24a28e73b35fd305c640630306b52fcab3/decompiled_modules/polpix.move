module 0xaa241bb106860439e5939eff66cc8d24a28e73b35fd305c640630306b52fcab3::polpix {
    struct POLPIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLPIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLPIX>(arg0, 6, b"POLPIX", b"Polar Pixel", x"4265737420506f6c6172204265617220506978656c20436f6d6d756e697479206f6e205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc4_ZQV_4y8_Yev_S_Drv_JB_734dmf_Bb6te_Z_Xhg_Mb_Eu_P3_CLA_St5_6dfa98472c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLPIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLPIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

