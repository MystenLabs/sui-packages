module 0xb5c40e9e6a186af0ac66ab12585c4779c2369de6ca524d6dd0328502e5a3f123::remus {
    struct REMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<REMUS>(arg0, 6, b"Remus", b"Remus Gargoyle", x"4c656e2053617373616d616e20446f672e0a52656d757320476172676f796c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_KW_2d_YG_Rdx_Fae_MWV_Kh1_S_Tey_Gn_G8_Ky_R_Eb_K66_J6_RK_Mpump_6516effc42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<REMUS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMUS>>(v2);
    }

    // decompiled from Move bytecode v6
}

