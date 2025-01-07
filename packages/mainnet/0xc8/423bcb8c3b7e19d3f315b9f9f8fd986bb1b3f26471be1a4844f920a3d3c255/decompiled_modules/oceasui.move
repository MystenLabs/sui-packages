module 0xc8423bcb8c3b7e19d3f315b9f9f8fd986bb1b3f26471be1a4844f920a3d3c255::oceasui {
    struct OCEASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEASUI>(arg0, 6, b"OCEASUI", b"Oceasui the Titan", b"Oceasui, the titan god of the ocean who symbolizes the boundless power and potential of the Sui network. Join our Telegram!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_6_2_a11eef2397.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCEASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

