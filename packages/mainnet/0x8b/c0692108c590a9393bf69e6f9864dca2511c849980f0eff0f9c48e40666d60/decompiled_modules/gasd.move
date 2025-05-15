module 0x8bc0692108c590a9393bf69e6f9864dca2511c849980f0eff0f9c48e40666d60::gasd {
    struct GASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GASD>(arg0, 6, b"GASD", b"aaa", b"DADADADA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibenssqrrj3ctd6bfuycn66ozwrtzt23b3atwegjnt5wkqcnfrndi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GASD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

