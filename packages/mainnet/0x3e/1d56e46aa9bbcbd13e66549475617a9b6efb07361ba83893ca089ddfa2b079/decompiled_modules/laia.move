module 0x3e1d56e46aa9bbcbd13e66549475617a9b6efb07361ba83893ca089ddfa2b079::laia {
    struct LAIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAIA>(arg0, 6, b"LAIA", b"Lux Agente IA", b"Lux is an innovative artificial intelligence agent designed to transform and evolve the Sui ecosystem. With advanced learning and adaptation capabilities, Lux facilitates the integration of emerging technologies, promoting continuous efficiency and innovation. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2024_11_01_035200_e923130b20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

