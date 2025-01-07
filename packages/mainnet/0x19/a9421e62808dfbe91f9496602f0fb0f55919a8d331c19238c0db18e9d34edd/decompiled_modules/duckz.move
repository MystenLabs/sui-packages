module 0x19a9421e62808dfbe91f9496602f0fb0f55919a8d331c19238c0db18e9d34edd::duckz {
    struct DUCKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKZ>(arg0, 6, b"DUCKZ", b"SuiDuckz", b"It's Time #DuckzSeason #SuiduckzEggs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9585_38d4ddccbf_9a158d3065.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

