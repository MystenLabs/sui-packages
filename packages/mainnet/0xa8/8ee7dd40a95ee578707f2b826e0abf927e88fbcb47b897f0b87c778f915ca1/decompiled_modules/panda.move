module 0xa88ee7dd40a95ee578707f2b826e0abf927e88fbcb47b897f0b87c778f915ca1::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"PANDA", b"SUIRED  PANDA", b"SUI Red Panda is a fun and playful web-based project built on the Sui blockchain, featuring an adorable red panda theme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihro447a47a7imbz4w4otgthaeho75liwpplxif5rg42ks4ifoasy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PANDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

