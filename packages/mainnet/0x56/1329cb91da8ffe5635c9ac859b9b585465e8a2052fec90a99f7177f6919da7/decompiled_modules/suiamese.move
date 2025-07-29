module 0x561329cb91da8ffe5635c9ac859b9b585465e8a2052fec90a99f7177f6919da7::suiamese {
    struct SUIAMESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAMESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAMESE>(arg0, 6, b"SUIAMESE", b"SIAMESE CAT ON SUI", b"Meet the king cat, The SUI-perstar of SUI Chain. Relaunch on Moonbags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifiwwudolnuqhja7wedfq36y5olwe5trod64fxzd2lzaxopxe5zbq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAMESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAMESE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

