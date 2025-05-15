module 0xb10bc22d5f542b1d5f488556599b44cd301b323621853eeda3aa9faec4af206b::bait {
    struct BAIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAIT>(arg0, 6, b"Bait", b"Shark", b"Welcome to Shark ($BAIT), a community-driven meme coin built on the high-performance Sui blockchain, designed to empower its community to take the lead and make waves in the Web3 space! Shark ($BAIT) combines the fun, viral energy of meme coins with the speed, scalability, and low-cost transactions of Sui, creating an exciting opportunity for holders, creators, and enthusiasts to shape its future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih44uomusicukhlkqwzoviseg4cfsfmuvfl5jd6utfpheqvfvvun4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

