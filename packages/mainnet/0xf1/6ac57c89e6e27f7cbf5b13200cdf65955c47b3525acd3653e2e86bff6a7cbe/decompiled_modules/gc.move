module 0xf16ac57c89e6e27f7cbf5b13200cdf65955c47b3525acd3653e2e86bff6a7cbe::gc {
    struct GC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GC>(arg0, 6, b"GC", b"GodCandle", b"Tired of getting rug pulled, let send this to the moon lets all make money ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4520_b93fef3898.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GC>>(v1);
    }

    // decompiled from Move bytecode v6
}

