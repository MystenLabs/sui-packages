module 0x8940d6836b4f68fe7d66ecaa7f42d3747f24a52248b6bd6abdc63b101cf5dbbd::suiwif {
    struct SUIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIF>(arg0, 6, b"SUIWIF", b"WIF ON SUI", b"WIF IS NOW ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieyrfuapeyls2gmvbwx4pcnyer3znz7u6xhvxvvpf7qrntbykmiga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWIF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

