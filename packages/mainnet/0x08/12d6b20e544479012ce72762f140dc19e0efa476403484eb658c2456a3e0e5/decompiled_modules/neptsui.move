module 0x812d6b20e544479012ce72762f140dc19e0efa476403484eb658c2456a3e0e5::neptsui {
    struct NEPTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTSUI>(arg0, 6, b"NEPTSUI", b"NEPTUNE", b"Building tools that makes trading and Interactions on Sui easier| Utility driven Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifsznm6yuixiomlqjgypqwqc273vl5a5j5dsjmmfw46cbjicq6uxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEPTSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

