module 0x565380d3863765cc3c6149f3f00050e4b11fe2158afb1ede6ce1b0bd7fd482d3::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"Goat", b"CryptoGoat", b"CryptoGoat: The legendary time-traveling, GOAT of crypto culture. From inspiring Julius Caesar to battling Goatzilla and dominating blockchain lore, CryptoGoat leads a herd of rebels, creators, and visionaries. With unstoppable energy, epic adventures, and a dash of chaos, CryptoGoat is here to climb every mountainreal or digitaland take you to the moon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9566_5866116db2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

