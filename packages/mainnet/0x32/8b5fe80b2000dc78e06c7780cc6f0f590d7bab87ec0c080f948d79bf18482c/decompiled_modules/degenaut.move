module 0x328b5fe80b2000dc78e06c7780cc6f0f590d7bab87ec0c080f948d79bf18482c::degenaut {
    struct DEGENAUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGENAUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGENAUT>(arg0, 6, b"DEGENAUT", b"Degenaut", b"Degenauts here to turn the Sui trenches into chaos. AI goes brrrr, printing memes while you sleep, and influencers scramble to explain what the hell we do. The charts are violent, the bags are heavy. Welcome to Degenaut. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/degenaut_logo_7403d928b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGENAUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGENAUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

