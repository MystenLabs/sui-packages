module 0x11406116e9a99004924ea493ef8b677c4c5e2374f83f62ebfda4adc7dedfdac5::fate {
    struct FATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATE>(arg0, 6, b"Fate", b"Flow State", b"just go with the flow bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_D_Ppwn_Ao3nj_D8u72qfa_Jpuurf_F3_Hf5_Gb9_AQ_3_Qq6_V4bks_87a49a45c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

