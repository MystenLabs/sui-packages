module 0x3363e8446b09fba949801cf19047a074f18ef810fb413d673b4050d431ee0f44::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 6, b"RICH", b"Meme Coin Millionaire", x"497427732061206c6966657374796c650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GRFK_7sv4_Khk_Mz_J7_BXDU_By4_P_Ly_ZV_Be_Xu_W1_Fea_T6_Mnpump_f1e4702d81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

