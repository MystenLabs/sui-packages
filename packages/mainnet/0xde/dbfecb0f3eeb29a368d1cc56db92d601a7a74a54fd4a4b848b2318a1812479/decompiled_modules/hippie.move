module 0xdedbfecb0f3eeb29a368d1cc56db92d601a7a74a54fd4a4b848b2318a1812479::hippie {
    struct HIPPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPIE>(arg0, 6, b"HIPPIE", b"HIPPIE PEPE", b" I'm a hippie pepe on the Sui chain, probably meditating on blocks and dreaming of decentralized rainbows.  Peace, love, and a little bit of chaosjust the way I like it. Catch you in the vibe flow! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_13_19_57_21_b9d41b61fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

