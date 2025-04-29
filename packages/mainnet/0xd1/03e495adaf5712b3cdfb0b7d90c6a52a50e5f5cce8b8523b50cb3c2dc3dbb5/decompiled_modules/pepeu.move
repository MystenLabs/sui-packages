module 0xd103e495adaf5712b3cdfb0b7d90c6a52a50e5f5cce8b8523b50cb3c2dc3dbb5::pepeu {
    struct PEPEU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEU>(arg0, 6, b"PEPEU", b"PEPE UNCHAINED", b"Pepe having drip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig5at4avxqdufoslvffzz6tew7tlq2sxnqxi5gtqvdmalbb34at5a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPEU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

