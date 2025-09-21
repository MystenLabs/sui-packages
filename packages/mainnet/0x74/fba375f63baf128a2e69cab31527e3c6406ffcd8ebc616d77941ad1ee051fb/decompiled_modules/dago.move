module 0x74fba375f63baf128a2e69cab31527e3c6406ffcd8ebc616d77941ad1ee051fb::dago {
    struct DAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGO>(arg0, 6, b"DAGO", b"Dago Coin", b"Lets build the DAGO community together all of us as one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiahy72ji6aigpgwgonv7nl3yimlguou3rkols46ajjdfg7gw73l6i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

