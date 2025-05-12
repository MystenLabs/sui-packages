module 0x1aa9931d428914d2fefe6f778221178f2a49932edcdf0402401016f7c80bd7af::dogla {
    struct DOGLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGLA>(arg0, 6, b"DOGLA", b"DOGLAVA", b"Dogla it's a community-powered firestorm fueled by fun  and volcanic vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiequzbaujf3hjlqjewuljrymylua3s5nc2frrryyz43tnmy322ndu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

