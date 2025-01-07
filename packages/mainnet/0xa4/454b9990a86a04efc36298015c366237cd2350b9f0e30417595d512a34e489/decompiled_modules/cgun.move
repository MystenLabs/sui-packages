module 0xa4454b9990a86a04efc36298015c366237cd2350b9f0e30417595d512a34e489::cgun {
    struct CGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGUN>(arg0, 9, b"CGUN", b"Cat gun", b"CAT WITH GUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c600b0e-d1d6-465c-b44a-06aa8101fcc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

