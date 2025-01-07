module 0xba3cbe341eb593eaa26c7ab1e93966817d832a9fe8d242ff5cbe70386fe68ffc::sinbred {
    struct SINBRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINBRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINBRED>(arg0, 6, b"SINBRED", b"INBRED CAT", x"536f20696620796f7572652067616d652c20626574746572206275636b6c65207570206361757365207468697320646f67732061626f757420746f206472616720686973206269672062616c6c7320616c6c206f766572205355492e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_46_07aeba2e4a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINBRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINBRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

