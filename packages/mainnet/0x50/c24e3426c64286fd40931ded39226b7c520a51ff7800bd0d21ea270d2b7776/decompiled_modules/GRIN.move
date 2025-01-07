module 0x50c24e3426c64286fd40931ded39226b7c520a51ff7800bd0d21ea270d2b7776::GRIN {
    struct GRIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIN>(arg0, 8, b"GRIN", b"Sui Glimmer Grin", b"Hidden behind a mischievous grin lies a secret waiting to be unveiled", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmbLa5ohY8iQ1dwQqjikjYENALK3EsaGaFczyMJgqgEpyB?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GRIN>>(0x2::coin::mint<GRIN>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

