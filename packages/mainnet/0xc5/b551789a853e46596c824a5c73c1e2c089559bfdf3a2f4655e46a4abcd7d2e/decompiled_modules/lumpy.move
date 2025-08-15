module 0xc5b551789a853e46596c824a5c73c1e2c089559bfdf3a2f4655e46a4abcd7d2e::lumpy {
    struct LUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMPY>(arg0, 6, b"LUMPY", b"Sui Lumpy", b"Welcome LUMPY is the community first meme coin Join us and help build a safer place in crypto Bring your own bananas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidl645sifuztntvrlvjebisixmvj54d4y7jcymgoeokv7r54dzhtu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUMPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

