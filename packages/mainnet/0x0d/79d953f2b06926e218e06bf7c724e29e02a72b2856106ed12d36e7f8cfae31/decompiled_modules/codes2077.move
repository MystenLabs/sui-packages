module 0xd79d953f2b06926e218e06bf7c724e29e02a72b2856106ed12d36e7f8cfae31::codes2077 {
    struct CODES2077 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODES2077, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODES2077>(arg0, 6, b"CODES2077", b"CODES 2077", b"40 years after the apocalypse, a lone stranger seeks the secret science of programming in a post apocalyptic wasteland. What will he find?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nq_Wypbj_Z_Jmpj1_B27_M_Zh2_De3_B_Kot_P9c_E4_S8a_T_Uip_Tn8fb_e81eaf91fc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODES2077>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODES2077>>(v1);
    }

    // decompiled from Move bytecode v6
}

