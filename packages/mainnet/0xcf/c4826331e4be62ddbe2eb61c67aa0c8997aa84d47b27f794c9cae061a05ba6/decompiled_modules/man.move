module 0xcfc4826331e4be62ddbe2eb61c67aa0c8997aa84d47b27f794c9cae061a05ba6::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 6, b"MAN", b"Pacman", b"Sui Blue Pac-Man, next meme generation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7823_44b606c167.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

