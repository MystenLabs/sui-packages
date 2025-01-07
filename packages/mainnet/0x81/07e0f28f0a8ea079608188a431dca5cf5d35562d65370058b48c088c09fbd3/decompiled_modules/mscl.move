module 0x8107e0f28f0a8ea079608188a431dca5cf5d35562d65370058b48c088c09fbd3::mscl {
    struct MSCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSCL>(arg0, 9, b"MSCL", b"Mooscles ", b"Yisss! Mooscles to the Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c45b341c-829a-4d59-8482-c7ca549c767b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSCL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSCL>>(v1);
    }

    // decompiled from Move bytecode v6
}

