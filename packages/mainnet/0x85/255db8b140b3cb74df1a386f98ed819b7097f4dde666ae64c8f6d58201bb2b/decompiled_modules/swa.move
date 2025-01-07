module 0x85255db8b140b3cb74df1a386f98ed819b7097f4dde666ae64c8f6d58201bb2b::swa {
    struct SWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWA>(arg0, 6, b"SWA", b"SUI WAVE AI", b"A massive wave rises on the horizon, but this is no ordinary wave. It's made of glowing circuits and flowing streams of data, symbolizing the power of artificial intelligence. The crest sparkles with neon blue and silver light, as if the ocean itself has transformed into a digital entity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c6e87040_f7d3_4962_b0b1_9441acd9a206_9ea81f5609.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

