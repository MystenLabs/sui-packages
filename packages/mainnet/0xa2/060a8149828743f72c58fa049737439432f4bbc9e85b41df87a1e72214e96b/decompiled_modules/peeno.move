module 0xa2060a8149828743f72c58fa049737439432f4bbc9e85b41df87a1e72214e96b::peeno {
    struct PEENO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEENO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEENO>(arg0, 6, b"PEENO", b"peeno sui", b"In a universe stuck in the 80s, where neon lights flash, synth beats pump, and crypto has already taken over, stands a man. His name? Peeno. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_333684e720.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEENO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEENO>>(v1);
    }

    // decompiled from Move bytecode v6
}

