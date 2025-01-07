module 0xc4f351d121abdf43636fe877d6c5c36071303ede58d0dd1981fbb42556eea9cd::mjeet {
    struct MJEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJEET>(arg0, 6, b"MJEET", b"JEET", b"ONLY TOKEN DEDICATED TO JEET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fmrcu9_JT_400x400_09e6e2e06f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MJEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

