module 0xcf89e125253d880662fea250b64615146db48f164b93f0b142160a4f5d3e6f5a::garyone {
    struct GARYONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARYONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARYONE>(arg0, 9, b"GARYONE", b"GaryOne", b"G01 testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://picsum.photos/200/300")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GARYONE>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARYONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

