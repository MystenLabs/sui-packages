module 0x6c2cb6ff236a1c04625f95c0b8478a5c6ba1633bccf2806e842fb8aeb23eed83::skurturtle {
    struct SKURTURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKURTURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKURTURTLE>(arg0, 6, b"SKURTURTLE", b"SKURTSUI", b"SKRRR THE BEST TURTLE SKATIST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_025341645_4677eee374.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKURTURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKURTURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

