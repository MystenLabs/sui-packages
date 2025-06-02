module 0x54b20c94cdf0dce121ee34258ab5041fdc50143a10c270700ddebc2160675c76::slug {
    struct SLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUG>(arg0, 6, b"SLUG", b"CosmoSlug", b"A Garden Slug with a Dream of Becoming and Astronaut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigebsonaswjrf6gazzwgwdm6eghcc3bsfon3kgtiv2aoq2utu4cfa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

