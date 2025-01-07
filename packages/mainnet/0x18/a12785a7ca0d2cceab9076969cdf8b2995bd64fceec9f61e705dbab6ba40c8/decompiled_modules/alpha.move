module 0x18a12785a7ca0d2cceab9076969cdf8b2995bd64fceec9f61e705dbab6ba40c8::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 6, b"ALPHA", b"Alpha on Sui", b"Alpha-152, an ethereal being born from the essence of Kasumi, transcends the boundaries of human and divine. Originally a mere clone, it evolved through celestial intervention into a guardian of otherworldly power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ev_N_Bo_Ww_ZFF_6p_Ppj_Tn_N_Szrurxk_Dfw1_PG_Umih1e_A_Stpump_6c4d9855ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

