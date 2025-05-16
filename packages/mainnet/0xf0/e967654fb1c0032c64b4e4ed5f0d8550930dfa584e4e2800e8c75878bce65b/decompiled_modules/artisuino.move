module 0xf0e967654fb1c0032c64b4e4ed5f0d8550930dfa584e4e2800e8c75878bce65b::artisuino {
    struct ARTISUINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTISUINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTISUINO>(arg0, 6, b"ARTISUINO", b"ARTISUINO Water-Ice Legendary Pokemon.", b"ARTISUINO the water-ice chilled Pokemon that freezes everything that goes in its way. The legendary Pokemon who once dominate the past.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif2kygprfisxwrcvpnrqbrxcirogvw2lrj6qzovj5jh5363x3obsa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTISUINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARTISUINO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

