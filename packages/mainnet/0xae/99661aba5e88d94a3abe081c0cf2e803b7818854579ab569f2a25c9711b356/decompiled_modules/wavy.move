module 0xae99661aba5e88d94a3abe081c0cf2e803b7818854579ab569f2a25c9711b356::wavy {
    struct WAVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVY>(arg0, 6, b"Wavy", b"Wavy CTO", b"Ride the wave of wealth with Wavy, the memecoin that flows as effortlessly as the tides. Built on the Sui blockchain, Wavy embodies the spirit of abundance and going with the flow. Like a raindrop joining the ocean, every Wavy moment connects you to a sea of endless possibilities and potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wavy_7058dfe331.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

