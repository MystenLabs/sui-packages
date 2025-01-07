module 0x34aaa5d92da0454a135db39febd2c8ca9704bc7b2d11295edb29f0eab55de0cf::lore {
    struct LORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORE>(arg0, 6, b"LORE", b"AiLORE", b"Empowering your crypto journey with AI-driven insights, intelligent automation, and real-time market analysis to maximize your investments.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733496019573.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LORE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

