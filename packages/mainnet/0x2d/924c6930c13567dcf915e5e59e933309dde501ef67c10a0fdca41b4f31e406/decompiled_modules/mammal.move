module 0x2d924c6930c13567dcf915e5e59e933309dde501ef67c10a0fdca41b4f31e406::mammal {
    struct MAMMAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMMAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMMAL>(arg0, 6, b"Mammal", b"The Most Savage Mammal", b"The Most Savage Mammal  a pure meme force born in the depths of the Sui chain. No utility, no roadmap, no fake promises  just raw meme energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiabhomuajzldwbe5fjvw5z6vxsugmwih26guzjj56zwzetigff6ay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMMAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAMMAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

