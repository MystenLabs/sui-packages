module 0x8b056d47d0987c6a78b5b15fb287bd0c4ff331719101c52c1187a3208e96c6d1::sse {
    struct SSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSE>(arg0, 6, b"SSE", b"SuiSeason", b"SuiSEAson", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0044_d97bfa93e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

