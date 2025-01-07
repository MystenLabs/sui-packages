module 0xc6729d126e2f4103019ce0953f6491f3b7dc930c62abcda825a2078e84569737::msp {
    struct MSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSP>(arg0, 6, b"MSP", b"Global", b"It's more expensive today than yesterday!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123_4e01e756eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

