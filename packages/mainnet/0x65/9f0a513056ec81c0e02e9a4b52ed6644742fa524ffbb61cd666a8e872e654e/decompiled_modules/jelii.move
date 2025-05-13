module 0x659f0a513056ec81c0e02e9a4b52ed6644742fa524ffbb61cd666a8e872e654e::jelii {
    struct JELII has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELII>(arg0, 6, b"JELII", b"Jely", b"its the jeli fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicv4fridmp3aisvpjsakds2ipptb4w4qsqjgto36ugouo3dfcpvpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JELII>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

