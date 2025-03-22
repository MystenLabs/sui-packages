module 0xdfb010a7e5de6764f0901975ae0cafeff050ddbfb3b24eb8f73413f24fd7f939::bytura {
    struct BYTURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYTURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYTURA>(arg0, 9, b"BYTURA", b"Bytura", x"4279747572612064656c69766572732041492d706f77657265642070726f74656374696f6e20746f206b6565702065766572792062797465206f6620796f7572206469676974616c206c69666520736166652066726f6d2065766f6c76696e6720637962657220746872656174732e0d0a0d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVKfsL5oojzKjTiYaL95HJQveEfLZsbMfFkjawaJtQ9qk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BYTURA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYTURA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYTURA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

