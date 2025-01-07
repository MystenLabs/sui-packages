module 0xc1298ab50dff335a390a136ec5fb15fd99b13a24767c0f8ac1f506f420c168ac::ek {
    struct EK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EK>(arg0, 9, b"EK", b"Width ", b"Am sure you will be ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8a7160a-548d-400c-a53e-9d463b054ec8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EK>>(v1);
    }

    // decompiled from Move bytecode v6
}

