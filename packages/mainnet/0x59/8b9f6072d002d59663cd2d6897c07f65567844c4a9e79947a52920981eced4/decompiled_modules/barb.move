module 0x598b9f6072d002d59663cd2d6897c07f65567844c4a9e79947a52920981eced4::barb {
    struct BARB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARB>(arg0, 6, b"BARB", b"Barbasaur sui", b"this is the best generation of pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibf6qzgbog4wzypozfcfnpq2fbv77i7gtzouwzefkzbowlwcq2gpi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

