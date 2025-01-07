module 0x35c35f12a474f12031e4b6f32b5be88a87e64a3cf4dfd027d3402b370fcd24b7::waterbear {
    struct WATERBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERBEAR>(arg0, 6, b"WATERBEAR", b"Sui Waterbear", b"meet waterbear- a microscopic chonky gummy space tank that literally cannot be killed. extreme temperatures? don't care. 6000 atmospheres of pressure? don't care. no water for 30 years? don't care. bitcoin crashes? hope not but don't care. live tiny, die never.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_P_Ss_X8_SZAQ_Lm3_Qa_Mq_Qkf_WDKFPF_1z_K_Yt_V2_H8xq7t_Apump_65932bcdc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

