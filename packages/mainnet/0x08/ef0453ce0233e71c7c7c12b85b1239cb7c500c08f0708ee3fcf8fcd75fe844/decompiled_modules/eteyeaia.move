module 0x8ef0453ce0233e71c7c7c12b85b1239cb7c500c08f0708ee3fcf8fcd75fe844::eteyeaia {
    struct ETEYEAIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETEYEAIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETEYEAIA>(arg0, 6, b"EtEyeAIA", b"EtherealEye", b"EtherealEy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ufr_HN_Lqia7_Nmqgbz_HYGF_4rt_X75n_Ewuk_PFFU_1_Ysc_K_Kqu_L_564f999178.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETEYEAIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETEYEAIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

