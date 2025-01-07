module 0x9429de3980e01754ba212baa5ea0a412e941c4c4a6d23ebdece34a3972116683::suicro {
    struct SUICRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICRO>(arg0, 6, b"SUICRO", b"SUICRODILE", b"be cro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_EBSA_Dtn_JN_Xiwr_Bsv_J1_Lm5_HS_Yf2yh_Xz8_VRD_Xfruz_Rqhu_8f9d008d30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

