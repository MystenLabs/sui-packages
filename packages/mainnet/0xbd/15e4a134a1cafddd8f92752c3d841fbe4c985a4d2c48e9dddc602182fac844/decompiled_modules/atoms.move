module 0xbd15e4a134a1cafddd8f92752c3d841fbe4c985a4d2c48e9dddc602182fac844::atoms {
    struct ATOMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATOMS>(arg0, 6, b"ATOMS", b"ATOM", b"The smallest entity in the SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihp76v7fsk3w6ql6i2cc5smizajtrqg2dxqvdlj7roxc6rll7rbza")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATOMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATOMS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

