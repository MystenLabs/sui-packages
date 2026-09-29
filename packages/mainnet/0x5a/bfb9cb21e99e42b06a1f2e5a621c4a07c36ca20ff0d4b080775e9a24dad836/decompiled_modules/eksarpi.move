module 0x5abfb9cb21e99e42b06a1f2e5a621c4a07c36ca20ff0d4b080775e9a24dad836::eksarpi {
    struct EKSARPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EKSARPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EKSARPI>(arg0, 9, b"EKSARPI", b"EKS-AR-PI", b"EKS-AR-PI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/c3daa42ea60cbc38de53cf481437d41a2aa6e2f91a3e3376634483935f9256cf")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<EKSARPI>>(0x2::coin::mint<EKSARPI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EKSARPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EKSARPI>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

