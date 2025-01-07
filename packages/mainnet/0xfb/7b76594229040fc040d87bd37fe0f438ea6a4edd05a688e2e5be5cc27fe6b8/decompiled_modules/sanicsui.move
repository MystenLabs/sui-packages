module 0xfb7b76594229040fc040d87bd37fe0f438ea6a4edd05a688e2e5be5cc27fe6b8::sanicsui {
    struct SANICSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANICSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANICSUI>(arg0, 6, b"SANICSUI", b"Sanic Sui", b"Sanic can run up to 12 times the speed of light, and can travel up to 8,047,399,548 mph in his base form which is 10 million times as fast compared to Sonic as he can only run up to 760 mph. Run to buy $SANICSUI FIRST!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gif_perfil_2_1d46975509.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANICSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANICSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

