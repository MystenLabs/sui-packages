module 0x4d117ea7581e32a3d1fcfe2c6a2d72c1bc0a66fe68176b92eeb7b7d8ec84dfc3::skydog {
    struct SKYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYDOG>(arg0, 9, b"SKYDOG", b"sky coin", b"sky is name for my dog, she's cute fr ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d0d68d4-6337-4cb3-b49f-ea948ca37370.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

