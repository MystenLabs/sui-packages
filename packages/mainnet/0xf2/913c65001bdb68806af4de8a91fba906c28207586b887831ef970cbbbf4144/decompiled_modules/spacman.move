module 0xf2913c65001bdb68806af4de8a91fba906c28207586b887831ef970cbbbf4144::spacman {
    struct SPACMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACMAN>(arg0, 6, b"SPacman", b"Sui Pacman", b"Pacman is an Sui Blockchain based meme token, just enjoy it and happy trading.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pac_man_image_7d74119e0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

