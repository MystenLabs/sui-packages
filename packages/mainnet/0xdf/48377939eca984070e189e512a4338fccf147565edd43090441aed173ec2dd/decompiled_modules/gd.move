module 0xdf48377939eca984070e189e512a4338fccf147565edd43090441aed173ec2dd::gd {
    struct GD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GD>(arg0, 6, b"GD", b"Golden Dolphin", b"Naya Legend of the Golden Dolphin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o4_AAA_Jf_Q_Cvk_Ib_C3_AP_Dn_FQEQRD_0_W9_Di8g_Axc_Af_M_tplv_dy_aweme_images_q75_ab06575855.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GD>>(v1);
    }

    // decompiled from Move bytecode v6
}

