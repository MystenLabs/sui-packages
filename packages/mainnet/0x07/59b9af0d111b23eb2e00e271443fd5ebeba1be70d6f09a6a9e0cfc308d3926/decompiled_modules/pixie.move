module 0x759b9af0d111b23eb2e00e271443fd5ebeba1be70d6f09a6a9e0cfc308d3926::pixie {
    struct PIXIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PIXIE>(arg0, 6, b"PIXIE", b"PixieAI by SuiAI", b"Unleash the full potential of your creativity with PixieAI. Our powerful AI generator transforms your ideas into unique, high-quality visuals effortlessly. Create, customize, and download your artwork in just a few clicks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2134_dbe200ecb3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIXIE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXIE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

