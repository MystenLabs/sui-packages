module 0x37beb12a8ee440dbfb15930da525fb193fb4d8699ab3f28f6492781039243db8::snorlax {
    struct SNORLAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNORLAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNORLAX>(arg0, 6, b"SNORLAX", b"SNORELAX", b"$SNORELAX is the sleepy cute Pokemon. He spends all day sleeping and resting while everyone is hyped.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeice25lddedfpajywbmzn6miplppf3uktzl4rufnvjm5jddlmryzb4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNORLAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNORLAX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

