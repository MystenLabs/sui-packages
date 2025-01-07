module 0x60ab894f9dfa8e4d54b42e46f4259afaa5cd95d7ce535b4797bcde732dcad164::aq {
    struct AQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQ>(arg0, 6, b"AQ", b"AQUASUI", b"AQ TOKEN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uatt3u5_Gmex_D56_Lpbbh_L44gdvn3qu_FV_Pqfud_Fo_C4g6_K5_be2c4cafd0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

