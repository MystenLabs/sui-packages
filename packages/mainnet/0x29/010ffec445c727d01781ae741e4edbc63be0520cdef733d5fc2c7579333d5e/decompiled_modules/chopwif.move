module 0x29010ffec445c727d01781ae741e4edbc63be0520cdef733d5fc2c7579333d5e::chopwif {
    struct CHOPWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPWIF>(arg0, 6, b"CHOPWIF", b"CHOP WIF HAT", b"CHOP WIF HAT. New chopstastic yield token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihtqwzmgdcbu46vz2kkf5vz77ff2admdv64htqkxppv6sflhpv22m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHOPWIF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

