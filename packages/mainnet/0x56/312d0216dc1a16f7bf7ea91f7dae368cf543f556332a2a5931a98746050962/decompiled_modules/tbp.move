module 0x56312d0216dc1a16f7bf7ea91f7dae368cf543f556332a2a5931a98746050962::tbp {
    struct TBP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBP>(arg0, 6, b"TBP", b"The Big Pump", b"$SUI, its time. Are you ready for The Big Pump? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_09_29_192131_9ab6e5550a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBP>>(v1);
    }

    // decompiled from Move bytecode v6
}

