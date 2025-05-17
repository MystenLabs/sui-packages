module 0x9a81ee3f9e31ae55f893a63c97642f42f2044ece402efabaf23acbcf9628a39a::misu {
    struct MISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISU>(arg0, 6, b"MISU", b"MINUN SUI", b"asfafasf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieorbtww675mu5in2tsepok56gnzvvbg6w4km4bolvqfj3yqdfuna")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MISU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

