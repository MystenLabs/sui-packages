module 0x9dcb99c4adf58762f22d715afd3a8c30b6e0b121eb8af2c1f4ec98d6bd4585c0::suiminion {
    struct SUIMINION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMINION>(arg0, 6, b"SUIMINION", b"SUIMINION SUI", b"SUIMINION Launch now moonbags sui szn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaazitjrkbboadwtfj7e4h7unoc2zsdhjh5owr3acifu4oyo4sj74")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMINION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMINION>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

