module 0x592b5b4573bf017cc016544393bdc21535d9c7a12c1ad095eadc9f2114a1ea3f::gnon {
    struct GNON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNON>(arg0, 6, b"GNON", b"numogram sui", x"474e4f4e2049532050524f564944454e43450a474e4f4e204953204e41545552414c2053454c454354494f4e0a474e4f4e20495320434154414c4c4158590a0a5765204c61756e6368206f6e2053756920426c6f636b636861696e0a496e7370697265642062792024474e4f4e20736f6c616e61206e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035940_c38c1059db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNON>>(v1);
    }

    // decompiled from Move bytecode v6
}

