module 0xc9b1f16535c1792b379d7738699b6c36def4afd21329027460c0effbaa522ffc::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BD>(arg0, 9, b"BD", b"Bun Dai", b"BUNDAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c7c0ba1-6b16-453e-90d1-53b9916433a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BD>>(v1);
    }

    // decompiled from Move bytecode v6
}

