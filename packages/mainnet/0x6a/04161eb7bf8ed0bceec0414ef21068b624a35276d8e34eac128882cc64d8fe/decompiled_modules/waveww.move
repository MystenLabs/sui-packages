module 0x6a04161eb7bf8ed0bceec0414ef21068b624a35276d8e34eac128882cc64d8fe::waveww {
    struct WAVEWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEWW>(arg0, 9, b"WAVEWW", b"OCTOPUS", b"Hi OCTOPUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc2d2710-8b5d-435d-9492-3cd54f5d9144.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

