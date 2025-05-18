module 0x3d79c4c292cf4fb342dcad8279652382634fe76ca49de297b6e2755157fe2128::blup {
    struct BLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUP>(arg0, 6, b"BLUP", b"BLUPA", b"BLUPA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiccm4cty5w5krk3nn7pvbl5n23dpljry6734tzvikzdljt6cysmny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

