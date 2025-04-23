module 0x91e9859bde77784a0d7510035cc27d3224d9ee5ebd974b53ca41872425afda83::schonko {
    struct SCHONKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHONKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHONKO>(arg0, 6, b"SCHONKO", b"Sui Chonko Dile", b"Big belly, bigger gains! The chonkiest gator on SUI too heavy to dump, too lazy to rug! No roadmap, just vibes and moonshots!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiesyw4fqwfk7b5o6graloag7h22tqfjbrqmtvzhq7z6rvgdlyvm3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHONKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCHONKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

