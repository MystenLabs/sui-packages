module 0x27c534d5890fa76bb0d10fb4074aa4ced6cb13b50cdc169570668f97fc7b6489::swif {
    struct SWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIF>(arg0, 6, b"SWIF", b"SylvesterWifHat", b"SWIF transcends the realm of mere meme coins. It is a power serving as a currency of cultural influence. With the introduction of a hat, Sylvester gave up chasing Tweety and now chases being rich in the DEFI world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_13_a_I_s_23_18_43_a36ee3137b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

