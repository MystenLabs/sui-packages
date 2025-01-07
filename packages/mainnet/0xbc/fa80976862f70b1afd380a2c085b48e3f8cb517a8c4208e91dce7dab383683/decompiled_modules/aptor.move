module 0xbcfa80976862f70b1afd380a2c085b48e3f8cb517a8c4208e91dce7dab383683::aptor {
    struct APTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: APTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APTOR>(arg0, 6, b"APTOR", b"APTOSAURE", b"$APTOR the pixel dino, ready to jump on the sui chain !  Official sui mascot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Zdss_Ehdx_Su_Wf_KKY_Mrp_Pu3hq8_P3_R_Soi7_PS_8n6x_Nb7cps_facb2ff8bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

