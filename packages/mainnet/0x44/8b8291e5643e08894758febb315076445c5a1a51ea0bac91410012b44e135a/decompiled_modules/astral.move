module 0x448b8291e5643e08894758febb315076445c5a1a51ea0bac91410012b44e135a::astral {
    struct ASTRAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTRAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTRAL>(arg0, 9, b"ASTRAL", b"Astral Sui", b"SuiAstral is a meme token representing the cosmic potential of the Sui ecosystem. It symbolizes exploration and stellar growth, inviting holders to venture into new crypto frontiers with limitless opportunities. Designed for those aiming to rise during the next super cycle, SuiAstral promises to shine bright in the digital space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1802968656521109504/PAIgYjPr.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASTRAL>(&mut v2, 330000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTRAL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTRAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

