module 0x9a14ffc53571872883571a60ffa1bdd059522c9e4d6b840cd3cc68bee322e057::suing {
    struct SUING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUING>(arg0, 6, b"Suing", b"Sue - Drake s lawsuit", b"Official Drake loss meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidb5embpzpqhihd2pjxamwreirdel7m3oonr362iefsgtaemacaay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

