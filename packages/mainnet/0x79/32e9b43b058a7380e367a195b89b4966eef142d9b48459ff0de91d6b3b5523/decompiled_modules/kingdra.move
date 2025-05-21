module 0x7932e9b43b058a7380e367a195b89b4966eef142d9b48459ff0de91d6b3b5523::kingdra {
    struct KINGDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGDRA>(arg0, 6, b"Kingdra", b"Kingdra On Sui", b"Kingdra : Journey To The King Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicjkzwcyonjet2w7sfg4u2fntnrwlm6c6ltlgfljeyqz5kvgzka4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KINGDRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

