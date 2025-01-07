module 0x146851f81954858ce2c46e7af9057e24c5f02342732b2b234e40d39c986135b::medusa {
    struct MEDUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDUSA>(arg0, 6, b"MEDUSA", b"SUIMEDUSA", b"im like an echo of your feelings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_T_Bp_JSUA_6_Nt1yv_BCG_6vvz_Sz1_Eju3i1u5es_Jxm_MA_7_Cc_Ji_f9e8f7a9fa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEDUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

