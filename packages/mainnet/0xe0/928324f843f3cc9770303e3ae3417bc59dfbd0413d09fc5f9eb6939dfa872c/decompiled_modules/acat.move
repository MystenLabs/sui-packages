module 0xe0928324f843f3cc9770303e3ae3417bc59dfbd0413d09fc5f9eb6939dfa872c::acat {
    struct ACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACAT>(arg0, 9, b"ACAT", b"Astronaut ", b"You can never bee too sure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a027d27-b39e-4602-b5f6-be966c3f76d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

