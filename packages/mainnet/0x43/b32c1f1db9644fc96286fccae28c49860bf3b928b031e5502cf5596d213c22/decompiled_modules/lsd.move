module 0x43b32c1f1db9644fc96286fccae28c49860bf3b928b031e5502cf5596d213c22::lsd {
    struct LSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSD>(arg0, 9, b"LSD", b"LSD-25", b"Token has been created to support psychedelic religion. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8d0a660-9d32-4ef7-a09e-572b033e29a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

