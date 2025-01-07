module 0xbc4e9689da075eb8d4ac497d69eafae311b0aab1cb95503410ae32cde5bed886::cdeng {
    struct CDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDENG>(arg0, 6, b"CDENG", b"Chinamoodeng", b"Who wins the Mini Hama faster?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CDENG_TDJQ_1_H_D8_JG_4_Opj_Gv_NW_cb597de1c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

