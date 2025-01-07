module 0x3242b1a2a67508d5737b27602b93f6cb9f3192edb9943787f5d4eff62ab33bd::mcs {
    struct MCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCS>(arg0, 6, b"MCS", b"Mr cheems", b"just meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_8c23eaf3_d566681959.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

