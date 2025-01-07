module 0xe0d2596fe8a793b8e01ac2eea0a57eb5ea5812a7a01e1d2d9a79192d0cced4f4::migglui {
    struct MIGGLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGGLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGGLUI>(arg0, 6, b"MIGGLUI", b"MIGGLES", b"Introducing Miggles!! Cryptos favourite mischievous kitty has clawed its way from Base chain to Sui! Miggles isnt just a coin, its a chain-hopping meme cat on a mission to spread laughs and a little chaos. Ready to join the litter?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/miggles_sui_full_image_404ae98600_f91a445c28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGGLUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIGGLUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

