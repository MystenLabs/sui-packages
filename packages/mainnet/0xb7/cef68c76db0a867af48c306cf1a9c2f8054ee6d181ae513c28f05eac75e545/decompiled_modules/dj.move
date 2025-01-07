module 0xb7cef68c76db0a867af48c306cf1a9c2f8054ee6d181ae513c28f05eac75e545::dj {
    struct DJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJ>(arg0, 6, b"Dj", b"Dana x jones", b"Dana love's Jones ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241119_041937_a376679989.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

