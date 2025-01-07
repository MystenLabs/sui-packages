module 0xdd1079e3b2abb2472fd12788cfb96abb9db4b320735ff3810127d1ccd1c25827::nobi {
    struct NOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBI>(arg0, 6, b"NOBI", b"NOBI ON SUI", b"The original cat-themed meme coin on the Sui blockchain! As the first of its kind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_79_f13de0a5fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

