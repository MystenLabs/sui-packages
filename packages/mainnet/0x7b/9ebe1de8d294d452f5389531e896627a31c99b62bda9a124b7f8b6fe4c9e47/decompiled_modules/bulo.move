module 0x7b9ebe1de8d294d452f5389531e896627a31c99b62bda9a124b7f8b6fe4c9e47::bulo {
    struct BULO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULO>(arg0, 6, b"BULO", b"Bulo The Octopus", b"The most transparent community memecoin on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifhqwswuq5ygnrldhlw2xcukldaz3anzw77rjbw45hdjjhtbne7gi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

