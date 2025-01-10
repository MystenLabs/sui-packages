module 0xeeb81d2381b15b176ad172b026fcd2ee4e6be0ca349187a7b6db1f28e1fbdd4a::ai300 {
    struct AI300 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI300, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI300>(arg0, 6, b"AI300", b"AI 300", b"AI300 stands as the cornerstone of the Global Financial Ecosystem, harnessing the power of quantum-driven AI oracles to deliver guaranteed profitability across", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meme_Pepe_banner_with_dimensions_1200x600_in_colorful_ASCII_art_style_46b534232e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI300>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI300>>(v1);
    }

    // decompiled from Move bytecode v6
}

