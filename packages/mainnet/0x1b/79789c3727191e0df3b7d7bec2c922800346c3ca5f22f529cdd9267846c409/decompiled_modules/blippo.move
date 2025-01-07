module 0x1b79789c3727191e0df3b7d7bec2c922800346c3ca5f22f529cdd9267846c409::blippo {
    struct BLIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLIPPO>(arg0, 6, b"BLIPPO", b"BLIPPO ON SUI", b"BRETTS'DOG BLIPPO ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_29_2fbd1747d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

