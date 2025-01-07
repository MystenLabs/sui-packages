module 0x4d1f0af4bae44a20422475478ec6e7f280f8c8bfab78c4fca0d0754f5f2e7f46::speed {
    struct SPEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEED>(arg0, 6, b"SPEED", b"Speed", b"SUI Network is at least 5x faster than Solana, attracting a wave of new meme traders who thrive on lightning-speed transactions and seamless scalability. And f#ck SOL btw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_30_00_16_35_90456fa934.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

