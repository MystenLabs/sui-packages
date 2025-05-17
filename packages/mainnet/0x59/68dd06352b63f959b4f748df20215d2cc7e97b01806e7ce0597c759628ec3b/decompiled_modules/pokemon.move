module 0x5968dd06352b63f959b4f748df20215d2cc7e97b01806e7ce0597c759628ec3b::pokemon {
    struct POKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMON>(arg0, 6, b"POKEMON", b"Just A Pokemon Token", b"Just A Pokemon token on sui. sui collab with pokemon. and now this going to meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia2bffp5hwtwdquzrsn6cjhzz2ot7ul6pzh64sjtknzoaz5xkeipi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

