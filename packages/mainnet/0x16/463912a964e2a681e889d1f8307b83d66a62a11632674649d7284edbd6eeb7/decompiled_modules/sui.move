module 0x16463912a964e2a681e889d1f8307b83d66a62a11632674649d7284edbd6eeb7::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"Sui", x"e59ca8e4babae7949f", x"737569e7bfbbe8af91e698afe59ca820202020e68980e4bba5e58fabe59ca8e4babae7949f202020e5a5bde5908de5ad97202020e5a4a7e5aeb6e983bde59ca8e4babae7949f202020e6a0bce5b180e8b5b7e69da5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaemlqrbr6xpjisv23sxekcrpxayr42obmnllxqw3onmadv3ba4su")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

