module 0xb7428747d0d35bb6f71b8ed4899859042a01439a4d4d7fe24e0c8709d14ed8::monster {
    struct MONSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTER>(arg0, 6, b"MONSTER", b"SUIMONSTER", b"MONSTER OF THE SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid6q7luv4riggqd6yrjy7kapwgrsqkis7ud3se724vcgdcvvdmi4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONSTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

