module 0x20c20f8f910cffdb00c65546ddfe8e47d941ceb2e9d83213ddd5851f69797ab7::suitable {
    struct SUITABLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITABLE>(arg0, 6, b"SUITABLE", b"TABLE SUI", b"Carpentarrer built the most suitable Table on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_030145068_516425a01f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITABLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITABLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

