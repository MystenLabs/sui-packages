module 0xc97e7a5909b19c2e11673aefd9b2642dcbebb764ed840c048271167a6ac792ed::fhop {
    struct FHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHOP>(arg0, 6, b"FHOP", b"FUK HOP", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2024_11_02_223920_c27903154d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

