module 0x8af4cb8920161714d1540b07c8cef65b3ecc0dfb3004aaea97785bf5b99b75d5::droopy {
    struct DROOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROOPY>(arg0, 6, b"Droopy", b"Droopy On Sui", b"Droopy is the wildest meme coin that's ever swung through the Sui blockdag!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiemzvnqex4nhvtmuupppupwkqo5nmt34ptrjpvqoxs43n33qz3sdm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DROOPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

