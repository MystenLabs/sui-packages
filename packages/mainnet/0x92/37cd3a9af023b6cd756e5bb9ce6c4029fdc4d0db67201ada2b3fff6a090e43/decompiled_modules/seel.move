module 0x9237cd3a9af023b6cd756e5bb9ce6c4029fdc4d0db67201ada2b3fff6a090e43::seel {
    struct SEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEL>(arg0, 6, b"SEEL", b"SEEL ON SUI", b"Seel is the cutest seal on sui, Born from a passion for both cute marine creatures and blockchain technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreien6ljgq6c2x5bkp33jzta6oqhibvcwpeafjw3cn44ivg27oezu6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

