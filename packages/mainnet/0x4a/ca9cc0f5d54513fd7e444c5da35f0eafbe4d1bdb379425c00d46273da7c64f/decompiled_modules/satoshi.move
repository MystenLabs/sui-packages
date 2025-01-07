module 0x4aca9cc0f5d54513fd7e444c5da35f0eafbe4d1bdb379425c00d46273da7c64f::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 6, b"SATOSHI", b"the real sathoshi", b"THE REAL SATHOSHI REVEAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/satoshi_b74118744b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

