module 0x20deb723da209fb4b0095372313361642228c6d419c82197e81af3dd7bc218b9::blackrock {
    struct BLACKROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKROCK>(arg0, 6, b"BLACKROCK", b"Store of Value", b"BlackRock, Inc. is an American multinational investment company. Founded in 1988, initially as an enterprise risk management.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidc5vdqjxxnfnb2b65ewsbl4cdlwscke6c2d4hip5dosit5sywhcy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLACKROCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

