module 0x2b68cf21368e558fe7a06853b96cf77cee0b27e35c436c6e549a6b01641e25ae::momandson {
    struct MOMANDSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMANDSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMANDSON>(arg0, 9, b"MOMANDSON", b"ELEPHANT", b"Cc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f374e850-5dcd-4211-990d-d28964db5e89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMANDSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMANDSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

