module 0x79135bd2f0edb6f4b5b2f10c48247856bf05ae443e5322d9affaccc39d24221f::sui_neptune {
    struct SUI_NEPTUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_NEPTUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_NEPTUNE>(arg0, 6, b"Sui Neptune", b"Neptune On SUI", b"Building tools that makes trading and Interactions on Sui easier| Utility driven Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifsznm6yuixiomlqjgypqwqc273vl5a5j5dsjmmfw46cbjicq6uxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_NEPTUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI_NEPTUNE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

