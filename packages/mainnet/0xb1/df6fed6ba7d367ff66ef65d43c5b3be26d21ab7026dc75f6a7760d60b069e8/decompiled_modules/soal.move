module 0xb1df6fed6ba7d367ff66ef65d43c5b3be26d21ab7026dc75f6a7760d60b069e8::soal {
    struct SOAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAL>(arg0, 6, b"SOAL", b"SuiSeal", b"look at this dude", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_09_15_021138_e2a184dd52.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

