module 0xadd4f82a1a04bf71ab0bf4f5fb69734c3c5247d20f523f32fe481647390ebd59::skanji {
    struct SKANJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKANJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKANJI>(arg0, 6, b"SKANJI", b"SUIKANJI", x"507269636520676f2075702c20707269636520676f20646f776e2c20627574206f6e65207468696e672072656d61696e73207468652073616d652e2049274d204e4f54204655434b494e47204c454156494e472c204c4f434b20494e20244b414e4a490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_67_a5b69c1af9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKANJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKANJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

