module 0x6fab4415c333b62678fb47332f7271d827e536caf4ecd86d979f3b12ac4feb48::shinchan {
    struct SHINCHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINCHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINCHAN>(arg0, 6, b"SHINCHAN", b"Shin Chan", b"Shin-Chan pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w7.pngwing.com/pngs/768/766/png-transparent-shin-chan-illustration-crayon-shin-chan-drawing-shinnosuke-nohara-desktop-kasukabe-shinchan-love-child-hand-thumbnail.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHINCHAN>(&mut v2, 3000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINCHAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHINCHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

