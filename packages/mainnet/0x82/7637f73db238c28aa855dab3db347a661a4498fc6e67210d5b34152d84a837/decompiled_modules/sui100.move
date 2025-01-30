module 0x827637f73db238c28aa855dab3db347a661a4498fc6e67210d5b34152d84a837::sui100 {
    struct SUI100 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI100, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI100>(arg0, 6, b"SUI100", b"sui100", b"Sui100 is the First AI X Agent on Sui, powered by DeepSeek-R1, bringing: Real-time Token Tracking, Live Technical Analysis, Instant Updates on the Sui Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui100_4d08f20852.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI100>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI100>>(v1);
    }

    // decompiled from Move bytecode v6
}

