module 0x12f23484831680666f70233101cb416c2b75c017ae7735e81539063fce07b27e::oshaa {
    struct OSHAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSHAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSHAA>(arg0, 6, b"OSHAA", b"OSHAA SUI", b"OSHAA was born on Sui to charm, naturally adorable, but always full of surprises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiabsrmkydfstk67jmopnvjflykozijqdjrb7vg7l6t54wrr35eamy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSHAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OSHAA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

