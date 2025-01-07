module 0x1d6e50665937e567b7fd6fab58ae2c0741907ab9ddcf90b06db1a00e7de67856::whiskers {
    struct WHISKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHISKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHISKERS>(arg0, 6, b"WHISKERS", b"WHISKERS THE CAT", b"Whiskers on Sui is a playful and community-driven meme coin built on the Sui blockchain. Inspired by the adorable antics of feline friends, this token aims to bring a touch of fun and humor to the world of cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4542_dac629c806.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHISKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHISKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

