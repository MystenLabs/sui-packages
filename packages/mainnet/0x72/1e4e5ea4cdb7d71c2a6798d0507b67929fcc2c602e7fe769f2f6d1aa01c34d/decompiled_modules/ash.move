module 0x721e4e5ea4cdb7d71c2a6798d0507b67929fcc2c602e7fe769f2f6d1aa01c34d::ash {
    struct ASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASH>(arg0, 6, b"ASH", b"ASSHOLE", b"ASS HOLE RISE!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_925e0a4275.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

