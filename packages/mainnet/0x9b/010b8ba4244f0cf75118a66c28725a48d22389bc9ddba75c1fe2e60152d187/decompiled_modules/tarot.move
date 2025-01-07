module 0x9b010b8ba4244f0cf75118a66c28725a48d22389bc9ddba75c1fe2e60152d187::tarot {
    struct TAROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAROT>(arg0, 6, b"Tarot", b"Tarot Memes", b"Tarot style memes made by Fabian in June before he made Weird Medieval Memes. https://x.com/fabianstelzer/status/1805245304712602089?s=46&t=velUG6gB5cCBgPsoPDURQg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_UEP_Jo_G_Kx3x_G1ipx_Sj_R_Ne_Un_Sp8xkyq9he_Tjb_WF_Xt_C24_FP_4ec400f783.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

