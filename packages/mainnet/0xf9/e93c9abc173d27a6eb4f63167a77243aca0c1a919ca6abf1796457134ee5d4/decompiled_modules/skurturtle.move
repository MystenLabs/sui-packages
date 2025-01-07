module 0xf9e93c9abc173d27a6eb4f63167a77243aca0c1a919ca6abf1796457134ee5d4::skurturtle {
    struct SKURTURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKURTURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKURTURTLE>(arg0, 6, b"SKURTURTLE", b"SKURTUR SUI", b"A cute and badass turtle shredding its way through SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_025503345_7290453ee8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKURTURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKURTURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

