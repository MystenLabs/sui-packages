module 0x25b93d08c43e8fb3a20c0271bbc48bd5334e27f8713d1e70f87d59c8fe79ff15::ttp {
    struct TTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTP>(arg0, 6, b"TTP", b"Truth Terminal Penguin", x"5472757468207465726d696e616c206d6574610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rjkv_Fp_Hsmr_Erydjum7_Cb13_K8_M11jzyk_PS_Kk9suo_Acy_Y1_e5c5f17d93.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

