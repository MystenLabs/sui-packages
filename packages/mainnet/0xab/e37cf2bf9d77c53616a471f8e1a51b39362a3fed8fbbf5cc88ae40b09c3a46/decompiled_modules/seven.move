module 0xabe37cf2bf9d77c53616a471f8e1a51b39362a3fed8fbbf5cc88ae40b09c3a46::seven {
    struct SEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEVEN>(arg0, 9, b"SEVEN", b"777", b"A selected number 777", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c4cc659-bc41-49a4-ae9d-1e56f64152a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

