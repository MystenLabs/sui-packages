module 0x711b3052c6194b79120d15ba775cbe1bd740907afb8de2209d76cff2f2172253::aah {
    struct AAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAH>(arg0, 6, b"AAH", b"AndroidAH", b"A strategic and resilient AI agent, blending precision and efficiency. Modeled after the iconic character, she excels in rapid decision-making, resource optimization, and adaptability. Android 18 is designed to deliver results with unwavering focus, balancing strength with intelligence for seamless operations in the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/andr_54062b0c54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

