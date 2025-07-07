module 0x8e5e83b24158a038eb92e5919ea8f6f95e90a25b82fd96925692af1d0e7b64c6::marble {
    struct MARBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARBLE>(arg0, 6, b"MARBLE", b"Marble Saga", b"Marble Saga is a meme token designed to capture the spirit of nostalgia, community, and internet culture. Inspired by the classic game of marbles, it blends playful themes with the decentralized nature of blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig3zcau4cn5hkxqddtmtxmyofcfjj3k4a3srbu735vu5tvn5ed344")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MARBLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

