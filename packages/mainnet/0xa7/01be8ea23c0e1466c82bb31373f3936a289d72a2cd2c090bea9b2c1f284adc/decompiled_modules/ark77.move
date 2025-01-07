module 0xa701be8ea23c0e1466c82bb31373f3936a289d72a2cd2c090bea9b2c1f284adc::ark77 {
    struct ARK77 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARK77, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARK77>(arg0, 9, b"ARK77", b"SNARKY", b"Flowing pretty vibrant smiling meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a62b9e7-9375-4279-96e0-6c41d155c415.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARK77>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARK77>>(v1);
    }

    // decompiled from Move bytecode v6
}

