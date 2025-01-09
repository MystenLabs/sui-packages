module 0x7fef196a9b030f436c4cfef249f72a0e64f0746908ea2c47e90a8cbe6e7d4f6d::nekron {
    struct NEKRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKRON>(arg0, 6, b"Nekron", b"Sui Nekron", b"Nekron is a sleek and futuristic AI agent designed with feline-inspired traits, embodying agility, intelligence, and advanced technology. With its streamlined metallic features, glowing eyes, and cat-like ears, Nekron bridges the gap between organic grace and digital precision. Engineered for adaptability and efficiency, Nekron is a symbol of innovation in the realm of AI, seamlessly blending form and function in a cutting-edge, minimalist design.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c919471c_9518_4780_a06a_c160434b142c_2d76971919.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

