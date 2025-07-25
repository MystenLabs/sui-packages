module 0xc9591201354a6c12ccac022d57c9fa6e2c53dee221d8078aa46293e988429a14::bobby {
    struct BOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBBY>(arg0, 6, b"BOBBY", b"Autism Bobby", b"Bobby isnt just any feline he is the living. purring parody of something way too serious. While others argue about charts and coins. Bobby naps on keyboards and accidentally buys snacks with someones credit card. Thats right.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiarlybmkbkdmbrhs73m44vdfxmbvpzwq2q7ii4uuxfbbsvi2wmuky")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOBBY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

