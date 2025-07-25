module 0xf8b477621fe2cc955539a4b0d75d65c9d7c6a8df6953964123549cd601360899::bonkyo {
    struct BONKYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKYO>(arg0, 6, b"BONKYO", b"Bonkyo on SUI", b"A CULTURE COIN AND PFP MADE ON BONK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigcjvqbbb44w3dmtxcwpyl6oiiacu3wj3rxjt3stviv4khzqzninq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BONKYO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

