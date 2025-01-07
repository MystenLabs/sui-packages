module 0xf4fe73e2b170bad35f9e42b1f8f667869f6976ce4f656ea95e8f38068fa4d318::suwa {
    struct SUWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWA>(arg0, 6, b"SUWA", b"SUI WHALE", b"SUWA Sui Whale is the cutest meme token in the ocean! Inspired by an adorable whale, this token brings fun and cuteness to the world of crypto. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suwa_200928830f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

