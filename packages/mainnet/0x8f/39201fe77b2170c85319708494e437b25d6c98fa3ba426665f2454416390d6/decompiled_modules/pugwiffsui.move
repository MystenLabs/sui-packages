module 0x8f39201fe77b2170c85319708494e437b25d6c98fa3ba426665f2454416390d6::pugwiffsui {
    struct PUGWIFFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGWIFFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGWIFFSUI>(arg0, 6, b"PUGWIFFSUI", b"PUGWIFFSU", b"Resurging from the ashes of a premature rug, arose the pug that doesn't quit. His message is clear: he won't stand for scams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_020430904_47ca1039fa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGWIFFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGWIFFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

