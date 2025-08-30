module 0x33dfb344c4b3a0c73b9b858bd8c4d2e42ae23bfddb8d40c4dfa8610da5c6cdba::trip {
    struct TRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIP>(arg0, 6, b"TRIP", b"Trump is Dead", b"Just facts...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifyg7jw7mvll22zcuqdqcosjyubdxoe7hpologuowpe2ggdonja6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

