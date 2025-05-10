module 0x2b2431c5d187d0d4a2ca88e290ab69226f62adfcfa791deb810ec117ef693c05::iggy {
    struct IGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGGY>(arg0, 6, b"IGGY", b"Iggy Sui", b"Lazy iguana was born in sui ecosystem as meme mascot with community fans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidxg3zrrmtsqggxmkjudvsgob2stanbu46ehvkspppnz4ntwlf23a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

