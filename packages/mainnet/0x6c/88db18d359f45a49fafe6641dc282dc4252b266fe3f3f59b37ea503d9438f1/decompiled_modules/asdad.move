module 0x6c88db18d359f45a49fafe6641dc282dc4252b266fe3f3f59b37ea503d9438f1::asdad {
    struct ASDAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDAD>(arg0, 6, b"ASDAD", b"asda", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif7xa2cqyqauckenfkw7y355t5fx4y7pbm2vrldzt53guqejhfpyy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASDAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

