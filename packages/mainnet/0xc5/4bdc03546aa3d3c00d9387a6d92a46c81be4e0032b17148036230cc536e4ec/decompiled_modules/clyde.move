module 0xc54bdc03546aa3d3c00d9387a6d92a46c81be4e0032b17148036230cc536e4ec::clyde {
    struct CLYDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLYDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLYDE>(arg0, 6, b"CLYDE", b"Sui Clyde", b"CLYDE token is more than just a token; it's a movement. The core philosophy behind CLYDE token is to create a vibrant and safe community where holders can thrive. Unlike other projects that promise the world with overcomplicated roadmaps, CLYDE token's current focus is on building a strong foundation. This means encouraging holders to work for their own bags and actively participate in the community's growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250429_163742_1184c2f017.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLYDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLYDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

