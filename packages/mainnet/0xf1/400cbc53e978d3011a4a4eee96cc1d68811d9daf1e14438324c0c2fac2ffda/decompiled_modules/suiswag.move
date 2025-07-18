module 0xf1400cbc53e978d3011a4a4eee96cc1d68811d9daf1e14438324c0c2fac2ffda::suiswag {
    struct SUISWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISWAG>(arg0, 6, b"SUISWAG", b"Sui Swag Cult", b"SUISWAG The Culture Of GOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiciql5edh6tlqbjuacj363bj2fe43q6brjspy3sm7csoquinzyiyi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISWAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

