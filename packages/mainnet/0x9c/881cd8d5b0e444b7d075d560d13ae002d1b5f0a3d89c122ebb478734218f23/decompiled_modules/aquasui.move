module 0x9c881cd8d5b0e444b7d075d560d13ae002d1b5f0a3d89c122ebb478734218f23::aquasui {
    struct AQUASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUASUI>(arg0, 6, b"AquaSUI", b"Aquatic Sui", b"No promises, no tokenomics, no utilities, just opportunities to grow together in the dynamic crypto ecosystem. Join us in creating new momentum in the world of memecoins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibd2vsc7tym2ahmw57gcjkco6ijzbpwsfssq4kxjfb573mu5rk4z4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUASUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

