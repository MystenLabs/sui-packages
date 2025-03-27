module 0x327bf4e438bb771cb6bce7bdda7cf96b1e0c35ece5bec46a4a49b2a649d96743::cliza {
    struct CLIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLIZA>(arg0, 6, b"CLIZA", b"CLIZA AI", b"CLIZA.ai and its X agent launch memecoins that support various content, projects, creators, communities, or causes. These tokens have no intrinsic value and are not investments. They may be created by anyone, including impersonators, and can experience extreme volatility or complete loss of value. Users must conduct their own research (DYOR) on token and content provenance, affiliated user accounts and underlying details before participating. Only use funds you're comfortable losing. Token descriptions by users do not reflect our views and should not be considered endorsement, tax, or financial advice. Our LLM technology is non-deterministic and may contain errors. Features are experimental and may not work as expected. \"Tokens\" and \"coins\" are used interchangeably.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_03_27_23_20_28_9e0c1e8531.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLIZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLIZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

