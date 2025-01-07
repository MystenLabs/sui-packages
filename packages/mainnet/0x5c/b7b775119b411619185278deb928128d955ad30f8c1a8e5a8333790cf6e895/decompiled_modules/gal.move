module 0x5cb7b775119b411619185278deb928128d955ad30f8c1a8e5a8333790cf6e895::gal {
    struct GAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAL>(arg0, 6, b"GAL", b"Galaxy Origins", b"Explore the power of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_9398_e7974ff92e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

