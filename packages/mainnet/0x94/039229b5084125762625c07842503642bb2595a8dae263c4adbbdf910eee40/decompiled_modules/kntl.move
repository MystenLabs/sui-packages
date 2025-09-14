module 0x94039229b5084125762625c07842503642bb2595a8dae263c4adbbdf910eee40::kntl {
    struct KNTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNTL>(arg0, 6, b"KNTL", b"KONTOL", b"KONTOL GUA GEDE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig6yqzufztahbsfrrayd5umkl5dxhv5xs4ousu4lu2j2r2zz4qrtq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KNTL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

