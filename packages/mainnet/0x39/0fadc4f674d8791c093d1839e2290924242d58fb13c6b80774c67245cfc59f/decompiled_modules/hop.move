module 0x390fadc4f674d8791c093d1839e2290924242d58fb13c6b80774c67245cfc59f::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"HOP", b"HOPCAT", b"Hi, I'm Hop, the coolest cat on sui! Yes, I'm like that - I jump like a real athlete, or almost... But every jump I make is a show! Also, between you and me, I love to eat fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rt5_E9_V_p_400x400_8a21a39e77.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

