module 0x51ab84616eb94c64745bdc2816ed9fca671c50088af1c8d4c491dc5371b9d38a::studio {
    struct STUDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUDIO>(arg0, 9, b"STUDIO", b"CartelStu", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91c3fac8-8098-47cd-a0fd-b07aeebf10b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STUDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

