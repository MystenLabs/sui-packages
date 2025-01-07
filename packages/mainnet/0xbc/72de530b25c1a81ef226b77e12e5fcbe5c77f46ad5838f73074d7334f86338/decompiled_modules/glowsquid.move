module 0xbc72de530b25c1a81ef226b77e12e5fcbe5c77f46ad5838f73074d7334f86338::glowsquid {
    struct GLOWSQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOWSQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOWSQUID>(arg0, 6, b"GLOWSQUID", b"Glow Squid", b"A glowing force from the depths of Sui. Mysterious, bright, and ready to light up the Sui Waters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Glow_Squid_861a833372.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOWSQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOWSQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

