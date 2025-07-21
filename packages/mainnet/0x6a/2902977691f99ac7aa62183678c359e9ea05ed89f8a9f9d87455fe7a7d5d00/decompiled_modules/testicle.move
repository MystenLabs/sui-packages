module 0x6a2902977691f99ac7aa62183678c359e9ea05ed89f8a9f9d87455fe7a7d5d00::testicle {
    struct TESTICLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTICLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTICLE>(arg0, 6, b"Testicle", b"test", b"testtttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihzstbmkfoziinclzpri77uqigmxywm5qzoifsojh2lvjjivfunga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTICLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTICLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

